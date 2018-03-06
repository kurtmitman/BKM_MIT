function [residual, g1, g2, g3] = CalibLFNewNeg_dynamic(y, x, params, steady_state, it_)
%
% Status : Computes dynamic model for Dynare
%
% Inputs :
%   y         [#dynamic variables by 1] double    vector of endogenous variables in the order stored
%                                                 in M_.lead_lag_incidence; see the Manual
%   x         [nperiods by M_.exo_nbr] double     matrix of exogenous variables (in declaration order)
%                                                 for all simulation periods
%   steady_state  [M_.endo_nbr by 1] double       vector of steady state values
%   params    [M_.param_nbr by 1] double          vector of parameter values in declaration order
%   it_       scalar double                       time period for exogenous variables for which to evaluate the model
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the dynamic model equations in order of 
%                                          declaration of the equations.
%                                          Dynare may prepend auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by #dynamic variables] double    Jacobian matrix of the dynamic model equations;
%                                                           rows: equations in order of declaration
%                                                           columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g2        [M_.endo_nbr by (#dynamic variables)^2] double   Hessian matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%   g3        [M_.endo_nbr by (#dynamic variables)^3] double   Third order derivative matrix of the dynamic model equations;
%                                                              rows: equations in order of declaration
%                                                              columns: variables in order stored in M_.lead_lag_incidence followed by the ones in M_.exo_names
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

%
% Model equations
%

residual = zeros(15, 1);
T39 = params(2)*((1-params(3))*y(22)/y(17)+exp(y(19))/y(17))*exp(y(21));
T47 = exp(y(15))*exp(y(9))/(1-y(14));
T88 = exp(y(2))^params(1);
T91 = exp(y(16))^(1-params(1));
T107 = exp(y(2))^(params(1)-1);
T114 = exp(y(16))^(-params(1));
lhs =y(14);
rhs =params(7)*(y(11)-params(11));
residual(1)= lhs-rhs;
lhs =exp(y(15));
rhs =exp(y(7))^(-params(4));
residual(2)= lhs-rhs;
lhs =exp(y(15))/(1-y(14));
rhs =T39/(1-y(20));
residual(3)= lhs-rhs;
lhs =T47;
rhs =params(12)*exp(y(16))^(1/params(13));
residual(4)= lhs-rhs;
lhs =y(4);
rhs =params(8)*y(1)+params(9)*x(it_, 1);
residual(5)= lhs-rhs;
lhs =y(10);
rhs =exp(y(4));
residual(6)= lhs-rhs;
lhs =y(13);
rhs =1;
residual(7)= lhs-rhs;
lhs =y(5);
rhs =y(10)*y(13);
residual(8)= lhs-rhs;
lhs =y(18);
rhs =params(16)*y(3)+params(17)*x(it_, 2);
residual(9)= lhs-rhs;
lhs =y(17);
rhs =exp(y(18));
residual(10)= lhs-rhs;
lhs =exp(y(11));
rhs =y(5)*T88*T91;
residual(11)= lhs-rhs;
lhs =y(12);
rhs =(exp(y(11))-exp(y(7)))/y(17);
residual(12)= lhs-rhs;
lhs =exp(y(6));
rhs =y(12)+(1-params(3))*exp(y(2));
residual(13)= lhs-rhs;
lhs =exp(y(8));
rhs =T91*y(5)*params(1)*T107;
residual(14)= lhs-rhs;
lhs =exp(y(9));
rhs =T88*y(5)*(1-params(1))*T114;
residual(15)= lhs-rhs;
if nargout >= 2,
  g1 = zeros(15, 24);

  %
  % Jacobian matrix
  %

T128 = exp(y(2))*getPowerDeriv(exp(y(2)),params(1),1);
T171 = exp(y(16))*getPowerDeriv(exp(y(16)),1-params(1),1);
  g1(1,11)=(-params(7));
  g1(1,14)=1;
  g1(2,7)=(-(exp(y(7))*getPowerDeriv(exp(y(7)),(-params(4)),1)));
  g1(2,15)=exp(y(15));
  g1(3,19)=(-(exp(y(21))*params(2)*exp(y(19))/y(17)/(1-y(20))));
  g1(3,14)=exp(y(15))/((1-y(14))*(1-y(14)));
  g1(3,20)=(-(T39/((1-y(20))*(1-y(20)))));
  g1(3,15)=exp(y(15))/(1-y(14));
  g1(3,21)=(-(T39/(1-y(20))));
  g1(3,17)=(-(exp(y(21))*params(2)*((-((1-params(3))*y(22)))/(y(17)*y(17))+(-exp(y(19)))/(y(17)*y(17)))/(1-y(20))));
  g1(3,22)=(-(exp(y(21))*params(2)*(1-params(3))/y(17)/(1-y(20))));
  g1(4,9)=T47;
  g1(4,14)=exp(y(15))*exp(y(9))/((1-y(14))*(1-y(14)));
  g1(4,15)=T47;
  g1(4,16)=(-(params(12)*exp(y(16))*getPowerDeriv(exp(y(16)),1/params(13),1)));
  g1(5,1)=(-params(8));
  g1(5,4)=1;
  g1(5,23)=(-params(9));
  g1(6,4)=(-exp(y(4)));
  g1(6,10)=1;
  g1(7,13)=1;
  g1(8,5)=1;
  g1(8,10)=(-y(13));
  g1(8,13)=(-y(10));
  g1(9,3)=(-params(16));
  g1(9,18)=1;
  g1(9,24)=(-params(17));
  g1(10,17)=1;
  g1(10,18)=(-exp(y(18)));
  g1(11,5)=(-(T88*T91));
  g1(11,2)=(-(T91*y(5)*T128));
  g1(11,11)=exp(y(11));
  g1(11,16)=(-(y(5)*T88*T171));
  g1(12,7)=(-((-exp(y(7)))/y(17)));
  g1(12,11)=(-(exp(y(11))/y(17)));
  g1(12,12)=1;
  g1(12,17)=(-((-(exp(y(11))-exp(y(7))))/(y(17)*y(17))));
  g1(13,2)=(-((1-params(3))*exp(y(2))));
  g1(13,6)=exp(y(6));
  g1(13,12)=(-1);
  g1(14,5)=(-(T91*params(1)*T107));
  g1(14,2)=(-(T91*y(5)*params(1)*exp(y(2))*getPowerDeriv(exp(y(2)),params(1)-1,1)));
  g1(14,8)=exp(y(8));
  g1(14,16)=(-(y(5)*params(1)*T107*T171));
  g1(15,5)=(-(T114*T88*(1-params(1))));
  g1(15,2)=(-(T114*y(5)*(1-params(1))*T128));
  g1(15,9)=exp(y(9));
  g1(15,16)=(-(T88*y(5)*(1-params(1))*exp(y(16))*getPowerDeriv(exp(y(16)),(-params(1)),1)));

if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],15,576);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],15,13824);
end
end
end
end
