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

static const int casadi_s0[9] = {5, 1, 0, 5, 0, 1, 2, 3, 4};
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

/* Simulate_system:(states[5],controls,params[3])->(xf[5]) */
static int casadi_f0(const casadi_real** arg, casadi_real** res, int* iw, casadi_real* w, void* mem) {
  casadi_real a0=arg[0] ? arg[0][0] : 0;
  casadi_real a1=4.1666666666666669e-004;
  casadi_real a2=arg[0] ? arg[0][1] : 0;
  casadi_real a3=2.;
  casadi_real a4=1.2500000000000000e-003;
  casadi_real a5=arg[2] ? arg[2][2] : 0;
  casadi_real a6=200.;
  casadi_real a7=10.;
  casadi_real a8=(a7*a0);
  a8=sq(a8);
  a8=(a6*a8);
  casadi_real a9=2000.;
  a8=(a8+a9);
  casadi_real a10=67.;
  a8=(a8/a10);
  a8=(a8*a2);
  casadi_real a11=12000.;
  casadi_real a12=(a7*a0);
  a12=sq(a12);
  a12=(a11*a12);
  casadi_real a13=1000.;
  a12=(a12+a13);
  a12=(a12*a0);
  a12=(a12/a10);
  a8=(a8+a12);
  a8=(a5-a8);
  a12=9.8100000000000005e+000;
  casadi_real a14=arg[2] ? arg[2][1] : 0;
  a12=(a12*a14);
  a8=(a8+a12);
  a14=10000.;
  casadi_real a15=arg[0] ? arg[0][2] : 0;
  casadi_real a16=(a14*a15);
  a16=(a16/a10);
  a8=(a8-a16);
  a16=(a4*a8);
  a16=(a2+a16);
  casadi_real a17=(a3*a16);
  a17=(a2+a17);
  casadi_real a18=(a4*a2);
  a18=(a0+a18);
  casadi_real a19=(a7*a18);
  a19=sq(a19);
  a19=(a6*a19);
  a19=(a19+a9);
  a19=(a19/a10);
  a19=(a19*a16);
  casadi_real a20=(a7*a18);
  a20=sq(a20);
  a20=(a11*a20);
  a20=(a20+a13);
  a20=(a20*a18);
  a20=(a20/a10);
  a19=(a19+a20);
  a19=(a5-a19);
  a19=(a19+a12);
  a20=fabs(a2);
  a20=(a20*a15);
  casadi_real a21=30.;
  casadi_real a22=3.1830988618379069e-001;
  casadi_real a23=9.8480775301220802e-001;
  casadi_real a24=arg[2] ? arg[2][0] : 0;
  a24=(a10*a24);
  a23=(a23*a24);
  a24=8.5174431145629327e+001;
  a23=(a23+a24);
  a23=atan(a23);
  a22=(a22*a23);
  a23=5.9999999999999998e-001;
  a22=(a22+a23);
  a21=(a21*a22);
  a23=15.;
  a23=(a23*a22);
  a22=5.0000000000000001e-003;
  a24=(a2/a22);
  a24=sq(a24);
  a24=(-a24);
  a24=exp(a24);
  a24=(a23*a24);
  a24=(a21+a24);
  a24=(a24/a14);
  a20=(a20/a24);
  a20=(a2-a20);
  a24=(a4*a20);
  a24=(a15+a24);
  casadi_real a25=(a14*a24);
  a25=(a25/a10);
  a19=(a19-a25);
  a25=(a4*a19);
  a25=(a2+a25);
  casadi_real a26=(a3*a25);
  a17=(a17+a26);
  a26=2.5000000000000001e-003;
  casadi_real a27=(a4*a16);
  a27=(a0+a27);
  casadi_real a28=(a7*a27);
  a28=sq(a28);
  a28=(a6*a28);
  a28=(a28+a9);
  a28=(a28/a10);
  a28=(a28*a25);
  casadi_real a29=(a7*a27);
  a29=sq(a29);
  a29=(a11*a29);
  a29=(a29+a13);
  a29=(a29*a27);
  a29=(a29/a10);
  a28=(a28+a29);
  a28=(a5-a28);
  a28=(a28+a12);
  a29=fabs(a16);
  a29=(a29*a24);
  a24=(a16/a22);
  a24=sq(a24);
  a24=(-a24);
  a24=exp(a24);
  a24=(a23*a24);
  a24=(a21+a24);
  a24=(a24/a14);
  a29=(a29/a24);
  a29=(a16-a29);
  a24=(a4*a29);
  a24=(a15+a24);
  casadi_real a30=(a14*a24);
  a30=(a30/a10);
  a28=(a28-a30);
  a30=(a26*a28);
  a30=(a2+a30);
  a17=(a17+a30);
  a17=(a1*a17);
  a17=(a0+a17);
  a19=(a3*a19);
  a8=(a8+a19);
  a28=(a3*a28);
  a8=(a8+a28);
  a28=(a26*a25);
  a28=(a0+a28);
  a19=(a7*a28);
  a19=sq(a19);
  a19=(a6*a19);
  a19=(a19+a9);
  a19=(a19/a10);
  a19=(a19*a30);
  casadi_real a31=(a7*a28);
  a31=sq(a31);
  a31=(a11*a31);
  a31=(a31+a13);
  a31=(a31*a28);
  a31=(a31/a10);
  a19=(a19+a31);
  a19=(a5-a19);
  a19=(a19+a12);
  a31=fabs(a25);
  a31=(a31*a24);
  a24=(a25/a22);
  a24=sq(a24);
  a24=(-a24);
  a24=exp(a24);
  a24=(a23*a24);
  a24=(a21+a24);
  a24=(a24/a14);
  a31=(a31/a24);
  a31=(a25-a31);
  a24=(a26*a31);
  a24=(a15+a24);
  casadi_real a32=(a14*a24);
  a32=(a32/a10);
  a19=(a19-a32);
  a8=(a8+a19);
  a8=(a1*a8);
  a8=(a2+a8);
  a19=(a7*a17);
  a19=sq(a19);
  a19=(a6*a19);
  a19=(a19+a9);
  a19=(a19/a10);
  a19=(a19*a8);
  a32=(a7*a17);
  a32=sq(a32);
  a32=(a11*a32);
  a32=(a32+a13);
  a32=(a32*a17);
  a32=(a32/a10);
  a19=(a19+a32);
  a19=(a5-a19);
  a19=(a19+a12);
  a29=(a3*a29);
  a20=(a20+a29);
  a31=(a3*a31);
  a20=(a20+a31);
  a31=fabs(a30);
  a31=(a31*a24);
  a24=(a30/a22);
  a24=sq(a24);
  a24=(-a24);
  a24=exp(a24);
  a24=(a23*a24);
  a24=(a21+a24);
  a24=(a24/a14);
  a31=(a31/a24);
  a31=(a30-a31);
  a20=(a20+a31);
  a20=(a1*a20);
  a15=(a15+a20);
  a20=(a14*a15);
  a20=(a20/a10);
  a19=(a19-a20);
  a20=(a4*a19);
  a20=(a8+a20);
  a31=(a3*a20);
  a31=(a8+a31);
  a24=(a4*a8);
  a24=(a17+a24);
  a29=(a7*a24);
  a29=sq(a29);
  a29=(a6*a29);
  a29=(a29+a9);
  a29=(a29/a10);
  a29=(a29*a20);
  a32=(a7*a24);
  a32=sq(a32);
  a32=(a11*a32);
  a32=(a32+a13);
  a32=(a32*a24);
  a32=(a32/a10);
  a29=(a29+a32);
  a29=(a5-a29);
  a29=(a29+a12);
  a32=fabs(a8);
  a32=(a32*a15);
  casadi_real a33=(a8/a22);
  a33=sq(a33);
  a33=(-a33);
  a33=exp(a33);
  a33=(a23*a33);
  a33=(a21+a33);
  a33=(a33/a14);
  a32=(a32/a33);
  a32=(a8-a32);
  a33=(a4*a32);
  a33=(a15+a33);
  casadi_real a34=(a14*a33);
  a34=(a34/a10);
  a29=(a29-a34);
  a34=(a4*a29);
  a34=(a8+a34);
  casadi_real a35=(a3*a34);
  a31=(a31+a35);
  a35=(a4*a20);
  a35=(a17+a35);
  casadi_real a36=(a7*a35);
  a36=sq(a36);
  a36=(a6*a36);
  a36=(a36+a9);
  a36=(a36/a10);
  a36=(a36*a34);
  casadi_real a37=(a7*a35);
  a37=sq(a37);
  a37=(a11*a37);
  a37=(a37+a13);
  a37=(a37*a35);
  a37=(a37/a10);
  a36=(a36+a37);
  a36=(a5-a36);
  a36=(a36+a12);
  a37=fabs(a20);
  a37=(a37*a33);
  a33=(a20/a22);
  a33=sq(a33);
  a33=(-a33);
  a33=exp(a33);
  a33=(a23*a33);
  a33=(a21+a33);
  a33=(a33/a14);
  a37=(a37/a33);
  a37=(a20-a37);
  a4=(a4*a37);
  a4=(a15+a4);
  a33=(a14*a4);
  a33=(a33/a10);
  a36=(a36-a33);
  a33=(a26*a36);
  a33=(a8+a33);
  a31=(a31+a33);
  a31=(a1*a31);
  a31=(a17+a31);
  if (res[0]!=0) res[0][0]=a31;
  a29=(a3*a29);
  a19=(a19+a29);
  a36=(a3*a36);
  a19=(a19+a36);
  a36=(a26*a34);
  a36=(a17+a36);
  a29=(a7*a36);
  a29=sq(a29);
  a6=(a6*a29);
  a6=(a6+a9);
  a6=(a6/a10);
  a6=(a6*a33);
  a7=(a7*a36);
  a7=sq(a7);
  a11=(a11*a7);
  a11=(a11+a13);
  a11=(a11*a36);
  a11=(a11/a10);
  a6=(a6+a11);
  a5=(a5-a6);
  a5=(a5+a12);
  a12=fabs(a34);
  a12=(a12*a4);
  a4=(a34/a22);
  a4=sq(a4);
  a4=(-a4);
  a4=exp(a4);
  a4=(a23*a4);
  a4=(a21+a4);
  a4=(a4/a14);
  a12=(a12/a4);
  a12=(a34-a12);
  a26=(a26*a12);
  a26=(a15+a26);
  a4=(a14*a26);
  a4=(a4/a10);
  a5=(a5-a4);
  a19=(a19+a5);
  a19=(a1*a19);
  a19=(a8+a19);
  if (res[0]!=0) res[0][1]=a19;
  a37=(a3*a37);
  a32=(a32+a37);
  a12=(a3*a12);
  a32=(a32+a12);
  a12=fabs(a33);
  a12=(a12*a26);
  a22=(a33/a22);
  a22=sq(a22);
  a22=(-a22);
  a22=exp(a22);
  a23=(a23*a22);
  a21=(a21+a23);
  a21=(a21/a14);
  a12=(a12/a21);
  a12=(a33-a12);
  a32=(a32+a12);
  a32=(a1*a32);
  a15=(a15+a32);
  if (res[0]!=0) res[0][2]=a15;
  a15=arg[0] ? arg[0][3] : 0;
  a32=2400000.;
  a12=sq(a0);
  a12=(a32*a12);
  a12=(a12*a2);
  a21=1200000.;
  a0=sq(a0);
  a0=(a21*a0);
  a0=(a0*a2);
  a12=(a12+a0);
  a0=arg[1] ? arg[1][0] : 0;
  a12=(a12+a0);
  a2=sq(a18);
  a2=(a32*a2);
  a2=(a2*a16);
  a18=sq(a18);
  a18=(a21*a18);
  a18=(a18*a16);
  a2=(a2+a18);
  a2=(a2+a0);
  a2=(a3*a2);
  a12=(a12+a2);
  a2=sq(a27);
  a2=(a32*a2);
  a2=(a2*a25);
  a27=sq(a27);
  a27=(a21*a27);
  a27=(a27*a25);
  a2=(a2+a27);
  a2=(a2+a0);
  a2=(a3*a2);
  a12=(a12+a2);
  a2=sq(a28);
  a2=(a32*a2);
  a2=(a2*a30);
  a28=sq(a28);
  a28=(a21*a28);
  a28=(a28*a30);
  a2=(a2+a28);
  a2=(a2+a0);
  a12=(a12+a2);
  a12=(a1*a12);
  a15=(a15+a12);
  a12=sq(a17);
  a12=(a32*a12);
  a12=(a12*a8);
  a17=sq(a17);
  a17=(a21*a17);
  a17=(a17*a8);
  a12=(a12+a17);
  a12=(a12+a0);
  a17=sq(a24);
  a17=(a32*a17);
  a17=(a17*a20);
  a24=sq(a24);
  a24=(a21*a24);
  a24=(a24*a20);
  a17=(a17+a24);
  a17=(a17+a0);
  a17=(a3*a17);
  a12=(a12+a17);
  a17=sq(a35);
  a17=(a32*a17);
  a17=(a17*a34);
  a35=sq(a35);
  a35=(a21*a35);
  a35=(a35*a34);
  a17=(a17+a35);
  a17=(a17+a0);
  a17=(a3*a17);
  a12=(a12+a17);
  a17=sq(a36);
  a32=(a32*a17);
  a32=(a32*a33);
  a36=sq(a36);
  a21=(a21*a36);
  a21=(a21*a33);
  a32=(a32+a21);
  a32=(a32+a0);
  a12=(a12+a32);
  a12=(a1*a12);
  a15=(a15+a12);
  if (res[0]!=0) res[0][3]=a15;
  a15=arg[0] ? arg[0][4] : 0;
  a12=(a3*a0);
  a12=(a0+a12);
  a32=(a3*a0);
  a12=(a12+a32);
  a12=(a12+a0);
  a12=(a1*a12);
  a15=(a15+a12);
  a12=(a3*a0);
  a12=(a0+a12);
  a3=(a3*a0);
  a12=(a12+a3);
  a12=(a12+a0);
  a1=(a1*a12);
  a15=(a15+a1);
  if (res[0]!=0) res[0][4]=a15;
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
  if (sz_w) *sz_w = 38;
  return 0;
}

#ifdef MATLAB_MEX_FILE
void mex_Simulate_system(int resc, mxArray *resv[], int argc, const mxArray *argv[]) {
  int i, j;
  if (argc>3) mexErrMsgIdAndTxt("Casadi:RuntimeError","Evaluation of \"Simulate_system\" failed. Too many input arguments (%d, max 3)", argc);
  if (resc>1) mexErrMsgIdAndTxt("Casadi:RuntimeError","Evaluation of \"Simulate_system\" failed. Too many output arguments (%d, max 1)", resc);
  int *iw = 0;
  casadi_real w[52];
  const casadi_real* arg[3] = {0};
  if (--argc>=0) arg[0] = casadi_from_mex(argv[0], w, casadi_s0, w+14);
  if (--argc>=0) arg[1] = casadi_from_mex(argv[1], w+5, casadi_s1, w+14);
  if (--argc>=0) arg[2] = casadi_from_mex(argv[2], w+6, casadi_s2, w+14);
  casadi_real* res[1] = {0};
  --resc;
  res[0] = w+9;
  i = Simulate_system(arg, res, iw, w+14, 0);
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
