%% numerical elaboration for derivative problem (y_press) implementation in matmpc
% utilizzo gli stati simulati per ottenere le grandezze di pressione
% indotta dalla piattaforma, ingresso dell'active seat


% for i = 1:length(input_u)-1
%     platform_p(i) = state_sim(i,4)-u_true(i);
% end


%% CALCOLO CONTROLLO PER DIFFERENZA
load([pwd,'\data\ActiveSeat_onlyP/rif_pressione']);

if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')|| strcmp(settings.model,'ActiveSeat_onlyP')||...
   strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP')|| strcmp(settings.model,'ActiveSeat_onlyP_HP')
                
    run([pwd,'\examples/Pressure_model_params_nonLin']);
            
    for i = 1:length(state_sim(:,1))-1
        k(i) = k1*(state_sim(i,1)).^2+k2;
        c(i)= c1*(state_sim(i,1)).^2+c2;
        platform_p(i)=((k(i)-k2)*state_sim(i,1))/A + ((c(i)-c2)*state_sim(i,2))/A;
            
    end

elseif strcmp(settings.model,'ActiveSeat_onlyP_Lin')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')||...
        strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')
            
    run([pwd,'\examples\Pressure_model_params_Lin']);
        
    for i = 1:length(state_sim(:,1))-1
        platform_p(i)=(k2*state_sim(i,1))/A + (c2*state_sim(i,2))/A;
            
    end

end
               

u_diff= rif_pressione-platform_p; %ingresso AS per differenza
          

        
        