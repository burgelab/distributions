function [MU,VR,SK,KR]=laplacestat(mu,b)

% function [MU,VR,SK,KR]=laplacestat(mu,b)
%
%   example call: [MU,VR,SK,KR]=laplacestat(5,1);
%
% moments-based statistics of laplace distribution
%
% mu:   mean
% b:    scale parameter
%%%%%%%%%%%%%%%%%%%%%%%
% MU:   mean
% VR:   variance
% SK:   skewness
% KR:   kurtosis


% MEAN
MU = mu;

% VARIANCE
VR = laplacevar(b);

% SKEWNESS
SK = 0;

% KURTOSIS
KR = laplacekurtosis();