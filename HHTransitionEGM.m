OmegaT = zeros(nA_fine,ns,TT);



bmin = params.bmin;


ST(:,:,TT) = dec_inf;
CpT(:,:,TT) = cpol_inf;

STfine = zeros(nA_fine,ns,TT); % savings decisions over time
CpTfine = zeros(nA_fine,ns,TT); % savings decisions over time
LabTfine = zeros(nA_fine,ns,TT); % savings decisions over time
%     keyboard
  
CpTfine(:,:,1) = c_fine_0;
CpTfine(:,:,TT) = c_fine_inf;


STfine(:,:,1)  = dec_fine_0;
STfine(:,:,TT) = dec_fine_0;

LabTfine(:,:,1) = lab_fine_0;

AT = zeros(TT,1);
AT(1) = A_0;

CT = zeros(TT,1);
CAH = zeros(TT,1);


OmegaT(:,:,1) = Omegass;

fprintf('Backsolve\n');

l_constrained=zeros(nA,ns);
options=optimset('Display','off');
sav_grid = repmat(Agrid,[1 ns]);

for h = 1:(TT-2)
    t = TT-h;

    r = rT(t);
    w = wT(t);
    tax = TauT(t);
    trans = transT(t);

    exLw = (1-params.tax)*w*repmat(ex',[nA 1]);
    
        
    Emup1 = squeeze(CpT(:,:,t+1).^(-params.gamma));
    Emup = beta*(1+rT(t+1))*Emup1*params.piex';
    c_s = Emup.^(-1/params.gamma);
    lab = (exLw.*Emup/params.psi).^params.frisch;

    a_today = (c_s+sav_grid - exLw.*lab-trans)/(1+r);
%     keyboard
    for j=1:ns
        i=1;
        while(Agrid(i)<a_today(1,j))
           l_constrained(i,j)=fsolve(@(x) w*ex(j)*(w*ex(j)*x+trans+(1+r)*Agrid(i))^(-params.gamma)-params.psi*x^(1/params.frisch),1/3,options);
           i = i + 1;
%            disp(i);
        end
        l_constrained(i:end,j)=lab(1,j);
    end
    c_constrained = l_constrained.*exLw+(1+r)*repmat(Agrid,[1 ns]);

    for j=1:ns
        CpT(:,j,t) = (Agrid>a_today(1,j)).*interp1(a_today(:,j),c_s(:,j),Agrid,'pchip')+(params.Agrid<=a_today(1,j)).*c_constrained(:,j);
        LabT(:,j,t) = (Agrid>a_today(1,j)).*interp1(a_today(:,j),lab(:,j),Agrid,'pchip')+(params.Agrid<=a_today(1,j)).*l_constrained(:,j);
        CpTfine(:,j,t) = (Agrid_fine>a_today(1,j)).*interp1(a_today(:,j),c_s(:,j),Agrid_fine,'pchip')+(params.Agrid_fine<=a_today(1,j)).*interp1(Agrid,c_constrained(:,j),Agrid_fine,'pchip');
        LabTfine(:,j,t) = (Agrid_fine>a_today(1,j)).*interp1(a_today(:,j),lab(:,j),Agrid_fine,'pchip')+(params.Agrid_fine<=a_today(1,j)).*interp1(Agrid,l_constrained(:,j),Agrid_fine,'pchip');        
        STfine(:,j,t) = (Agrid_fine>a_today(1,j)).*((1+r)*Agrid_fine+LabTfine(:,j,t)*w*ex(j)*(1-params.tax)+trans-CpTfine(:,j,t));
    end
%     keyboard
end

    % update distributions
OmegaT(:,:,2:TT)=0;
t=1;
a = sum(OmegaT(:,:,t).*STfine(:,:,t),1);
c = sum(OmegaT(:,:,t).*CpTfine(:,:,t),1);
l = sum(OmegaT(:,:,t).*LabTfine(:,:,t),1);


AT(t) = sum(a);
CT(t) = sum(c);
LabT(t) = sum(l);
fprintf('Forward simulate\n');


for t=2:TT
    r = rT(t);
    w = wT(t);
    trans = transT(t);

    
    
    
 
    for j=1:ns
        apl = floor( (nA_fine-1)*((STfine(:,j,t-1)-params.Amin)/(params.Amax-params.Amin)).^(1/params.curv_fine) )+1;
        apl=apl.*(apl<nA_fine)+(nA_fine-1)*(apl>=nA_fine);
        vala = (params.Agrid_fine(apl+1)-STfine(:,j,t-1))./(params.Agrid_fine(apl+1)- params.Agrid_fine(apl));
        for ai = 1:nA_fine     
            for jp=1:ns
%                 keyboard
                OmegaT(apl(ai),jp,t) = OmegaT(apl(ai),jp,t)+OmegaT(ai,j,t-1)*params.piex(j,jp)*vala(ai);
                OmegaT(apl(ai)+1,jp,t) = OmegaT(apl(ai)+1,jp,t)+OmegaT(ai,j,t-1)*params.piex(j,jp)*(1-vala(ai));
                
            end
        end
    end

    
    a = sum(OmegaT(:,:,t).*STfine(:,:,t),1);
    c = sum(OmegaT(:,:,t).*CpTfine(:,:,t),1);
    l = sum(OmegaT(:,:,t).*LabTfine(:,:,t).*repmat(ex',[nA_fine 1]),1);


    AT(t) = sum(a);
    CT(t) = sum(c);
    LST(t) = sum(l);
    
%     keyboard
end