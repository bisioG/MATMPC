%% scrip per plottare il comportamento della rigidezza lineare e confrontarlo con il nonlineare

legend_size=12; %LEGEND SIZE SETTINGS
title_size=19;  %TITLE SIZE SETTINGS

% parametri di partenza
k1=1200000;
k2=1000;


x=[-0.10:0.001:0.10];
for i=1:length(x)
K(i) = k1*(x(i)).^2+k2;
end

% calcolo del k medio e limiti di posizione del corpo
x_hlim = max(abs(pos_nonLin));
k_hlim = k1*x_hlim.^2+k2;
x_llim = min(abs(pos_nonLin));
k_llim = k1*x_llim.^2+k2;

k_lin = (k_hlim-k_llim)/2+k_llim;

%calcolo rette
m1 = (k_hlim-k_llim)/(x_hlim-x_llim);
m2 = -m1;
q=k2;
x1=[0:0.001:0.1];
x2= -x1;
y1=x1*m1+q;
y2=x2*m2+q;

%% plot
figure
plot(x,K,'m','Linewidth',1)
ylim([0 k_hlim+1000])
hold on
plot(x,6000*ones(1,length(x)),'b','Linewidth',1)
plot(x,k_lin*ones(1,length(x)),'g','Linewidth',1)
% plot(x1,y1,'y','Linewidth',1)
% plot(x2,y2,'y','Linewidth',1)

 line([x_hlim x_hlim], [-2000 14000],'Color','red','LineStyle','--','Linewidth',1)
 line([-x_hlim -x_hlim], [-2000 14000],'Color','red','LineStyle','--','Linewidth',1)
 line([-0.1 0.1], [k_hlim k_hlim],'Color','black','LineStyle','--','Linewidth',1)
 line([-0.1 0.1], [k_llim k_llim],'Color','black','LineStyle','--','Linewidth',1)
lgd = legend('k(x)','k = 6000', ['k'' = ',num2str(k_lin)]);
lgd.FontSize = legend_size;
title(['Spring function,Input signal fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size);