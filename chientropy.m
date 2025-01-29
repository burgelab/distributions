function KR = chientropy(nu)

% function KR = chientropy(nu)
%
%   example call: chientropy([1:10])
%
% entropy of the chi distribution ( if X ~ chi2, sqrt(X) ~ chi )
%
% nu:   degrees of freedom
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S:   entropy

S = log( gamma(nu/2) ) + 0.5.*(nu - log(2) - (k-1).*psi(k/2));

