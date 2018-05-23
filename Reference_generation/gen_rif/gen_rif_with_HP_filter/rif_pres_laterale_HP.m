% VERSIONE: GENERAZIONE DEL RIFERIMENTO DI PRESSIONE CON FILTRO PASSA ALTO
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;

%% parametri comuni della simulazione

N_sim = 5000;
Ts = 0.005;
t = linspace(0.005,N_sim/200,N_sim);

%% parametri ax,ay  SINUSOIDE *******************************************************

% param_name = 'Sinusoidal';
% Amp = 10;
% fr = 5;
% ay = Amp*sin(2*pi*fr*t);
% ax = ay;

%% parametri ax,ay GRADINO ************************************************************

% param_name = 'Step';
% Amp = 10;
% ay = [zeros(1,100) Amp*ones(1,(length(t)-100))];
% ax = ay;

%% parametri ax,ay CALABOGIE *********************************************************

param_name = 'Calabogie track';
g=9.81;
load ('acc_data\ay.mat')
load ('acc_data\ax.mat')
ax = IN1_XY(1:N_sim)*g;
ay = IN1_YX(1:N_sim)*g; % trasformo in m/s^2

%% parametri ax,ay CHICANE **********************************************************

% param_name = 'Chicane section';
% g =9.81;
% load ('acc_data\ay2.mat')
% load ('acc_data\ax2.mat')
% ay = -IN1_YX(1:N_sim)*g; % trasformo in m/s^2
% ax = IN1_XY(1:N_sim)*g;

%% *************** PARAMETRI FILTRAGGIO

tau_hp = 21; %[secondi]


%% ODE nonLin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_nonLin
cd(current_path);

A = 0.016; %area di contatto

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_hpfilter(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


% Calcolo uscite nonLin
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
    
    Output_NL(i)= elastic_effect(i)+damping_effect(i); %forza premente 
    ypf_NL(i) = (-1/tau_hp)*y(i,4)+ Output_NL(i)./A; %pressione filtrata
end

yp_NL = Output_NL./A;       %pressione non filtrata
    

%% ODE nonLin_WOfriction

% parametri modello pressorio sono gli stessi del caso non-lineare

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin_WOfriction_hpfilter(t,y,tspan,ay,m,k1,k2,c1,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


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
    ypf_NL_WOfriction(i) = (-1/tau_hp)*y(i,3)+ Output_NL_WOfriction(i)./A;
    
end

yp_NL_WOfriction = Output_NL_WOfriction./A;

%% ODE Lin

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_Lin
cd(current_path);

%new c2,k2 value

c2=2000;
k2=1000;

%********************

A = 0.016; %area di contatto

tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali


ode_function = @(t,y) odefun_lin_hpfilter(t,y,tspan,ay,m,k2,c2,tau_hp,A);
[t,y] = ode45(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%stace state Linear model

% A=[0 1; -k2/m -c2/m];
% B=[0 1]';
% C=[k2 c2];


%% Calcolo uscite Lin
for i = 1:N_sim

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2); %smorzamento
    ay_corpo_Lin(i) = ay(i)-damping_Lin(i)/m-F_pres_Lin(i)/m;
    
    pos_Lin(i)=y(i,1);
    vel_Lin(i)=y(i,2);
    
    Output_L(i) = F_pres_Lin(i)+damping_Lin(i);  %forza premente
    ypf_L(i) = (-1/tau_hp)*y(i,3)+ Output_L(i)./A; %pressione filtrata
    
end

yp_L = Output_L./A;


%**************************************************************************

%% plots delle componenti del segnale pressorio NON filtrato (studio del segnale pressorio)
%  run plot_rif_pres_laterale

%% plots confronto tra segnali filtrati e non filtrati
   run plot_rif_pres_laterale_HP

%% plot stifness lineare
%  run lin_stifness_plot

%% plot damping lineare
%  run lin_damping_plot



