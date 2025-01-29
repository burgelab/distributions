function S = gamskewness(a,b)

% function S = gamskewness(a,b)
%
%   example call:% SKEWNESS OF GAMMA = CHI2 WITH df DEGREES OF FREEDOM
%                  gamskewness(df/2,2)
%                   
% skewness of gamma distribution
% 
% a: shape parameter
% b: scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S: skewness

S = 2/sqrt(a);