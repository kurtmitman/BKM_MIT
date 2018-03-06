 %% File to compute the steady state of a heterogenous agent model 
%  "Exploiting MIT Shocks in Heterogeneous-Agent Economies: The Impulse Response as a Numerical Derivative"
%   by Boppart, Krusell and Mitman (2018) 
%% I. Parameter Input

% 1. economic parameters
params.alpha = 0.36; % share of capital
params.sigma = 1; % CRRA (must be > 0)
params.delta = 0.025; % depreciation rate

%Labor productivity 
params.Z = 1;

%Steady state quarterly K/Y ratio = 10.26, normalize H=1/3
params.KYss = 10.26;    % target value
params.Lss  = 1/3;      % target value
params.Kss  = (params.Z*params.KYss*params.Lss^(1-params.alpha))^(1/(1-params.alpha));
params.Yss  = params.Z*params.Kss^params.alpha*params.Lss^(1-params.alpha);
params.rss  = params.alpha*params.Z*params.Kss^(params.alpha-1)*params.Lss^(1-params.alpha) - params.delta;
params.wss  = (1-params.alpha)*params.Z*params.Kss^(params.alpha)*params.Lss^(-params.alpha);


%income process from Krueger, Mitman and Perri (2016) Handbook Chapter
params.nx=7;
nx=params.nx;

%CRRA parameter
params.gamma=1;

params.frisch = 1;
params.invfrisch = 1+1/params.frisch;

%Numbers from KMP Handbook Chapter
%Persistence of AR(1)
params.rho=(0.9695)^(1/4);
rho=params.rho;
%Variance of innovations of AR(1)
sigy=sqrt(0.0384/(1+sqrt(rho)+rho+rho^(3/2)));

ns=nx;
params.ns=params.nx;
[params.ex,params.piex] =rouwenhorst(params.nx,0,rho,sigy);
params.ex=exp(params.ex);
temp=params.piex^1000000;
params.exinv=temp(1,:);
ydist=params.exinv;
params.ex=params.ex/(params.exinv*params.ex);    



%Borrowing constraint [Units of mean quarterly income]
params.bmin = 0;


%Gov't policy parameters 
% Gov spending (=6% of Y)
params.Gss = 0; %0.06*params.Yss; 
% Gov debt (=30% of annual GDP)
params.BGss = 0; 
% Proportional labor tax
params.tax = 0.0; 
% Lumpsum transfer
params.transss = params.tax*params.wss - params.Gss - params.rss*params.BGss;

params.taxc = 0;

params.Amin = params.bmin; % minimum asset holdings (if no transfer, add epsilon to zero for positive consumption)
params.Amax = 500; % maximum asset holdings


% 2. technical parameters to solve model
params.nA = 50; % # asset grid points (we do allow for off-grid decisions)
% put more points at lower end of asset grid. Note that optimal savings
% decisions become linear in the limit (i.e. as assets go to infinity).
curv=7;
params.curv=curv;
params.Agrid = params.Amin+(params.Amax-params.Amin)*(linspace(0,1,params.nA).^curv);
params.Agrid = params.Agrid';
nA = params.nA;
nA_fine = 1000;
params.nA_fine = nA_fine;
curv_fine=4;
params.curv_fine=curv_fine;
params.Agrid_fine = params.Amin+(params.Amax-params.Amin)*(linspace(0,1,params.nA_fine).^curv_fine);
params.Agrid_fine = params.Agrid_fine';
params.tol = 1e-12; % numerical error tolerance for consumption policy function in EGM
params.maxIter = 1e3; % maximum # of iterations savings problem

params.Chi=1;
%% II. Call function that computes Aiyagari equilibrium

%Initial guesses for the parameters
beta = 0.9850;
psi = 8.0241;

x0 = [beta; psi];
options=optimset('Display','iter','MaxIter',20);
XT = fsolve(@(x) calibrate_beta_psi(x,params,NaN,NaN),x0,options);
[resid,dec,cpol,G0,lab,c_fine,dec_fine,lab_fine]=calibrate_beta_psi(XT,params,NaN,NaN);

params.beta = XT(1);
params.psi  = XT(2);

beta=params.beta;
psi = params.psi;
Omega=G0;
save([SaveDir 'SteadyStateOutput'])



