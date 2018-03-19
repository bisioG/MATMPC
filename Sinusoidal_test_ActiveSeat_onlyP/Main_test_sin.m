%Main script for sinusoidal test of ActiveSeat models
clear all;
close all;
clc;
path_test=pwd;

%% create sinusoidal ax,ay and rif_pressione_calabogie

fr =1;
Ampl = 10;

cd([pwd,'\nonlinear_ref_gen']);
[rif_pressione,accX, accY]= rif_pres_laterale_SIN(Ampl, fr,1); %(amplitude,frequncy,boolean plot)
display('press any key to continue');
pause

%% create input params accX,accY,roll for AS_onlyP _onlyP_Lin _onlyP_WOfriction
rif_roll = zeros(length(accX));
rif_accX = accX*0.5;
rif_accY = accY*0.5;

save([pwd,'\data\ActiveSeat_onlyP\rif_input_pres'],'rif_accX','rif_accY','rif_roll');

%% run MATMPC

run Code_Generation
run Simulation

%% restore saved file
cd([pwd,'/data/ActiveSeat_onlyP\saved_data'])
%move
copyfile rif_input_pres.mat ..\.
copyfile rif_pressione_calabogie.mat ..\.
