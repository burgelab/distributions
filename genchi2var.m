function VAR = genchi2var(lambda,nu,delta,sigma,c)

% function VAR = genchi2var(lambda,nu,delta,sigma,c)
%
%   example call: [lambda nu delta sigma K] = mvnpdf2genchi2params(MU,COV,MU,COV);
%
% variance of generalized chi-squared distribution
%
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale of normal term
% c:        constant offset term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VAR:      variance

VAR = 2*sum( (lambda.^2).*(nu + 2*delta) ) + sigma^2;
