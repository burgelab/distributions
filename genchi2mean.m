function MU = genchi2mean(lambda,nu,delta,sigma,c)

% function MU = genchi2mean(lambda,nu,delta,sigma,c)
%
%   example call:
%
% mean of generalized chi-squared distribution
%
%     genchi2 = lambda(:)'*y(:) + sigma.*z + c
%     
%     y_i ~ chi2( nu_i, delta_i ) 
%     where nu_i is DOF and delta_i is non-centrality parameter
%
%     z   ~ normrnd(0,1) 
%     where sigma is a scale parameter
%              
%
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma:    standard deviation of gaussian component
% c:        constant offset term
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:       mean

MU = dot( lambda, nu+delta ) + c;