function [Par] = AS_PAR(Tf,Ts)

    %% find your path to the original active seat model files
    oldfolder = pwd;
    cd('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\MATMPC\data\ActiveSeat_onlyP');

% %% Input signals assignment
    
    load rif_input_pres.mat
    Par=[];


for i=1:Tf/Ts
            Par = [Par; rif_accX(i) rif_roll(i) rif_accY(i)];
            
end

    %% save your data in the path of your MATMPC
    save([pwd,'\AS_PAR_DATA'], 'Par');
    
    cd(oldfolder); %return to main
    
    clc;
end

