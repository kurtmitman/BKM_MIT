 %% Master file to replicate: "Exploiting MIT Shocks in Heterogeneous-Agent Economies: The Impulse Response as a Numerical Derivative"
%   by Boppart, Krusell and Mitman (2018) 

clear;
close all;
SaveDir=[pwd '/Results/'];
RepAgentDir=[pwd '/DynareCode/'];
CodeDir=pwd;


%% Representative Agent Economy
% Note, to execute this code requires Dynare to be installed on your
% computer
cd(RepAgentDir)
CompareNoExtZQ;
SimulateModelZQ;
cd(CodeDir)

%% Steady state computation


%Solve for the discount factor and labor disutility that clears the asset
%at the calibrated K/Y ratio and delivers average working time of 1/3

SteadyStateCalibrate;


%% Compute transition paths

Transition_SingleShocks;

SimulateHAModel

%% Make figures

FigsRAHA
