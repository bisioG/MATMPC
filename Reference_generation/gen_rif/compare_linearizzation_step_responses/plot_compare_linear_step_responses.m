

load setting_time
tt=Ts:Ts:N_sim*Ts;

legend_size=12; %LEGEND SIZE SETTINGS
title_size=19;  %TITLE SIZE SETTINGS

%% ****


figure
load accy
plot(tt,(m*ay)/0.016,'g','Linewidth',1)
xlim([0 1.5])
hold on
load yp_L_cunico
plot(tt,yp_L,'--','Linewidth',1)
load yp_L_6000
plot(tt,yp_L,'--','Linewidth',1)
load yp_L_4500
plot(tt,yp_L,'r--','Linewidth',1)
load yp_L_4000
plot(tt,yp_L,'m--','Linewidth',1)
load yp_L_2000
plot(tt,yp_L,'k--','Linewidth',1)
load yp_L_1000
plot(tt,yp_L,'b--','Linewidth',1)
load yp_NL
plot(tt,yp_NL,'--','Linewidth',1)

lgd=legend('Reference Pressure (m*ay)/A','Pressure k = 6000 c=500','Pressure k = 6000 c=2000','Pressure k = 4500 c=2000','Pressure k = 4000 c=2000','Pressure k = 2000 c=2000','Pressure k = 1000 c=2000','Pressure NL model');
lgd.FontSize= legend_size;
xlabel('time [s]')
ylabel('force [N]')

title('Step response with different k value','FontSize',title_size)
grid on
