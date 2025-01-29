function [MU,VAR] = genchi2stat(lambda,nu,delta,sigma,c)

% function VAR = genchi2stat(lambda,nu,delta,sigma,c)
%
%   example call:
%
% mean and variance of generalized chi-squared distribution
%
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale of normal term                            [  scalar  ]
% c:        constant offset term                            [  scalar  ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:       mean
% VAR:      variance

MU  = genchi2mean(lambda,nu,delta,sigma,c);
VAR = genchi2var( lambda,nu,delta,sigma,c);
