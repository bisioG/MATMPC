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
    N  = settings.N;             % No. of shooting points
    nbx = settings.nbx;
    nbu = settings.nbu;
    nbu_idx = settings.nbu_idx;
    
 %% **********************MODIFICA VELOCE PESI****************************
    if strcmp(settings.model,'ActiveSeat_onlyP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin')||strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')||...
            strcmp(settings.model,'ActiveSeat_onlyP_HP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP')||strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP')
        Wq_t(1) = 10;
        Wr3_t(1)= 0.1;
    end
%% ************************IMPOSTAZIONE PESI E LIMITI *************************

    
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

%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
        case 'ActiveSeat_onlyP_HP'
            
            input.x0 = [0, 0.0001, 0, 0, 0, 0, 0]'; %AGGIUNTA DUE STATI
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];
    
%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
      case 'ActiveSeat_onlyP_Lin'
            
            input.x0 = [0, 0.0001, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];         

%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
       case 'ActiveSeat_onlyP_Lin_HP'
            
            input.x0 = [0, 0.0001, 0, 0, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];         

%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
      case 'ActiveSeat_onlyP_WOfriction'
            
            input.x0 = [0, 0.0001, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];         

%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
       case 'ActiveSeat_onlyP_WOfriction_HP'
            
            input.x0 = [0, 0.0001, 0, 0, 0, 0]';
            input.u0 = zeros(nu,1);
            para0 = [0 0 0];         

%             Wq_t(1) = 10; % peso sull'unica uscita pressione totale ypress

            Wq = diag(Wq_t); % diag matrix coi pesi

%             Wr3_t(1)= 0.1;
            Wr3 = diag(Wr3_t); % diag matrix coi pesi
            
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
            
           
    end

%% prepare the data
    
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
    
    main_folder= 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC'; %change with MATMPC main folder
    switch settings.model
        case 'ActiveSeat_onlyP'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
         
        case 'ActiveSeat_onlyP_HP'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
            
        case 'ActiveSeat_onlyP_Lin'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
            
        case 'ActiveSeat_onlyP_Lin_HP'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
            
        case 'ActiveSeat_onlyP_WOfriction'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
            
        case 'ActiveSeat_onlyP_WOfriction_HP'
            cd([main_folder,'\data\ActiveSeat_onlyP']);
            data.REF = AS_REF_onlyP(25,Ts);
            data.PAR = AS_PAR(25,Ts);
            cd(main_folder);
        
        case 'ActiveSeat'
            cd([main_folder,'\data\ActiveSeat']);
            data.REF = AS_REF(25,Ts);
            cd(main_folder);
                       
 
    end
    
end
   