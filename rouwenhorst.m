function [Z,PI] = rouwenhorst(N,mu,rho,sigma)
% Code to approximate AR(1) process using the Rouwenhorst method as in 
% Kopecky & Suen, Review of Economic Dynamics (2010), Vol 13, p 701-714
%
%Purpose:    Finds a Markov chain whose sample paths approximate those of
%            the AR(1) process
%                z(t+1) = (1-rho)*mu + rho * z(t) + eps(t+1)
%            where eps are normal with stddev sigma
%
%Format:     [Z, PI] = rouwenhorst(N,mu,rho,sigma)
%
%Input:      N       scalar, number of nodes for Z
%            mu      scalar, unconditional mean of process
%            rho     scalar
%            sigma   scalar, std. dev. of epsilons
%
%Output:     Z       N*1 vector, nodes for Z
%            PI      N*N matrix, transition probabilities
%
% Code and comment by Martin Floden, Stockholm University, August 2010
%
% Comment on this method:
% As opposed to the methods suggested by Tauchen and Tauchen and Hussey 
% (see M. Floden, Economic Letters, 2008, 99, 516-520), the Rouwenhorst
% method perfectly matches both the conditional and unconditional variances
% and autocorrelations of the AR(1) process. The method however tends to 
% generate errors eps that are further away from the normal distribution
% than the Tauchen methods (the kurtosis of the simulated eps is too high
% with the Rouwenhorst method).

sigmaz = sigma / sqrt(1-rho^2);

p  = (1+rho)/2;
PI = [p 1-p; 1-p p];

for n = 3:N
    PI = p*[PI zeros(n-1,1); zeros(1,n)] + ...
         (1-p)*[zeros(n-1,1) PI; zeros(1,n)] + ...
         (1-p)*[zeros(1,n); PI zeros(n-1,1)] + ...
         p*[zeros(1,n); zeros(n-1,1) PI];
    PI(2:end-1,:) = PI(2:end-1,:)/2;
end

fi = sqrt(N-1)*sigmaz;
Z  = linspace(-fi,fi,N)';
Z  = Z + mu;

