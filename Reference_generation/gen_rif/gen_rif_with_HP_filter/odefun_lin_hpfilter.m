function dydt = odefun_lin(t,y,time,ay,m,k2,c2,tau_hp,A)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t

k = (k2)*y(1); %elastic force
c = (c2)*y(2); %damping


dydt = [y(2); ...
       -(c2)/m.*y(2)-(k2)/m.*y(1)+ay; ... 
       (-1/tau_hp)*y(3)+(c+k)/A]; 
