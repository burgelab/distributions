function MD = chi2mode(nu)

% function MD = chi2mode(nu)
%
%   example call: chi2mode([1:10])
%
% mode of (central) chi2 distribution
%
% nu:   degrees of freedom
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MD:   mode

MD = max(nu-2,0);
