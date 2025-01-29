function [a,b] = betavar2param(VAR)

% function [a,b] = betavar2param(VAR)
%
%   example call: [a,b] = betavar2param(VAR)
%
% parameters of symmetric beta distribution from variance
% 
% reference: https://en.wikipedia.org/wiki/beta_distribution
%
% IMPORTANT SPECIAL CASES
%   a=b=0.5 -> arcsin  dstb: var(B) = 1/8
%   a=b=1.0 -> uniform dstb: var(B) = 1/12
% 
% VAR:   variance
%%%%%%%%%%%%%%%%%
% a:     shape parameter #1
% b:     shape parameter #2


% INPUT HANDLING
for i = 1:length(VAR)
if VAR(i) <= 0
 error(['betavar2param: WARNING! invalid variance: VAR=' num2str(VAR(i)) '. Variance must be greater than 0!!!']);
end
end

% BETA VARIANCE (FOR SYMMETRIC DISTRIBUTION a=b)
% VAR = 1./(8.*a+4);

% BETA PARAMETERS FROM VARIANCE
a = (1./VAR - 4)./8;
b = a;



