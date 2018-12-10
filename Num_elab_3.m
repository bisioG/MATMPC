%% *************** CALCOLO PRESSIONI PERCEPITE ***************************************

N_sim = 5000;
tspan = linspace(0,25,Tf/Ts);
    
    % pressione piattaforma percepita

    y0 = [0];
    dydt = @(t,y)[(-1/tau_hp)*y+interp1(tspan,platform_p',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    platform_p_hp= (-1/tau_hp)*G_hp_mpc*y +G_hp_mpc*interp1(tspan,platform_p',t);

    % pressione active seat percepita dopo azionamento valvole

    y0 = [0];
    dydt = @(t,y)[(-1/tau_lp)*y+interp1(tspan,input_u(1:end-1)',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    input_u_lp= (1/tau_lp)*G_lp_mpc*y;

    y0 = [0];
    dydt = @(t,y)[(-1/tau_hp)*y+interp1(tspan,input_u_lp',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    input_u_hp= (-1/tau_hp)*G_hp_mpc*y + G_hp_mpc*interp1(tspan,input_u_lp',t);
    
    %pressione cuscinetto dopo azionamento valvola
    
    y0 = [0];
    dydt = @(t,y)[(-1/tau_lp)*y+interp1(tspan,pc',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_lp= (1/tau_lp)*G_lp_mpc*y;

    %pressione cuscinetto dopo azionamento valvola (positiva)
    
    y0 = [0];
    dydt = @(t,y)[(-1/tau_lp)*y+interp1(tspan,pc_p',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_p_lp= (1/tau_lp)*G_lp_mpc*y;
    
    %pressione cuscinetto dopo azionamento valvola (negativa)
    
    y0 = [0];
    dydt = @(t,y)[(-1/tau_lp)*y+interp1(tspan,pc_n',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_n_lp= (1/tau_lp)*G_lp_mpc*y;
    
    if strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
        
    %filtro 30hz per rumore da integrazione dovuto a LP
    
    y0 = [0];
    dydt = @(t,y)[(-30)*y+interp1(tspan,pc_n',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_n_f= (30)*G_lp_mpc*y;
    
    %filtro 30hz per rumore da integrazione dovuto a LP
    
    y0 = [0];
    dydt = @(t,y)[(-30)*y+interp1(tspan,pc_p',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_p_f= (30)*G_lp_mpc*y;
    
    %filtro 30hz per rumore da integrazione dovuto a LP
    
    y0 = [0];
    dydt = @(t,y)[(-30)*y+interp1(tspan,pc',t)]; 
    [t,y] = ode45(dydt, tspan, y0); 
    pc_f= (30)*G_lp_mpc*y;
    
    end


%% **********CALCOLO PARAMETRI ATTRITO

if strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin')|| strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP')||strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')
    
else

for i = 1:length(state_sim(:,1))-1
    
    N(i)= m*data.PAR(i,1)*cos(pi/180*alpha)+MM*g*sin(pi/180*alpha) ; %Fn = normale al poggia schiena
    f_tan(i)= 1/(pi)*atan(N(i))+0.6 ;
    
    F_attr(i) = sigma_0*state_sim(i,3); %forza attrito de wit
    
end

F_s = f_tan.*Fs.*N; % forza di attrito statico
F_d = f_tan.*Fc.*N; % forza di attrito dinamico

end
