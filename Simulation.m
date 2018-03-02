clear mex; close all;clc;

%% Configuration (complete your configuration here...)
addpath([pwd,'/nmpc']);
addpath([pwd,'/model_src']);
addpath([pwd,'/mex_core']);
addpath(genpath([pwd,'/data']));

cd data;
if exist('settings','file')==2
    load settings
    cd ..
else 
    cd ..
    error('No setting data is detected!');
end

Ts  = settings.Ts;       % Sampling time
Ts_st = settings.Ts_st;  % Shooting interval
s = settings.s;      % number of integration steps per interval
nx = settings.nx;    % No. of states
nu = settings.nu;    % No. of controls
ny = settings.ny;    % No. of outputs (references)    
nyN= settings.nyN;   % No. of outputs at terminal stage 
np = settings.np;    % No. of parameters (on-line data)
nc = settings.nc;    % No. of constraints
ncN = settings.ncN;  % No. of constraints at terminal stage

%% solver configurations
N  = 40;             % No. of shooting points
settings.N = N;

opt.integrator='ERK4-CASADI'; % 'ERK4','IRK3, 'ERK4-CASADI'
opt.hessian='gauss_newton';  % 'gauss_newton', 
opt.qpsolver='qpoases'; %'qpoases'
opt.condensing='full';  %'full'
opt.hotstart='no'; %'yes','no' (only for qpoases)
opt.shifting='yes'; % 'yes','no'
opt.lin_obj='yes'; % 'yes','no' % if objective function is linear least square
opt.ref_type=0; % 0-time invariant, 1-time varying(no preview), 2-time varying (preview)

%% Initialize Data (all users have to do this)

[input, data] = InitData(settings);

%% Initialize Solvers (only for advanced users)

mem = InitMemory(settings, opt, input);

%% Simulation (start your simulation...)

mem.iter = 1; time = 0.0;
Tf = 4;  % simulation time
state_sim= [input.x0]';
controls_MPC = [input.u0]';
y_sim = [];
constraints = [];
CPT = [];
ref_traj = [];
input_u = input.u0';

while time(end) < Tf
    
    % the reference input.y is a ny by N matrix
    % the reference input.yN is a nyN by 1 vector
    
    switch opt.ref_type
        case 0 % time-invariant reference
            input.y = repmat(data.REF',1,N);
            input.yN = data.REF(1:nyN)';
        case 1 % time-varying reference (no reference preview)
            input.y = repmat(data.REF(mem.iter,:)',1,N);
            input.yN = data.REF(mem.iter,1:nyN)';
        case 2 %time-varying reference (reference preview)
            if strcmp(settings.model,'TiltHex')
                REF = zeros(ny,N+1);
                for i=1:N+1
                    x = data.amplitude_x*sin(((time(end)+(i-1)*Ts_st))*2*pi*data.f_x);
                    theta = data.amplitude_theta*sin(((time(end)+(i-1)*Ts_st))*2*pi*data.f_theta);
                    REF(:,i) = [x 0 0 0 theta 0 zeros(1,nu)]';
                end
                ref_traj=[ref_traj, REF(:,1)];
                input.y = REF(:,1:N);
                input.yN = REF(1:nyN,N+1);
            else
                input.y = data.REF(mem.iter:mem.iter+N-1,:)';
                input.yN = data.REF(mem.iter+N,1:nyN)';
            end
    end
              
    % obtain the state measurement
    input.x0 = state_sim(end,:)';
    
    % call the NMPC solver   
    [output, mem]=mpc_nmpcsolver(input, settings, mem);
    
    % obtain the solution and update the data
    switch opt.shifting
        case 'yes'
        input.x=[output.x(:,2:end),output.x(:,end)];  
        input.u=[output.u(:,2:end),output.u(:,end)]; 
        input.lambda=[output.lambda(:,2:end),output.lambda(:,end)];
        input.mu=[output.mu(:,2:end),[output.muN;output.mu(ncN+1:nc,end)]];
        input.muN=output.muN;
        case 'no'
        input.x=output.x;
        input.u=output.u;
        input.lambda=output.lambda;
        input.mu=output.mu;
        input.muN=output.muN;
    end
    
    % collect the statistics
    cpt=output.info.cpuTime;
    tshooting=output.info.shootTime;
    tcond=output.info.condTime;
    tqp=output.info.qpTime;
    KKT=output.info.kktValue;
    
    % Simulate system dynamics
    sim_input.x = state_sim(end,:).';
    sim_input.u = output.u(:,1);
    sim_input.p = input.od(:,1)';
    xf=full( Simulate_system('Simulate_system', sim_input.x, sim_input.u, sim_input.p) ); 
    
    % Collect outputs
    y_sim = [y_sim; full(h_fun('h_fun', xf, sim_input.u, sim_input.p))'];  
    
    % Collect constraints
    constraints=[constraints; full( path_con_fun('path_con_fun', xf, sim_input.u, sim_input.p) )'];
    
    % Collect other data
    if strcmp(settings.model,'ActiveSeat')
        input_u = [input_u; output.u(1:6,1)',xf(32)];
    end
    
    % store the optimal solution and states
    controls_MPC = [controls_MPC; output.u(:,1)'];
    state_sim = [state_sim; xf'];
    
    % go to the next sampling instant
    nextTime = mem.iter*Ts; 
    mem.iter = mem.iter+1;
    disp(['current time:' num2str(nextTime) '  CPT:' num2str(cpt) 'ms  MULTIPLE SHOOTING:' num2str(tshooting) 'ms  COND:' num2str(tcond) 'ms  QP:' num2str(tqp) 'ms  KKT:' num2str(KKT)]);
    disp(['exactly updated sensitivities:' num2str(mem.perc) '%']);
    disp(['threshold_pri:' num2str(mem.threshold_pri) '   threshold_dual:' num2str(mem.threshold_dual)]);
    
    time = [time nextTime];
    
    CPT = [CPT; cpt, tshooting, tcond, tqp];
end

qpOASES_sequence( 'c', mem.warm_start);
clear mex;

%% draw pictures (optional)
disp(['Average CPT: ', num2str(mean(CPT(2:end-1,:),1)) ]);
disp(['Maximum CPT: ', num2str(max(CPT(2:end-1,:))) ]);

Draw;
