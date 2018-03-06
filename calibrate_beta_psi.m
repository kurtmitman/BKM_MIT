function [resid,dec,cpol,G0,lab,c_fine,dec_fine,lab_fine] = calibrate_beta_psi(XT,params,c0,G0)


    Agrid = params.Agrid;
    ns = params.ns;
    nA = params.nA;
    ex = params.ex;
    exinv = params.exinv;

    nA_fine = params.nA_fine;
    Agrid_fine = params.Agrid_fine;



    exL = ex;


    beta = XT(1);
    psi = XT(2);
    params.beta = beta;
    params.psi = psi;
    params.disutil_scale = psi;
    
    
    BGss = params.BGss;
    Kss  = params.Kss;
    r    = params.rss;
    w    = params.wss;
    trans = params.transss;

    if(isnan(c0)==1)
        disp('No initial guess for c0')
        c0 = trans+repmat(exL',[nA 1])*w*(1-params.tax)+r*repmat(Agrid,[1 ns]);
    end
    if(isnan(G0)==1)
        disp('No initial guess for G0')
        G0 = repmat(exinv,[nA_fine 1]).*repmat(linspace(0,1,nA_fine)',[1 ns]);
    end
    load('Cguess','cpol','G0');
    c0=cpol;
    [dec,cpol,lab,dec_fine,c_fine,lab_fine] = solve_EGM_EL(w,r,exL,trans,beta,c0,params); % stochastic consumption savings problem
   

    ComputeDistHist   
    
    save CGuess cpol G0;

    A = sum(a);
    L = sum(labs);

    
    resid(1)   = BGss + Kss - A;
    resid(2)   = params.Lss - L;   

end