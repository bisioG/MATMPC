

%%*******CALCOLO RAGGIO DI CURVATURA r e PRESSIONE CUSCINETTO pc*****
%%**** VERSIONE CON MODULO DI YOUNG CONTATTO VARIABILE CON P CUSCINETTO

 run([pwd,'\examples/Pressure_model_params_nonLin']);
    
    for i = 1:length(state_sim(:,1))-1
     
        if state_sim(i,1)>=0
            
        position(i)=state_sim(i,1);
        
        else
        position(i)=0;
        end
        
        pol = [4*m1^2 position(i)*4*m1^2 -input_u(i)^2*(pi^2) -input_u(i)^2*pi^2*r0];
            
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
        
        delta_R(i)=psol(i);
        
%         %elimino disturbi di calcolo (solo senza attrito)
            if strcmp(settings.model,'ActiveSeat_onlyP_WOfriction_HP_LP')
                if i>2060
                    if delta_R(i)<2*10^-4
                    delta_R(i)=0;
                    end
                end
            end
                 
        d(i)=delta_R(i)+position(i); %penetrazione       
        r(i)=delta_R(i)+r0;             %raggio     
        pc(i)=m2*delta_R(i);            %pressione cuscinetto
        
        Ev(i)=m1*delta_R(i);            %coefficente elasticita`
         
    end
    