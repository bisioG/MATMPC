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
    
    if strcmp(settings.model,'ActiveSeat')
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
        
        
    else
        
        if  strcmp(settings.model,'ActiveSeat_onlyP_HP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP_LP')||...
                strcmp(settings.model,'ActiveSeat_onlyP_HP_LP_v2')
           
       
        % load the references
       
        load([pwd,'\data\ActiveSeat_onlyP/rif_pressione']);
        
        %% figure MATMPC
        
        figure;        
        plot(time(1:end-1),rif_pressione_hp(1:Tf/0.005)./10^5,'b','Linewidth',2);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1)./10^5,'r--','Linewidth',3);
        lgd = legend('Reference perceived pressure','Pressure perceived induced by platform motion+active seat');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
        %title(['[MPC] Perceived pressure, Model: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
    
        %% compare reference
        
        figure;        
        plot(time(1:end-1),rif_pressione_hp(1:Tf/0.005)./10^5,'b','Linewidth',2);
        hold on; grid on;
        plot(time(1:end-1),rif_pressione(1:Tf/0.005)./10^5,'r','Linewidth',2);
        lgd = legend('Reference pressure perceived y_{pf}','Reference pressure y_p');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
        %title(['Compare reference, Model: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        
        %% MPC perceived pressure contributor 1
        
%         figure;
%         plot(time(1:end-1),y_sim(:,1)./10^5,'r--','Linewidth',1);
%         hold on; grid on;
%         plot(time(1:end-1),platform_p_hp(1:Tf/0.005)./10^5,'k','Linewidth',1);
%         plot(time(1:end-1),input_u_hp./10^5,'g','Linewidth',1);%control with mpc
%         %plot(time(1:end-1),input_u_hp./10^5+platform_p_hp(1:Tf/0.005)./10^5,'b','Linewidth',1);
%         lgd = legend('Active seat + platform pressure perceived','Platform pressure perceived','Active seat contact pressure perceived');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[(m/s)^2]-[Bar]');
%         title(['[MPC] control contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%  


   % not HP-LP models
%     elseif strcmp(settings.model,'ActiveSeat_onlyP')||...
%             strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')||...
%             strcmp(settings.model,'ActiveSeat_onlyP_Lin')||...
%             strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')

    else
        % load the references
       
        load([pwd,'\data\ActiveSeat_onlyP/rif_pressione']);
        
        %% figure MATMPC
        
        figure;        
        plot(time(1:end-1),rif_pressione(1:Tf/0.005)./10^5,'k','Linewidth',1);   % 0.016 è l'area del cuscinetto
        hold on; grid on;
        plot(time(1:end-1),y_sim(:,1)./10^5,'r--','Linewidth',2);
        lgd = legend('Reference','Pressure induced by platform motion+active seat');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
        title(['[MPC], reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
    end
        
        %% control by difference
        
        figure;
        plot(time(1:end-1),rif_pressione(1:Tf/0.005)./10^5,'r','Linewidth',1);
        hold on; grid on;
        plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'k','Linewidth',1);
        plot(time(1:end-1),u_diff./10^5,'b--','Linewidth',1);
        lgd = legend('Reference pressure (not hp)','Platform pressure','Contact pressure (by difference)');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[(m/s)^2]-[Bar]');
        title(['[Control by difference], reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
   
        %% figure compare input AS
        
%         figure;        
%         hold on; grid on;
%         plot(time(1:end-1),u_diff./10^5,'r--','Linewidth',1); %control by difference 
%         plot(time(1:end-1),input_u(1:end-1)./10^5,'g--','Linewidth',1); %control with mpc
%         lgd = legend('Contact pressure (by difference)','Contact pressure (MPC,hp)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[Bar]');
%         title(['Compare contact pressure, Model: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        %% body position and acc
        
%         figure;        
%         plot(time(1:end-1),state_sim(1:end-1,1),'b','Linewidth',1);
%         hold on; grid on;
%         
%         if strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
%        
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,1)./100,'r','Linewidth',1);%accX
%         else
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,3)./100,'r','Linewidth',1);%accY
%         end
%         
%         lgd = legend('Body position dy','Acceleration of the platform (scaled by 100)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[m]-[(m/s)^2]');
%         title(['Body position, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        %% platform pressure
        
%         figure;        
%         plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'b','Linewidth',1);
%         hold on; grid on;
%         
%         if strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
%        
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,1)./100,'r','Linewidth',1);
%         else
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,3)./100,'r','Linewidth',1);
%         end
%         
%         lgd = legend('Pressure induce by the platform moviments','Acceleration of the platform (scaled by 100)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[Bar]-[(m/s)^2]');
%         title(['Platform pressure, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
%  %%*********************** plot pressione del cuscinetto, raggio di curvatura e profondita` di penetrazione           
%         
%         %% radius
%         figure;
%         plot(time(1:end-1),r,'r--','Linewidth',1);
%         hold on
%         lgd = legend('Radius R(u)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[m]');
%         title(['Contact contributions: Radius , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        %% profondita` di penetrazione
        
        figure;
        plot(time(1:end-1),d,'r','Linewidth',2);
        hold on;grid on;
        plot(time(1:end-1),delta_R,'k--','Linewidth',2);
        %plot(time(1:end-1),state_sim(1:end-1,1),'g--','Linewidth',2);
        plot(time(1:end-1),position,'g--','Linewidth',2);
        lgd = legend('Penetration depth d','Variation of curvature radius \Delta R','Position of the body d_y');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[m]');
        %title(['Contact contributions: Penetration depth , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        %% contributi vari
%         figure;
%         plot(time(1:end-1),d,'r','Linewidth',1);
 %        hold on
%         plot(time(1:end-1),temp3,'b--','Linewidth',1);
    %     plot(time(1:end-1),temp1,'m--','Linewidth',1);
%        plot(time(1:end-1),temp2,'g--','Linewidth',1);
% %         plot(time(1:end-1),r,'k--','Linewidth',1);
%       plot(time(1:end),state_sim(:,1)-0.001,'r--','Linewidth',1);
%         plot(time(1:end-1),delta_R,'k--','Linewidth',1);
%         plot(time(1:end-1),rif_pressione(1:Tf/0.005)./10^5,'b','Linewidth',1);
%         %lgd = legend('Penetration depth d','\Delta R','Position of the body d_y');
%         %lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[m]');
%         title(['Contact contributions: Penetration depth , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')

        %% pressioni (cuscinetto,contatto)
        
        figure;
        plot(time(1:end-1),pc./10^5,'k','Linewidth',2);
        hold on;grid on;
        xlim([0 15]);
        plot(time(1:end),input_u./10^5,'r','Linewidth',2);
        %plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'g','Linewidth',1);
        lgd = legend('Bladder pressure p_c','Contact pressure p_0');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
        %title(['Pressure contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        
         %% pressioni (riferimento,piattaforma e contatto)
         
        figure;
        plot(time(1:end-1),rif_pressione_hp(1:Tf/0.005)./10^5,'b','Linewidth',2);
        hold on;grid on;
        plot(time(1:end),input_u./10^5,'r','Linewidth',2);
        plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'g','Linewidth',2);
        lgd = legend('Reference pressure perceived y_{pf}','Contact pressure p_0','Platform pressure');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
       % title(['Pressure contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        
        
        %% pressione cuscinetto e dinamica corpo
        
%         figure;
%         plot(time(1:end-1),pc./10^5,'k','Linewidth',1);
%         hold on;
%         plot(time(1:end-1),state_sim(1:end-1,1),'b','Linewidth',1);
%         
%         if strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
%        
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,1),'r','Linewidth',1);
%         else
%                 plot(time(1:end-1),data.PAR(1:Tf/0.005,3),'r','Linewidth',1);
%         end
%         
%         lgd = legend('Valve pressure','Body position','Platform acceleration');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[Bar]-[(m/s)^2]');
%         title(['Pressure contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        %% body position and contact pressure
        
%         figure;        
%         plot(time(1:end-1),state_sim(1:end-1,1),'b','Linewidth',1);
%         hold on; grid on;
%         plot(time(1:end),input_u./10^5,'r','Linewidth',1);
%         lgd = legend('Body position dy','Contact pressure');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[(m/s)^2]-[Bar]');
%         title(['Body position, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        
        %% effetto del filtro passa basso
        
%         if strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')||...
%            strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP_LP')
%         
%         figure;
%         plot(time(1:end-1),pc_n./10^5,'k','Linewidth',1);
%         hold on; grid on;
%         plot(time(1:end-1),pc_n_lp./10^5,'k--','Linewidth',1);
%         plot(time(1:end-1),pc_p./10^5,'r','Linewidth',1);
%         plot(time(1:end-1),pc_p_lp./10^5,'r--','Linewidth',1);
%         lgd = legend('Valve pressure right (input)','Valve pressure right (output)','Valve pressure left (input)','Valve pressure left (output)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[Bar]');
%         title(['Valve pressure IN & OUT , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
%         end
%         
%         
        %% plot attrito statico e dinamico e forza attrito de wit
        
        if strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||...
           strcmp(settings.model,'ActiveSeat_onlyP_HP')||...
           strcmp(settings.model,'ActiveSeat_onlyP')
        
        figure;
        plot(time(1:end-1),F_s,'k','Linewidth',1);
        hold on; grid on;
        plot(time(1:end-1),F_d,'g','Linewidth',1);
        plot(time(1:end-1),F_attr,'m','Linewidth',1);
        plot(time(1:end-1),f_tan,'b','Linewidth',1);
        plot(time(1:end-1),N,'r','Linewidth',1);
        %plot(time(1:end-1),data.PAR(1:Tf/0.005,1).*100,'r','Linewidth',1)
        lgd = legend('Static friction force','Dinamic friction force','De Wit friction force','Contact tangent function','Normal Force');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[N]');
        title(['Friction forces , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        end
        
    end    