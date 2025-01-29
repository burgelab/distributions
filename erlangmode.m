function MD = erlangmode(k,lambda)

% function MD = erlangmode(k,lambda)
%
%   example call: erlangmode(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% mode of erlang distribution
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 

MD = (1./lambda).*(k-1);