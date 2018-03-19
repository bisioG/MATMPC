function dydt = odefun_acado_calabogie(t,y,time,ay,m,k1,k2,c1,c2,sigma_0,v_s,alpha,M,ax,g,Fs,Fc)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t
ax = interp1(time,ax,t);

% calcolo forza di attrito secondo il modello di de Wit
F_att = sigma_0*y(3);

% Calcolo parametri con accoppiamento accelerazione longitudinale
N = m*ax*cosd(alpha) + M*g*sind(alpha);
g_N = 1/(pi)*atan(N)+0.55;
F_s = Fs*g_N; % attrito statico
F_c = Fc*g_N; % attrito dinamico

dydt = [y(2); ...
       -(c1*(10*y(1)).^2+c2)/m.*y(2)-(k1*(10*y(1)).^2+k2)/m.*y(1)+ay-F_att/m; ... 
       y(2)-abs(y(2))*y(3)/((F_c+(F_s-F_c)*exp(-(y(2)/v_s)^2))/sigma_0)]; 
