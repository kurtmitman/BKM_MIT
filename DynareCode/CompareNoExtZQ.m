close all;
set(0,'DefaultLineLineWidth',4)

c_steady  = 1.222904553789543;
css      = c_steady;
kss = 3;
hss = 0;
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
labval=7.75;
frischval=1;
sub_val   = 0.0;
qpers = 0.9;
qvar = 0.0;
dynare CalibLFNew

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

FigName = 'RA_LF_Z';
RA_IRFs_Z
close all
save RA_LF_Z_dat

cons_lf_z = c-c_steady;
y_z = y;

qvar=0.02;
zvar=0.0;
dynare CalibLFNew

cons_lf_q = c-c_steady;
y_q = y;
FigName = 'RA_LF_Q';
RA_IRFs_Q
close all

save RA_LF_Q_dat


