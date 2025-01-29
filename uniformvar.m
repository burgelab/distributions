function VR = uniformvar(a,b)

% function VR = uniformvar(a,b)
%
%   example call: uniformvar(0,1);
%
% variance of uniform distribution with support between a and b
%
% a:     lower boundary
% b:     upper boundary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VR:    variance

% UNIFORM VARIANCE
VR = (1/12).*(b-a).^2;
