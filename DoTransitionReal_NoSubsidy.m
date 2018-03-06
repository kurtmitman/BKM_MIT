max_rel_diff = 1;
close all;
alpha = params.alpha;
KT = ones(TT,1)*params.Kss;
rT = ones(TT,1)*r_ss;
rtildeT = ones(TT,1)*rtilde_ss;
for iter = 1:maxiter
    % first, we solve for the path of capital and wages given guessed
    % interest rate
    tic
    
    
    exLT = L_ss*ones(TT,1);
    if params.kappa == 0
        KT   = ((rT+params.delta)./(alpha.*ZT)).^(1/(alpha-1));
    else
        for t=2:TT-1
            rT(t) = phi_ext(CT(t),params)*ZT(t)*alpha*KT(t)^(alpha-1)-params.delta;
            rtildeT(t) = (rT(t)+params.delta)/qT(t-1)+(1-params.delta)*qT(t)/qT(t-1)-1; 
            KT(t+1) = (phi_ext(CT(t),params)*ZT(t)*KT(t)^alpha - CT(t))/qT(t) + (1-params.delta)*KT(t);
        end
    end
    

    wT      = (1-alpha)*ZT.*phi_ext(CT,params).*KT.^alpha;  
    YT      = ZT.*phi_ext(CT,params).*KT.^alpha; 
    TaxT    = wT.*exLT*tax;
    transT  = zeros(TT,1);
    if params.budget_balance ==1
        taxcT   = ones(TT,1)*params.taxc;
        transT(1) = params.transss; 
        BGT = BG_ss*ones(TT,1);
        for t=2:TT-1
            transT(t) = BGT(t+1)-(1+rT(t))*BGT(t)-GT(t)+TaxT(t)+taxcT(t)*CT(t);
        end        
        t=TT;
        transT(TT) = BG_ss-(1+rT(t))*BGT(t)-GT(t)+TaxT(t)+taxcT(t)*CT(t);
    else
        BGT = BG_ss*ones(TT,1);
        taxcT = ones(TT,1)*params.taxc;
        for t=2:TT-1
            BGT(t+1)=(1+rT(t))*BGT(t)-taxcT(t)*CT(t)-TaxT(t);
        end        
    end
    [VT,ST,AT,OmegaT] = backsolve_trans_V(V,decision,Omega,A_ss,Ghat,rtildeT,wT,transT,exLT,betaT,taxcT,params,ChiT);


    if(max_rel_diff <0.005)
        updatescale=update1;
    else
        updatescale=update2;
    end
    CT2=zeros(TT,1);
    CT2(1) = params.Css;
    for t=2:TT
        CT2(t) = ((1+rtildeT(t))*AT(t-1)-AT(t)+wT(t)*(1-tax)+transT(t))*(1-taxcT(t));%changed
    end
    
    
    if(params.kappa == 0)
        rTNew(2) = ZT(2)*alpha*K_ss^(alpha-1) - params.delta;
        rTNew=zeros(TT,1);
        rTNew(3:TT)=(ones(TT-2,1)+((BGT(3:TT)+KT(3:TT))./AT(2:TT-1)-1)/updatescale).*rT(3:TT);
        rTNew(TT) = r_ss;
        rTNew(1)  = r_ss;

    else
        CTNew = ones(TT,1)*params.Css;
        CTNew(2:TT-1) = (ones(TT-2,1)+( CT2(2:TT-1)./CT(2:TT-1) - 1)/updatescale).*CT(2:TT-1);
    end
    


    display('simulated economy')
    toc


    max_rel_diff = max( abs((BGT(3:TT)+qT(2:TT-1).*KT(3:TT)-AT(2:TT-1)))/A_ss);
    max_abs_diff = max(abs(BGT(3:TT)+qT(2:TT-1).*KT(3:TT)-AT(2:TT-1)));
    

    fprintf('maximum relative difference bonds-savings: %f \n',max_rel_diff);
    fprintf('maximum absolute difference bonds-savings: %f \n',max_abs_diff);



    if max(max_rel_diff) < rel_tol
        fprintf('found approximate fixed point of bond evolution \n in %d iterations \n',iter);
        break
     elseif (iter < maxiter)
         if params.kappa == 0
             rT(2:TT-1) = rT(2:TT-1)*lamb+rTNew(2:TT-1)*(1-lamb);
         else
             CT(2:TT-1) = CT(2:TT-1)*lamb+CTNew(2:TT-1)*(1-lamb);
         end
    else
         fprintf('debt evolution over transition period did not converge \n in %d iterations \n',iter);
    end


end
