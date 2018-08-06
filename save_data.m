
%to save useful data where you want
old_path = pwd;

%% for validation of the LP filter
path_save_input = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\LP_filter_validation\data'; %data folder inside LP_filter_validation folder
cd(path_save_input)

if strcmp(settings.model,'ActiveSeat_onlyP_HP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')
    save('simulation_HP','input_u','rif_type','time','tau_lp','Ts','u_diff');
elseif strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
    save('simulation_HP_LP','input_u','rif_type','time'); 
end

cd(old_path);

%% to test offline the vigrade AS control

path_offline_VI_test = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\Active_Seat_test\vigrade_offline_test\MATMPC_data';% Active_Seat_test\vigrade_offline_test\MATMPC_data
cd(path_offline_VI_test)

if strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
    
    longitudinal_control = input_u;
    save('longitudinal_control','longitudinal_control','sim_type');
  
else
    lateral_control=input_u;
    save('lateral_control','lateral_control','sim_type');
end
    
cd(old_path);