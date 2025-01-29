function [a b] = gam2invgamparam(gamparam)

% function [a b] = gam2invgamparam(gamparam)
%
%   example call:
%
% converts parameters of gamma distribution to inverse gamma distribution
%
% gamparam:     shape and scale parameter of gamma distribution  [ N x 2 ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:            shape parameter of inverse gamma                 [ N x 1 ]
% b:            scale parameter of inverse gamma                 [ N x 1 ]
%
%         ***        see invgam2gamparam.m        ***

a = gamparam(:,1);
b = 1./gamparam(:,2);