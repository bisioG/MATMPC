%% PLOT rif_pres_laterale_HP.m*****************************************************************

    
    tt=Ts:Ts:N_sim*Ts;
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS


%% ********** compare signals filtered vs not filtered **********************

%%  NON_LINEAR case

figure;
plot(tspan,yp_NL)
hold on
plot(tspan,ypf_NL)
lgd = legend('Input Data','Filtered Data')
lgd.FontSize = legend_size;
title(['Compare NON-Linear signals,test: ', param_name ],'FontSize',title_size)
grid on


%% LINEAR case

figure;
plot(tspan,yp_L)
hold on
plot(tspan,ypf_L)
lgd = legend('Input Data','Filtered Data')
lgd.FontSize = legend_size;
title(['Compare Linear signals,test: ', param_name ],'FontSize',title_size)
grid on

%% NON-LINEAR WO FRICTION case

figure;
plot(tspan,yp_NL_WOfriction)
hold on
plot(tspan,ypf_NL_WOfriction)
lgd = legend('Input Data','Filtered Data')
lgd.FontSize = legend_size;
title(['Compare NON-Linear WO friction signals,test: ', param_name ],'FontSize',title_size)
grid on

