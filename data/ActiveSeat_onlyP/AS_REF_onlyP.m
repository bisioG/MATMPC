function [Yref] = AS_REF_onlyP(Tf,Ts)

    %% find your path to the original active seat model files

% %% Input signals assignment
    
    load rif_pressione.mat
    Yref=[];


for i=1:Tf/Ts
            Yref = [Yref; rif_pressione(i), 0 ];
            
end

    %% save your data in the path of your MATMPC
    save([pwd,'\AS_REF_DATA_onlyP'], 'rif_pressione');    
    
    clc;
end

