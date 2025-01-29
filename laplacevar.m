function V = laplacevar(b)

% function V = laplacevar(b)
%
%   example call: laplacevar(1);
%
% variance of laplace distribution from scale parameter (b)
%
% b:     scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V:     variance
%
%               *** see laplace*.m ***

% LAPLACE VARIANCE
V = 2.*b.^2;
