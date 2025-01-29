function MU = ncx2smean(nu,delta,S)

% function MU = ncx2smean(nu,delta,S)
%
%   example call: MU = ncx2smean(1,100,0.8), mean( 0.8.*(10 + randn(1000000,1)).^2 )
%
% mean of scaled non-central defined by nu = degrees of freedom and 
% non-centrality parameter delta = sum( mu.^2 ) where mu are the 
% non-zero means of the squared gaussian random variables, and scale 
% parameter S, where S is the variance of the underlying gaussian variables
% 
% NOTE! the non-central chi2 distribution is the distribution of a squared 
%           gaussian random variable with non-zero and unit variance
%
% ref: https://en.wikipedia.org/wiki/Noncentral_chi-squared_distribution         
% 
% nu:     shape parameter (i.e. degrees of freedom)
% delta:  non-centrality parameter (sum of squared means of Gauss RVs )
% S:      scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:     variance of non-central chi2 random variable
%
%          ***  see  ncx2pdf.m,  ncx2mean.m,  ncx2var.m, etc.  ***
%          ***  see   ***    ,  ncx2smean.m, ncx2svar.m, etc.  ***
%          ***  see  chi2pdf.m,  chi2mean.m,  chi2var.m, etc.  ***
%          ***  see chi2spdf.m, chi2smean.m, chi2svar.m, etc.  ***

% INPUT HANDLING
for i = 1:length(nu)
if nu(i) <= 0 || delta(i) <= 0
 error(['ncx2smean: WARNING! invalid parameters nu(' num2str(nu(i)) ')=' num2str(nu(i)) ',delta(' num2str(delta(i)) ')=' num2str(delta(i)) '. Both must be greater than 0']);
end
end

% SCALED NON-CENTRAL CHI2 MEAN
MU = (S.*nu + S.*delta);
