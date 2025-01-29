function [p,bDoubt] = genchi2cdf_davies(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel)

% function [p,bDoubt] = genchi2cdf_davies(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel)
%
%   example call: genchi2cdf_davies(1,0.5,0,1,1,0)
%
% cdf of generalized chi-squared distribution, a weighted sum of 
% non-central chi-squares, obtained via differntiation of the cdf
% using Davies' method from 1973 & 1980
%
% x:        point at which to evaluate cdf
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
%           (i.e. if eigenvalues of covariance matrix)
% nu:        degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale of normal term
% c:        constant term
% side:     'lower' -> compute from lower side
%           'upper' -> compute from upper side
% tolabs:   absolute error tolerance for cdf computation
% tolrel:   relative error tolerance for cdf computation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:        generalized chi-squared cumulative distribution function 
% bDoubt:   boolean indicating if output is too close to 0 or 1 
%           to doubt the computational result
%           1 -> doubt the result
%           0 -> don't

% INPUT HANDLING
if ~exist('side','var')   || isempty(side)   side   = 'lower'; end
if ~exist('tolabs','var') || isempty(tolabs) tolabs =   1e-10; end
if ~exist('tolrel','var') || isempty(tolrel) tolrel =    1e-6; end

if ~isempty(tolabs) && ~isempty(tolrel)
    % AREA UNDER CURVE (NUMERICAL)
    % (NOTE!!! arrayfun.m NECESSARY B/C integral.m REQUIRES SCALAR INPUT)
    area = arrayfun(@(x) integral(@(u) integrand(u,x-c,lambda(:),nu(:),delta(:),sigma),0,inf,'AbsTol',tolabs,'RelTol',tolrel), x);
else
    % SYMBOLIC VARIABLE
    syms u
    try
	% AREA UNDER CURVE (SYMBOLIC)
    % (NOTE!!! arrayfun.m NECESSARY B/C integral.m REQUIRES SCALAR INPUT)
    area = arrayfun(@(x) vpaintegral(@(u) integrand(u,x-c,lambda',nu',delta',sigma),u,0,inf,'AbsTol',tolabs,'RelTol',tolrel,'MaxFunctionCalls',inf), x);
    catch
    error(['genchi2cdf_davies: WARNING! vpaintegral.m and/or symbolic toolbox not on path? vpaintegral.m was introduced w. Matlab 2016b']);
    end
end

% COMPUTE PROBABILITY
if strcmpi(side,'lower')
    p = 0.5 - area./pi;
elseif strcmpi(side,'upper')
    p = 0.5 + area./pi;
end

% DOUBLE CHECK RESULTS
bDoubt = p<0 | p>1;
p = max(p,0);
p = min(p,1);

end

% INTEGRAND OF GENERALIZED CHI-SQUARED (reference Davies 1973 & 1980)
function f = integrand(u,x,lambda,nu,delta,sigma)

    % function f = integrand(u,x,lambda,nu,delta,sigma)
    %
    % u:      variable of integration
    % x:      chi2 values
    % lambda: quadratic coefficients        [ n x 1 ] NOTE! must be col vector
    % nu:     degrees of freedom            [ n x 1 ] NOTE! must be col vector
    % delta:  non-centrality parameters     [ n x 1 ] NOTE! must be col vector
    % sigma:  standard deviation
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % f:      result

    % INPUT HANDLING
    if isvector(lambda) lambda = lambda(:); else, error(['genchi2cdf_davies->integrand.m: lambda must be a vector']); end
    if isvector(nu)     nu     = nu(:);     else, error(['genchi2cdf_davies->integrand.m:   nu   must be a vector']); end
    if isvector(delta)  delta  = delta(:);  else, error(['genchi2cdf_davies->integrand.m:  delta must be a vector']); end
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % IDENTICAL TO IMHOF (1961) EQUATION 3.2 W. ADDITION OF sigma-DEPENDENT TERM %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    theta = sum( nu.*atan(lambda*u) + ( delta.*(lambda*u) )./( 1+(lambda.^2)*(u.^2) ) ,1 )/2 - u*x/2;                
    rho   = prod( ( (1+(lambda.^2)*(u.^2)).^(nu/4) ).*exp( ( (lambda.^2*u.^2).*delta)./( 2*( 1+(lambda.^2)*(u.^2) ) )),1) .* exp(u.^2*sigma^2/8);
    f     = sin(theta)./(u.*rho);

end