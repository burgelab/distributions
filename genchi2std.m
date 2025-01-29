function SD = genchi2std(lambda,nu,delta,sigma,c)

% function SD = genchi2std(lambda,nu,delta,sigma,c)
%
%   example call:
%
% standard deviation of generalized chi-squared distribution
%
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale of normal term
% c:        constant offset term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SD:      variance


% STANDARD DEVIATION
SD = sqrt( genchi2var(lambda,nu,delta,sigma,c) );

