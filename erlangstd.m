function SD = erlangstd(k,lambda)

% function SD = erlangstd(k,lambda)
%
%   example call: erlangstd(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% standard deviation of erlang distribution
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
%%%%%%%%%%%%%%%%%%%%
% SD:      standard deviation

SD = sqrt(erlangvar(k,lambda));