%% numerical elaboration
% -utilizzo gli stati simulati per ottenere le grandezze di pressione indotta dalla piattaforma, ingresso dell'active seat per calcolarmi il
% segnale di controllo per differenza e confrontarlo



%% CALCOLO CONTROLLO PER DIFFERENZA

load([pwd,'\data\ActiveSeat_onlyP/rif_pressione']);

if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')|| strcmp(settings.model,'ActiveSeat_onlyP')||...
   strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP')|| strcmp(settings.model,'ActiveSeat_onlyP_HP')||...
   strcmp(settings.model,'ActiveSeat_onlyP_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')||...
   strcmp(settings.model,'ActiveSeat_onlyP_HP_LP_v2')||strcmp(settings.model,'ActiveSeat_onlyP_HP_LP_contact')||...
   strcmp(settings.model,'ActiveSeat_onlyP_contact')
                
    run([pwd,'\examples/Pressure_model_params_nonLin']);
            
    for i = 1:length(state_sim(:,1))-1
        k(i) = k1*(state_sim(i,1)).^p+k2;
        c(i)= c1*(state_sim(i,1)).^p+c2;
        Fe_sim(i) =(k(i))*state_sim(i,1);
        Fs_sim(i)= ((c(i)-c2)*state_sim(i,2));
        platform_p(i)=((k(i)-k2)*state_sim(i,1))/A + ((c(i)-c2)*state_sim(i,2))/A;
            
    end

% elseif strcmp(settings.model,'ActiveSeat_onlyP_Lin')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long')||...
%         strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP')||...
%         strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')...
%         strcmp(settings.model,'ActiveSeat_onlyP_Lin_HP_LP')||strcmp(settings.model,'ActiveSeat_onlyP_Lin_Long_HP_LP')
else       
    run([pwd,'\examples\Pressure_model_params_Lin']);
        
    for i = 1:length(state_sim(:,1))-1
        platform_p(i)=(k2*state_sim(i,1))/A + (c2*state_sim(i,2))/A;
            
    end

end
               

u_diff= rif_pressione-platform_p; %ingresso AS per differenza

%pulisco il segnale di pressione di contatto input_u;
input_u=filter([0 1-exp(-Ts/0.03)],[1 -exp(-Ts/0.03)],input_u);

