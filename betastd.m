function [SD] = betastd(a,b)

% function [SD] = betastd(a,b)
%
%   example call: [SD] = betastd(a,b)
%
% variance of beta distribution from shape parameters a and b
% 
% reference: https://en.wikipedia.org/wiki/gamma_distribution
% 
% a:     shape parameter #1
% b:     shape parameter #2
%%%%%%%%%%%%%%%%%
% SD:    standard deviation

% VARIANCE
VAR = betavar(a,b);

% STANDARD DEVIATION
SD = sqrt(VAR);
