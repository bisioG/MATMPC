function [Yref] = AS_REF_onlyP(Tf,Ts)

    %% find your path to the original active seat model files
    oldfolder = pwd;
%     cd('C:\Users\giulio\Desktop\UNIVERSITA\TESI\active seat\nonlinear');

% %% Input signals assignment
    
    load rif_pressione_calabogie.mat
    Yref=[];


for i=1:Tf/Ts
            Yref = [Yref; rif_pressione(i), 0 ];
            
end

    %% save your data in the path of your MATMPC
    save([pwd,'\AS_REF_DATA_onlyP'], 'rif_pressione');
    
    cd(oldfolder); %return to main
    
    clc;
end
