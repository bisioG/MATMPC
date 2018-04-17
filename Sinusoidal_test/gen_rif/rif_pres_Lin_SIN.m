function [ rif_pressione, ax, ay ] = rif_pres_Lin_SIN(Amp, fr)
% Modello nonlineare riferimento pressione di tipo sinusoidale per test

%% parametri simulazione

N_sim = 5000;
Ts = 0.005;

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_Lin
cd(current_path);

A = 0.016; %area di contatto

% parametri sinusoide ax,ay

t = linspace(0.005,N_sim/200,N_sim);
ay = Amp*sin(2*pi*fr*t);
ax = ay;

%% ODE
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0]; % cond iniziali

ode_function = @(t,y) odefun_lin(t,y,tspan,ay,m,k2,c2);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite
for i = 1:N_sim

    F_pres_Lin(i) = k2*y(i,1); % forza di pressione
    damping_Lin(i) = c2*y(i,2);
    
    Output_L(i) = (F_pres_Lin(i)+damping_Lin(i)); %come forza premente 
    
end

rif_pressione = Output_L;

%% save rif_pressione as rif_pressione_calabogie
cd('..\');
cd('..\');
save([pwd,'\data\ActiveSeat_onlyP\rif_pressione_calabogie'],'rif_pressione');

end

