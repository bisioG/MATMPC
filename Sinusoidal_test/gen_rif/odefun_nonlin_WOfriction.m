function dydt = odefun_nonlin_WOfriction(t,y,time,ay,m,k1,k2,c1,c2)

ay = interp1(time,ay,t); % Interpolate the data set (gt,g) at time t


dydt = [y(2); ...
       -(c1*(y(1)).^2+c2)/m.*y(2)-(k1*(y(1)).^2+k2)/m.*y(1)+ay; ... 
        ]; 
