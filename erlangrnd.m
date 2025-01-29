function [X,Xindi] = erlangrnd(nSmp,k,lambda)

% function [X,Xindi] = erlangrnd(nSmp,k,lambda)
%
%    example call:  [X,Xindi] = erlangrnd(1000000,3,2); 
%                   M=[mean(X) erlangmean(3,2)], V=[var(X) erlangvar(3,2)], S=[skewness(X) erlangskew(3,2)], K=[kurtosis(X)-3 erlangkurtosis(3,2)],
%
% random samples from generalized erlang random variable where such RVs are given
% by the sum of two or more i.i.d. exponentially distributed random variables
% 
%                           X ~ erlang(k,lambda)
%                                 where
%                         X = X1 + X2 + ... + Xk
%                               and where 
%                    X1,X2,...Xk ~ exppdf(1./lambda)
% 
% nSmp:    number of samples
% k:       shape (i.e. number of i.i.d. RVs that are being summed)   scalar >= 2
%          PDF AND CDF HAVE UNKNOWN FORMS FOR MORE THAN TWO RVs
% lambda:  rate                                                     scalar OR [1 x k]
%          (i.e. rate or time constant or inverse scale of each exp RV: lambda = 1/mu) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:     generalized erlang random samples [nSmp x 1]
% Xindi: individual random samples         [nSmp x k]


if ~exist('k','var') || isempty(k) k = length(lambda); end
if length(unique(lambda)) ~= 1, error(['erlangrnd: WARNING! erlang random variables are sum of k >= 2 i.i.d. expoential random variables']); end
if k < 2,                       error(['erlangrnd: WARNING! erlang random variables are sum of k >= 2 i.i.d. expoential random variables. k == ' num2str(k)]); end

% RANDOM VARIABLES
Xindi = zeros(nSmp,length(lambda));
for i = 1:k
    Xindi(:,i) = exprnd(1./lambda(1),nSmp,1);
end

% ERLANG RV
X = sum(Xindi,2);