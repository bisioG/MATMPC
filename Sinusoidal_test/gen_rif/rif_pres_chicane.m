% Modello nonlineare con modello di attrito di de Wit, i parametri F_c e 
% F_s variano secondo l'accelerazione longitudinale 

clc
clear
% close all


%% parametri modello
N_sim = 2500;
Ts = 0.005;

% parametri modello pressorio
g = 9.81;
load ay2.mat
ay = -IN1_YX(1:N_sim)*g; % trasformo in m/s^2
m = 67;
k1 = 12000;
k2 = 1000;
c1 = 200;
c2 = 2000;

% parametri modello di attrito
Fs = 45;
Fc = 30;
sigma_0 = 10^4;
sigma_1 = 0;
sigma_2 = 0;
v_s = 0.005;

% parametri per accoppiamento con accelerazione long.
load ax2.mat
ax = IN1_XY(1:N_sim)*g;
alpha = 10; % angolo inclinazione sedile
M = 50; % massa in appoggio sul sedile


%% ODE
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,v_s,alpha,M,ax,g,Fs,Fc);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite
for i = 1:N_sim
    k(i) = k1*(10*y(i,1)).^2+k2;  
    F_pres(i) = k(i)*y(i,1); % forza elastica 
    
    F_att(i) = sigma_0*y(i,3)+sigma_2*y(i,2); % forza di attrito
end

%% PLOT

tt=Ts:Ts:N_sim*Ts;

figure
plot(tt,ay)
hold on
plot(tt,y(:,1:2))
legend('a_y','x','x''')
xlabel('time [s]')

figure
plot(tt,m*ay)
hold on
plot(tt,F_pres)
plot(tt,F_att,'k')
legend('may','kx','friction force')
xlabel('time [s]')
ylabel('force [N]')
title('Nonlinear lateral model')


%%
rif_pressione = F_pres/0.016;
figure
plot(rif_pressione)
legend('rif pressione chicane')