function [Yref] = AS_REF_onlyP()

    %% find your path to the original active seat model files

% %% Input signals assignment
    
    load rif_pressione.mat
    N = length(rif_pressione);
    Yref=[];


for i=1:N
            Yref = [Yref; rif_pressione(i), 0 ];
            
end

    %% save your data in the path of your MATMPC
    save([pwd,'\AS_REF_DATA_onlyP'], 'rif_pressione');    
    
    clc;
end

