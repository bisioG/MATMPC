%Main script for sinusoidal test of ActiveSeat models
clear all;
close all;
clc;



% parametri di test
fr =1/25;
Amp = 10;
ref_type = 0; % reference type 1= nonLinear 0=Linear 

test_settings.fr = fr;
test_settings.Amp = Amp;
test_settings.ref_type = ref_type;

save([pwd,'\saved_AS_input_test\test_settings'],'test_settings');

if ref_type==1
%% create sinusoidal ax,ay and rif_pressione_NONLin

cd([pwd,'\gen_rif']);
[rif_pressione_nonLin,accX, accY]= rif_pres_nonLin_SIN(Amp, fr); %(amplitude,frequency)

end

if ref_type ==0
%% create sinusoidal ax,ay and rif_pressione_Lin
cd([pwd,'\gen_rif']);
[rif_pressione_Lin,accX, accY]= rif_pres_Lin_SIN(Amp, fr); %(amplitude,frequency)    
end    
    
%% create input params accX,accY,roll for AS_onlyP _onlyP_Lin _onlyP_WOfriction
rif_roll = zeros(length(accX));

% rif_accX = accX*0.5; %scale
% rif_accY = accY*0.5;

rif_accX = accX; %not scale
rif_accY = accY;

save([pwd,'\data\ActiveSeat_onlyP\rif_input_pres'],'rif_accX','rif_accY','rif_roll');

% run MATMPC


%% _onlyP model
clear all;
display('Test with _onlyP model');
settings.model='ActiveSeat_onlyP';
run Code_Generation 
run Simulation
input_u_onlyP =  u_true;
display('press any key to continue...');
save([pwd,'\Sinusoidal_test\saved_AS_input_test\input_u_onlyP'],'input_u_onlyP','time');
pause


%% _lin model
clear all;
display('Test with _onlyP_Lin model');
settings.model='ActiveSeat_onlyP_Lin';
run Code_Generation 
run Simulation
input_u_onlyP_Lin =  u_true;
display('press any key to continue...');
save([pwd,'\Sinusoidal_test\saved_AS_input_test\input_u_onlyP_Lin'],'input_u_onlyP_Lin','time');
pause


%% _onlyP_WOfriction
clear all;
display('Test with _onlyP_WOfriction model');
settings.model='ActiveSeat_onlyP_WOfriction';
run Code_Generation 
run Simulation
input_u_onlyP_WOfriction =  u_true;
save([pwd,'\Sinusoidal_test\saved_AS_input_test\input_u_onlyP_WOfriction'],'input_u_onlyP_WOfriction','time');
display('press any key to continue...');
pause
main_matmpc_path = pwd;


%% restore saved file (rif_input_pres,rif_pressione_calobogie del tracciato)

cd([pwd,'/data/ActiveSeat_onlyP\saved_data'])
%move
copyfile rif_input_pres.mat ..\.
copyfile rif_pressione_calabogie.mat ..\.

%% draw compare

display('Draw compare plot');
cd(main_matmpc_path);
cd([pwd,'\Sinusoidal_test'])
run draw_compare_test_1ref3mod
