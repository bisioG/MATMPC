function dydt = odefun_lin(t,y,time,ay,m,k2,c2)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t
% ax = interp1(time,ax,t);

% calcolo forza di attrito secondo il modello di de Wit
% F_att = sigma_0*y(3);

% Calcolo parametri con accoppiamento accelerazione longitudinale
% N = m*ax*cosd(alpha) + M*g*sind(alpha);
% g_N = 1/(pi)*atan(N)+0.55;
% F_s = Fs*g_N; % attrito statico
% F_c = Fc*g_N; % attrito dinamico

dydt = [y(2); ...
       -(c2)/m.*y(2)-(k2)/m.*y(1)+ay; ... 
       ]; 
