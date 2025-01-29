function chi2skewness(df)

% function chi2skewness(df)
%
%   example call: % SKEWNESS OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2skewness(1)
%
%                 % SKEWNESS OF CHI2 DISTRIBUTION WITH 1 DEGREE OF FREEDOM
%                   chi2skewness(2)
%
% skewness of a chi2 distribution
%
% df:   degrees of freedom
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SKW:  skewness 

SKW = sqrt(8./df);