max_rel_diff = 1;
close all;
alpha = params.alpha;
% KT = ones(TT,1)*params.Kss;
% CT = ones(TT,1)*params.Css;
% rT = ones(TT,1)*r_ss;
rtildeT = ones(TT,1)*rtilde_ss;
Css = params.Css;
% keyboard
for iter = 1:maxiter
    % first, we solve for the path of capital and wages given guessed
    % interest rate
    tic
    
    
    if params.kappa == 0
%         KT   = ((rT+params.delta)./(alpha.*ZT)).^(1/(alpha-1));

        KLratioT = (rdT./ZT /alpha).^(1/(alpha-1));
        rT       = rdT - params.delta;
%         rT(2:TT-1) = ZT(2:TT-1).*alpha.*KT(2:TT-1).^(alpha-1).*exLT(2:TT-1).^(1-alpha)-params.delta;
        rtildeT(2:TT-1) = (rT(2:TT-1)+params.delta)./qT(1:TT-2)+(1-params.delta)*qT(2:TT-1)./qT(1:TT-2)-1; %changed

    else
        rT = phi_ext(CT,params).*ZT.*alpha.*KLratioT.^(alpha-1)-params.delta;
        
        for t=2:TT-1
            rtildeT(t) = (rT(t)+params.delta)/qT(t-1)+(1-params.delta)*qT(t)/qT(t-1)-1; %changed

            %             rT(t) = phi_ext(CT(t),params)*ZT(t)*alpha*KT(t)^(alpha-1)*exLT(t)^(1-alpha)-params.delta;
%             if(~isreal(rT(t)))
%                 keyboard
%             end
%             rtildeT(t) = (rT(t)+params.delta)/qT(t-1)+(1-params.delta)*qT(t)/qT(t-1)-1; %changed
%             KT(t+1) = (phi_ext(CT(t),params)*ZT(t)*KT(t)^alpha*exLT(t)^(1-alpha) - CT(t))/qT(t) + (1-params.delta)*KT(t);%changed
            
        end
    end
    
%     keyboard

    wT      = (1-alpha)*ZT.*phi_ext(CT,params).*(KLratioT).^alpha;  
%     wT      = (1-alpha)*ZT.*phi_ext(CT,params).*(KT./exLT).^alpha;  
%     YT      = ZT.*phi_ext(CT,params).*KT.^alpha.*exLT.^(1-alpha); 
%     TaxT    = wT.*exLT*tax;
    transT  = zeros(TT,1);
    TaxT = zeros(TT,1);
    
    
    BGT = BG_ss*ones(TT,1);
    taxcT = ones(TT,1)*params.taxc;
    for t=2:TT-1
        transT(t) = tax_val*(log(CT(t))-log(params.Css)) + debt_val*(BGT(t)-BG_ss);
        BGT(t+1)=(1+rtildeT(t))*BGT(t)+transT(t);%change
    end        
%     keyboard
%     [VT,ST,AT,OmegaT] = backsolve_trans_V(V,decision,Omega,A_ss,Ghat,rT,wT,transT,exLT,betaT,taxcT,params,ChiT);
    [CpT,ST,AT,CT2,LabT,OmegaT] = backsolve_egm(cpol,c_fine,dec,dec_fine,lab_fine,Omega,A_ss,Css,rtildeT,wT,transT,params);


    if(max_rel_diff <0.0001)
        updatescale=update1;
    else
        updatescale=update2;
    end
    
    if(params.kappa == 0)
%         rTNew(2) = ZT(2)*alpha*K_ss^(alpha-1) - params.delta;
%         rTNew=zeros(TT,1);
%         rTNew(3:TT)=(ones(TT-2,1)+((BGT(3:TT)+KT(3:TT))./AT(2:TT-1)-1)/updatescale).*rT(3:TT);
%         rTNew(TT) = r_ss;
%         rTNew(1)  = r_ss;
%         For when kappa>0 shooting on rT
%         rTNew(2) = (1+((((1+rT(2))*AT(1)-AT(2) +wT(2) + transT(2)) / CT(2))-1)/(10*updatescale))*rT(2);

%         KTNew = ones(TT,1)*params.Kss;
%         KTNew(3:TT) = (ones(TT-2,1)+( ((AT(2:TT-1)-BGT(3:TT))./qT(2:TT-1))./KT(3:TT) - 1)/updatescale).*KT(3:TT);
%         LTNew = ones(TT,1)*params.Lss;
%         LTNew(2:TT-1) = (ones(TT-2,1)+( LabT(2:TT-1)./exLT(2:TT-1) - 1)/(updatescale)).*exLT(2:TT-1);

        KLratioNew          = ones(TT,1)*params.Kss/params.Lss;
        KLratioNew(2)       = params.Kss/LabT(2);
        KLratioNew(3:TT-1)    = ((AT(2:TT-2)-BGT(3:TT-1))./qT(2:TT-2))./LabT(3:TT-1);

%         rdTNew         = ones(TT,1)*(params.rss+params.delta);
%         rdTNew(2)      = ZT(2)*alpha*K_ss^(alpha-1)*LabT(2)^(1-alpha);
%         rdTNew(3:TT) = ZT(3:TT).*alpha.*(((AT(2:TT-1)-BGT(3:TT))./qT(2:TT-1))./LabT(3:TT)).^(alpha-1);

    else
        CTNew = ones(TT,1)*params.Css;
        CTNew(2:TT-1) = (ones(TT-2,1)+( CT2(2:TT-1)./CT(2:TT-1) - 1)/updatescale).*CT(2:TT-1);
        KLratioNew          = ones(TT,1)*params.Kss/params.Lss;
        KLratioNew(2)       = params.Kss/LabT(2);
        KLratioNew(3:TT-1)    = ((AT(2:TT-2)-BGT(3:TT-1))./qT(2:TT-2))./LabT(3:TT-1);

    end
    
% keyboard

    display('simulated economy')
    toc


%     max_rel_diff = max( abs((BGT(3:TT)+qT(2:TT-1).*KT(3:TT)-AT(2:TT-1)))/A_ss);
%     max_abs_diff = max(abs(BGT(3:TT)+qT(2:TT-1).*KT(3:TT)-AT(2:TT-1)));
%     
%     max_rel_diff_L = max( abs((exLT(2:TT-1)-LabT(2:TT-1)))/params.Lss);
% 
% 
%     fprintf('maximum relative difference bonds-savings: %f \n',max_rel_diff);
%     fprintf('maximum relative difference labor supply-demand: %f \n',max_rel_diff_L);
    
    
%     max_rel_diff = max(KLratioT(2:TT)-[K_ss./LabT(2); (((AT(2:TT-1)-BGT(3:TT))./qT(2:TT-1))./LabT(2:TT-1))]);

    max_rel_diff = max(abs(KLratioT-KLratioNew))/(params.Kss/params.Lss);
    if(params.kappa ~=0)
        max_rel_diff_C = max(abs(CT2-CT))/(params.Css);
        fprintf('maximum difference K/L: %e\t C: %e \n',max_rel_diff,max_rel_diff_C);
    else
        max_rel_diff_C = 0;
        fprintf('maximum difference K/L: %e \n',max_rel_diff);
    end
    
    
%     fprintf('maximum absolute difference bonds-savings: %f \n',max_abs_diff);

    if(max_rel_diff <0.00001)
        lambv = lamb2;
    else
        lambv = lamb;
    end
% keyboard

    if max(max_rel_diff,max_rel_diff_C) < rel_tol
        fprintf('found approximate fixed point of bond evolution \n in %d iterations \n',iter);
        break
     elseif (iter < maxiter)
         if params.kappa == 0
%              rdT(2:TT-1) = rdT(2:TT-1)*lamb+rdTNew(2:TT-1)*(1-lamb);
             rdT = ZT.*alpha.*(KLratioT*lambv+KLratioNew*(1-lambv)).^(alpha-1);
             
%              rT(2:TT-1) = rT(2:TT-1)*lamb+rTNew(2:TT-1)*(1-lamb);
%              KT(3:TT-1) = KT(3:TT-1)*lamb+KTNew(3:TT-1)*(1-lamb);
%              exLT(2:TT-1) = exLT(2:TT-1)*lamb+LTNew(2:TT-1)*(1-lamb);

            

         else
             CT(2:TT-1) = CT(2:TT-1)*lambv+CTNew(2:TT-1)*(1-lambv);
             KLratioT = KLratioT*lambv+KLratioNew*(1-lambv);

         end
    else
         fprintf('debt evolution over transition period did not converge \n in %d iterations \n',iter);
    end


end
