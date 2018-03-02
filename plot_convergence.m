clear;clc

load opt_data;

x_opt = x;
u_opt = u;

load conv_data_0;

kkt_opt = kkt;
err_opt = err;
it_opt = 0:length(kkt_opt)-1;

load conv_data_1;

kkt_1 = kkt;
err_1 = err;
perc_1 = perc;
it_1 = 0:length(kkt_1)-1;

load conv_data_2;

kkt_2 = kkt;
err_2 = err;
perc_2 = perc;
it_2 = 0:length(kkt_2)-1;

figure(1)
yyaxis left
semilogy(it_opt, kkt_opt,'k','LineWidth',2);
hold on;
semilogy(it_1, kkt_1,'r','LineWidth',2);
semilogy(it_2, kkt_2,'b','LineWidth',2);
yyaxis right
plot(it_1, perc_1, '--r*');
plot(it_2, perc_2, '--b*');

%%

% figure(2);
% semilogy(it_opt, err_opt,'k','LineWidth',2);
% hold on;
% semilogy(it_1, err_1,'r--','LineWidth',2);
% semilogy(it_2, err_2,'b-.','LineWidth',2);

