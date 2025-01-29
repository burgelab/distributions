function K = gamkurtosis(a,b)

% function K = gamkurtosis(a,b)
%
%   example call: % KURTOSIS OF GAMMA = CHI2 WITH df DEGREES OF FREEDOM
%                   gamkurtosis(df/2,2)
%
% excess kurtosis of gamma distribution
% NOTE! excess kurtosis of gaussian is 0.0
% 
% a:    shape parameter
% b:    scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K:    kurtosis of gamma pdf,      where        kurtosis of gaussian = 3.0
%       excess kurtosis equals K-3, where excess kurtosis of gaussian = 0.0
%    

% EXCESS KURTOSIS OF GAMMA
K = 6/a;    