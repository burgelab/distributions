function KR = chikurtosis(nu)

% function KR = chikurtosis(nu)
%
%   example call: chikurtosis([1:10])
%
% excess kurtosis of the chi distribution
% NOTE! excess kurtosis of gaussian is 3.0
%
% nu:   degrees of freedom
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KR:   kurtosis

KR = 2.*(1 - chimean(nu).*chistd(nu).*chiskew(nu) - chivar(nu) )./chivar(nu);

