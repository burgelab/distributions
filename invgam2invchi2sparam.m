function [nu,SD] = invgam2invchi2sparam(a,b)

% function [nu,SD] = invgam2invchi2sparam(a,b)
%
%   example call:
%
% converts parameters of inverse gamma distribution to 
% parameters of a scaled inverse chi2 distribution
%
% relationships to other distributions
%  X ~ invgampdf(x,a,1/2)   ->        inverse chi2 pdf: X ~ invchi2( 2a)
%  X ~ invgampdf(x,a/2,1/2) -> scaled inverse chi2 pdf: X ~ sinvchi2(a,1/a)
%  X ~ invgampdf(x,1/2,c/2) -> Levy distribution      : X ~ L(0,c)
%
% a:            shape parameter of inverse gamma                 [ N x 1 ]
% b:            scale parameter of inverse gamma                 [ N x 1 ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% gamparam:     shape and scale parameter of gamma distribution  [ N x 2 ]
%
%         ***        see invchi2sinvgamparam.m        ***

% INVERSE GAMMA TO GAMMA
nu = 2.*a;
SD = sqrt(2/b);

error(['invgam2invchi2sparam: WARNING! untested function. Do not use']);