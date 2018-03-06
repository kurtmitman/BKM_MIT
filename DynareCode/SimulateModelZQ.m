close all;

c_steady  = 1.222904553789543;
css      = c_steady;
kss = 3;
hss = log(1/3);
u_css = 0;
wss  = 0;
rss = -4;
invss = 1;
yss = 1;
sigma_val = 1;
zpers     = 0.95;
zvar      = 0.007;
chipers     = 0.0;
chivar      = 0.0;
delta_val = 0.025;
psi_val   = 0.0;
kappa_val = 0.0;
alpha_val = 0.36;
labval=1;
frischval=1;
sub_val = 0;
qpers     = 0.9;
qvar      = 0.02; 

dynare CalibLFNew
const_test = c;
c_steady = oo_.steady_state(4);
kss   = oo_.steady_state(3);
yss   = oo_.steady_state(8);
css   = oo_.steady_state(4);
u_css = oo_.steady_state(12);
wss   = oo_.steady_state(6);
hss   = oo_.steady_state(13);
rss   = oo_.steady_state(5);
invss = oo_.steady_state(9);

psi_val   = 0.0;
kappa_val = 0.0;


qvar = 0;
dynare CalibLFNew
sim_length = 500;
approxlength = 500;
pols_z = (fliplr(oo_.endo_simul(:,2:end-1))-oo_.steady_state(:))/0.01;

qvar = 0.02;
zvar = 0;
dynare CalibLFNew
approxlength = 500;
pols_q = (fliplr(oo_.endo_simul(:,2:end-1))-oo_.steady_state(:))/0.01;


zvar = 0.007;
dynare SimulLFNew

%%

aggvars = zeros(length(oo_.steady_state),10500);
for t=2:10501
    aggvars(:,t-1) = oo_.steady_state(:)+pols_z(:,sim_length-approxlength+1:end)*zshocks(t:t+approxlength-1)+pols_q(:,sim_length-approxlength+1:end)*qshocks(t:t+approxlength-1);
end

our_corr=corr(aggvars([1 15 8 4 13 9 5 6 ],501:end)');
dlmwrite('RACorr_Our.txt',our_corr,'delimiter','&','precision','%10.3f');

%%
approxlength = 100;
aggvars = zeros(length(oo_.steady_state),10500);
for t=2:10501
    aggvars(:,t-1) = oo_.steady_state(:)+pols_z(:,sim_length-approxlength+1:end)*zshocks(t:t+approxlength-1)+pols_q(:,sim_length-approxlength+1:end)*qshocks(t:t+approxlength-1);
end
our_corr=corr(aggvars([1 15 8 4 13 9 5 6 ],501:end)');

dlmwrite('RACorr_Our100.txt',our_corr,'delimiter','&','precision','%10.3f');

approxlength = 10;
aggvars = zeros(length(oo_.steady_state),10500);
for t=2:10501
    aggvars(:,t-1) = oo_.steady_state(:)+pols_z(:,sim_length-approxlength+1:end)*zshocks(t:t+approxlength-1)+pols_q(:,sim_length-approxlength+1:end)*qshocks(t:t+approxlength-1);
end
our_corr=corr(aggvars([1 15 8 4 13 9 5 6 ],501:end)');

dlmwrite('RACorr_Our10.txt',our_corr,'delimiter','&','precision','%10.3f');

