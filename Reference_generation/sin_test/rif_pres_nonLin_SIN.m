function [ rif_pressione, ax, ay ] = rif_pres_nonLin_SIN(Amp, fr)
% Modello nonlineare riferimento pressione di tipo sinusoidale per test

%% parametri simulazione

N_sim = 5000;
Ts = 0.005;

% parametri modello pressorio gli stessi con cui creo il modello mpc

current_path =pwd;
cd ('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\examples');
run Pressure_model_params_nonLin
cd(current_path);

A = 0.016; %area di contatto


% parametri sinusoide ax,ay

t = linspace(0.005,N_sim/200,N_sim);
ay = Amp*sin(2*pi*fr*t);
ax = ay;

%% ODE
tspan = linspace(0.005,N_sim/200,N_sim); % tspan = Ts:Ts:N_sim/200;
y0 = [0;0;0]; % cond iniziali

ode_function = @(t,y) odefun_nonlin(t,y,tspan,ay,m,k1,k2,c1,c2,sigma_0,vs,alpha,MM,ax,g,Fs,Fc);
[t,y] = ode23(ode_function, tspan, y0); %  (funzione da integrare, intervallo di integrazione, cond iniziali)


%% Calcolo uscite
for i = 1:N_sim
    k(i) = k1*(y(i,1)).^2+k2;
    c(i) = c1*(y(i,1)).^2+c2;
    Output_NL(i) = ((k(i)-k2)*y(i,1))+((c(i)-c2)*y(i,2)); % forza che premente
    
end


rif_pressione= Output_NL; %come forza premente


%% save rif_pressione as rif_pressione_calabogie
cd('..\');
cd('..\');
save([pwd,'\data\ActiveSeat_onlyP\rif_pressione_calabogie'],'rif_pressione');

end

