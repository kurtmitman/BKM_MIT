function [residual, g1, g2, g3] = SimulLFNew_dynamic(y, x, params, steady_state, it_)
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
T24 = exp(y(15))/(1-y(14));
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
lhs =T24;
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
rhs =params(14)*y(3)+params(15)*x(it_, 2);
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
T134 = exp(y(2))*getPowerDeriv(exp(y(2)),params(1)-1,1);
T142 = exp(y(7))*getPowerDeriv(exp(y(7)),(-params(4)),1);
T150 = (-(exp(y(21))*params(2)*exp(y(19))/y(17)/(1-y(20))));
T160 = exp(y(15))*exp(y(9))/((1-y(14))*(1-y(14)));
T167 = exp(y(16))*getPowerDeriv(exp(y(16)),1/params(13),1);
T171 = exp(y(16))*getPowerDeriv(exp(y(16)),1-params(1),1);
T177 = exp(y(16))*getPowerDeriv(exp(y(16)),(-params(1)),1);
T187 = exp(y(21))*params(2)*((-((1-params(3))*y(22)))/(y(17)*y(17))+(-exp(y(19)))/(y(17)*y(17)));
T197 = (-(exp(y(21))*params(2)*(1-params(3))/y(17)/(1-y(20))));
  g1(1,11)=(-params(7));
  g1(1,14)=1;
  g1(2,7)=(-T142);
  g1(2,15)=exp(y(15));
  g1(3,19)=T150;
  g1(3,14)=exp(y(15))/((1-y(14))*(1-y(14)));
  g1(3,20)=(-(T39/((1-y(20))*(1-y(20)))));
  g1(3,15)=T24;
  g1(3,21)=(-(T39/(1-y(20))));
  g1(3,17)=(-(T187/(1-y(20))));
  g1(3,22)=T197;
  g1(4,9)=T47;
  g1(4,14)=T160;
  g1(4,15)=T47;
  g1(4,16)=(-(params(12)*T167));
  g1(5,1)=(-params(8));
  g1(5,4)=1;
  g1(5,23)=(-params(9));
  g1(6,4)=(-exp(y(4)));
  g1(6,10)=1;
  g1(7,13)=1;
  g1(8,5)=1;
  g1(8,10)=(-y(13));
  g1(8,13)=(-y(10));
  g1(9,3)=(-params(14));
  g1(9,18)=1;
  g1(9,24)=(-params(15));
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
  g1(14,2)=(-(T91*y(5)*params(1)*T134));
  g1(14,8)=exp(y(8));
  g1(14,16)=(-(y(5)*params(1)*T107*T171));
  g1(15,5)=(-(T114*T88*(1-params(1))));
  g1(15,2)=(-(T114*y(5)*(1-params(1))*T128));
  g1(15,9)=exp(y(9));
  g1(15,16)=(-(T88*y(5)*(1-params(1))*T177));

if nargout >= 3,
  %
  % Hessian matrix
  %

  v2 = zeros(78,3);
T265 = T128+exp(y(2))*exp(y(2))*getPowerDeriv(exp(y(2)),params(1),2);
T276 = T171+exp(y(16))*exp(y(16))*getPowerDeriv(exp(y(16)),1-params(1),2);
  v2(1,1)=2;
  v2(1,2)=151;
  v2(1,3)=(-(T142+exp(y(7))*exp(y(7))*getPowerDeriv(exp(y(7)),(-params(4)),2)));
  v2(2,1)=2;
  v2(2,2)=351;
  v2(2,3)=exp(y(15));
  v2(3,1)=3;
  v2(3,2)=451;
  v2(3,3)=T150;
  v2(4,1)=3;
  v2(4,2)=326;
  v2(4,3)=(-(exp(y(15))*((-(1-y(14)))-(1-y(14)))))/((1-y(14))*(1-y(14))*(1-y(14))*(1-y(14)));
  v2(5,1)=3;
  v2(5,2)=475;
  v2(5,3)=(-(exp(y(21))*params(2)*exp(y(19))/y(17)/((1-y(20))*(1-y(20)))));
  v2(6,1)=3;
  v2(6,2)=452;
  v2(6,3)=  v2(5,3);
  v2(7,1)=3;
  v2(7,2)=476;
  v2(7,3)=(-((-(T39*((-(1-y(20)))-(1-y(20)))))/((1-y(20))*(1-y(20))*(1-y(20))*(1-y(20)))));
  v2(8,1)=3;
  v2(8,2)=350;
  v2(8,3)=exp(y(15))/((1-y(14))*(1-y(14)));
  v2(9,1)=3;
  v2(9,2)=327;
  v2(9,3)=  v2(8,3);
  v2(10,1)=3;
  v2(10,2)=351;
  v2(10,3)=T24;
  v2(11,1)=3;
  v2(11,2)=499;
  v2(11,3)=T150;
  v2(12,1)=3;
  v2(12,2)=453;
  v2(12,3)=  v2(11,3);
  v2(13,1)=3;
  v2(13,2)=500;
  v2(13,3)=(-(T39/((1-y(20))*(1-y(20)))));
  v2(14,1)=3;
  v2(14,2)=477;
  v2(14,3)=  v2(13,3);
  v2(15,1)=3;
  v2(15,2)=501;
  v2(15,3)=(-(T39/(1-y(20))));
  v2(16,1)=3;
  v2(16,2)=403;
  v2(16,3)=(-(exp(y(21))*params(2)*(-exp(y(19)))/(y(17)*y(17))/(1-y(20))));
  v2(17,1)=3;
  v2(17,2)=449;
  v2(17,3)=  v2(16,3);
  v2(18,1)=3;
  v2(18,2)=404;
  v2(18,3)=(-(T187/((1-y(20))*(1-y(20)))));
  v2(19,1)=3;
  v2(19,2)=473;
  v2(19,3)=  v2(18,3);
  v2(20,1)=3;
  v2(20,2)=405;
  v2(20,3)=(-(T187/(1-y(20))));
  v2(21,1)=3;
  v2(21,2)=497;
  v2(21,3)=  v2(20,3);
  v2(22,1)=3;
  v2(22,2)=401;
  v2(22,3)=(-(exp(y(21))*params(2)*((-((-((1-params(3))*y(22)))*(y(17)+y(17))))/(y(17)*y(17)*y(17)*y(17))+(-((-exp(y(19)))*(y(17)+y(17))))/(y(17)*y(17)*y(17)*y(17)))/(1-y(20))));
  v2(23,1)=3;
  v2(23,2)=524;
  v2(23,3)=(-(exp(y(21))*params(2)*(1-params(3))/y(17)/((1-y(20))*(1-y(20)))));
  v2(24,1)=3;
  v2(24,2)=478;
  v2(24,3)=  v2(23,3);
  v2(25,1)=3;
  v2(25,2)=525;
  v2(25,3)=T197;
  v2(26,1)=3;
  v2(26,2)=502;
  v2(26,3)=  v2(25,3);
  v2(27,1)=3;
  v2(27,2)=521;
  v2(27,3)=(-(exp(y(21))*params(2)*(-(1-params(3)))/(y(17)*y(17))/(1-y(20))));
  v2(28,1)=3;
  v2(28,2)=406;
  v2(28,3)=  v2(27,3);
  v2(29,1)=4;
  v2(29,2)=201;
  v2(29,3)=T47;
  v2(30,1)=4;
  v2(30,2)=321;
  v2(30,3)=T160;
  v2(31,1)=4;
  v2(31,2)=206;
  v2(31,3)=  v2(30,3);
  v2(32,1)=4;
  v2(32,2)=326;
  v2(32,3)=(-(exp(y(15))*exp(y(9))*((-(1-y(14)))-(1-y(14)))))/((1-y(14))*(1-y(14))*(1-y(14))*(1-y(14)));
  v2(33,1)=4;
  v2(33,2)=345;
  v2(33,3)=T47;
  v2(34,1)=4;
  v2(34,2)=207;
  v2(34,3)=  v2(33,3);
  v2(35,1)=4;
  v2(35,2)=350;
  v2(35,3)=T160;
  v2(36,1)=4;
  v2(36,2)=327;
  v2(36,3)=  v2(35,3);
  v2(37,1)=4;
  v2(37,2)=351;
  v2(37,3)=T47;
  v2(38,1)=4;
  v2(38,2)=376;
  v2(38,3)=(-(params(12)*(T167+exp(y(16))*exp(y(16))*getPowerDeriv(exp(y(16)),1/params(13),2))));
  v2(39,1)=6;
  v2(39,2)=76;
  v2(39,3)=(-exp(y(4)));
  v2(40,1)=8;
  v2(40,2)=298;
  v2(40,3)=(-1);
  v2(41,1)=8;
  v2(41,2)=229;
  v2(41,3)=  v2(40,3);
  v2(42,1)=10;
  v2(42,2)=426;
  v2(42,3)=(-exp(y(18)));
  v2(43,1)=11;
  v2(43,2)=29;
  v2(43,3)=(-(T91*T128));
  v2(44,1)=11;
  v2(44,2)=98;
  v2(44,3)=  v2(43,3);
  v2(45,1)=11;
  v2(45,2)=26;
  v2(45,3)=(-(T91*y(5)*T265));
  v2(46,1)=11;
  v2(46,2)=251;
  v2(46,3)=exp(y(11));
  v2(47,1)=11;
  v2(47,2)=365;
  v2(47,3)=(-(T88*T171));
  v2(48,1)=11;
  v2(48,2)=112;
  v2(48,3)=  v2(47,3);
  v2(49,1)=11;
  v2(49,2)=362;
  v2(49,3)=(-(y(5)*T128*T171));
  v2(50,1)=11;
  v2(50,2)=40;
  v2(50,3)=  v2(49,3);
  v2(51,1)=11;
  v2(51,2)=376;
  v2(51,3)=(-(y(5)*T88*T276));
  v2(52,1)=12;
  v2(52,2)=151;
  v2(52,3)=(-((-exp(y(7)))/y(17)));
  v2(53,1)=12;
  v2(53,2)=251;
  v2(53,3)=(-(exp(y(11))/y(17)));
  v2(54,1)=12;
  v2(54,2)=391;
  v2(54,3)=(-(exp(y(7))/(y(17)*y(17))));
  v2(55,1)=12;
  v2(55,2)=161;
  v2(55,3)=  v2(54,3);
  v2(56,1)=12;
  v2(56,2)=395;
  v2(56,3)=(-((-exp(y(11)))/(y(17)*y(17))));
  v2(57,1)=12;
  v2(57,2)=257;
  v2(57,3)=  v2(56,3);
  v2(58,1)=12;
  v2(58,2)=401;
  v2(58,3)=(-((-((-(exp(y(11))-exp(y(7))))*(y(17)+y(17))))/(y(17)*y(17)*y(17)*y(17))));
  v2(59,1)=13;
  v2(59,2)=26;
  v2(59,3)=(-((1-params(3))*exp(y(2))));
  v2(60,1)=13;
  v2(60,2)=126;
  v2(60,3)=exp(y(6));
  v2(61,1)=14;
  v2(61,2)=29;
  v2(61,3)=(-(T91*params(1)*T134));
  v2(62,1)=14;
  v2(62,2)=98;
  v2(62,3)=  v2(61,3);
  v2(63,1)=14;
  v2(63,2)=26;
  v2(63,3)=(-(T91*y(5)*params(1)*(T134+exp(y(2))*exp(y(2))*getPowerDeriv(exp(y(2)),params(1)-1,2))));
  v2(64,1)=14;
  v2(64,2)=176;
  v2(64,3)=exp(y(8));
  v2(65,1)=14;
  v2(65,2)=365;
  v2(65,3)=(-(params(1)*T107*T171));
  v2(66,1)=14;
  v2(66,2)=112;
  v2(66,3)=  v2(65,3);
  v2(67,1)=14;
  v2(67,2)=362;
  v2(67,3)=(-(y(5)*params(1)*T134*T171));
  v2(68,1)=14;
  v2(68,2)=40;
  v2(68,3)=  v2(67,3);
  v2(69,1)=14;
  v2(69,2)=376;
  v2(69,3)=(-(y(5)*params(1)*T107*T276));
  v2(70,1)=15;
  v2(70,2)=29;
  v2(70,3)=(-(T114*(1-params(1))*T128));
  v2(71,1)=15;
  v2(71,2)=98;
  v2(71,3)=  v2(70,3);
  v2(72,1)=15;
  v2(72,2)=26;
  v2(72,3)=(-(T114*y(5)*(1-params(1))*T265));
  v2(73,1)=15;
  v2(73,2)=201;
  v2(73,3)=exp(y(9));
  v2(74,1)=15;
  v2(74,2)=365;
  v2(74,3)=(-(T88*(1-params(1))*T177));
  v2(75,1)=15;
  v2(75,2)=112;
  v2(75,3)=  v2(74,3);
  v2(76,1)=15;
  v2(76,2)=362;
  v2(76,3)=(-(y(5)*(1-params(1))*T128*T177));
  v2(77,1)=15;
  v2(77,2)=40;
  v2(77,3)=  v2(76,3);
  v2(78,1)=15;
  v2(78,2)=376;
  v2(78,3)=(-(T88*y(5)*(1-params(1))*(T177+exp(y(16))*exp(y(16))*getPowerDeriv(exp(y(16)),(-params(1)),2))));
  g2 = sparse(v2(:,1),v2(:,2),v2(:,3),15,576);
if nargout >= 4,
  %
  % Third order derivatives
  %

  g3 = sparse([],[],[],15,13824);
end
end
end
end
