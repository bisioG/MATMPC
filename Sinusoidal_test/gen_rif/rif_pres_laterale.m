
%  Creazione del Modello nonlineare riferimento 

clear all;
clc;
close all;
%% parametri modello
N_sim = 5000;
Ts = 0.005;

% parametri modello pressorio
g = 9.81;

m = 67;
k1 = 12000;
k2 = 1000;
c1 = 200;
c2 = 2000;

% parametri modello di attrito
Fs = 45;
Fd = 30;
sigma_0 = 10^4;
sigma_1 = 0;
sigma_2 = 0;
v_s = 0.005;

% parametri per accoppiamento con accelerazione long.

alpha = 10; % angolo inclinazione sedile
M = 50; % massa in appoggio sul sedile

%% parametri ax,ay *******************************************************

t = linspace(0.005,N_sim/200,N_sim);

Amp = 10;
% fr = 1;
% ay = Amp*sin(2*pi*fr*t);
ay = [zeros(1,100) Amp*ones(1,(length(t)-100))];

ax = ay;

%% ODE nonLin
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,v_s,alpha,M,ax,g,Fs,Fd);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite nonLin
for i = 1:N_sim
    k(i) = k1*(10*y(i,1)).^2+k2;
    F_pres_nonLin(i) = k(i)*y(i,1); % forza di pressione
    F_att(i) = sigma_0*y(i,3)+sigma_2*y(i,3); % forza di attrito [sigma_2=0]
    
    c(i)= c1*(10*y(i,1)).^2+c2;
    damping_nonLin(i) = c(i)*y(i,2);
    ay_corpo_nonLin(i) = ay(i)-F_att(i)/m -damping_nonLin(i)/m-F_pres_nonLin(i)/m;
    pos_nonLin(i)=y(i,1);
    vel_nonLin(i)=y(i,2);
    zm(i) = y(i,3);
    
end


rif_pressione_nonLin = F_pres_nonLin/0.016;



%% ODE Lin
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin(t,y,tspan,ay,m,k2,c2);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite Lin
for i = 1:N_sim

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2);
    ay_corpo_Lin(i) = ay(i)-damping_Lin(i)/m-F_pres_Lin(i)/m;
    
    pos_Lin(i)=y(i,1);
    vel_Lin(i)=y(i,2);
    
end


rif_pressione_Lin = F_pres_Lin/0.016;


%% PLOT

    
    tt=Ts:Ts:N_sim*Ts;


%% Linear vs NonLinear

    figure
    plot(tt,m*ay,'--')
    xlim([0 20])
    hold on
    plot(tt,F_pres_nonLin)
    plot(tt,F_pres_Lin)
    plot(tt,F_att,'k--')
    legend('Forza inerzia generata(m*ay)','Forza elastica NONLin','Forza elastica Lin','Forza attrito')
    xlabel('time [s]')
    ylabel('force [N]')
    title('Nonlinear vs Linear lateral model')
    
%% NonLinear contributors

    figure
    plot(tt,m*ay)
    xlim([0 1.5])
%     xlim([0 5*1/fr])
    hold on
    plot(tt,m*ay_corpo_nonLin)   
    plot(tt,F_pres_nonLin,'--')
    plot(tt,damping_nonLin,'--')
    plot(tt,F_att,'k--')
    legend('Inerzia generata (m*ay)','Inerzia subita (m*ay corpo)','Forza elastica','Effetto smorzamento','Forza attrito')
    xlabel('time [s]')
    ylabel('force [N]')
    title('Nonlinear contributors')
    
%% position NONLin

% figure
% plot(tt,pos_nonLin)
% hold on
% plot(tt,vel_nonLin)
% xlim([0 2])
% % ylim([0 0.3])
% legend('posizione corpo NONLin','velocita` corpo NONLin')
% xlabel('time [s]')
% ylabel('m')
% title('Nonlinear positions and velocity')
    
%% Linear contributors

%     figure
%     plot(tt,m*ay)
%     hold on
% % xlim([0 10])
%     xlim([0 5*1/fr])
%     plot(tt,m*ay_corpo_Lin)
%     plot(tt,F_pres_Lin)
%     plot(tt,damping_Lin)
%     legend('Inerzia generata (m*ay)','Inerzia subita (m*ay corpo)','Forza elastica','Effetto smorzamento')
%     xlabel('time [s]')
%     ylabel('force [N]')
%     title('Linear contributors')

%% Linear position and velocity

% figure
% plot(tt,pos_Lin)
% hold on
% plot(tt,vel_Lin)
% % xlim([0 2])
% % ylim([0 0.3])
% legend('posizione corpo Lin','velocita` corpo Lin')
% xlabel('time [s]')
% ylabel('m')
% title('Linear positions and velocity')

%%
% figure
% plot(rif_pressione_Lin)
% hold on
% plot(rif_pressione_nonLin)
% legend('rif pressione Lin','rif pressione nonLin')

%%

% figure
% plot(tt,F_att)
% hold on
% legend('Forza attrito')
