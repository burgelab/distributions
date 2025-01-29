function gamparam = invgam2gamparam(a,b)

% function invgam2gamparam(gamparam)
%
%   example call:
%
% converts parameters of inverse gamma distribution to 
% parameters of the gamma distribution
%
% a:            shape parameter of inverse gamma                 [ N x 1 ]
% b:            scale parameter of inverse gamma                 [ N x 1 ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gamparam:     shape and scale parameter of gamma distribution  [ N x 2 ]
%
%         ***        see gam2invgamparam.m        ***

gamparam(:,1) = a;
gamparam(:,2) = 1./b;