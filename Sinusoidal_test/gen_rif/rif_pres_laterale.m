
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;
%% parametri simulazione

N_sim = 5000;
Ts = 0.005;

%% parametri ax,ay *******************************************************

t = linspace(0.005,N_sim/200,N_sim);

Amp = 10;
fr = 1;
 ay = Amp*sin(2*pi*fr*t);
% ay = [zeros(1,100) Amp*ones(1,(length(t)-100))];

ax = ay;

%% ODE nonLin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_nonLin
cd(current_path);

A = 0.016; %area di contatto

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite nonLin
for i = 1:N_sim
    k(i) = k1*(y(i,1)).^2+k2; 
    F_el_nonLin(i) = k(i)*y(i,1); % forza di elastica
    F_att(i) = sigma_0*y(i,3); % forza di attrito [sigma_2=0]
    
    c(i)= c1*(y(i,1)).^2+c2;
    damping_nonLin(i) = c(i)*y(i,2); %forza damping
    ay_corpo_nonLin(i) = ay(i)-F_att(i)/m -damping_nonLin(i)/m-F_el_nonLin(i)/m;
    pos_nonLin(i)=y(i,1);
    vel_nonLin(i)=y(i,2);
    zm(i) = y(i,3);
    
    
    elastic_effect(i)=(k(i)-k2)*y(i,1);
    damping_effect(i)=(c(i)-c2)*y(i,2);
    
    Output_NL(i)= elastic_effect(i)+damping_effect(i);
    
end

%% ODE nonLin_WOfriction

% parametri modello pressorio gli stessi con cui creo il modello mpc

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_WOfriction(t,y,tspan,ay,m,k1,k2,c1,c2);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite nonLin WOfriction
for i = 1:N_sim
    k(i) = k1*(y(i,1)).^2+k2; 
    F_el_nonLin_WOfriction(i) = k(i)*y(i,1); % forza di elastica
    c(i)= c1*(y(i,1)).^2+c2;
    damping_nonLin_WOfriction(i) = c(i)*y(i,2); %forza damping
    ay_corpo_nonLin_WOfriction(i) = ay(i)-damping_nonLin_WOfriction(i)/m-F_el_nonLin_WOfriction(i)/m;
    pos_nonLin_WOfriction(i)=y(i,1);
    vel_nonLin_WOfriction(i)=y(i,2);
    
    
    Output_NL_WOfriction(i)=((k(i)-k2)*y(i,1)) + ((c(i)-c2)*y(i,2));
    
end


%% ODE Lin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_Lin
cd(current_path);

A = 0.016; %area di contatto

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0]; % cond iniziali


ode_function = @(t,y) odefun_lin(t,y,tspan,ay,m,k2,c2);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


% A=[0 1; -k2/m -c2/m];
% B=[0 1]';
% C=[k2 c2];


%% Calcolo uscite Lin
for i = 1:N_sim

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2);
    ay_corpo_Lin(i) = ay(i)-damping_Lin(i)/m-F_pres_Lin(i)/m;
    
    pos_Lin(i)=y(i,1);
    vel_Lin(i)=y(i,2);
    
end


Output_L = F_pres_Lin+damping_Lin;

%% plots

%  run plot_rif_pres_laterale

%% plot stifness lineare

 run lin_stifness_plot

%% plot damping lineare

 run lin_damping_plot



