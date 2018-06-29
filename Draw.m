%% Plot results


%% graphic settings

% define colors
blue=[0 0 255]/255;
red=[220 20 60]/255;
orange=[255 165 0]/255;
green=[0 205 102]/255;

legend_size=12; %LEGEND SIZE SETTINGS
title_size=19;  %TITLE SIZE SETTINGS

%% start generating pictures
switch settings.model
    
    case 'ActiveSeat'
        % load the data you saved
        load([pwd,'\data\ActiveSeat/AS_REF_DATA']);
        
        figure
        plot(time(1:end-1),y_sim(:,1))
        hold on; grid on;
        plot(time(1:end-1),REF_XY(1,:))
        lgd = legend('Actual pitch perceived vel.','Reference pitch perceived vel.');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[rad/s]');
        ylim([-0.2 0.2])

        figure
        plot(time(1:end-1),y_sim(:,2))
        hold on; grid on;
        plot(time(1:end-1),REF_XY(2,:))
        lgd = legend('Actual longitudinal perceived acc.','Reference longitudinal perceived acc.')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m/s^2]');

        figure
        plot(time(1:end-1),y_sim(:,3))
        hold on; grid on;
        plot(time(1:end-1),REF_XY(3,:))
        lgd = legend('Actual pitch displacement','Reference pitch displacement')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[rad]');

        figure
        plot(time(1:end-1),y_sim(:,4))
        hold on; grid on;
        plot(time(1:end-1),REF_XY(4,:))
        plot(time(1:end-1),0.75*ones(1,Tf/Ts),'k--')
        plot(time(1:end-1),-0.75*ones(1,Tf/Ts),'k--')
        lgd = legend('Actual longitudinal displacement','Reference longitudinal displacement')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m]');
        ylim([-0.8 0.8])

        figure
        plot(time(1:end-1),y_sim(:,5))
        grid on;
        lgd = legend('Actual longitudinal velocity')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m/s]');
        ylim([-0.5 0.5])

        % plot y-roll

        figure
        plot(time(1:end-1),y_sim(:,7))
        hold on; grid on;
        plot(time(1:end-1),REF_YX(1,:))
        lgd = legend('Actual roll perceived vel.','Reference roll perceived vel.');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[rad/s]');
        ylim([-0.2 0.2])

        figure
        plot(time(1:end-1),y_sim(:,8))
        hold on; grid on;
        plot(time(1:end-1),REF_YX(2,:))
        lgd = legend('Actual lateral perceived acc.','Reference lateral perceived acc.');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m/s^2]');
        ylim([-1 1])

        figure
        plot(time(1:end-1),y_sim(:,9))
        hold on; grid on;
        plot(time(1:end-1),REF_YX(3,:))
        lgd = legend('Actual roll displacement','Reference roll displacement')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[rad]');
        ylim([-0.02 0.02])

        figure
        plot(time(1:end-1),y_sim(:,10))
        hold on; grid on;
        plot(time(1:end-1),REF_YX(4,:))
        plot(time(1:end-1),0.75*ones(1,Tf/Ts),'k--')
        plot(time(1:end-1),-0.75*ones(1,Tf/Ts),'k--')
        lgd = legend('Actual lateral displacement','Reference lateral displacement')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m]');
        ylim([-0.8 0.8])

        figure
        plot(time(1:end-1),y_sim(:,11))
        grid on;
        lgd = legend('Actual lateral velocity')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m/s]');
        
        figure;
        plot(time(1:end-1),rif_pressione(1:Tf/0.005)/0.016) % 0.016  l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end),input_u(:,7)/0.016);
        plot(time(1:end-1),y_sim(:,19)/0.016);
        lgd = legend('Reference lateral trunk pressure','Active seat trunk pressure','Pressure induced by platform motion')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        
    case 'ActiveSeat_onlyP'
        % load the data you saved
       
        load([pwd,'\data\ActiveSeat_onlyP/rif_pressione']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'m','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title('Model: ActiveSeat OnlyP','FontSize',title_size)
        
    case 'ActiveSeat_onlyP_HP'
        % load the data you saved
        
        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'g--','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title(['Model: ActiveSeat OnlyP HP  Test: ',label],'FontSize',title_size,'Interpreter', 'none')
               
    case 'ActiveSeat_onlyP_Lin'
        % load the data you saved
        
        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'m','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title('Model: ActiveSeat OnlyP Linear','FontSize',title_size)
        
     case 'ActiveSeat_onlyP_Lin_HP'
        % load the data you saved
        
        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'m','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title('Model: ActiveSeat OnlyP Linear','FontSize',title_size)
        
     case 'ActiveSeat_onlyP_WOfriction'
        % load the data you saved
        
        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'m','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title('Model: ActiveSeat OnlyP WOfriction','FontSize',title_size)
        
     case 'ActiveSeat_onlyP_WOfriction_HP'
        % load the data you saved
        
        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005),'b','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1),'r','Linewidth',1);
        plot(time(1:end-1),u_true,'m','Linewidth',1);
        plot(time(1:end-1),platform_p,'k--','Linewidth',1);
        lgd = legend('Reference lateral trunk pressure','Pressure induced by platform motion+active seat','Active seat trunk pressure (by difference)','Pressure induced by platform motion')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Pa]');
        title('Model: ActiveSeat OnlyP WOfriction','FontSize',title_size)
        
    
end