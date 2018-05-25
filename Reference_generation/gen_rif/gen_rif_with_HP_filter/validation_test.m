%% verifica tra space state e filter

ypfilt_NL = filter([1 -1],[1 -exp(-Ts/tau_hp)],Output_NL/A);

title_size = 18;
legend_size = 12;

figure
plot (t,ypf_NL,'r','Linewidth',1)
hold on
plot (t,ypfilt_NL,'b--','Linewidth',2)
lgd = legend('ODE Output','Filter() Output');
lgd.FontSize = legend_size;
title('Compare pressure signals','FontSize',title_size)
grid on

% filtro a tempo discreto
hp_tf_d= tf([1 -1],[1 -exp(-Ts/tau_hp)],Ts);
figure
bode(hp_tf_d);
title('Diagramma di Bode, filtro a tempo discreto','FontSize',title_size)

%filtro a tempo continuo
hp_tf_c = tf([tau_hp 0],[tau_hp 1]);
figure
bode(hp_tf_c);
title('Diagramma di Bode, filtro a tempo continuo','FontSize',title_size)
