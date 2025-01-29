function VR = erlangvar(k,lambda)

% function VR = erlangvar(k,lambda)
%
%   example call: erlangvar(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% variance of erlang distribution
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
%%%%%%%%%%%%%%%%%%%%
% VR:      variance

VR = k./(lambda.^2);