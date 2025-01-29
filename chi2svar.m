function [VAR] = chi2svar(nu,S)

% function [VAR] = chi2svar(nu,S)
%
%   example call: [VAR] = chi2svar(1,3); var( (sqrt(3).*randn(1000000,1)).^2 )
%
% variance of scaled chi2 distribution from shape and scale parameters
% 
% NOTE! the scaled chi2 distribution is the distribution of a squared 
%       mean zero gaussian random variable with variance S where
%
%                chi2s = S.*chi2
%                chi2s = ( sqrt(S).*randn(100000,1) ).^2
% 
% reference: https://en.wikipedia.org/wiki/?
% 
% nu:    shape parameter... (i.e. number of degrees of freedom)
% S:     scale parameter    (i.e. variance of Gaussian random 
%                             variable that was squared)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VAR:    variance of scaled chi2 random variable

% INPUT HANDLING
for i = 1:length(nu)
if nu(i) <= 0 || S(i) <= 0
 error(['chi2svar: WARNING! invalid parameters nu(' num2str(nu(i)) ')=' num2str(nu(i)) ',S(' num2str(S(i)) ')=' num2str(S(i)) '. Both must be greater than 0']);
end
end

% VARIANCE OF SCALED CHI2
VAR = (S.^2).*chi2var(nu);
