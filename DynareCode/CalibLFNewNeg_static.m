function [residual, g1, g2, g3] = CalibLFNewNeg_static(y, x, params)
%
% Status : Computes static model for Dynare
%
% Inputs : 
%   y         [M_.endo_nbr by 1] double    vector of endogenous variables in declaration order
%   x         [M_.exo_nbr by 1] double     vector of exogenous variables in declaration order
%   params    [M_.param_nbr by 1] double   vector of parameter values in declaration order
%
% Outputs:
%   residual  [M_.endo_nbr by 1] double    vector of residuals of the static model equations 
%                                          in order of declaration of the equations.
%                                          Dynare may prepend or append auxiliary equations, see M_.aux_vars
%   g1        [M_.endo_nbr by M_.endo_nbr] double    Jacobian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g2        [M_.endo_nbr by (M_.endo_nbr)^2] double   Hessian matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%   g3        [M_.endo_nbr by (M_.endo_nbr)^3] double   Third derivatives matrix of the static model equations;
%                                                       columns: variables in declaration order
%                                                       rows: equations in order of declaration
%
%
% Warning : this file is generated automatically by Dynare
%           from model file (.mod)

residual = zeros( 15, 1);

%
% Model equations
%

T36 = exp(y(12))*params(2)*((1-params(3))*y(14)/y(14)+exp(y(5))/y(14));
T42 = exp(y(12))*exp(y(6))/(1-y(11));
T81 = exp(y(3))^params(1);
T84 = exp(y(13))^(1-params(1));
T96 = exp(y(3))^(params(1)-1);
T103 = exp(y(13))^(-params(1));
lhs =y(11);
rhs =params(7)*(y(8)-params(11));
residual(1)= lhs-rhs;
lhs =exp(y(12));
rhs =exp(y(4))^(-params(4));
residual(2)= lhs-rhs;
lhs =exp(y(12))/(1-y(11));
rhs =T36/(1-y(11));
residual(3)= lhs-rhs;
lhs =T42;
rhs =params(12)*exp(y(13))^(1/params(13));
residual(4)= lhs-rhs;
lhs =y(1);
rhs =y(1)*params(8)+params(9)*x(1);
residual(5)= lhs-rhs;
lhs =y(7);
rhs =exp(y(1));
residual(6)= lhs-rhs;
lhs =y(10);
rhs =1;
residual(7)= lhs-rhs;
lhs =y(2);
rhs =y(7)*y(10);
residual(8)= lhs-rhs;
lhs =y(15);
rhs =y(15)*params(16)+params(17)*x(2);
residual(9)= lhs-rhs;
lhs =y(14);
rhs =exp(y(15));
residual(10)= lhs-rhs;
lhs =exp(y(8));
rhs =y(2)*T81*T84;
residual(11)= lhs-rhs;
lhs =y(9);
rhs =(exp(y(8))-exp(y(4)))/y(14);
residual(12)= lhs-rhs;
lhs =exp(y(3));
rhs =y(9)+(1-params(3))*exp(y(3));
residual(13)= lhs-rhs;
lhs =exp(y(5));
rhs =T84*y(2)*params(1)*T96;
residual(14)= lhs-rhs;
lhs =exp(y(6));
rhs =T81*y(2)*(1-params(1))*T103;
residual(15)= lhs-rhs;
if ~isreal(residual)
  residual = real(residual)+imag(residual).^2;
end
if nargout >= 2,
  g1 = zeros(15, 15);

  %
  % Jacobian matrix
  %

T117 = exp(y(3))*getPowerDeriv(exp(y(3)),params(1),1);
T159 = exp(y(13))*getPowerDeriv(exp(y(13)),1-params(1),1);
  g1(1,8)=(-params(7));
  g1(1,11)=1;
  g1(2,4)=(-(exp(y(4))*getPowerDeriv(exp(y(4)),(-params(4)),1)));
  g1(2,12)=exp(y(12));
  g1(3,5)=(-(exp(y(12))*params(2)*exp(y(5))/y(14)/(1-y(11))));
  g1(3,11)=exp(y(12))/((1-y(11))*(1-y(11)))-T36/((1-y(11))*(1-y(11)));
  g1(3,12)=exp(y(12))/(1-y(11))-T36/(1-y(11));
  g1(3,14)=(-(exp(y(12))*params(2)*(-exp(y(5)))/(y(14)*y(14))/(1-y(11))));
  g1(4,6)=T42;
  g1(4,11)=exp(y(12))*exp(y(6))/((1-y(11))*(1-y(11)));
  g1(4,12)=T42;
  g1(4,13)=(-(params(12)*exp(y(13))*getPowerDeriv(exp(y(13)),1/params(13),1)));
  g1(5,1)=1-params(8);
  g1(6,1)=(-exp(y(1)));
  g1(6,7)=1;
  g1(7,10)=1;
  g1(8,2)=1;
  g1(8,7)=(-y(10));
  g1(8,10)=(-y(7));
  g1(9,15)=1-params(16);
  g1(10,14)=1;
  g1(10,15)=(-exp(y(15)));
  g1(11,2)=(-(T81*T84));
  g1(11,3)=(-(T84*y(2)*T117));
  g1(11,8)=exp(y(8));
  g1(11,13)=(-(y(2)*T81*T159));
  g1(12,4)=(-((-exp(y(4)))/y(14)));
  g1(12,8)=(-(exp(y(8))/y(14)));
  g1(12,9)=1;
  g1(12,14)=(-((-(exp(y(8))-exp(y(4))))/(y(14)*y(14))));
  g1(13,3)=exp(y(3))-(1-params(3))*exp(y(3));
  g1(13,9)=(-1);
  g1(14,2)=(-(T84*params(1)*T96));
  g1(14,3)=(-(T84*y(2)*params(1)*exp(y(3))*getPowerDeriv(exp(y(3)),params(1)-1,1)));
  g1(14,5)=exp(y(5));
  g1(14,13)=(-(y(2)*params(1)*T96*T159));
  g1(15,2)=(-(T103*T81*(1-params(1))));
  g1(15,3)=(-(T103*y(2)*(1-params(1))*T117));
  g1(15,6)=exp(y(6));
  g1(15,13)=(-(T81*y(2)*(1-params(1))*exp(y(13))*getPowerDeriv(exp(y(13)),(-params(1)),1)));
  if ~isreal(g1)
    g1 = real(g1)+2*imag(g1);
  end
if nargout >= 3,
  %
  % Hessian matrix
  %

  g2 = sparse([],[],[],15,225);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],15,3375);
end
end
end
end
