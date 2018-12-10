%plot dettaglio di alcuni contributi e forze


load([pwd,'\data\ActiveSeat_onlyP/rif_params']);

tilt = MM*g*rif_roll;
f_esterna = m*rif_accY;

%% forze 

figure;
plot(time(1:end-1),tilt,'r');
hold on;grid on;
plot(time(1:end-1),f_esterna,'b');
plot(time(1:end-1),Fe_sim,'k');
plot(time(1:end-1),Fs_sim,'g');
plot(time(1:end-1),F_attr,'m');
lgd = legend('tilt','inerzia piattaforma','forza elastica','smorzamento','forza di attrito');

%% forze esterne e subite dal corpo
figure;
plot(time(1:end-1),tilt+f_esterna,'r--','Linewidth',2);
hold on;grid on;
%plot(time(1:end-1),f_esterna,'b');
plot(time(1:end-1),Fe_sim,'k','Linewidth',2);
plot(time(1:end-1),Fs_sim,'g','Linewidth',2);
plot(time(1:end-1),F_attr,'m','Linewidth',2);
plot(time(1:end-1),tilt+f_esterna-F_attr-Fe_sim-Fs_sim,'b--','Linewidth',2);
lgd = legend('tilt+inerzia piattaforma','forza elastica','smorzamento','forza di attrito','inerzia del corpo');


%%

figure;
plot(time(1:end),state_sim(:,2),'k','Linewidth',2);
hold on;grid on;
plot(time(1:end-1),f_esterna/1000,'b','Linewidth',2);
plot(time(1:end-1),Fs_sim/1000,'g','Linewidth',2);
plot(time(1:end-1),F_attr/1000,'m','Linewidth',2);

lgd = legend('velocita corpo','f esterna','smorzamento','attrito');

%%

figure;
plot(time(1:end),state_sim(:,3),'k','Linewidth',2);
lgd = legend('piegamento setole')

%%

figure;
plot(time(1:end),state_sim(:,1),'k','Linewidth',2);
hold on; grid on;
plot(time(1:end),state_sim(:,2),'b','Linewidth',2);
lgd = legend('posizione tronco','velocita` del tronco')