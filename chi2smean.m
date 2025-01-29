function [MU] = chi2smean(nu,S)

% function [MU] = chi2smean(nu,S)
%
%   example call: MU = chi2smean(1,3), mean( (sqrt(3).*randn(1000000,1)).^2 )          
%
% mean of scaled chi2 distribution from shape and scale parameters
% 
% NOTE! the scaled chi2 distribution is the distribution of a squared 
%       mean zero gaussian random variable with variance S where
%
%                chi2s = S.*chi2
%                chi2s = ( sqrt(S).*randn(100000,1) ).^2
%
% reference: https://en.wikipedia.org/wiki/?
% 
% nu:     shape parameter    (i.e. number of degrees of freedom)
% S:      scale parameter    (i.e. variance of Gaussian random 
%                             variable that was squared)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:     mean of scaled chi2 random variable
%
%          ***  see nxc2pdf.m, nxc2mean.m, nxc2var.m, etc.  ***
%          ***  see chi2pdf.m, chi2mean.m, chi2var.m, etc.  ***
%          ***  see chi2spdf.m, chi2smean.m, chi2svar.m, etc.  ***

% INPUT HANDLING
for i = 1:length(nu)
if nu(i) <= 0 || S(i) <= 0
 error(['chi2smean: WARNING! invalid parameters nu(' num2str(nu(i)) ')=' num2str(nu(i)) ',S(' num2str(S(i)) ')=' num2str(S(i)) '. Both must be greater than 0']);
end
end

% SCALED CHI2 MEAN
[MU] = S.*chi2mean(nu); 
