function [dec,cpol,labor,dec_fine,c_fine,lab_fine] = solve_EGM_EL(w,r,exL,trans,beta,c0,params)
% solve_EGM_EL Function that solves stochastic consumption savings problem
% using the endogenous grid point method with endogenous labor supply
%
% INPUT:        w     wage rate
%               r     interest rate
%               exL   effective labor productivity
%               c0    initial guess consumption function
%               param parameter structure
%
% OUTPUT:       dec   optimal savings decisions (nA*ns)
%               cpol  optimal consumption decisions (nA*ns)
%               labor optimal labor supply (nA*ns)
%               dec_fine same as above, but for fine grid (nA_fine*ns)
%               c_fine same as above, but for fine grid (nA_fine*ns)
%               lab_fine same as above, but for fine grid (nA_fine*ns)


nA = params.nA;
nA_fine = params.nA_fine;
ns = params.ns; 
Agrid = params.Agrid;
Agrid_fine = params.Agrid_fine;
tol = params.tol;
maxIter = params.maxIter;


sav_grid = repmat(Agrid,[1 ns]);

exLw = (1-params.tax)*w*repmat(exL',[nA 1]);
l_constrained=zeros(nA,ns);
options=optimset('Display','off');
for j=1:ns
    for i=1:nA
       l_constrained(i,j)=fsolve(@(x) w*exL(j)*(w*exL(j)*x+trans+(1+r)*Agrid(i))^(-params.gamma)-params.psi*x^(1/params.frisch),1/3,options);
    end
end
c_constrained = l_constrained.*exLw+(1+r)*repmat(Agrid,[1 ns]);


for m=1:maxIter

    Emup1 = c0.^(-params.gamma);
    Emup = beta*(1+params.rss)*Emup1*params.piex';
    c_s = Emup.^(-1/params.gamma);
%     here, need to solve for labor supply
    lab = (exLw.*Emup/params.psi).^params.frisch;
        
    a_today = (c_s+sav_grid - exLw.*lab-trans)/(1+r);
    
    %When a < a_today(1,j) that means borrowing constrained so that
    % c_s = exLw*lab
    
    for j=1:ns
        
        c_new(:,j) = (Agrid>a_today(1,j)).*interp1(a_today(:,j),c_s(:,j),Agrid,'pchip')+(params.Agrid<=a_today(1,j)).*c_constrained(:,j);
        labor(:,j) = (Agrid>a_today(1,j)).*interp1(a_today(:,j),lab(:,j),Agrid,'pchip')+(params.Agrid<=a_today(1,j)).*l_constrained(:,j);
        
    end
    
    maxDiff = max(max(abs(c_new-c0)));
    if(maxDiff < 1e-4)
        updateval = 0.5;
    else
        updateval = 0.9;
    end
    
    if (maxDiff < tol)
        fprintf('consumption policy function converged after %d iterations \n',m);
        break
    end
    if (m==maxIter)
        fprintf('consumption policy function did NOT converge after %d iterations \n',maxIter);
    end
    c0 = c_new*updateval+(1-updateval)*c0;

end

dec  = (1+r)*repmat(Agrid, [1 ns])+labor.*exLw+trans-c0;
cpol = c0;
c_fine = zeros(nA_fine,ns);
dec_fine = zeros(nA_fine,ns);
lab_fine = zeros(nA_fine,ns);
for j=1:ns
    c_fine(:,j) = (Agrid_fine>a_today(1,j)).*interp1(a_today(:,j),c_s(:,j),Agrid_fine,'pchip')+(params.Agrid_fine<=a_today(1,j)).*interp1(Agrid,c_constrained(:,j),Agrid_fine,'pchip');
    lab_fine(:,j) = (Agrid_fine>a_today(1,j)).*interp1(a_today(:,j),lab(:,j),Agrid_fine,'pchip')+(params.Agrid_fine<=a_today(1,j)).*interp1(Agrid,l_constrained(:,j),Agrid_fine,'pchip');        
    dec_fine(:,j) = (Agrid_fine>a_today(1,j)).*((1+r)*Agrid_fine+lab_fine(:,j)*w*exL(j)*(1-params.tax)+trans-c_fine(:,j));
end


end