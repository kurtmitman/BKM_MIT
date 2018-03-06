function [CpT,ST,AT,CT,LST,OmegaT] = backsolve_egm(CpolF,CFine,Decision,dec_fine_0,lab_fine_0,Dist,Ass,Css,rT,wT,transT,params)
%Solve backwards the policy functions using endogenous grid point method
    Amin = params.Amin;
    Amax = params.Amax;
    nA = params.nA;
    piex = params.piex;
    ns = params.ns; 
    Agrid = params.Agrid;
    tol = params.tol;
    tax = params.tax;
    TT = params.TT;
    ex = params.ex;
    exinv = params.exinv;
    nA_fine = params.nA_fine;
    Agrid_fine = params.Agrid_fine;
    TauT = params.tax*ones(TT,1);
    LST = params.Lss*ones(TT,1);
    dec_inf   = Decision;
    cpol_inf  = CpolF;
    dec_0   = Decision;
    cpol_0  = cpol_inf;
    Omegass = Dist;
    beta = params.beta;
    c_fine_0 = CFine;
    c_fine_inf = c_fine_0;

    A_0     = Ass;
    HHTransitionEGM

    CT(TT) = Css;
    LST(TT) = params.Lss;
