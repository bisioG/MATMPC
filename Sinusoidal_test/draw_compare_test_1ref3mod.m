clear all;
load([pwd,'\saved_AS_input_test\input_u_onlyP']);
load([pwd,'\saved_AS_input_test\input_u_onlyP_Lin']);
load([pwd,'\saved_AS_input_test\input_u_onlyP_WOfriction']);
load([pwd,'\saved_AS_input_test\test_settings']);

if test_settings.ref_type ==1
    type = 'nonLinear';
else
    type = 'Linear';
end

figure
hold on
plot(time(1:end),input_u_onlyP(:,1)/0.016);
plot(time(1:end),input_u_onlyP_Lin(:,1)/0.016);
plot(time(1:end),input_u_onlyP_WOfriction(:,1)/0.016);
legend('input mod:NoNLin','input mod:Lin','input mod:WOfriction')
title(['Compare AS input with different models and same reference:',type,' fr=',num2str(test_settings.fr),'[Hz] ',' A=',num2str(test_settings.Amp),'[m/s^2]'])

