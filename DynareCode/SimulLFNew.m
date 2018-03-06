%
% Status : main Dynare file
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

if isoctave || matlab_ver_less_than('8.6')
    clear all
else
    clearvars -global
    clear_persistent_variables(fileparts(which('dynare')), false)
end
tic0 = tic;
% Save empty dates and dseries objects in memory.
dates('initialize');
dseries('initialize');
% Define global variables.
global M_ options_ oo_ estim_params_ bayestopt_ dataset_ dataset_info estimation_info ys0_ ex0_
options_ = [];
M_.fname = 'SimulLFNew';
M_.dynare_version = '4.5.1';
oo_.dynare_version = '4.5.1';
options_.dynare_version = '4.5.1';
%
% Some global variables initialization
%
global_initialization;
diary off;
diary('SimulLFNew.log');
M_.exo_names = 'e_z';
M_.exo_names_tex = 'e\_z';
M_.exo_names_long = 'e_z';
M_.exo_names = char(M_.exo_names, 'e_q');
M_.exo_names_tex = char(M_.exo_names_tex, 'e\_q');
M_.exo_names_long = char(M_.exo_names_long, 'e_q');
M_.endo_names = 'log_z';
M_.endo_names_tex = 'log\_z';
M_.endo_names_long = 'log_z';
M_.endo_names = char(M_.endo_names, 'a');
M_.endo_names_tex = char(M_.endo_names_tex, 'a');
M_.endo_names_long = char(M_.endo_names_long, 'a');
M_.endo_names = char(M_.endo_names, 'k');
M_.endo_names_tex = char(M_.endo_names_tex, 'k');
M_.endo_names_long = char(M_.endo_names_long, 'k');
M_.endo_names = char(M_.endo_names, 'c');
M_.endo_names_tex = char(M_.endo_names_tex, 'c');
M_.endo_names_long = char(M_.endo_names_long, 'c');
M_.endo_names = char(M_.endo_names, 'r');
M_.endo_names_tex = char(M_.endo_names_tex, 'r');
M_.endo_names_long = char(M_.endo_names_long, 'r');
M_.endo_names = char(M_.endo_names, 'w');
M_.endo_names_tex = char(M_.endo_names_tex, 'w');
M_.endo_names_long = char(M_.endo_names_long, 'w');
M_.endo_names = char(M_.endo_names, 'z');
M_.endo_names_tex = char(M_.endo_names_tex, 'z');
M_.endo_names_long = char(M_.endo_names_long, 'z');
M_.endo_names = char(M_.endo_names, 'y');
M_.endo_names_tex = char(M_.endo_names_tex, 'y');
M_.endo_names_long = char(M_.endo_names_long, 'y');
M_.endo_names = char(M_.endo_names, 'inv');
M_.endo_names_tex = char(M_.endo_names_tex, 'inv');
M_.endo_names_long = char(M_.endo_names_long, 'inv');
M_.endo_names = char(M_.endo_names, 'phi');
M_.endo_names_tex = char(M_.endo_names_tex, 'phi');
M_.endo_names_long = char(M_.endo_names_long, 'phi');
M_.endo_names = char(M_.endo_names, 's');
M_.endo_names_tex = char(M_.endo_names_tex, 's');
M_.endo_names_long = char(M_.endo_names_long, 's');
M_.endo_names = char(M_.endo_names, 'u_c');
M_.endo_names_tex = char(M_.endo_names_tex, 'u\_c');
M_.endo_names_long = char(M_.endo_names_long, 'u_c');
M_.endo_names = char(M_.endo_names, 'h');
M_.endo_names_tex = char(M_.endo_names_tex, 'h');
M_.endo_names_long = char(M_.endo_names_long, 'h');
M_.endo_names = char(M_.endo_names, 'q');
M_.endo_names_tex = char(M_.endo_names_tex, 'q');
M_.endo_names_long = char(M_.endo_names_long, 'q');
M_.endo_names = char(M_.endo_names, 'log_q');
M_.endo_names_tex = char(M_.endo_names_tex, 'log\_q');
M_.endo_names_long = char(M_.endo_names_long, 'log_q');
M_.endo_partitions = struct();
M_.param_names = 'alpha_k';
M_.param_names_tex = 'alpha\_k';
M_.param_names_long = 'alpha_k';
M_.param_names = char(M_.param_names, 'beta_c');
M_.param_names_tex = char(M_.param_names_tex, 'beta\_c');
M_.param_names_long = char(M_.param_names_long, 'beta_c');
M_.param_names = char(M_.param_names, 'delta_k');
M_.param_names_tex = char(M_.param_names_tex, 'delta\_k');
M_.param_names_long = char(M_.param_names_long, 'delta_k');
M_.param_names = char(M_.param_names, 'sigma_c');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_c');
M_.param_names_long = char(M_.param_names_long, 'sigma_c');
M_.param_names = char(M_.param_names, 'kappa_c');
M_.param_names_tex = char(M_.param_names_tex, 'kappa\_c');
M_.param_names_long = char(M_.param_names_long, 'kappa_c');
M_.param_names = char(M_.param_names, 'psi_c');
M_.param_names_tex = char(M_.param_names_tex, 'psi\_c');
M_.param_names_long = char(M_.param_names_long, 'psi_c');
M_.param_names = char(M_.param_names, 'gamma_g');
M_.param_names_tex = char(M_.param_names_tex, 'gamma\_g');
M_.param_names_long = char(M_.param_names_long, 'gamma_g');
M_.param_names = char(M_.param_names, 'rho_z');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_z');
M_.param_names_long = char(M_.param_names_long, 'rho_z');
M_.param_names = char(M_.param_names, 'sigma_ez');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_ez');
M_.param_names_long = char(M_.param_names_long, 'sigma_ez');
M_.param_names = char(M_.param_names, 'phi_lev');
M_.param_names_tex = char(M_.param_names_tex, 'phi\_lev');
M_.param_names_long = char(M_.param_names_long, 'phi_lev');
M_.param_names = char(M_.param_names, 'y_steady');
M_.param_names_tex = char(M_.param_names_tex, 'y\_steady');
M_.param_names_long = char(M_.param_names_long, 'y_steady');
M_.param_names = char(M_.param_names, 'lab_disutil');
M_.param_names_tex = char(M_.param_names_tex, 'lab\_disutil');
M_.param_names_long = char(M_.param_names_long, 'lab_disutil');
M_.param_names = char(M_.param_names, 'frisch');
M_.param_names_tex = char(M_.param_names_tex, 'frisch');
M_.param_names_long = char(M_.param_names_long, 'frisch');
M_.param_names = char(M_.param_names, 'rho_q');
M_.param_names_tex = char(M_.param_names_tex, 'rho\_q');
M_.param_names_long = char(M_.param_names_long, 'rho_q');
M_.param_names = char(M_.param_names, 'sigma_q');
M_.param_names_tex = char(M_.param_names_tex, 'sigma\_q');
M_.param_names_long = char(M_.param_names_long, 'sigma_q');
M_.param_partitions = struct();
M_.exo_det_nbr = 0;
M_.exo_nbr = 2;
M_.endo_nbr = 15;
M_.param_nbr = 15;
M_.orig_endo_nbr = 15;
M_.aux_vars = [];
M_.Sigma_e = zeros(2, 2);
M_.Correlation_matrix = eye(2, 2);
M_.H = 0;
M_.Correlation_matrix_ME = 1;
M_.sigma_e_is_diagonal = 1;
M_.det_shocks = [];
options_.block=0;
options_.bytecode=0;
options_.use_dll=0;
M_.hessian_eq_zero = 0;
erase_compiled_function('SimulLFNew_static');
erase_compiled_function('SimulLFNew_dynamic');
M_.orig_eq_nbr = 15;
M_.eq_nbr = 15;
M_.ramsey_eq_nbr = 0;
M_.lead_lag_incidence = [
 1 4 0;
 0 5 0;
 2 6 0;
 0 7 0;
 0 8 19;
 0 9 0;
 0 10 0;
 0 11 0;
 0 12 0;
 0 13 0;
 0 14 20;
 0 15 21;
 0 16 0;
 0 17 22;
 3 18 0;]';
M_.nstatic = 8;
M_.nfwrd   = 4;
M_.npred   = 3;
M_.nboth   = 0;
M_.nsfwrd   = 4;
M_.nspred   = 3;
M_.ndynamic   = 7;
M_.equations_tags = {
};
M_.static_and_dynamic_models_differ = 0;
M_.exo_names_orig_ord = [1:2];
M_.maximum_lag = 1;
M_.maximum_lead = 1;
M_.maximum_endo_lag = 1;
M_.maximum_endo_lead = 1;
oo_.steady_state = zeros(15, 1);
M_.maximum_exo_lag = 0;
M_.maximum_exo_lead = 0;
oo_.exo_steady_state = zeros(2, 1);
M_.params = NaN(15, 1);
M_.NNZDerivatives = [48; 78; -1];
M_.params( 8 ) = zpers;
rho_z = M_.params( 8 );
M_.params( 9 ) = zvar;
sigma_ez = M_.params( 9 );
M_.params( 14 ) = qpers;
rho_q = M_.params( 14 );
M_.params( 15 ) = qvar;
sigma_q = M_.params( 15 );
M_.params( 4 ) = sigma_val;
sigma_c = M_.params( 4 );
M_.params( 2 ) = 0.99;
beta_c = M_.params( 2 );
M_.params( 1 ) = alpha_val;
alpha_k = M_.params( 1 );
M_.params( 3 ) = delta_val;
delta_k = M_.params( 3 );
M_.params( 12 ) = labval;
lab_disutil = M_.params( 12 );
M_.params( 13 ) = frischval;
frisch = M_.params( 13 );
M_.params( 6 ) = psi_val;
psi_c = M_.params( 6 );
M_.params( 5 ) = kappa_val;
kappa_c = M_.params( 5 );
M_.params( 10 ) = 1/(exp(c_steady)+M_.params(5))^M_.params(6);
phi_lev = M_.params( 10 );
M_.params( 11 ) = yss;
y_steady = M_.params( 11 );
M_.params( 7 ) = sub_val;
gamma_g = M_.params( 7 );
%
% INITVAL instructions
%
options_.initval_file = 0;
oo_.steady_state( 3 ) = kss;
oo_.steady_state( 8 ) = yss;
oo_.steady_state( 5 ) = rss;
oo_.steady_state( 6 ) = wss;
oo_.steady_state( 4 ) = css;
oo_.steady_state( 13 ) = hss;
oo_.steady_state( 12 ) = u_css;
oo_.steady_state( 9 ) = invss;
oo_.steady_state( 2 ) = 1;
oo_.steady_state( 11 ) = 0;
oo_.steady_state( 10 ) = 1;
oo_.steady_state( 7 ) = 1;
oo_.steady_state( 1 ) = 0;
oo_.steady_state( 14 ) = 1;
if M_.exo_nbr > 0
	oo_.exo_simul = ones(M_.maximum_lag,1)*oo_.exo_steady_state';
end
if M_.exo_det_nbr > 0
	oo_.exo_det_simul = ones(M_.maximum_lag,1)*oo_.exo_det_steady_state';
end
steady;
options_.qz_zero_threshold = 1e-25;
oo_.dr.eigval = check(M_,options_,oo_);
%
% SHOCKS instructions
%
M_.exo_det_length = 0;
M_.Sigma_e(1, 1) = 1;
M_.Sigma_e(2, 2) = 1;
set_dynare_seed('default')
options_.drop = 500;
options_.irf = 0;
options_.order = 1;
options_.periods = 10500;
var_list_ = char();
info = stoch_simul(var_list_);
cons_linear = c;
linear_corr=corr(oo_.endo_simul([1 15 8 4 13 9 5 6],501:end)');
dlmwrite('RACorr_Lin.txt',linear_corr,'delimiter','&','precision','%10.3f');
zshocks = [zeros(approxlength,1); oo_.exo_simul(:,1)];
qshocks = [zeros(approxlength,1); oo_.exo_simul(:,2)];
set_dynare_seed('reset')
options_.drop = 500;
options_.irf = 0;
options_.order = 2;
options_.periods = 10500;
var_list_ = char();
info = stoch_simul(var_list_);
cons_quad = c;
quad_corr=corr(oo_.endo_simul([1 15 8 4 13 9 5 6],501:end)');
dlmwrite('RACorr_Quad.txt',quad_corr,'delimiter','&','precision','%10.3f');
zshocks2 = [zeros(approxlength,1); oo_.exo_simul(:,1)];
qshocks2 = [zeros(approxlength,1); oo_.exo_simul(:,2)];
zzt=oo_.endo_simul(1,:);
qqt=oo_.endo_simul(15,:);
save shock_inputs zshocks qshocks zzt qqt;
save('SimulLFNew_results.mat', 'oo_', 'M_', 'options_');
if exist('estim_params_', 'var') == 1
  save('SimulLFNew_results.mat', 'estim_params_', '-append');
end
if exist('bayestopt_', 'var') == 1
  save('SimulLFNew_results.mat', 'bayestopt_', '-append');
end
if exist('dataset_', 'var') == 1
  save('SimulLFNew_results.mat', 'dataset_', '-append');
end
if exist('estimation_info', 'var') == 1
  save('SimulLFNew_results.mat', 'estimation_info', '-append');
end
if exist('dataset_info', 'var') == 1
  save('SimulLFNew_results.mat', 'dataset_info', '-append');
end
if exist('oo_recursive_', 'var') == 1
  save('SimulLFNew_results.mat', 'oo_recursive_', '-append');
end


disp(['Total computing time : ' dynsec2hms(toc(tic0)) ]);
if ~isempty(lastwarn)
  disp('Note: warning(s) encountered in MATLAB/Octave code')
end
diary off
