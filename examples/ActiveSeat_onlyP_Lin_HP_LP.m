% ONLY LATERAL PRESSURE MODEL LINEAR + HIGH PASS FILTER

%%***** SETTING MAIN MATMPC PATH

path_main_matmpc = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC';

%% usefull from here

run Pressure_model_params_Lin

%% Dimensions

nx=5;       % No. of states
nu=1;       % No. of controls
ny=2;       % No. of outputs
nyN=1;      % No. of outputs at the terminal point
np=3;       % No. of model parameters
nc=0;       % No. of general constraints
ncN=0;      % No. of general constraints at the terminal point
nbx = 0;    % No. of bounds on states
nbu = 0;    % No. of bounds on controls


import casadi.*

states   = SX.sym('states',nx,1);
controls = SX.sym('controls',nu,1);
params   = SX.sym('params',np,1);    
refs     = SX.sym('refs',ny,1);
refN     = SX.sym('refs',nyN,1);
Q        = SX.sym('Q',ny,ny);
QN       = SX.sym('QN',nyN,nyN);


%% Dynamics

accX=params(1); 
roll=params(2); 
accY=params(3);

prY1=states(1); 
prY2=states(2);  
pressY=states(3);
x_hp = states(4);
x_lp = states (5);

dpressY=controls(1);


x_dot=[prY2;...
       -c2/m*prY2-k2*prY1/m+accY+MM*g*roll/m; ...               
       dpressY;...
       (-1/tau_hp)*x_hp+[c2/A*prY2+k2*prY1/A]+[(1/tau_lp)*x_lp];...
       (-1/tau_lp)*x_lp+pressY];
       
   
 
xdot = SX.sym('xdot',nx,1);
impl_f = xdot - x_dot;
     
%% Objectives and constraints

% objectives
h = [(-1/tau_hp)*x_hp+[c2/A*prY2+k2*prY1/A]+[(1/tau_lp)*x_lp]; pressY ];

hN=[pressY]; %generic state 

h_fun=Function('h_fun', {states,controls,params}, {h},{'states','controls','params'},{'h'});
hN_fun=Function('hN_fun', {states,params}, {hN},{'states','params'},{'hN'});

% general inequality constraints
general_con = [];
general_con_N = [];

% state and control bounds
nbx_idx = 0;    %nbx_idx = [2]; % indexs of states which are bounded
nbu_idx = 0;    % indexs of controls which are bounded
path_con=general_con;
path_con_N=general_con_N;
for i=1:nbx
    path_con=[path_con;states(nbx_idx(i))];
    path_con_N=[path_con_N;states(nbx_idx(i))];
end    
nc=nc+nbx;
ncN=ncN+nbx;

% build the function for inequality constraints
path_con_fun=Function('path_con_fun', {states,controls,params}, {path_con},{'states','controls','params'},{'path_con'});
path_con_N_fun=Function('path_con_N_fun', {states,params}, {path_con_N},{'states','params'},{'path_con_N'});


%% NMPC sampling time [s]

Ts = 0.005; % simulation sample time
Ts_st = 0.005; % shooting interval time

%% save your data in the path of your MATMPC

cd(path_main_matmpc); %main matmpc folder

clc;