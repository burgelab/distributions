function [MU,VR,SK,KR]=invgamstat(a,b)

% function [MU,VR,SK,KR]=invgamstat(a,b)
%
%   example call: [MU,VR,SK,KR]=invgamstat(5,1);
%
% moments-based statistics of inverse gamma distribution
%
% a:    shape parameter
% b:    scale parameter
%%%%%%%%%%%%%%%%%%%%%%%
% MU:   mean
% VR:   variance
% SK:   skewness
% KR:   kurtosis

% MEAN
MU = invgammean(a,b);

% VARIANCE
VR = invgamvar(a,b);

% SKEWNESS
SK = invgamskewness(a,b);

% KURTOSIS
KR = invgamkurtosis(a,b);