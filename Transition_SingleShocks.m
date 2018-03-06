% MATLAB script that computes impulse responses to technology shocks
clear
close all;
SaveDir=[pwd '/Results/'];
RepAgentDir=[pwd '/DynareCode/'];
cd(RepAgentDir)

tax_val = 0; 
debt_val = 0; 
TT = 350; % length of transition period (increasing in rho)
params.TT=TT;
shocks_z=[1 0 0 -1];
shocks_q=[0 -1 1 0];
rho_z=0.95;
rho_q=0.9;
var_q=0.02;
var_z=0.007;


kappa_val = 0;
c_steady  = 1.25581;
sigma_val = 1;
zpers     = rho_z;
zvar      = var_z;
delta_val = 0.025;
psi_val   = 0.0;
alpha_val = 0.36;
labval=1;
frischval=1;
qpers     = rho_q;
qvar      = var_q; 
sub_val   = 0;
yss       = 0;
kss       = 1;
rss       = 0;
wss       = 0;
hss       = log(1/3);
css       = c_steady;
u_css     = 1/css;
invss     = 1;

for jjj=1:4
    switch jjj
        case 1
            qvar      = 0; 
            zvar      = var_z;

            dynare CalibLFNewPos;
        case 2
            qvar      = var_q; 
            zvar      = 0;
            dynare CalibLFNewNeg;
        case 3
            qvar      = var_q; 
            zvar      = 0;
            dynare CalibLFNewPos;
        case 4
            qvar      = 0; 
            zvar      = var_z;
            dynare CalibLFNewNeg;
    end            
    r_steady = oo_.steady_state(5);
    rguess(:,jjj) = exp(r-r_steady);
    shock_q = shocks_q(jjj); % size of shock
    shock_z = shocks_z(jjj);

    for t = 2:TT
        shockval=shock_z*var_z/100;
        Zshock(t,jjj) = rho_z^(t-2) * shockval;
        shockval=shock_q*var_q/100;
        qshock(t,jjj) = rho_q^(t-2) * shockval;
    end
end

savefigs=1;
load([SaveDir 'SteadyStateOutput.mat']);
SaveDir=[pwd '/Results/'];
RepAgentDir=[pwd '/DynareCode/'];
figname='HAEcon_single_shock_small';
expname='LF';
cd(CodeDir)
params.Css = params.Yss-params.delta*params.Kss;
params.kappa = kappa_c; 
params.psi_ext = psi_val;
params.phi_lev = 1/(params.Css+params.kappa)^params.psi_ext;
nA_fine = params.nA_fine;
Agrid_fine = params.Agrid_fine;
params.TT=TT;
CT = ones(TT,1)*params.Css;
exLT = ones(TT,1)*params.Lss;
KT = ones(TT,1)*params.Kss;
piex = params.piex;
exinv = params.exinv;
ns = params.ns;
nA = params.nA;
Amin = params.Amin;
Amax = params.Amax;
Agrid = params.Agrid;
tax = params.tax;
tol = params.tol;
w_ss = params.wss;
z_ss = params.Z;
L_ss = 1;
K_ss = params.Kss;
G_ss = params.Gss;
trans_ss = params.transss;
Omega = G0;
BG_ss = params.BGss;
A_ss = K_ss + BG_ss;
r_ss = params.rss;

params.q = 1; %steady state value
rtilde_ss = r_ss+params.delta+(1-params.delta)*params.q-1;
params.rtilde_ss = rtilde_ss;

params.r_ss = params.rss;
shock = [shockval]; % size of shock
rho = 0.9; % autocorrelation technology

Chishock = zeros(TT,length(shock));
params.Chi=1;
Gshock = zeros(TT,1);
Tshock = zeros(TT,1);

rTtrans=zeros(TT,length(shock)); %al reves

%%

for k=1:length(shocks_z)
    params.budget_balance = 1; %to keep debt constant
    
    rdT = ones(TT,1)*(params.delta+params.rss);
    rdT(2:TT-1) = rguess(2:TT-1,k)*(params.delta+params.rss);

    
    GT = exp(Gshock)*G_ss;
    ZT = exp(Zshock(:,k))*params.Z;
    transT = exp(Tshock)*trans_ss;
    qT = exp(qshock(:,k))*params.q;
    

    maxiter = 150;
    rel_tol = 1e-7;
    damping = 0.8;

    betaT=params.beta*ones(TT,1);

    do_smooth=1;
    lamb=0.8;
    lamb2=0.75;
    update1=1;
    update2=2;
    
%     keyboard
    
    DoTransitionRealEGM_NoSubsidy;
    close all;
    KT = ones(TT,1)*params.Kss;
    KT(3:TT-1) = ((AT(2:TT-2)-BGT(3:TT-1))./qT(2:TT-2));
    YT      = ZT.*phi_ext(CT2,params).*KT.^alpha.*LabT.^(1-alpha);
    
    rTtrans_dev(:,k)=log(rT)-log(params.rss); %al reves
    rtildeTtrans_dev(:,k)=log(rtildeT)-log(params.rss);%changed
    CTtrans_dev(:,k)=log(CT2)-log(params.Css);
    KTtrans_dev(:,k)=log(KT)-log(params.Kss);
    wTtrans_dev(:,k)=log(wT)-log(params.wss);
    BGTtrans_dev(:,k)=log(BGT)-log(params.BGss);
    transTtrans_dev(:,k)=log(transT)-log(params.transss);
    YTtrans_dev(:,k)=log(YT)-log(params.Yss);
    LTtrans_dev(:,k)=log(LabT)-log(params.Lss);
    
    save([SaveDir figname expname '_Zshock_' num2str(1000*shocks_z(1,k)) '_Qshock_' num2str(1000*shocks_q(1,k)) ])

    
 
end


