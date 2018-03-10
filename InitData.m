%% Initialization
function [input, data] = InitData(settings)

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
    N     = settings.N;             % No. of shooting points
    nbx = settings.nbx;
    nbu = settings.nbu;
    nbu_idx = settings.nbu_idx;

    switch settings.model
        case 'ActiveSeat'
            
            input.x0 = [zeros(1,nx-4), 0.0001, 0, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = 0;
            
            rw_uscita_xy = [20000 300 15000 600 650 0];
            rw_deltau_xy = [10 0.01];
            rw_u_xy = [0.0001 0.1];
            rw_uscita_yx = [40000 500 15000 600 600 0];
            rw_deltau_yx = [10 10];
            rw_u_yx = [0.0001 0.01];
            rw_uscita_za = [3800 1100 0];
            rw_deltau_za = 0.0001;
            rw_u_za = 0.0001;
            rw_uscita_zv = [2000 600 2000];
            rw_deltau_zv = 0.0001;
            rw_u_zv = 0.0001;

            Wq_t(1) = rw_uscita_xy(1);   % vpP       vel pitch perc
            Wq_t(2) = rw_uscita_xy(2);   % accXP     acc long perc
            Wq_t(3) = rw_uscita_xy(3);   % p         pitch
            Wq_t(4) = rw_uscita_xy(4);   % X         pos long
            Wq_t(5) = rw_uscita_xy(5);    % vX        vel long
            Wq_t(6) = rw_uscita_xy(6);      % vp        vel pitch

            Wq_t(7) = rw_uscita_yx(1);    % vrP       vel roll perc
            Wq_t(8) = rw_uscita_yx(2);   % accYP     acc lat perc
            Wq_t(9) = rw_uscita_yx(3);   % r         roll
            Wq_t(10) = rw_uscita_yx(4);   % Y         pos lat
            Wq_t(11) = rw_uscita_yx(5);   % vY        vel lat
            Wq_t(12) = rw_uscita_yx(6);     % vr        vel roll

            Wq_t(13) = rw_uscita_zv(1);  % accZP     acc vert perc
            Wq_t(14) = rw_uscita_zv(2);  % Z         pos vert
            Wq_t(15) = rw_uscita_zv(3);  % vZ        vel vert

            Wq_t(16) = rw_uscita_za(1);  % vyP       vel yaw perc
            Wq_t(17) = rw_uscita_za(2);   % y         yaw
            Wq_t(18) = rw_uscita_za(3);     % vy        vel yaw

            Wq_t(19) = 1; % uscita pressione y

            Wq = diag(Wq_t); % diag matrix coi pesi
            Wr = diag([rw_deltau_xy(1) rw_deltau_xy(2) rw_deltau_yx(1) rw_deltau_yx(2) ...
                        rw_deltau_zv(1) rw_deltau_za(1) 0]); % pesi su ingressi effettivi

            Wr3_t(1) = rw_u_xy(1);    % acc x tripod 
            Wr3_t(2) = rw_u_xy(2);    % acc y tripod
            Wr3_t(3) = rw_u_yx(1);     % acc z
            Wr3_t(4) = rw_u_yx(2);    % vel yaw tripod
            Wr3_t(5) = rw_u_zv(1);     % vel pitch
            Wr3_t(6) = rw_u_za(1);     % vel roll

            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            Q = blkdiag(Wq,Wr*Ts^2,Wr3);
            QN = Wq(1:nyN,1:nyN)*0;
            
            
            load([pwd, '/data/ActiveSeat/data_AS']);
            % upper and lower bounds for states (=nbx)
            lb_x = -[data_AS.y_lim_xy_pa;data_AS.y_lim_xy_pl;data_AS.y_lim_yx_pa;...
                    data_AS.y_lim_yx_pl;data_AS.y_lim_zv_pv;data_AS.y_lim_za_pa];
            ub_x = -lb_x;

            % upper and lower bounds for controls (=nbu)           
            lb_u = [];
            ub_u = [];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];
            
        case 'ActiveSeat_onlyP'
            
            input.x0 = [0, 0.0001, 0, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];
            
            rw_deltau_xy = [10 0.01];
            rw_u_xy = [0.0001 0.1];
            rw_uscita_yx = [40000 500 15000 600 600 0];
            rw_deltau_yx = [10 10];
            rw_u_yx = [0.0001 0.01];
            rw_uscita_za = [3800 1100 0];
            rw_deltau_za = 0.0001;
            rw_u_za = 0.0001;
            rw_uscita_zv = [2000 600 2000];
            rw_deltau_zv = 0.0001;
            rw_u_zv = 0.0001;

            Wq_t(1) = 1; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr_t(1) = 1; % peso sull'unico ingresso dpressY
%             Wr = diag(Wr_t); % matrice diagonale con i pesi su ingressi effettivi

            Wr3_t(1)= 0.01;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
%             Q = blkdiag(Wq,Wr*Ts^2,Wr3);
            Q = blkdiag(Wq,Wr3);
            QN = Wq(1:nyN,1:nyN)*0;
            
            
            % upper and lower bounds for states (=nbx)
            
            lb_x = [];%-inf(nu,1);
            ub_x = [];%-lb_x;

            % upper and lower bounds for controls (=nbu)           
            lb_u = [];
            ub_u = [];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

            % store the constraint data into input
            
            input.lb=repmat([lb_g;lb_x],1,N);
            input.ub=repmat([ub_g;ub_x],1,N); 
            nput.lbN=[lb_gN;lb_x];               
            input.ubN=[ub_gN;ub_x]; 
            
            lbu = -inf(nu,1);
            ubu = inf(nu,1);
            for i=1:nbu
                lbu(nbu_idx(i)) = lb_u(i);
                ubu(nbu_idx(i)) = ub_u(i);
            end
            
            input.lbu = repmat(lbu,1,N);
            input.ubu = repmat(ubu,1,N);
            
        case 'DiM'
            input.x0 = zeros(nx,1);    % initial state
            input.u0 = zeros(nu,1);    % initial control
            para0 = 0;  % initial parameters (by default a np by 1 vector, if there is no parameter, set para0=0)

            %weighting matrices
            Q=diag([1200,1200,2000,800,800,5800,... % perceived acc and angular vel
                    32000*1.1,32000*1.1,1600*1,... %px,py,pz hex
                    3200*1.1,3200*1.1,2000*1,... %vx, vy, vz hex
                    4600*1,600*1,... % x,y tri
                    850*1,850*1,... % vx,vy tri
                    3700,3000,1500,... % phi, theta, psi hex
                    750,... % phi tri
                    0.01,0.0,0.0,... % omega phi,theta,psi hex
                    500.0,... % omega phi tri
                    0.0,0.0,0.001,... %ax,ay,az hex %         20*1.1,20*1.1,... % ax,ay tri
                    0.0,0.01,0.1 ... % alpha phi,theta, psi hex 
                    ]);

              QN=Q(1:nyN,1:nyN);
              
              % upper and lower bounds for states (=nbx)
              lb_x = [];
              ub_x = [];
              lb_xN = [];
              ub_xN = [];
              
              % upper and lower bounds for controls (=nbu)           
              lb_u = [];
              ub_u = [];

              % upper and lower bounds for general constraints (=nc)
              lb_g=[1.045;1.045;1.045;1.045;1.045;1.045];    % lower bounds for ineq constraints
              ub_g=[1.3750;1.3750;1.3750;1.3750;1.3750;1.3750];  % upper bounds for ineq constraints
              lb_gN=[1.045;1.045;1.045;1.045;1.045;1.045];  % lower bounds for ineq constraints at terminal point
              ub_gN=[1.3750;1.3750;1.3750;1.3750;1.3750;1.3750];  % upper bounds for ineq constraints at terminal point
              
        case 'InvertedPendulum'
            input.x0 = [0;pi;0;0];    
            input.u0 = zeros(nu,1);    
            para0 = 0;  

            Q=diag([10 10 0.1 0.1 0.01]);
            QN=Q(1:nyN,1:nyN);

            % upper and lower bounds for states (=nbx)
            lb_x = -2;
            ub_x = 2;
            lb_xN = -2;
            ub_xN = 2;

            % upper and lower bounds for controls (=nbu)           
            lb_u = -20;
            ub_u = 20;
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

        case 'ChainofMasses_Lin'
            n=15;
            data.n=n;
            input.x0=zeros(nx,1);
            for i=1:n
                input.x0(i)=7.5*i/n;
            end
            input.u0=zeros(nu,1);
            para0=0;
            wv=[];wx=[];wu=[];
            wu=blkdiag(wu,0.1, 0.1, 0.1);
            for i=1:3
                wx=blkdiag(wx,25);
                wv=blkdiag(wv,diag(0.25*ones(1,n-1)));
            end
            Q=blkdiag(wx,wv,wu);
            QN=blkdiag(wx,wv);

            % upper and lower bounds for states (=nbx)
            lb_x = [];
            ub_x = [];
            lb_xN = [];
            ub_xN = [];

            % upper and lower bounds for controls (=nbu)           
            lb_u = [-1;-1;-1];
            ub_u = [1;1;1];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

        case 'ChainofMasses_NLin'
            n=10;
            data.n=n;
            x0=[0.1 0.2 0.3 0.4 0.5 0.6 0.7 0.8 0.9 1 zeros(1,nx-n)]';
%             input.x0=[rand(1,n), 0.6*rand(1,n)-1, -0.6*rand(1,n) , zeros(1,3*(n-1))]';
            input.u0=zeros(nu,1);
            para0=0;
            wv=[];wx=[];wu=[];
            wu=blkdiag(wu,0.01, 0.01, 0.01);
            for i=1:3
                wx=blkdiag(wx,25);
                wv=blkdiag(wv,diag(1*ones(1,n-1)));
            end
            Q=blkdiag(wx,wv,wu);
            QN=blkdiag(wx,wv);

            % upper and lower bounds for states (=nbx)
            lb_x = [];
            ub_x = [];
            lb_xN = [];
            ub_xN = [];

            % upper and lower bounds for controls (=nbu)           
            lb_u = [-1;-1;-1];
            ub_u = [1;1;1];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

        case 'Hexacopter'
            input.x0=zeros(nx,1);
            input.u0=zeros(nu,1);
            para0=0;
            
            q = [5e0, 5e0, 5e0, 0.1, 0.1, 0.1];
            qN = q(1:nyN);
            Q = diag(q);
            QN = diag(qN);

            % upper and lower bounds for states (=nbx)
            lb_x = [];
            ub_x = [];

            % upper and lower bounds for controls (=nbu)           
            lb_u = -inf*ones(nbu,1);
            ub_u = inf*ones(nbu,1);
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

        case 'TiltHex'
            input.x0=zeros(nx,1);
            input.u0=zeros(nu,1);
            para0=0;

            q =[5,5,5,0.1,1,0.1,1e-5*ones(1,nu)];
            qN = q(1:nyN);
            Q = diag(q);
            QN = diag(qN);
            
            % upper and lower bounds for states (=nbx)
            lb_x = 0*ones(nbx,1);
            ub_x = 12*ones(nbx,1);

            % upper and lower bounds for controls (=nbu)           
            lb_u = -80*ones(nbu,1);
            ub_u = 80*ones(nbu,1);
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = [];
            ub_g = [];            
            lb_gN = [];
            ub_gN = [];

            %Frequency for x(t) in rad/s 
            data.f_rif_x=1.2;
            %Same frequency used in MPC algorithm
            data.f_x=data.f_rif_x*0.5/pi;
            %Amplitude of x(t)
            data.amplitude_x=1.2;
            %Frequency for theta(t) in rad/s
            data.f_rif_theta=1.2;
            %Same frequency used in MPC algorithm
            data.f_theta=data.f_rif_theta*0.5/pi;
            %Amplitude of theta(t)
            data.amplitude_theta=pi/18;
            
        
        case 'TethUAV'
            input.x0=[0; 0; 0; 0; 0; 0];%zeros(nx,1);
            input.u0=[0; 0];%zeros(nu,1);%
            para0=0;
            
            q = [10, 1, 10, 1, 0.01, 0.01];
            qN = q(1:nyN);
            Q = diag(q);
            QN = diag(qN);
            
            b = 1;
            omegaMax = 10*b;
            fL_min = 0;
            fL_max = 10;

            % upper and lower bounds for states (=nbx)
            lb_x = 0*ones(nbx,1);
            ub_x = omegaMax*ones(nbx,1);

            % upper and lower bounds for controls (=nbu)           
            lb_u = [];
            ub_u = [];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = fL_min;
            ub_g = fL_max;            
            lb_gN = fL_min;
            ub_gN = fL_max;
            
        case 'TethUAV_param'
            input.x0=[0; 0; 0; 0; 0; 0];%zeros(nx,1);
            input.u0=[0; 0];%zeros(nu,1);%
            alpha = 20*pi/180;
            para0=[-alpha; alpha];
            
            q = [10, 30, 10, 30, 0.01, 0.01, 80, 40, 10, 0];
            qN = q(1:nyN);
            Q = diag(q);
            QN = diag(qN);
            
            b = 1;
            omegaMax = 10*b;
            fL_min = 0;
            fL_max = 10;

            % upper and lower bounds for states (=nbx)
            lb_x = 0*ones(nbx,1);
            ub_x = omegaMax*ones(nbx,1);

            % upper and lower bounds for controls (=nbu)           
            lb_u = [];
            ub_u = [];
                       
            % upper and lower bounds for general constraints (=nc)
            lb_g = fL_min;
            ub_g = fL_max;            
            lb_gN = fL_min;
            ub_gN = fL_max;

    end

    % prepare the data
    
    input.lb=repmat([lb_g;lb_x],1,N);
    input.ub=repmat([ub_g;ub_x],1,N); 
    input.lbN=[lb_gN;lb_x];               
    input.ubN=[ub_gN;ub_x]; 
            
    lbu = -inf(nu,1);
    ubu = inf(nu,1);
    for i=1:nbu
        lbu(nbu_idx(i)) = lb_u(i);
        ubu(nbu_idx(i)) = ub_u(i);
    end
            
    input.lbu = repmat(lbu,1,N);
    input.ubu = repmat(ubu,1,N);

    x = repmat(input.x0,1,N+1);  % initialize all shooting points with the same initial state 
    u = repmat(input.u0,1,N);    % initialize all controls with the same initial control
    para = repmat(para0,1,N+1);  % initialize all parameters with the same initial para
    
%     load init_data;    % if you want to use your own initiliazation data
    
    input.x=x;           % states and controls of the first N stages (nx by N+1 matrix)
    input.u=u;           % states of the terminal stage (nu by N vector)
    input.od=para;       % on-line parameters (np by N+1 matrix)
    input.W=Q;           % weights of the first N stages (ny by ny matrix)
    input.WN=QN;         % weights of the terminal stage (nyN by nyN matrix)

    input.lambda=zeros(nx,N+1);
    input.mu=zeros(nc,N);
    input.muN=zeros(ncN,1);
    input.mu_u = zeros(N*nu,1);
    %% Reference generation

    switch settings.model
        case 'ActiveSeat_onlyP'
            cd('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\data\ActiveSeat_onlyP');
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC');
            
        case 'DiM'

            load REF_DiM_2;

            REF_DiM_2 = [REF_DiM_2, zeros(5000,24)];

            data.REF = REF_DiM_2;

        case 'InvertedPendulum'

            data.REF=zeros(1,nx+nu);

        case 'ChainofMasses_Lin'

            data.REF=[7.5,0,0,zeros(1,3*(n-1)),zeros(1,nu)];

        case 'ChainofMasses_NLin'

            data.REF=[1,0,0,zeros(1,3*(n-1)),zeros(1,nu)];

        case 'Hexacopter'

            data.REF = [1 1 1 0 0 0];

        case 'TiltHex'
            data.REF = [];
            
        case 'ActiveSeat'
            data.REF = AS_REF(25,Ts);
            
        case 'TethUAV'
            data.REF = [0 0 pi/6 0 0 0];
            
        case 'TethUAV_param'
            data.REF = zeros(1,ny);
    end
    
end
   