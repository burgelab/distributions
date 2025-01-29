function SD = uniformstd(a,b)

% function SD = uniformstd(a,b)
%
%   example call: SD = uniformstd(0,1);
%
% standard deviation of uniform distribution with support between a and b
%
% a:     lower boundary
% b:     upper boundary
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SD:    standard deviation

% VARIANCE
VR = uniformvar(a,b);

% STANDARD VARIANCE
SD = sqrt(VR);

