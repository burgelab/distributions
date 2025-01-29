function V = chi2var(nu)

% function V = chi2var(nu)
%
%   example call: % VARIANCE OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2var(1)
%
%                 % VARIANCE OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2var(2)
%
% variance of chi2 distribution
% 
% nu:   degrees of freedom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V:    variance 

V = 2.*nu;