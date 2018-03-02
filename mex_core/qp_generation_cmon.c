
#include "mex.h"
#include "string.h"

#include "casadi_wrapper.h"

#include "blas.h"

static bool mem_alloc = false;

static double *Jac[2]; 
static double *Jac_N = NULL;

static double *num_pri;	
static double *den_pri;	
static double *num_dual;	
static double *den_dual;
static double *tmp;
static double *dual_out[3];

void exitFcn(){ 
    if (Jac[0]!=NULL)
        mxFree(Jac[0]);
    if (Jac[1]!=NULL)
        mxFree(Jac[1]);
    if (Jac_N!=NULL)
        mxFree(Jac_N);
    
    mxFree(num_pri);	
    mxFree(den_pri);	
    mxFree(num_dual);	
    mxFree(den_dual);
    
    mxFree(tmp);
    mxFree(dual_out[2]);
}

void
mexFunction(int nlhs,mxArray *plhs[],int nrhs,const mxArray *prhs[])
{
    double *x = mxGetPr( mxGetField(prhs[0], 0, "x") );
    double *u = mxGetPr( mxGetField(prhs[0], 0, "u") );
    double *y = mxGetPr( mxGetField(prhs[0], 0, "y") );
    double *yN = mxGetPr( mxGetField(prhs[0], 0, "yN") );
    double *od = mxGetPr( mxGetField(prhs[0], 0, "od") );
    double *W = mxGetPr( mxGetField(prhs[0], 0, "W") );
    double *WN = mxGetPr( mxGetField(prhs[0], 0, "WN") );
    double *lb = mxGetPr( mxGetField(prhs[0], 0, "lb") );
    double *ub = mxGetPr( mxGetField(prhs[0], 0, "ub") );
    double *lbN = mxGetPr( mxGetField(prhs[0], 0, "lbN") );
    double *ubN = mxGetPr( mxGetField(prhs[0], 0, "ubN") );
    double *x0 = mxGetPr( mxGetField(prhs[0], 0, "x0") );
    double *lbu = mxGetPr( mxGetField(prhs[0], 0, "lbu") );
    double *ubu = mxGetPr( mxGetField(prhs[0], 0, "ubu") );
    double *lambda = mxGetPr( mxGetField(prhs[0], 0, "lambda") );	
    double *mu = mxGetPr( mxGetField(prhs[0], 0, "mu") );	
    double *muN = mxGetPr( mxGetField(prhs[0], 0, "muN") );	
    double *mu_u = mxGetPr( mxGetField(prhs[0], 0, "mu_u") );
    
    size_t nx = mxGetScalar( mxGetField(prhs[1], 0, "nx") );
    size_t nu = mxGetScalar( mxGetField(prhs[1], 0, "nu") );
    size_t np = mxGetScalar( mxGetField(prhs[1], 0, "np") ); if(np==0) np++;
    size_t ny = mxGetScalar( mxGetField(prhs[1], 0, "ny") );
    size_t nyN = mxGetScalar( mxGetField(prhs[1], 0, "nyN") );
    size_t nc = mxGetScalar( mxGetField(prhs[1], 0, "nc") ); 
    size_t ncN = mxGetScalar( mxGetField(prhs[1], 0, "ncN") );
    size_t N = mxGetScalar( mxGetField(prhs[1], 0, "N") );    
    int sim_method = mxGetScalar( mxGetField(prhs[2], 0, "sim_method") );
    
    int i=0,j=0;
    char *nTrans = "N", *Trans="T", *UPLO="L";
    double one_d = 1.0, zero = 0.0, minus_one_d = -1.0;
    size_t one_i = 1;
    size_t nz = nx+nu;
      
    double *Q = mxGetPr( mxGetField(prhs[2], 0, "Q") );
    double *S = mxGetPr( mxGetField(prhs[2], 0, "S") );
    double *R = mxGetPr( mxGetField(prhs[2], 0, "R") );
    double *A = mxGetPr( mxGetField(prhs[2], 0, "A") );
    double *B = mxGetPr( mxGetField(prhs[2], 0, "B") );
    double *Cx = mxGetPr( mxGetField(prhs[2], 0, "Cx") );
    double *Cu = mxGetPr( mxGetField(prhs[2], 0, "Cu") );
    double *CN = mxGetPr( mxGetField(prhs[2], 0, "CN") );
    double *gx = mxGetPr( mxGetField(prhs[2], 0, "gx") );
    double *gu = mxGetPr( mxGetField(prhs[2], 0, "gu") );   
    double *a = mxGetPr( mxGetField(prhs[2], 0, "a") );
    double *ds0 = mxGetPr( mxGetField(prhs[2], 0, "ds0") );
    double *lc = mxGetPr( mxGetField(prhs[2], 0, "lc") );
    double *uc = mxGetPr( mxGetField(prhs[2], 0, "uc") );
    double *lb_du = mxGetPr( mxGetField(prhs[2], 0, "lb_du") );
    double *ub_du = mxGetPr( mxGetField(prhs[2], 0, "ub_du") );    
    int lin_obj = mxGetScalar( mxGetField(prhs[2], 0, "lin_obj") );
    
    double *F_old = mxGetPr( mxGetField(prhs[2], 0, "F_old") );	
    double *CMON_pri = mxGetPr( mxGetField(prhs[2], 0, "CMON_pri") );	
    double *CMON_dual = mxGetPr( mxGetField(prhs[2], 0, "CMON_dual") );	
    double *x_pri = mxGetPr( mxGetField(prhs[2], 0, "dx") );
    double *u_pri = mxGetPr( mxGetField(prhs[2], 0, "du") );
    double *q_dual = mxGetPr( mxGetField(prhs[2], 0, "q_dual") );	
    double threshold_pri = mxGetScalar( mxGetField(prhs[2], 0, "threshold_pri") );	
    double threshold_dual = mxGetScalar( mxGetField(prhs[2], 0, "threshold_dual") );	
    double *perc = mxGetPr( mxGetField(prhs[2], 0, "perc") );
    
    for (i=0;i<nx;i++)
        ds0[i] = x0[i] - x[i];
    
    // allocate memory
    double *Sens[2];    
    double *Cons[2];
      
    double *casadi_in[6];
    double *casadi_out[2];    
    casadi_in[4] = W;
       
    if (!mem_alloc){
        if (sim_method!=0)
            mexErrMsgTxt("Supports only ERK-CASADI");
                          
        Jac[0] = (double *) mxMalloc(ny*nx * sizeof(double));
        mexMakeMemoryPersistent(Jac[0]); 
        Jac[1] = (double *) mxMalloc(ny*nu * sizeof(double));
        mexMakeMemoryPersistent(Jac[1]); 
        Jac_N = (double *) mxMalloc(nyN*nx * sizeof(double));
        mexMakeMemoryPersistent(Jac_N);
        
        num_pri = (double *) mxCalloc(nx, sizeof(double));	
        mexMakeMemoryPersistent(num_pri);	
        den_pri = (double *) mxCalloc(nx, sizeof(double));	
        mexMakeMemoryPersistent(den_pri);	
        	
        num_dual = (double *) mxCalloc(nz, sizeof(double));	
        mexMakeMemoryPersistent(num_dual);	
        den_dual = (double *) mxCalloc(nz, sizeof(double));	
        mexMakeMemoryPersistent(den_dual);
        
        tmp = (double *)mxMalloc(nz * sizeof(double));	
        mexMakeMemoryPersistent(tmp);	
        dual_out[2] = (double *)mxMalloc(nz * sizeof(double));	
        mexMakeMemoryPersistent(dual_out[2]);
        
        mem_alloc=true;
        mexAtExit(exitFcn);
    }
    
    double num_norm_pri, den_norm_pri, num_norm_dual, den_norm_dual;	
    int num_updated = 0;
    
    // start loop
    for(i=0;i<N;i++){
        casadi_in[0] = x+i*nx;
        casadi_in[1] = u+i*nu;
        casadi_in[2] = od+i*np;
        casadi_in[3] = y+i*ny;
        
        // control bounds
        for (j=0;j<nu;j++){
            lb_du[i*nu+j] = lbu[i*nu+j]-u[i*nu+j];
            ub_du[i*nu+j] = ubu[i*nu+j]-u[i*nu+j];
        }
        
        // integration                      
        
        casadi_out[0] = a+i*nx;
        F_Fun(casadi_in, casadi_out);
        
        // primal CMON
        Sens[0] = A + i*nx*nx;
        Sens[1] = B + i*nx*nu;       
        dgemv(nTrans, &nx, &nx, &one_d, Sens[0], &nx, x_pri+i*nx, &one_i, &zero, den_pri, &one_i);            	
        dgemv(nTrans, &nx, &nu, &one_d, Sens[1], &nx, u_pri+i*nu, &one_i, &one_d, den_pri, &one_i); 
        den_norm_pri = dnrm2(&nx, den_pri, &one_i);
        if (den_norm_pri>0){           	
            memcpy(num_pri, a+i*nx, nx*sizeof(double));	
            daxpy(&nx, &minus_one_d, F_old+i*nx, &one_i, num_pri, &one_i);	
            daxpy(&nx, &minus_one_d, den_pri, &one_i, num_pri, &one_i);	
            num_norm_pri=dnrm2(&nx, num_pri, &one_i);                	
            CMON_pri[i] = num_norm_pri/den_norm_pri;	
        }else {	
            CMON_pri[i] = 10000000;	
        }
        
        // dual CMON	
        dgemv(Trans, &nx, &nx, &one_d, Sens[0], &nx, q_dual+(i+1)*nx, &one_i, &zero, den_dual, &one_i);	
        dgemv(Trans, &nx, &nu, &one_d, Sens[1], &nx, q_dual+(i+1)*nx, &one_i, &zero, den_dual+nx, &one_i);	
        den_norm_dual = dnrm2(&nz, den_dual, &one_i);	
        if (den_norm_dual>0){   	
            casadi_in[5] = q_dual+(i+1)*nx;	
            casadi_in[6] = mu+i*nc;	
            dual_out[0] = tmp;	
            dual_out[1] = num_dual;	
            adj_Fun(casadi_in, dual_out);	
            daxpy(&nz, &minus_one_d, den_dual, &one_i, num_dual, &one_i);	
            num_norm_dual=dnrm2(&nz, num_dual, &one_i); 	
            CMON_dual[i] = num_norm_dual/den_norm_dual;	
        }else {	
            CMON_dual[i] = 10000000;	
        }
        
        if (CMON_pri[i]>threshold_pri || CMON_dual[i]>threshold_dual){	
            num_updated++;	
            D_Fun(casadi_in, Sens);	
        }	
        memcpy(F_old+i*nx, a+i*nx, nx*sizeof(double));
        perc[0] = 100*num_updated/N;       
       
        // equality residual        
        for (j=0;j<nx;j++)
            a[i*nx+j] -= x[(i+1)*nx+j];
       
        // Hessian
        if (!lin_obj){
            Ji_Fun(casadi_in, Jac);
            dsyrk(UPLO, Trans, &nx, &ny, &one_d, Jac[0], &ny, &zero, Q+i*nx*nx, &nx);
            dgemm(Trans, nTrans, &nx, &nu, &ny, &one_d, Jac[0], &ny, Jac[1], &ny, &zero, S+i*nx*nu, &nx);
            dsyrk(UPLO, Trans, &nu, &ny, &one_d, Jac[1], &ny, &zero, R+i*nu*nu, &nu);
        }
        
        // gradient
//         casadi_out[0] = gx+i*nx;
//         casadi_out[1] = gu+i*nu;
//         gi_Fun(casadi_in, casadi_out);
        casadi_in[5] = lambda+(i+1)*nx;	
        casadi_in[6] = mu+i*nc;	
        dual_out[0] = tmp;	
        dual_out[1] = num_dual;	
        adj_Fun(casadi_in, dual_out);
        
        for(j=0;j<nx;j++)
            gx[i*nx+j] = dual_out[0][j] + dual_out[1][j];
        dgemv(Trans, &nx, &nx, &minus_one_d, Sens[0], &nx, lambda+(i+1)*nx, &one_i, &one_d, gx+i*nx, &one_i);
        
        for(j=0;j<nu;j++)
            gu[i*nu+j] = dual_out[0][nx+j] + dual_out[1][nx+j];
        dgemv(Trans, &nx, &nu, &minus_one_d, Sens[1], &nx, lambda+(i+1)*nx, &one_i, &one_d, gu+i*nu, &one_i);
        
        // constraint residual
        if (nc>0){  
            casadi_in[0]=x+i*nx;
            casadi_in[1]=u+i*nu;
            casadi_in[2]=od+i*np; 
            casadi_out[0] = lc + i*nc;
            path_con_Fun(casadi_in, casadi_out);
            for (j=0;j<nc;j++){
                uc[i*nc+j] = ub[i*nc+j] - casadi_out[0][j];
                casadi_out[0][j] = lb[i*nc+j] - casadi_out[0][j];            
            }
        
            // constraint Jacobian
            Cons[0] = Cx+i*nc*nx;
            Cons[1] = Cu+i*nc*nu;
            Ci_Fun(casadi_in, Cons);
        }
    }
    
    // terminal data
    casadi_in[0] = x+N*nx;
    casadi_in[1] = od+N*np;
    casadi_in[2] = yN;
    casadi_in[3] = WN;
    
    if (!lin_obj){
        JN_Fun(casadi_in, Jac_N);
        dsyrk(UPLO, Trans, &nx, &nyN, &one_d, Jac_N, &nyN, &zero, Q+N*nx*nx, &nx);
    }
    
    casadi_out[0] = gx+N*nx;
    gN_Fun(casadi_in, casadi_out);

    if (ncN>0){
        casadi_out[0] = lc + N*nc;
        path_con_N_Fun(casadi_in, casadi_out);
        for (j=0;j<ncN;j++){
            uc[i*nc+j] = ubN[j] - casadi_out[0][j];
            casadi_out[0][j] = lbN[j] - casadi_out[0][j];            
        }

        CN_Fun(casadi_in, &CN);
    }
    
}