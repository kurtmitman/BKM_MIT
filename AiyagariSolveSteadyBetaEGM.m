function [beta,V,dec,cpol,G0,Ghat,DGhat] = AiyagariSolveSteadyBetaEGM(params,V0,dec0)


Amin = params.Amin;
Amax = params.Amax;
Agrid = params.Agrid;
ns = params.ns;
nA = params.nA;
piex = params.piex;
ex = params.ex;
tol2 = params.tol2;
tax = params.tax;
exinv = params.exinv;

nA_fine = params.nA_fine;
Agrid_fine = params.Agrid_fine;


diff = 1;   % set initial difference larger than tolerance level
diffG = 1;
iter = 0;

exL = ex;
gL = zeros(ns,1);


betamin = params.betamin;
betamax = params.betamax;
beta = (betamin+betamax)/2;

BGss = params.BGss;
Kss  = params.Kss;
r    = params.rss;
w    = params.wss;
trans = params.transss;

if(isnan(c0)==1)
    disp('No initial guess for c0')
    c0 = trans+repmat(exL',[nA 1])*w*(1-params.tax)+r*repmat(Agrid,[1 ns]);
end

G0 = repmat(exinv,[nA_fine 1]).*repmat(linspace(0,1,nA_fine)',[1 ns]);
size(G0)
while abs(diff)>tol2 && (betamax - betamin) > 0.001*tol2
    
    beta = (betamin+betamax)/2;
    params.beta=beta;
    [dec,cpol,labor] = solve_EGM_EL(w,r,exL,trans,beta,c0,params); % stochastic consumption savings problem
   
    t2 = tic;
    save VGuess V dec;
    for j=1:ns
        dec_fine(:,j) = interp1(Agrid(j,:),dec(:,j),Agrid_fine(j,:),'pchip');
    end
    for j=1:ns
        for jp=1:ns
            for y=1:ny
                cah_fine = dec_fine(:,j)*(1+r)+(1-tax)*w*exL(jp)*zet(y)+trans;
                [cah_unique, ind_unique] = unique(cah_fine,'last');
                Sinv(y,jp,j) = pchip(cah_unique,Agrid_fine(jp,ind_unique)'); %pchip respects monotonicity (other than spline!)
                IL(:,y,jp,j) = (cah_fine(1)<=Agrid_fine(jp,:)'); %indicator for a(i)>=minimum savings decision
                IH(:,y,jp,j) = (cah_fine(nA_fine)<=Agrid_fine(jp,:)'); %indicator for a(i)>=maximum savings decision
            end
        end
    end
    
    diffG = 1;
    iterG = 0;
    while abs(diffG)>1e-10
        for j=1:ns
            Ghat(j) = pchip(Agrid_fine(j,:),G0(:,j)); %pchip respects monotonicity (other than spline!)
        end
        G1 = zeros(nA_fine,ns);
        for j=1:ns
            for j2=1:ns
                for y=1:ny
                    G1(:,j) = G1(:,j) + ome(y)*IL(:,y,j,j2).*piex(j2,j).*(IH(:,y,j,j2).*exinv(j2)+(1-IH(:,y,j,j2)).*ppval(Ghat(j2),ppval(Sinv(y,j,j2),Agrid_fine(j,:)')));
                end
            end
        end
        diffG = max(max(abs(G1-G0)));
        G0 = G1;
        iterG = iterG+1;
    end
    % Now that the invariant distribution has been found, we can compute
    % the aggregate level of savings supplied by the consumers in this
    % economy by taking the expection over the invariant distribution.
    for j=1:ns
        DGhat = myfnder(Ghat(j));
        dechat = pchip(Agrid(j,:),dec(:,j));
        fh = @(x) ppval(dechat,x).*ppval(DGhat,x);
        a(j) = integral(fh,Amin(j),Amax,'AbsTol',1e-8,'RelTol',1e-8);
        a(j) = a(j)+G0(1,j)*dec(1,j);
        fh = @(x) x.*ppval(DGhat,x);
        cahp(j) = integral(fh,Amin(j),Amax,'AbsTol',1e-8,'RelTol',1e-8);
        cahp(j) = cahp(j)+G0(1,j)*Agrid(1,j);
        Chat = pchip(Agrid(j,:),cpol(:,j));
        fh = @(x) ppval(Chat,x).*ppval(DGhat,x);
        c(j) = integral(fh,Amin(j),Amax,'AbsTol',1e-8,'RelTol',1e-8);
        c(j) = c(j)+G0(1,j)*cpol(1,j);

    end
    A = sum(a);
    C = sum(c);
    CAHP = sum(cahp);
    % Finally, we compute the difference between the aggregate level of
    % capital demanded by firms (the guess we started out with, which
    % resulted in fixed interest and wage rates) and the aggregate level of
    % capital supplied by consumers.
    diff = BGss + Kss - A;
    if diff > 0  % savings too low -> r must increase
        betamin = beta;
    else  % savings too high -> r must decrease
        betamax = beta;
    end
    iter = iter+1;
    fprintf('time spent on simulation: %f \n',toc(t2));
    fprintf('beta = %.8f, BG = %.3f, A = %.3f,C = %.3f,CAH = %.3f,BUD = %e, diff = %.3f \n',beta,BGss+Kss,A,C,CAHP,CAHP-C-A,diff)
    V0 = V; %update initial guess to speed up process
    dec0 = dec;
%     keyboard

end

% size(G0)
BG=params.BGss;
end