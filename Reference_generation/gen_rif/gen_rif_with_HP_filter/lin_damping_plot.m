%% scrip per plottare il comportamento dello smorzamento lineare e confrontarlo con il nonlineare

legend_size=12; %LEGEND SIZE SETTINGS
title_size=19;  %TITLE SIZE SETTINGS

% parametri di partenza
c1=20000;
c2=2000;


x=[-0.10:0.001:0.10];
for i=1:length(x)
C(i) = c1*(x(i)).^2+c2;
end

% calcolo del k medio e limiti di posizione del corpo
x_hlim = max(abs(pos_nonLin));
c_hlim = c1*x_hlim.^2+c2;
x_llim = min(abs(pos_nonLin));
c_llim = c1*x_llim.^2+c2;

k_lin = (c_hlim-c_llim)/2+c_llim;

%calcolo rette
m1 = (c_hlim-c_llim)/(x_hlim-x_llim);
m2 = -m1;
q=c2;
x1=[0:0.001:0.1];
x2= -x1;
y1=x1*m1+q;
y2=x2*m2+q;



%% plot

figure
plot(x,C,'m','Linewidth',1)
title('Detail damping function')


figure
plot(x,C,'m','Linewidth',1)
% ylim([0 c_hlim+1000])
hold on
plot(x,500*ones(1,length(x)),'b','Linewidth',1)
plot(x,k_lin*ones(1,length(x)),'g','Linewidth',1)
% plot(x1,y1,'y','Linewidth',1)
% plot(x2,y2,'y','Linewidth',1)

 line([x_hlim x_hlim], [0 3000],'Color','red','LineStyle','--','Linewidth',1)
 line([-x_hlim -x_hlim], [0 3000],'Color','red','LineStyle','--','Linewidth',1)
 line([-0.1 0.1], [c_hlim c_hlim],'Color','black','LineStyle','--','Linewidth',1)
 line([-0.1 0.1], [c_llim c_llim],'Color','black','LineStyle','--','Linewidth',1)
lgd = legend('c(x)','c = 500', ['c'' = ',num2str(k_lin)])
lgd.FontSize= legend_size;
title(['Damping function,Input signal fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size);
