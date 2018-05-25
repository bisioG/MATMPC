% GENERAZIONE DEL RIFERIMENTO DI PRESSIO SENZA FILTRO PASSA ALTO
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

%new c2,k2 value

c2=2000;
k2=1000;

%********************

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

%   run plot_rif_pres_laterale

%% plot stifness lineare

%  run lin_stifness_plot

%% plot damping lineare

%  run lin_damping_plot

%% ************** CREAZIONE DEL FILE DI RIFERIMENTO DI PRESSIONE PER MATMPC

rif_pressione= ypf_NL; % il riferimento scelto (rif_pressione variabile utilizzata in matmpc)

% tipi:
% 
% ypf_NL
% ypf_NL_WOfriction
% ypf_L

cd([pwd,'\rif_pressione_saved'])
save('rif_pressione','rif_pressione');
cd('..');

%% *************** CREAZIONE DEI PARAMETRI DI ACCX,ACCY,ROLL DA UTILIZZARE NEL MODELLO MPC

if (strcmp(param_name,'Sinusoidal')==1) || (strcmp(param_name,'Step')==1)

    rif_roll = zeros(length(ax));

    % rif_accX = ax*0.5; %scale
    % rif_accY = ay*0.5;

    rif_accX = ax; %not scale
    rif_accY = ay;

    save([pwd,'\rif_params_saved\rif_params'],'rif_accX','rif_accY','rif_roll');

end