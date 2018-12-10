% Plot results [parte positiva]

%% graphic settings

% define colors
blue=[0 0 255]/255;
red=[220 20 60]/255;
orange=[255 165 0]/255;
green=[0 205 102]/255;

legend_size=14; %LEGEND SIZE SETTINGS
title_size=19;  %TITLE SIZE SETTINGS
    
 %%*********************** plot pressione del cuscinetto, raggio di curvatura e profondita` di penetrazione           
        
        %% radius
%         figure;
%         plot(time(1:end-1),r_p,'r--','Linewidth',1);
%         hold on
%         lgd = legend('Radius R(u)');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[m]');
%         title(['Contact contributions: Radius , reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        %% profondita` di penetrazione
        
        figure;
        plot(time(1:end-1),d_p,'r','Linewidth',2);
        hold on;grid on;
        plot(time(1:end-1),delta_R_p,'k--','Linewidth',2);
        %plot(time(1:end-1),state_sim(1:end-1,1),'g--','Linewidth',2);
        plot(time(1:end-1),position_p,'b--','Linewidth',2);
        lgd = legend({'d','$\Delta \tilde{R}$','$\epsilon$'},'Interpreter','latex') 
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
        plot(time(1:end-1),pc_p_f./10^5,'k','Linewidth',2);
        hold on;grid on;
        plot(time(1:end-1),input_u_p./10^5,'r','Linewidth',2);
        %plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'g','Linewidth',1);
        lgd = legend({'$p_c$','$p_0$'},'Interpreter','latex')
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
        %title(['Pressure contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        
        %% pressioni (riferimento,piattaforma e contatto)
        
        figure;
        plot(time(1:end-1),rif_pressione_hp(1:Tf/0.005)./10^5,'b','Linewidth',2);
        hold on;grid on;
        plot(time(1:end-1),u_diff./10^5,'r--','Linewidth',2);
        plot(time(1:end-1),platform_p(1:Tf/0.005)./10^5,'g','Linewidth',2);
        lgd = legend('Reference pressure perceived y_{pf}','Contact pressure p_0','Platform pressure');
        lgd.FontSize= legend_size;
        xlabel('time [s]'); ylabel('[Bar]');
       % title(['Pressure contributions, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
        
        
        
        %% pressione cuscinetto e dinamica corpo
        
%         figure;
%         plot(time(1:end-1),pc_p./10^5,'k','Linewidth',1);
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
%         plot(time(1:end-1),input_u_p./10^5,'r','Linewidth',1);
%         lgd = legend('Body position dy','Contact pressure');
%         lgd.FontSize= legend_size;
%         xlabel('time [s]'); ylabel('[(m/s)^2]-[Bar]');
%         title(['Body position, reference type: ',rif_type,', Simulation: ',sim_type],'FontSize',title_size,'Interpreter', 'none')
%         
        
        
    
    