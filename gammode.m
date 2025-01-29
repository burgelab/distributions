function MD = gammode(a,b)

% function MD = gammode(alpha,beta)
%
%   example call: MD = gammode(a,b)
%
% returns mode (i.e. peak) of gampdf
%
% a:   shape parameter
% b:   scale parameter
%%%%%%%%%%%%%%%%%%%%
% MD:  mode

MD = (a-1).*b;