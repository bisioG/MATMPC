%to save useful data where you want
old_path = pwd;

%% to test offline the vigrade AS control

path_offline_VI_test = 'C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\Active_Seat_test\vigrade_offline_test\MATMPC_controls';% Active_Seat_test\vigrade_offline_test\MATMPC_data
cd(path_offline_VI_test)

if strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
    
    longitudinal_control = pc;
    cd([sim_type]);
    save('longitudinal_control','longitudinal_control','sim_type');
  
else
    cd([sim_type]);
    lateral_control=pc;
    save('lateral_control','lateral_control','sim_type');
end
    
cd(old_path);