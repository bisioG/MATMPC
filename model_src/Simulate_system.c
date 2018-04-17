/* This file was automatically generated by CasADi.
   The CasADi copyright holders make no ownership claim of its contents. */
#ifdef __cplusplus
extern "C" {
#endif

/* How to prefix internal symbols */
#ifdef CODEGEN_PREFIX
  #define NAMESPACE_CONCAT(NS, ID) _NAMESPACE_CONCAT(NS, ID)
  #define _NAMESPACE_CONCAT(NS, ID) NS ## ID
  #define CASADI_PREFIX(ID) NAMESPACE_CONCAT(CODEGEN_PREFIX, ID)
#else
  #define CASADI_PREFIX(ID) Simulate_system_ ## ID
#endif

#include <math.h>
#include <string.h>
#ifdef MATLAB_MEX_FILE
#include <mex.h>
#endif

#ifndef casadi_real
#define casadi_real double
#endif

#define to_double(x) (double) x
#define to_int(x) (int) x
#define CASADI_CAST(x,y) (x) y

/* Pre-c99 compatibility */
#if __STDC_VERSION__ < 199901L
  #define fmin CASADI_PREFIX(fmin)
  casadi_real fmin(casadi_real x, casadi_real y) { return x<y ? x : y;}
  #define fmax CASADI_PREFIX(fmax)
  casadi_real fmax(casadi_real x, casadi_real y) { return x>y ? x : y;}
#endif

/* CasADi extensions */
#define sq CASADI_PREFIX(sq)
casadi_real sq(casadi_real x) { return x*x;}
#define sign CASADI_PREFIX(sign)
casadi_real CASADI_PREFIX(sign)(casadi_real x) { return x<0 ? -1 : x>0 ? 1 : x;}
#define twice CASADI_PREFIX(twice)
casadi_real twice(casadi_real x) { return x+x;}
#define if_else CASADI_PREFIX(if_else)
casadi_real if_else(casadi_real c, casadi_real x, casadi_real y) { return c!=0 ? x : y;}

/* Add prefix to internal symbols */
#define casadi_f0 CASADI_PREFIX(f0)
#define casadi_fill CASADI_PREFIX(fill)
#define casadi_from_mex CASADI_PREFIX(from_mex)
#define casadi_s0 CASADI_PREFIX(s0)
#define casadi_s1 CASADI_PREFIX(s1)
#define casadi_s2 CASADI_PREFIX(s2)
#define casadi_to_mex CASADI_PREFIX(to_mex)

/* Printing routine */
#ifdef MATLAB_MEX_FILE
  #define PRINTF mexPrintf
#else
  #define PRINTF printf
#endif

/* Symbol visibility in DLLs */
#ifndef CASADI_SYMBOL_EXPORT
  #if defined(_WIN32) || defined(__WIN32__) || defined(__CYGWIN__)
    #if defined(STATIC_LINKED)
      #define CASADI_SYMBOL_EXPORT
    #else
      #define CASADI_SYMBOL_EXPORT __declspec(dllexport)
    #endif
  #elif defined(__GNUC__) && defined(GCC_HASCLASSVISIBILITY)
    #define CASADI_SYMBOL_EXPORT __attribute__ ((visibility ("default")))
  #else
    #define CASADI_SYMBOL_EXPORT
  #endif
#endif

static const int casadi_s0[8] = {4, 1, 0, 4, 0, 1, 2, 3};
static const int casadi_s1[5] = {1, 1, 0, 1, 0};
static const int casadi_s2[7] = {3, 1, 0, 3, 0, 1, 2};

void casadi_fill(casadi_real* x, int n, casadi_real alpha) {
  int i;
  if (x) {
    for (i=0; i<n; ++i) *x++ = alpha;
  }
}

#ifdef MATLAB_MEX_FILE
casadi_real* casadi_from_mex(const mxArray* p, casadi_real* y, const int* sp, casadi_real* w) {
  if (!mxIsDouble(p) || mxGetNumberOfDimensions(p)!=2)
    mexErrMsgIdAndTxt("Casadi:RuntimeError","\"from_mex\" failed: Not a two-dimensional matrix of double precision.");
  int nrow = *sp++, ncol = *sp++, nnz = sp[ncol];
  const int *colind=sp, *row=sp+ncol+1;
  size_t p_nrow = mxGetM(p), p_ncol = mxGetN(p);
  int is_sparse = mxIsSparse(p);
  mwIndex *Jc, *Ir;
  if (is_sparse) {
#ifndef CASADI_MEX_NO_SPARSE
    Jc = mxGetJc(p);
    Ir = mxGetIr(p);
#else /* CASADI_MEX_NO_SPARSE */
    mexErrMsgIdAndTxt("Casadi:RuntimeError","\"from_mex\" failed: Sparse inputs disabled.");
#endif /* CASADI_MEX_NO_SPARSE */
  }
  const double* p_data = (const double*)mxGetData(p);
  if (p_nrow==1 && p_ncol==1) {
    double v = is_sparse && Jc[1]==0 ? 0 : *p_data;
    casadi_fill(y, nnz, v);
  } else {
    int tr = 0;
    if (nrow!=p_nrow || ncol!=p_ncol) {
      tr = nrow==p_ncol && ncol==p_nrow && (nrow==1 || ncol==1);
      if (!tr) mexErrMsgIdAndTxt("Casadi:RuntimeError","\"from_mex\" failed: Dimension mismatch.");
    }
    int r,c,k;
    if (is_sparse) {
      if (tr) {
        for (c=0; c<ncol; ++c)
          for (k=colind[c]; k<colind[c+1]; ++k) w[row[k]+c*nrow]=0;
        for (c=0; c<p_ncol; ++c)
          for (k=Jc[c]; k<Jc[c+1]; ++k) w[c+Ir[k]*p_ncol] = p_data[k];
        for (c=0; c<ncol; ++c)
          for (k=colind[c]; k<colind[c+1]; ++k) y[k] = w[row[k]+c*nrow];
      } else {
        for (c=0; c<ncol; ++c) {
          for (k=colind[c]; k<colind[c+1]; ++k) w[row[k]]=0;
          for (k=Jc[c]; k<Jc[c+1]; ++k) w[Ir[k]]=p_data[k];
          for (k=colind[c]; k<colind[c+1]; ++k) y[k]=w[row[k]];
        }
      }
    } else {
      for (c=0; c<ncol; ++c) {
        for (k=colind[c]; k<colind[c+1]; ++k) {
          y[k] = p_data[row[k]+c*nrow];
        }
      }
    }
  }
  return y;
}

#endif

#ifdef MATLAB_MEX_FILE
mxArray* casadi_to_mex(const int* sp, const casadi_real* x) {
  int nrow = *sp++, ncol = *sp++, nnz = sp[ncol];
  const int *colind = sp, *row = sp+ncol+1;
#ifndef CASADI_MEX_NO_SPARSE
  if (nnz!=nrow*ncol) {
    mxArray*p = mxCreateSparse(nrow, ncol, nnz, mxREAL);
    int i;
    mwIndex* j;
    for (i=0, j=mxGetJc(p); i<=ncol; ++i) *j++ = *colind++;
    for (i=0, j=mxGetIr(p); i<nnz; ++i) *j++ = *row++;
    if (x) {
      double* d = (double*)mxGetData(p);
      for (i=0; i<nnz; ++i) *d++ = to_double(*x++);
    }
    return p;
  }
#endif /* CASADI_MEX_NO_SPARSE */
  mxArray* p = mxCreateDoubleMatrix(nrow, ncol, mxREAL);
  if (x) {
    double* d = (double*)mxGetData(p);
    int c, k;
    for (c=0; c<ncol; ++c) {
      for (k=colind[c]; k<colind[c+1]; ++k) {
        d[row[k]+c*nrow] = to_double(*x++);
      }
    }
  }
  return p;
}

#endif

/* Simulate_system:(states[4],controls,params[3])->(xf[4]) */
static int casadi_f0(const casadi_real** arg, casadi_real** res, int* iw, casadi_real* w, void* mem) {
  casadi_real a0=arg[0] ? arg[0][0] : 0;
  casadi_real a1=4.1666666666666669e-004;
  casadi_real a2=arg[0] ? arg[0][1] : 0;
  casadi_real a3=2.;
  casadi_real a4=1.2500000000000000e-003;
  casadi_real a5=arg[2] ? arg[2][2] : 0;
  casadi_real a6=20000.;
  casadi_real a7=sq(a0);
  a7=(a6*a7);
  casadi_real a8=2000.;
  a7=(a7+a8);
  casadi_real a9=67.;
  a7=(a7/a9);
  a7=(a7*a2);
  casadi_real a10=1200000.;
  casadi_real a11=sq(a0);
  a11=(a10*a11);
  casadi_real a12=1000.;
  a11=(a11+a12);
  a11=(a11*a0);
  a11=(a11/a9);
  a7=(a7+a11);
  a7=(a5-a7);
  a11=9.8100000000000005e+000;
  casadi_real a13=arg[2] ? arg[2][1] : 0;
  a11=(a11*a13);
  a7=(a7+a11);
  a13=(a4*a7);
  a13=(a2+a13);
  casadi_real a14=(a3*a13);
  a14=(a2+a14);
  casadi_real a15=(a4*a2);
  a15=(a0+a15);
  casadi_real a16=sq(a15);
  a16=(a6*a16);
  a16=(a16+a8);
  a16=(a16/a9);
  a16=(a16*a13);
  casadi_real a17=sq(a15);
  a17=(a10*a17);
  a17=(a17+a12);
  a17=(a17*a15);
  a17=(a17/a9);
  a16=(a16+a17);
  a16=(a5-a16);
  a16=(a16+a11);
  a17=(a4*a16);
  a17=(a2+a17);
  casadi_real a18=(a3*a17);
  a14=(a14+a18);
  a18=2.5000000000000001e-003;
  casadi_real a19=(a4*a13);
  a19=(a0+a19);
  casadi_real a20=sq(a19);
  a20=(a6*a20);
  a20=(a20+a8);
  a20=(a20/a9);
  a20=(a20*a17);
  casadi_real a21=sq(a19);
  a21=(a10*a21);
  a21=(a21+a12);
  a21=(a21*a19);
  a21=(a21/a9);
  a20=(a20+a21);
  a20=(a5-a20);
  a20=(a20+a11);
  a21=(a18*a20);
  a21=(a2+a21);
  a14=(a14+a21);
  a14=(a1*a14);
  a14=(a0+a14);
  a16=(a3*a16);
  a7=(a7+a16);
  a20=(a3*a20);
  a7=(a7+a20);
  a20=(a18*a17);
  a20=(a0+a20);
  a16=sq(a20);
  a16=(a6*a16);
  a16=(a16+a8);
  a16=(a16/a9);
  a16=(a16*a21);
  casadi_real a22=sq(a20);
  a22=(a10*a22);
  a22=(a22+a12);
  a22=(a22*a20);
  a22=(a22/a9);
  a16=(a16+a22);
  a16=(a5-a16);
  a16=(a16+a11);
  a7=(a7+a16);
  a7=(a1*a7);
  a7=(a2+a7);
  a16=sq(a14);
  a16=(a6*a16);
  a16=(a16+a8);
  a16=(a16/a9);
  a16=(a16*a7);
  a22=sq(a14);
  a22=(a10*a22);
  a22=(a22+a12);
  a22=(a22*a14);
  a22=(a22/a9);
  a16=(a16+a22);
  a16=(a5-a16);
  a16=(a16+a11);
  a22=(a4*a16);
  a22=(a7+a22);
  casadi_real a23=(a3*a22);
  a23=(a7+a23);
  casadi_real a24=(a4*a7);
  a24=(a14+a24);
  casadi_real a25=sq(a24);
  a25=(a6*a25);
  a25=(a25+a8);
  a25=(a25/a9);
  a25=(a25*a22);
  casadi_real a26=sq(a24);
  a26=(a10*a26);
  a26=(a26+a12);
  a26=(a26*a24);
  a26=(a26/a9);
  a25=(a25+a26);
  a25=(a5-a25);
  a25=(a25+a11);
  a26=(a4*a25);
  a26=(a7+a26);
  casadi_real a27=(a3*a26);
  a23=(a23+a27);
  a4=(a4*a22);
  a4=(a14+a4);
  a27=sq(a4);
  a27=(a6*a27);
  a27=(a27+a8);
  a27=(a27/a9);
  a27=(a27*a26);
  casadi_real a28=sq(a4);
  a28=(a10*a28);
  a28=(a28+a12);
  a28=(a28*a4);
  a28=(a28/a9);
  a27=(a27+a28);
  a27=(a5-a27);
  a27=(a27+a11);
  a28=(a18*a27);
  a28=(a7+a28);
  a23=(a23+a28);
  a23=(a1*a23);
  a23=(a14+a23);
  if (res[0]!=0) res[0][0]=a23;
  a25=(a3*a25);
  a16=(a16+a25);
  a27=(a3*a27);
  a16=(a16+a27);
  a18=(a18*a26);
  a18=(a14+a18);
  a27=sq(a18);
  a6=(a6*a27);
  a6=(a6+a8);
  a6=(a6/a9);
  a6=(a6*a28);
  a8=sq(a18);
  a8=(a10*a8);
  a8=(a8+a12);
  a8=(a8*a18);
  a8=(a8/a9);
  a6=(a6+a8);
  a5=(a5-a6);
  a5=(a5+a11);
  a16=(a16+a5);
  a16=(a1*a16);
  a16=(a7+a16);
  if (res[0]!=0) res[0][1]=a16;
  a16=arg[0] ? arg[0][2] : 0;
  a5=2400000.;
  a11=sq(a0);
  a11=(a5*a11);
  a11=(a11*a2);
  a0=sq(a0);
  a0=(a10*a0);
  a0=(a0+a12);
  a0=(a0*a2);
  a11=(a11+a0);
  a0=arg[1] ? arg[1][0] : 0;
  a11=(a11+a0);
  a2=sq(a15);
  a2=(a5*a2);
  a2=(a2*a13);
  a15=sq(a15);
  a15=(a10*a15);
  a15=(a15+a12);
  a15=(a15*a13);
  a2=(a2+a15);
  a2=(a2+a0);
  a2=(a3*a2);
  a11=(a11+a2);
  a2=sq(a19);
  a2=(a5*a2);
  a2=(a2*a17);
  a19=sq(a19);
  a19=(a10*a19);
  a19=(a19+a12);
  a19=(a19*a17);
  a2=(a2+a19);
  a2=(a2+a0);
  a2=(a3*a2);
  a11=(a11+a2);
  a2=sq(a20);
  a2=(a5*a2);
  a2=(a2*a21);
  a20=sq(a20);
  a20=(a10*a20);
  a20=(a20+a12);
  a20=(a20*a21);
  a2=(a2+a20);
  a2=(a2+a0);
  a11=(a11+a2);
  a11=(a1*a11);
  a16=(a16+a11);
  a11=sq(a14);
  a11=(a5*a11);
  a11=(a11*a7);
  a14=sq(a14);
  a14=(a10*a14);
  a14=(a14+a12);
  a14=(a14*a7);
  a11=(a11+a14);
  a11=(a11+a0);
  a14=sq(a24);
  a14=(a5*a14);
  a14=(a14*a22);
  a24=sq(a24);
  a24=(a10*a24);
  a24=(a24+a12);
  a24=(a24*a22);
  a14=(a14+a24);
  a14=(a14+a0);
  a14=(a3*a14);
  a11=(a11+a14);
  a14=sq(a4);
  a14=(a5*a14);
  a14=(a14*a26);
  a4=sq(a4);
  a4=(a10*a4);
  a4=(a4+a12);
  a4=(a4*a26);
  a14=(a14+a4);
  a14=(a14+a0);
  a14=(a3*a14);
  a11=(a11+a14);
  a14=sq(a18);
  a5=(a5*a14);
  a5=(a5*a28);
  a18=sq(a18);
  a10=(a10*a18);
  a10=(a10+a12);
  a10=(a10*a28);
  a5=(a5+a10);
  a5=(a5+a0);
  a11=(a11+a5);
  a11=(a1*a11);
  a16=(a16+a11);
  if (res[0]!=0) res[0][2]=a16;
  a16=arg[0] ? arg[0][3] : 0;
  a11=(a3*a0);
  a11=(a0+a11);
  a5=(a3*a0);
  a11=(a11+a5);
  a11=(a11+a0);
  a11=(a1*a11);
  a16=(a16+a11);
  a11=(a3*a0);
  a11=(a0+a11);
  a3=(a3*a0);
  a11=(a11+a3);
  a11=(a11+a0);
  a1=(a1*a11);
  a16=(a16+a1);
  if (res[0]!=0) res[0][3]=a16;
  return 0;
}

CASADI_SYMBOL_EXPORT int Simulate_system(const casadi_real** arg, casadi_real** res, int* iw, casadi_real* w, void* mem){
  return casadi_f0(arg, res, iw, w, mem);
}

CASADI_SYMBOL_EXPORT void Simulate_system_incref(void) {
}

CASADI_SYMBOL_EXPORT void Simulate_system_decref(void) {
}

CASADI_SYMBOL_EXPORT int Simulate_system_n_in(void) { return 3;}

CASADI_SYMBOL_EXPORT int Simulate_system_n_out(void) { return 1;}

CASADI_SYMBOL_EXPORT const char* Simulate_system_name_in(int i){
  switch (i) {
    case 0: return "states";
    case 1: return "controls";
    case 2: return "params";
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const char* Simulate_system_name_out(int i){
  switch (i) {
    case 0: return "xf";
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const int* Simulate_system_sparsity_in(int i) {
  switch (i) {
    case 0: return casadi_s0;
    case 1: return casadi_s1;
    case 2: return casadi_s2;
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT const int* Simulate_system_sparsity_out(int i) {
  switch (i) {
    case 0: return casadi_s0;
    default: return 0;
  }
}

CASADI_SYMBOL_EXPORT int Simulate_system_work(int *sz_arg, int* sz_res, int *sz_iw, int *sz_w) {
  if (sz_arg) *sz_arg = 3;
  if (sz_res) *sz_res = 1;
  if (sz_iw) *sz_iw = 0;
  if (sz_w) *sz_w = 29;
  return 0;
}

#ifdef MATLAB_MEX_FILE
void mex_Simulate_system(int resc, mxArray *resv[], int argc, const mxArray *argv[]) {
  int i, j;
  if (argc>3) mexErrMsgIdAndTxt("Casadi:RuntimeError","Evaluation of \"Simulate_system\" failed. Too many input arguments (%d, max 3)", argc);
  if (resc>1) mexErrMsgIdAndTxt("Casadi:RuntimeError","Evaluation of \"Simulate_system\" failed. Too many output arguments (%d, max 1)", resc);
  int *iw = 0;
  casadi_real w[41];
  const casadi_real* arg[3] = {0};
  if (--argc>=0) arg[0] = casadi_from_mex(argv[0], w, casadi_s0, w+12);
  if (--argc>=0) arg[1] = casadi_from_mex(argv[1], w+4, casadi_s1, w+12);
  if (--argc>=0) arg[2] = casadi_from_mex(argv[2], w+5, casadi_s2, w+12);
  casadi_real* res[1] = {0};
  --resc;
  res[0] = w+8;
  i = Simulate_system(arg, res, iw, w+12, 0);
  if (i) mexErrMsgIdAndTxt("Casadi:RuntimeError","Evaluation of \"Simulate_system\" failed.");
  if (res[0]) resv[0] = casadi_to_mex(casadi_s0, res[0]);
}
#endif


#ifdef MATLAB_MEX_FILE
void mexFunction(int resc, mxArray *resv[], int argc, const mxArray *argv[]) {
  char buf[16];
  int buf_ok = --argc >= 0 && !mxGetString(*argv++, buf, sizeof(buf));
  if (!buf_ok) {
    /* name error */
  } else if (strcmp(buf, "Simulate_system")==0) {
    return mex_Simulate_system(resc, resv, argc, argv);
  }
  mexErrMsgTxt("First input should be a command string. Possible values: 'Simulate_system'");
}
#endif
#ifdef __cplusplus
} /* extern "C" */
#endif
