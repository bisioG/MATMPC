%% PLOT rif_pres_laterale_HP.m*****************************************************************

    
    tt=Ts:Ts:N_sim*Ts;
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS


%% ********** compare signals filtered vs not filtered **********************

%%  NON_LINEAR case

figure;
plot(tspan,yp_NL,'r--','Linewidth',1)
% xlim([0 3*1/fr])
%xlim([0 3])
hold on
plot(tspan,ypf_NL,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
title(['Compare NON-Linear model,test: ', param_name ],'FontSize',title_size)
grid on


%% LINEAR case

figure;
plot(tspan,yp_L,'r--','Linewidth',1)
%xlim([0 3*1/fr])
%xlim([0 3])
hold on
plot(tspan,ypf_L,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
title(['Compare Linear model,test: ', param_name ],'FontSize',title_size)
grid on

%% NON-LINEAR WO FRICTION case

figure;
plot(tspan,yp_NL_WOfriction,'r--','Linewidth',1)
% xlim([0 3*1/fr])
%xlim([0 3])
hold on
plot(tspan,ypf_NL_WOfriction,'b--','Linewidth',1)
lgd = legend('Ref. Pressure','Ref. Pressure Filtered');
lgd.FontSize = legend_size;
title(['Compare NON-Linear WO friction model,test: ', param_name ],'FontSize',title_size)
grid on

