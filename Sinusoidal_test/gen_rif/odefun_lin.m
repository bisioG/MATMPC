function dydt = odefun_lin(t,y,time,ay,m,k2,c2)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t


dydt = [y(2); ...
       -(c2)/m.*y(2)-(k2)/m.*y(1)+ay; ... 
       ]; 
