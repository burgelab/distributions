function SK = erlangskew(k,lambda)

% function SK = erlangskew(k,lambda)
%
%   example call: erlangskew(2,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% skew of erlang distribution
%
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
%%%%%%%%%%%%%%%%%%%%
% SK:      skew

SK = 2./sqrt(k);