%% numerical elaboration for derivative problem (y_press) implementation in matmpc
% utilizzo gli stati simulati per ottenere le grandezze di pressione
% indotta dalla piattaforma, reale ingresso dell'active seat
        
        if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')|| strcmp(settings.model,'ActiveSeat_onlyP')
                
            run([pwd,'\examples/Pressure_model_params_nonLin']);
            
            for i = 1:length(state_sim(:,1))-1
                k(i) = k1*(state_sim(i,1)).^2+k2;
                c(i)= c1*(state_sim(i,1)).^2+c2;
                platform_p(i)=((k(i)-k2)*state_sim(i,1))/A + ((c(i)-c2)*state_sim(i,2))/A;
            
            end
        elseif strcmp(settings.model,'ActiveSeat_onlyP_Lin')
            
            run([pwd,'\examples\Pressure_model_params_Lin']);
        
            for i = 1:length(state_sim(:,1))-1
                platform_p(i)=(k2*state_sim(i,1))/A + (c2*state_sim(i,2))/A;
            
            end
        elseif  strcmp(settings.model,'ActiveSeat_onlyP_HP') 
            
            run([pwd,'\examples/Pressure_model_params_nonLin']);
            for i = 1:length(state_sim(:,1))-1
                k(i) = k1*(state_sim(i,1)).^2+k2;
                c(i)= c1*(state_sim(i,1)).^2+c2;
                platform_p(i)=(-1/tau_hp)*(state_sim(i,6))+[((k(i)-k2)*state_sim(i,1))/A + ((c(i)-c2)*state_sim(i,2))/A];
            
            end
            
        end
        
          u_true= y_sim(:,1)'-platform_p; %ingresso vero AS
          
%         load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
%         u_true = rif_pressione-platform_p;
        
        
        