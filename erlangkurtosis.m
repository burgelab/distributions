function KR = erlangkurtosis(k,lambda)

% function KR = erlangkurtosis(k,lambda)
%
%   example call: erlangkurtosis(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% excess kurtosis of erlang distribution
% NOTE! excess kurtosis of gaussian is 0.0
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
%%%%%%%%%%%%%%%%%%%%
% SK:      skew

KR = 6./k;