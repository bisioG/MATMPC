function [Par] = AS_PAR(Tf,Ts)

% %% Input signals assignment
    
     load rif_input_pres.mat
   
    Par=[];


for i=1:Tf/Ts
             Par = [Par; rif_accX(i) rif_roll(i) rif_accY(i)];
               
            
end

    %% save your data in the path of your MATMPC
    save([pwd,'\AS_PAR_DATA'], 'Par');
    
    
    clc;
end

