function [output, mem] = mpc_nmpcsolver(input, settings, mem)

    tic;

    i=0;
%     KKT = 1e8;
    
    CPT.SHOOT=0;
    CPT.COND=0;
    CPT.QP=0;
    
    load opt_data;
    err=sqrt( norm(input.x-x) + norm(input.u-u) ); 
    perc = mem.perc;
    kkt=[];
    
    [eq_res, ineq_res, KKT] = solution_info(input, settings, mem);
    kkt=[kkt;KKT];
    
    
    while(i < mem.sqp_maxit  &&  KKT > mem.kkt_lim ) % RTI or multiple call
        
        %% ----------- QP Preparation
       
        tshoot = tic;
        qp_generation_cmon(input, settings, mem);
        tSHOOT = toc(tshoot)*1e3; 
                      
        tcond=tic;
        Condensing(mem, settings);        
        tCOND=toc(tcond)*1e3;
                
%         %% ----------  Solving QP
        [tQP,mem] = mpc_qp_solve_qpoases(settings,mem);
        
        %% ---------- Line search

        Line_search(mem, input, settings);
                
        %% ---------- KKT calculation 
        
        [eq_res, ineq_res, KKT] = solution_info(input, settings, mem);
        
        %% eta computation
        if mem.iter==1 && i==0
            [rho_inv, c0] = CMoN_Init(settings, mem);
            mem.rho_cmon = rho_inv*c0;
        end
        
        adaptive_eta(mem,settings);
        
        %% ---------- Multiple call management and convergence check
                        
        CPT.SHOOT=CPT.SHOOT+tSHOOT;
        CPT.COND=CPT.COND+tCOND;
        CPT.QP=CPT.QP+tQP;
        
        i=i+1;
        
        err=[err;sqrt( norm(input.x-x) + norm(input.u-u) )]; 
        perc = [perc;mem.perc];
        kkt=[kkt;KKT];
        
    end
    
    save('conv_data_2','err','perc','kkt');
   
    output.info.cpuTime=toc*1e3;   % Total CPU time for the current sampling instant
    
    output.x=input.x;
    output.u=input.u;   
    output.lambda=input.lambda;
    output.mu=input.mu;
    output.muN=input.muN;

    output.info.iteration_num=i;    
    output.info.kktValue=KKT;
    output.info.eq_res=eq_res;
    output.info.ineq_res=ineq_res;
    output.info.shootTime=CPT.SHOOT;
    output.info.condTime=CPT.COND;
    output.info.qpTime=CPT.QP;

end

