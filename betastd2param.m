function [a,b] = betastd2param(SD)

% function [a,b] = betastd2param(SD)
%
%   example call: [a,b] = betastd2param(SD)
%
% parameters of symmetric beta distribution from standard deviation
% 
% reference: https://en.wikipedia.org/wiki/beta_distribution
%
% IMPORTANT SPECIAL CASES
%   a=b=0.5 -> arcsin  dstb: var(B) = 1/8
%   a=b=1.0 -> uniform dstb: var(B) = 1/12
% 
% SD:    standard deviation
%%%%%%%%%%%%%%%%%
% a:     shape parameter #1
% b:     shape parameter #2

% INPUT HANDLING
for i = 1:length(SD)
if SD(i) <= 0
 error(['betastd2param: WARNING! invalid variance: SD=' num2str(SD(i)) '. Standard deviation must be greater than 0!!!']);
end
end

% BETA PARAMETERS FROM STANDARD DEVIATION
[a,b]=betavar2param(SD.^2);


