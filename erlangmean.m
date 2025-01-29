function MU = erlangmean(k,lambda)

% function MU = erlangmean(k,lambda)
%
%   example call: erlangmean(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% mean of erlang distribution
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
%%%%%%%%%%%%%%%%%%%%%%%%
% MU:      mean

MU = k./lambda;