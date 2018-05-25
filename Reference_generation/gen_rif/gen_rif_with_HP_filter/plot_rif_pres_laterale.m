%% PLOT rif_pres_laterale_HP.m*****************************************************************

    
    tt=Ts:Ts:N_sim*Ts;
    
    legend_size=12; %LEGEND SIZE SETTINGS
    title_size=19;  %TITLE SIZE SETTINGS


%% Linear vs NonLinear (non filtrate)

%     figure
%     plot(tt,m*ay,'g','Linewidth',1)
%      xlim([0 3])
% %     xlim([0 3*1/fr])
%     hold on
%     plot(tt,Output_NL,'r--','Linewidth',1)
%     plot(tt,Output_L,'b--','Linewidth',1)
%     plot(tt,Output_NL_WOfriction,'k--','Linewidth',1)
%     lgd=legend('Reference Force (m*ay)','Output NL','Output L','Output NL without friction');
%     lgd.FontSize= legend_size;
%     xlabel('time [s]')
%     ylabel('force [N]')
%     
%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Nonlinear vs Linear lateral model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Nonlinear vs Linear lateral model, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Nonlinear vs Linear lateral model, test:', param_name],'FontSize',title_size)    
%     end
%         
%     grid on
    
%% NonLinear contributors (non filtrate)

%    figure
%    plot(tt,m*ay,'g','Linewidth',1)
% %     xlim([0 3])
%    xlim([0 3*1/fr])
%    hold on
%    plot(tt,Output_NL,'b--','Linewidth',1)  
%    plot(tt,m*ay_corpo_nonLin,'c','Linewidth',1)
%    plot(tt,F_el_nonLin,'r--','Linewidth',1)
%    plot(tt,damping_nonLin,'y','Linewidth',1)
%    plot(tt,F_att,'k--','Linewidth',1)
%    plot(tt,F_att+F_el_nonLin+damping_nonLin,'m','Linewidth',1)
%    lgd = legend('Reference Force (m*ay)','Output','Body Force (ma_y -
%    damping- Friction-pressure)','Elastic Force','Damping','Friction','Sum: Elastic, Damping and Friction Forces');
%    lgd.FontSize= legend_size;
%    xlabel('time [s]')
%    ylabel('force [N]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Nonlinear Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Nonlinear Model, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Nonlinear Model, test:', param_name],'FontSize',title_size)    
%     end
    
%    grid on
%    
%% NONLinear output contributor (non filtrate)
%    
%     figure
%    plot(tt,m*ay,'g--','Linewidth',1)
% %     xlim([0 3])
%    xlim([0 3*1/fr])
%    hold on
%    plot(tt,Output_NL,'b','Linewidth',1)  
%    plot(tt,damping_effect,'r--','Linewidth',1)
%    plot(tt,elastic_effect,'m--','Linewidth',1)
%    %plot(tt,F_el_nonLin,'k--','Linewidth',1)
%    %plot(tt,damping_nonLin,'y','Linewidth',1)
%    lgd = legend('Reference Force (m*ay)','Output','Damping effect
%    (c(x)-c2)','Elastic effect (k(x)-k2)');
%    lgd.FontSize= legend_size;
%    xlabel('time [s]')
%    ylabel('force [N]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Nonlinear Model output contributors, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Nonlinear Model output contributors, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Nonlinear Model output contributors, test:', param_name],'FontSize',title_size)    
%     end

%    grid on
%    
%% NonLinear contributors WOfriction (non filtrate)

%    figure
%    plot(tt,m*ay,'g','Linewidth',1)
% %     xlim([0 3])
%    xlim([0 3*1/fr])
%    hold on
%    plot(tt,Output_NL_WOfriction,'b--','Linewidth',1)  
%    plot(tt,m*ay_corpo_nonLin_WOfriction,'c','Linewidth',1)
%    plot(tt,F_el_nonLin_WOfriction,'r--','Linewidth',1)
%    plot(tt,damping_nonLin_WOfriction,'y','Linewidth',1)
%    plot(tt,F_el_nonLin+damping_nonLin,'m','Linewidth',1)
%    lgd = legend('Reference Force (m*ay)','Output','Body Force (ma_y -
%    damping-pressure)','Elastic Force','Damping','Sum: Elastic, Damping and Friction Forces');
%    lgd.FontSize= legend_size;
%    xlabel('time [s]')
%    ylabel('force [N]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Nonlinear WOfriction Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Nonlinear WOfriction Model, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Nonlinear WOfriction Model, test:', param_name],'FontSize',title_size)    
%     end

%    grid on
%     
%% position NONLin (non filtrate)
% 
% figure
% plot(tt,pos_nonLin)
% hold on
% plot(tt,vel_nonLin)
% % xlim([0 5])
% % ylim([0 0.3])
% lgd = legend('body position NONLin','body velocity NONLin');
% lgd.FontSize= legend_size;
% xlabel('time [s]')
% ylabel('[m]or [m/s]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Nonlinear positions and velocity, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Nonlinear positions and velocity, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Nonlinear positions and velocity, test:', param_name],'FontSize',title_size)    
%     end
    
% grid on
%     
%% Linear contributors (non filtrate)
% 
%     figure
%     plot(tt,m*ay,'g','Linewidth',1)
%     hold on
% %     xlim([0 3])
%     xlim([0 3*1/fr])
%     plot(tt,Output_L,'b','Linewidth',1)  
%     plot(tt,m*ay_corpo_Lin,'c','Linewidth',1)
%     plot(tt,F_pres_Lin,'r--','Linewidth',1)
%     plot(tt,damping_Lin,'y','Linewidth',1)
%     plot(tt,F_pres_Lin+damping_Lin,'m--','Linewidth',1)
%     lgd = legend('Reference Force (m*ay)','Output','Body Force (ma_y -
%     damping - elastic force)','Elastic Force','Damping','Sum Elastic, Damping');
%     lgd.FontSize= legend_size;
%     xlabel('time [s]')
%     ylabel('force [N]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Linear Model, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Linear Model, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Linear Model, test:', param_name],'FontSize',title_size)    
%     end
    
%     grid on
% 
%% Linear position and velocity (non filtrate)
% 
% figure
% plot(tt,pos_Lin)
% hold on
% plot(tt,vel_Lin)
% % xlim([0 2])
% % ylim([0 0.3])
% lgd = legend('posizione corpo Lin','velocita` corpo Lin');
% lgd.FontSize= legend_size;
% xlabel('time [s]')
% ylabel('[m] or [m/s]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Linear positions and velocity, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Linear positions and velocity, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Linear positions and velocity, test:', param_name],'FontSize',title_size)    
%     end
    
% grid on
% 
%% position and velocity compare (non filtrate)
% 
% figure
% plot(tt,pos_Lin,'b','Linewidth',1)
% hold on
% plot(tt,pos_nonLin,'r','Linewidth',1)
% plot(tt,pos_nonLin_WOfriction,'g','Linewidth',1)
% %  xlim([0 3])
%  xlim([0 3*1/fr])
% %  ylim([0 0.3])
% lgd = legend('posizione corpo Lin','posizione corpo nonLin', 'posizione
% corpo nonLin WOfriction' );
% lgd.FontSize= legend_size;
% xlabel('time [s]')
% ylabel('[m]')

%     if strcmp(param_name,'Sinusoidal')==1
%     title(['Linear vs Non-Linear positions, test:', param_name,' fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     elseif strcmp(param_name,'Step')==1
%     title(['Linear vs Non-Linear positions, test:', param_name,' A=',num2str(Amp),'[m/s^2]'],'FontSize',title_size)
%     else
%     title(['Linear vs Non-Linear positions, test:', param_name],'FontSize',title_size)    
%     end
    
% grid on

