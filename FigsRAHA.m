%%
clear;
close all;
SaveDir=[pwd '/Results/'];
RepAgentDir=[pwd '/DynareCode/'];
CodeDir=pwd;

set(0,'DefaultTextFontSize', 16)
set(0,'DefaultLineLineWidth',3)
set(0,'defaultfigurepaperunits','inches');
set(0,'defaultfigurepaperorientation','landscape');

cd(SaveDir)
load HAEcon_single_shock_smallLF_Zshock_-1000_Qshock_0
index_val = 3;
KT = exp(KTtrans_dev(:,index_val)+log(params.Kss));
YT = exp(YTtrans_dev(:,index_val)+log(params.Yss));
CT = ones(params.TT,1)*params.Css;
qT = exp(qshock(:,index_val));
CT(2:end-1) = YT(2:end-1)+(1-params.delta)*qT(2:end-1).*KT(2:end-1)-qT(2:end-1).*KT(3:end);
CTtrans_dev(:,index_val)=log(CT)-log(params.Css);
rT = exp(rTtrans_dev(:,index_val)+log(params.rss));
rT = rT+params.delta;
rTtrans_dev(:,index_val)=log(rT)-log(params.rss+params.delta);

cd(RepAgentDir)
load RA_LF_Q_dat
FigName = 'IRF_LF_Q';
cd(CodeDir)
MakeRAHAFigQNew

%%
cd(SaveDir)
load HAEcon_single_shock_smallLF_Zshock_-1000_Qshock_0

index_val = 1;
KT = exp(KTtrans_dev(:,index_val)+log(params.Kss));
YT = exp(YTtrans_dev(:,index_val)+log(params.Yss));
CT = ones(params.TT,1)*params.Css;
qT = exp(qshock(:,index_val));
CT(2:end-1) = YT(2:end-1)+(1-params.delta)*qT(2:end-1).*KT(2:end-1)-qT(2:end-1).*KT(3:end);
CTtrans_dev(:,index_val)=log(CT)-log(params.Css);
rT = exp(rTtrans_dev(:,index_val)+log(params.rss));
rT = rT+params.delta;
rTtrans_dev(:,index_val)=log(rT)-log(params.rss+params.delta);

cd(RepAgentDir)
load RA_LF_Z_dat
FigName = 'IRF_LF_Z';
cd(CodeDir)
MakeRAHAFigZNew




