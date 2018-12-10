%% numerical elaboration POSITIVE PRESSURE
run([pwd,'\examples/Pressure_model_params_nonLin']);

for i = 1:length(state_sim(:,1))-1
    
    %parte positiva avvicinamento
    if state_sim(i,1)>=0
            
    position_p(i)=state_sim(i,1);
        
    else
    position_p(i)=0;
    end
    
    %parte positiva pressione di contatto
    if input_u(i)>=0
            
    input_u_p(i)=input_u(i);
    flag_positive=1;
        
    else
    input_u_p(i)=0;
    end
    
end



%%*******CALCOLO RAGGIO DI CURVATURA r e PRESSIONE CUSCINETTO pc*****
%%**** VERSIONE CON MODULO DI YOUNG CONTATTO VARIABILE CON P CUSCINETTO

% run([pwd,'\examples/Pressure_model_params_nonLin']);
    
    for i = 1:length(state_sim(:,1))-1
     
        
        pol = [4*m1^2 position_p(i)*4*m1^2 -input_u_p(i)^2*(pi^2) -input_u_p(i)^2*pi^2*r0];
            
        sol = roots(pol);
        
        sol1(i)=sol(1,1);
        sol2(i)=sol(2,1);
        sol3(i)=sol(3,1);
        
        %***** separo la parte reale per i plot 
        if real(sol1(i))>=0
        psol1(i)=real(sol1(i));
        else
        psol1(i)=0;
        end
        
        if real(sol2(i))>=0
        psol2(i)=real(sol2(i));
        else
        psol2(i)=0;
        end
        
        if real(sol3(i))>=0
        psol3(i)=real(sol3(i));
        else
        psol3(i)=0;
        end
        
        %**** unione soluzioni positive CREAZIONE DEL SEGNALE UTILE
        
        if real(sol1(i))>=0
        psol(i)=real(sol1(i));
        else
            if real(sol2(i))>=0
            psol(i)=real(sol2(i)); 
            
            else
                if real(sol3(i))>=0
                psol(i)=real(sol3(i));
                else
                psol(i)=0;
                end
            end
        end
        
        delta_R_p(i)=psol(i);
        
%         %elimino disturbi di calcolo (solo senza attrito)
            if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')
                if i>2060
                    if delta_R_p(i)<2*10^-4
                    delta_R_p(i)=0;
                    end
                end
            end
                 
        d_p(i)=delta_R_p(i)+position_p(i); %penetrazione       
        r_p(i)=delta_R_p(i)+r0;             %raggio     
        pc_p(i)=m2*delta_R_p(i);            %pressione cuscinetto
        
        Ev_p_p(i)=m1*delta_R_p(i);            %coefficente elasticita`
         
    end
    
run Num_elab_3