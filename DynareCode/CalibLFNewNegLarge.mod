/*
    Rep Agent Model
        1.  Aggregate states: TFP, capital
        2.  TFP follows an AR(1) process in logs.

*/

// IMPORTANT: Keep z, k, h in first positions, need to agree with idx_states
// variable in matlab code.
var log_z, a,k, c, r, w, z, y, inv, phi,  s, u_c, h, q,log_q;
varexo e_z, e_q;
parameters alpha_k, beta_c, delta_k, sigma_c, kappa_c, psi_c, gamma_g
    rho_z, sigma_ez, phi_lev, y_steady, lab_disutil, frisch, rho_chi, sigma_chi, rho_q, sigma_q;

// TFP parameters
rho_z     = zpers;         // Persistence in TFP
sigma_ez  = zvar;        // Stdev of innovation


// Investment parameters
rho_q    = qpers;         // Persistence in TFP
sigma_q  = qvar;        // Stdev of innovation

// Preferences
sigma_c = sigma_val;          // RRA coefficient
beta_c = 0.99;        // discount factor

// Production
alpha_k   = alpha_val;         // Capital share
delta_k   = delta_val;        // Depreciation (possibly = 1)
lab_disutil = labval;
frisch      = frischval;
psi_c     = psi_val;  // Analytic convenience
kappa_c   = kappa_val;            // Externality in TFP from C
phi_lev   = 1/(exp(c_steady)+kappa_c)^psi_c;
y_steady = yss;

// Government
gamma_g   = sub_val;          // Strength of consumption subsidy

model;
// === Gov't ===
s       = gamma_g*(y-y_steady);

// === Households ===

exp(u_c)             = exp(c)^(-sigma_c);
exp(u_c) /(1-s) = beta_c * ((1-delta_k)*q(+1)/q+exp(r(+1))/q) * exp(u_c(+1))/(1-s(+1));
exp(w)*exp(u_c)/(1-s) = lab_disutil*exp(h)^(1/frisch);

// === TFP process ===
log_z   = rho_z * log_z(-1) + sigma_ez*e_z;              // Update z
z       = exp(log_z);
phi     = 1; //phi_lev*(kappa_c + exp(c))^psi_c;                // Externality
a       = z*phi;

// === Investment Process ===
log_q   = rho_q * log_q(-1) + sigma_q*e_q;
q       = exp(log_q);




// === Production ===
exp(y)       = a * exp(k(-1))^(alpha_k)*exp(h)^(1-alpha_k);

// === Resource constraints ===
 inv     = (exp(y) - exp(c))/q;
 exp(k)       = (1-delta_k) * exp(k(-1)) + inv;

// === Prices ===
exp(r)       = alpha_k * a * exp(k(-1))^(alpha_k-1)*exp(h)^(1-alpha_k);
exp(w)       = (1-alpha_k) * a * exp(k(-1))^alpha_k * exp(h)^-alpha_k;



end;

//var log_z, a,k, c, r, w, z, y, inv, phi,  s, T, b , u_c;






initval;
k = kss;
y = yss;
r = rss;
w = wss;
c = css;
h = hss;
u_c = u_css;
inv = invss;
a = 1;
s = 0;
phi = 1;
z = 1;
log_z =0;
q=1;

end;

steady;
check(qz_zero_threshold = 1e-25);

shocks;
var e_z;
periods 1;
values -2;
var e_q;
periods 1;
values -2;
end;
simul(periods=500,tolf=1e-10,tolx=1e-10,maxit=100);

//shocks;
//var e_z = 1;
//end;

//stoch_simul(irf=1000,order=1);
//stoch_simul(drop=500,periods=10500,irf=0,order=1);

//subplot(3,3,1);rplot k

//shocks;
//var e_z = sigma_ez^2;
//end;

//stoch_simul(drop=500,periods=10500,irf=0);
