function [rho_inv, c0] = CMoN_Init(sizes, mem)

    nx=sizes.nx;
    nu=sizes.nu;
    nc=sizes.nc;
    ncN=sizes.ncN;
    N=sizes.N;
    nbu=sizes.nbu;
    nbu_idx=sizes.nbu_idx;

    nz = nx+nu;
    nw = (N+1)*nx+N*nu;
    neq = (N+1)*nx;
    nineq = 2*(N*nc+ncN+N*nbu);

    H=[];
    for i=0:N-1
        H=blkdiag(H, [mem.Q(:,i*nx+1:(i+1)*nx), mem.S(:,i*nu+1:(i+1)*nu); 
                      (mem.S(:,i*nu+1:(i+1)*nu))', mem.R(:,i*nu+1:(i+1)*nu)]);    
    end
    H=blkdiag(H, mem.Q(:,N*nx+1:(N+1)*nx));

    BT=zeros(nw,neq);
    BT(1:nz,1:2*nx)=[eye(nx,nx), (mem.A(:,1:nx))'; zeros(nu,nx), (mem.B(:,1:nu))'];
    for i=1:N-1
        BT(i*nz+1:(i+1)*nz, i*nx+1:(i+2)*nx) = [-eye(nx,nx), (mem.A(:,i*nx+1:(i+1)*nx))'; zeros(nu,nx), (mem.B(:,i*nu+1:(i+1)*nu))'];
    end
    BT(N*nz+1:N*nz+nx, N*nx+1:(N+1)*nx) = -eye(nx,nx);  
    B=BT';

    C=[];
    Iu = zeros(nbu,nu);
    for j=1:nbu
        Iu(j,nbu_idx(j))=1;
    end
    for i=0:N-1
        C=blkdiag(C, [mem.Cx(:,i*nx+1:(i+1)*nx), mem.Cu(:,i*nu+1:(i+1)*nu);
                      -mem.Cx(:,i*nx+1:(i+1)*nx) , -mem.Cu(:,i*nu+1:(i+1)*nu);
                      zeros(nbu,nx), Iu;
                      zeros(nbu,nx), -Iu]);
    end
    C=blkdiag(C,[mem.CN;-mem.CN]);

    nmui = 2*(nc+nbu);
    blk4 = [];
    for i=0:N-1
        for j=0:nc-1
            mu_ub = max(mem.mu_new(i*nc+j+1), 0);
            mu_lb = min(mem.mu_new(i*nc+j+1), 0);
            blk4=[blk4; -mu_ub*C(i*nmui+j+1,:)];
            blk4=[blk4; -mu_lb*C(i*nmui+nc+j+1,:)];
        end 
        for j=0:nbu-1
            tmp = mem.mu_u_new(i*nu+j+1);
            tmp = tmp(nbu_idx);
            mu_ub = max(tmp, 0);
            mu_lb = min(tmp, 0);
            blk4=[blk4; -mu_ub*C(i*nmui+2*nc+j+1,:)];
            blk4=[blk4; -mu_lb*C(i*nmui+2*nc+nbu+j+1,:)];
        end 
    end
    for j=0:ncN-1
        mu_ub = max(mem.muN_new(j+1), 0);
        mu_lb = min(mem.muN_new(j+1), 0);
        blk4=[blk4; -mu_ub*C(N*nmui+j+1,:)];
        blk4=[blk4; -mu_ub*C(N*nmui+ncN+j+1,:)];
    end 
    
    c=[];
    for i=0:N-1
        c=[c;-mem.uc(i*nc+1:(i+1)*nc);
             mem.lc(i*nc+1:(i+1)*nc)];
        tmp1 = mem.ub_du(i*nu+1:(i+1)*nu);
        tmp1 = tmp1(nbu_idx);
        tmp2 = mem.lb_du(i*nu+1:(i+1)*nu);
        tmp2 = tmp2(nbu_idx);
        c=[c;-tmp1;
             tmp2];
    end
    c=[c;-mem.uc(N*nc+1:end);
         mem.lc(N*nc+1:end)];
    blk5 = -diag(c);

    M=[H,C',BT;
       blk4, blk5, zeros(nineq, neq);
       B, zeros(neq,nineq), zeros(neq, neq)];
   
    s= svd(M);
   
    rho_inv = min(s);
    
    c0=var(s)*size(M,1);
end

