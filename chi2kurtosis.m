function chi2kurtosis(df)

% function chi2kurtosis(df)
%
%   example call: % KURTOSIS OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2kurtosis(1)
%
%                 % KURTOSIS OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2kurtosis(2)
%
% excess kurtosis of chi2 distribution
% NOTE! excess kurtosis of gaussian is 0.0
% 
% df:    degrees of freedom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KUR:  kurtosis,                   where        kurtosis of gaussian = 3.0
%       excess kurtosis equals K-3, where excess kurtosis of gaussian = 0.0

KUR = 12./df + 3;