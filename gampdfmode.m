function MD = gampdfmode(a,b)

% function MD = gampdfmode(alpha,beta)
%
%   example call: MD = gampdfmode(a,b)
%
% returns mode (i.e. peak) of gampdf
%
% a:   shape parameter
% b:   scale parameter
%%%%%%%%%%%%%%%%%%%%
% MD:  mode

MD = (a-1).*b;