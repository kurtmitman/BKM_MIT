
clear;
close all;
SaveDir='~/Dropbox/Kurt_Per_Timo_JEDC/EGMCode/Results/';

load([SaveDir 'shock_inputs.mat'])
load([SaveDir 'HAEcon_single_shock_smallLF_Zshock_1000_Qshock_0.mat']);

% keyboard
index_val=1;
CTtrans_dev=zeros(params.TT,4);
KT = exp(KTtrans_dev(:,index_val)+log(params.Kss));
InvT = zeros(TT,4);
InvT(1:TT-1,index_val) = log(KT(2:TT)-(1-params.delta)*KT(1:TT-1))-log(params.delta*params.Kss); 
YT = exp(YTtrans_dev(:,index_val)+log(params.Yss));
CT = ones(params.TT,1)*params.Css;
qT = exp(qshock(:,index_val));
CT(2:end-1) = YT(2:end-1)+(1-params.delta)*qT(2:end-1).*KT(2:end-1)-qT(2:end-1).*KT(3:end);
CTtrans_dev(:,index_val)=log(CT)-log(params.Css);
HtM = zeros(params.TT,1);
HtM = log(sum(squeeze(OmegaT(1,:,:)),1))-log(sum(OmegaT(1,:,1)));
HtMss=sum(OmegaT(1,:,1));

Gini = zeros(params.TT,1);
GiniT = Gini;
for jj=1:TT
    distt = sum(squeeze(OmegaT(:,:,jj)),2);
    Si=cumsum(params.Agrid_fine.*distt);
    Si1=[0; Si(1:end-1)];
    Gini(jj)=1-sum(distt.*(Si+Si1))/Si(end);  
end
GiniT = log(Gini)-log(Gini(1));

index_val=1;
sim_length = 349;
approxlength = 349;
trange=2:350;
pols_z = [ fliplr(YTtrans_dev(trange,index_val)'); fliplr(CTtrans_dev(trange,index_val)');...
    fliplr(InvT(trange,index_val)'); fliplr(LTtrans_dev(trange,index_val)'); ...
    fliplr(rTtrans_dev(trange,index_val)'); fliplr(wTtrans_dev(trange,index_val)'); ...
    fliplr(HtM(trange)); fliplr(GiniT(trange)')]/0.01;

close all
figure1=figure;
axes1 = axes('Parent',figure1,'FontSize',14);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'on');
index_val=1;
xrange=1:50;
plot(xrange,GiniT(xrange),xrange,HtM(xrange));
legend('Gini','HtM','Location','Best')
cd(SaveDir)
set(legend,'FontSize',16);
set(gcf, 'PaperOrientation','landscape');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    print(figure1,'-dpdf','Gini_IRF_Z.pdf','-fillpage')
        print(figure1,'-depsc2','Gini_IRF_Z.eps','-loose')

    cd(CodeDir); 



load([SaveDir 'HAEcon_single_shock_smallLF_Zshock_0_Qshock_1000.mat']);

index_val=3;
KT = exp(KTtrans_dev(:,index_val)+log(params.Kss));
InvT(1:TT-1,index_val) = log(KT(2:TT)-(1-params.delta)*KT(1:TT-1))-log(params.delta*params.Kss); 
YT = exp(YTtrans_dev(:,index_val)+log(params.Yss));
CT = ones(params.TT,1)*params.Css;
qT = exp(qshock(:,index_val));
CT(2:end-1) = YT(2:end-1)+(1-params.delta)*qT(2:end-1).*KT(2:end-1)-qT(2:end-1).*KT(3:end);
CTtrans_dev(:,index_val)=log(CT)-log(params.Css);
HtM = zeros(params.TT,1);
HtM = log(sum(squeeze(OmegaT(1,:,:)),1))-log(sum(OmegaT(1,:,1)));
HtMss=sum(OmegaT(1,:,1));
Gini = zeros(params.TT,1);
GiniT = Gini;
for jj=1:TT
    distt = sum(squeeze(OmegaT(:,:,jj)),2);
    Si=cumsum(params.Agrid_fine.*distt);
    Si1=[0; Si(1:end-1)];
    Gini(jj)=1-sum(distt.*(Si+Si1))/Si(end);  
end
GiniT = log(Gini)-log(Gini(1));
sim_length = 349;
approxlength = 349;
trange=2:350;
pols_q = [ fliplr(YTtrans_dev(trange,index_val)'); fliplr(CTtrans_dev(trange,index_val)');...
    fliplr(InvT(trange,index_val)'); fliplr(LTtrans_dev(trange,index_val)'); ...
    fliplr(rTtrans_dev(trange,index_val)'); fliplr(wTtrans_dev(trange,index_val)'); ...
    fliplr(HtM(trange)); fliplr(GiniT(trange)')]/0.01;

aggvars = zeros(8,10500);
log_zt = zeros(1,10500);
log_qt = zeros(1,10500);
for t=2:10501
    log_qt(t-1) = rho_q*log_qt(t-1)+var_q*qshocks(t+499);
    log_zt(t-1) = rho_z*log_zt(t-1)+var_z*zshocks(t+499);
    aggvars(:,t-1) = [params.Yss;params.Css;params.delta*params.Kss;params.Lss;params.rss;params.wss;HtMss;Gini(1)]+pols_z(:,sim_length-approxlength+1:end)*zshocks(t+151:t+approxlength+150)+pols_q(:,sim_length-approxlength+1:end)*qshocks(t+151:t+approxlength+150);
end
% aggvars=[exp(log_zt(1:end));exp(log_qt(1:end));aggvars];
aggvars=[zzt;qqt;aggvars];
HA_corr=corr(aggvars(:,501:end)');
dlmwrite('HACorr_Our.txt',HA_corr,'delimiter','&','precision','%10.3f');
close all
figure1=figure;
axes1 = axes('Parent',figure1,'FontSize',14);
box(axes1,'on');
grid(axes1,'on');
hold(axes1,'on');
index_val=1;
xrange=1:50;
plot(xrange,GiniT(xrange),xrange,HtM(xrange));
legend('Gini','HtM','Location','Best')
cd(SaveDir)
set(legend,'FontSize',16);
set(gcf, 'PaperOrientation','landscape');
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);
    print(figure1,'-dpdf','Gini_IRF_Q.pdf','-fillpage')
            print(figure1,'-depsc2','Gini_IRF_Q.eps','-loose')

    cd(CodeDir); 
