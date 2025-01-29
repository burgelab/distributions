function [VAR] = ncx2var(nu,L)

% function [VAR] = ncx2var(nu,L)
%
%   example call: [VAR] = ncx2var(1,100^2)
%
% mean of non-central defined by nu = degrees of freedom and 
% non-centrality parameter L = sum( mu.^2 ) where mu are the 
% non-zero means of the squared gaussian random variables
% 
% NOTE! the non-central chi2 distribution is the distribution of a squared 
%           gaussian random variable with non-zero and unit variance
%
% ref: https://en.wikipedia.org/wiki/Noncentral_chi-squared_distribution         
% 
% nu:     shape parameter (i.e. degrees of freedom)
% L:      non-centrality parameter (sum of squared means of Gauss RVs )
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VAR:        variance of non-central chi2 random variable
%
%          ***  see  ncx2pdf.m,  ncx2mean.m,  ncx2var.m, etc.  ***
%          ***  see  chi2pdf.m,  chi2mean.m,  chi2var.m, etc.  ***
%          ***  see chi2spdf.m, chi2smean.m, chi2svar.m, etc.  ***

% INPUT HANDLING
for i = 1:length(nu)
if nu(i) <= 0 || L(i) <= 0
 error(['ncx2var: WARNING! invalid parameters nu(' num2str(nu(i)) ')=' num2str(nu(i)) ',SD(' num2str(SD(i)) ')=' num2str(SD(i)) '. Both must be greater than 0']);
end
end

 
% NON-CENTRAL CHI2 VARIANCE
% VAR = 2.*(nu + 2.*L)

% NON-CENTRAL CHI2 VARIANCE
[~,VAR] = ncx2stat(nu,L); 
