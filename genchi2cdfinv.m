function X2 = genchi2cdfinv(P,lambda,nu,delta,sigma,c)

% function X2 = genchi2cdfinv(P,lambda,nu,delta,sigma,c)
%
%   example call:
%
% input cummulative probability and get back value of X2 via numerical methods 
%
% P:        cumulative probability
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale (i.e. standard deviation) of normal term
% c:        constant offset term
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X2:       value of chi2 random variable that yields specified cum prob

% GENCHI2 MEAN AND VARIANCE
[MU,VAR] = genchi2stat(lambda,nu,delta,sigma,c);

% SAMPLE VALUES
x2 = linspace(MU-4.*sqrt(VAR),MU+4.*sqrt(VAR),5001);
% SAMPLED CUMULATIVE PROBABIILITIES
p = genchi2cdf(x2,lambda,nu,delta,sigma,c);
% INVERSE CDF
X2 = interp1(p,x2,P);