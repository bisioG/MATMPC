%% numerical elaboration for derivative problem implementation in matmpc

        load([pwd,'\data\ActiveSeat_onlyP/AS_REF_DATA_onlyP']);
        A = 0.016;
        if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction')|| strcmp(settings.model,'ActiveSeat_onlyP') 
        run([pwd,'\examples/Pressure_model_params_nonLin']);
        for i = 1:length(state_sim(:,1))-1
            k(i) = k1*(state_sim(i,1)).^2+k2;
            c(i)= c1*(state_sim(i,1)).^2+c2;
            platform_p(i)=((k(i)-k2)*state_sim(i,1)) + ((c(i)-c2)*state_sim(i,2));
            
        end
        else
        run([pwd,'\examples\Pressure_model_params_Lin']);
        
        for i = 1:length(state_sim(:,1))-1
            platform_p(i)=(k2*state_sim(i,1)) + (c2*state_sim(i,2));
            
        end
        end
        
        u_true= y_sim(:,1)' -platform_p;