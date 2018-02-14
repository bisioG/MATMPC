function [tQP, mem] = mpc_qp_solve_blockIP(mem,sizes)

    opts.it_max=50;
    opts.tol = 1e-10;
    opts.print_level = 0;
    opts.reg = 0;
    
    tic;
    blockIP(mem, sizes, opts);
    tQP = toc*1e3;
end

