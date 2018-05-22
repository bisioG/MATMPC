%% PLOT rif_pres_laterale.m*****************************************************************

    
    tt=Ts:Ts:N_sim*Ts;


%% Linear vs NonLinear

    figure
    plot(tt,m*ay,'g','Linewidth',1)
     xlim([0 3])
%     xlim([0 3*1/fr])
    hold on
    plot(tt,Output_NL,'r--','Linewidth',1)
    plot(tt,Output_L,'b--','Linewidth',1)
    plot(tt,Output_NL_WOfriction,'k--','Linewidth',1)
    legend('Reference Force (m*ay)','Output NL','Output L','Output NL without friction')
    xlabel('time [s]')
    ylabel('force [N]')
    title(['Nonlinear vs Linear lateral model , fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'])
    grid on
    
%  %% NonLinear contributors
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
%    legend('Reference Force (m*ay)','Output','Body Force (ma_y - damping- Friction-pressure)','Elastic Force','Damping','Friction','Sum: Elastic, Damping and Friction Forces')
%    xlabel('time [s]')
%    ylabel('force [N]')
%    title(['Nonlinear Model, fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'])
%    grid on
%    
%    %% NONLinear output contributor
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
%    legend('Reference Force (m*ay)','Output','Damping effect (c(x)-c2)','Elastic effect (k(x)-k2)')
%    xlabel('time [s]')
%    ylabel('force [N]')
%    title(['Nonlinear Model output contributors, fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'])
%    grid on
%    
%    %% NonLinear contributors WOfriction
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
%    legend('Reference Force (m*ay)','Output','Body Force (ma_y - damping-pressure)','Elastic Force','Damping','Sum: Elastic, Damping and Friction Forces')
%    xlabel('time [s]')
%    ylabel('force [N]')
%    title(['Nonlinear WOfriction Model, fr=',num2str(fr),'[Hz] A=',num2str(Amp),'[m/s^2]'])
%    grid on
%     
% %% position NONLin
% 
% figure
% plot(tt,pos_nonLin)
% hold on
% plot(tt,vel_nonLin)
% % xlim([0 5])
% % ylim([0 0.3])
% legend('body position NONLin','body velocity NONLin')
% xlabel('time [s]')
% ylabel('[m]or [m/s]')
% title(['Nonlinear positions and velocity, fr=',num2str(fr),'[Hz] A=',int2str(Amp),'[m/s^2]'])
% grid on
%     
% %% Linear contributors
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
%     legend('Reference Force (m*ay)','Output','Body Force (ma_y - damping - elastic force)','Elastic Force','Damping','Sum Elastic, Damping')
%     xlabel('time [s]')
%     ylabel('force [N]')
%     title(['Linear Model, fr=',num2str(fr),'[Hz] A=',int2str(Amp),'[m/s^2]'])
%     grid on
% 
% %% Linear position and velocity
% 
% figure
% plot(tt,pos_Lin)
% hold on
% plot(tt,vel_Lin)
% % xlim([0 2])
% % ylim([0 0.3])
% legend('posizione corpo Lin','velocita` corpo Lin')
% xlabel('time [s]')
% ylabel('[m] or [m/s]')
% title(['Linear positions and velocity, fr=',num2str(fr),'[Hz] A=',int2str(Amp),'[m/s^2]'])
% grid on
% 
% %% position and velocity compare
% 
% figure
% plot(tt,pos_Lin,'b','Linewidth',1)
% hold on
% plot(tt,pos_nonLin,'r','Linewidth',1)
% plot(tt,pos_nonLin_WOfriction,'g','Linewidth',1)
% %  xlim([0 3])
%  xlim([0 3*1/fr])
% %  ylim([0 0.3])
% legend('posizione corpo Lin','posizione corpo nonLin', 'posizione corpo nonLin WOfriction' )
% xlabel('time [s]')
% ylabel('[m]')
% title(['Linear vs Non-Linear positions, fr=',num2str(fr),'[Hz] A=',int2str(Amp),'[m/s^2]'])
% grid on
