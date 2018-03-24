function [ rif_pressione, ax, ay ] = rif_pres_nonLin_SIN(Amp, fr)
% Modello nonlineare riferimento pressione di tipo sinusoidale per test

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
Fc = 30;
sigma_0 = 10^4;
sigma_1 = 0;
sigma_2 = 0;
v_s = 0.005;

% parametri per accoppiamento con accelerazione long.

alpha = 10; % angolo inclinazione sedile
M = 50; % massa in appoggio sul sedile

% parametri sinusoide ax,ay

t = linspace(0.005,N_sim/200,N_sim);
ay = Amp*sin(2*pi*fr*t);
ax = ay;

%% ODE
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,v_s,alpha,M,ax,g,Fs,Fc);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite
for i = 1:N_sim
    k(i) = k1*(10*y(i,1)).^2+k2;
    F_pres(i) = k(i)*y(i,1); % pressione
    
    F_att(i) = sigma_0*y(i,3)+sigma_2*y(i,2); % forza di attrito
end


rif_pressione= F_pres/0.016;


%% save rif_pressione_calabogie_fr
cd('..\');
cd('..\');
save([pwd,'\data\ActiveSeat_onlyP\rif_pressione_calabogie'],'rif_pressione');

end

