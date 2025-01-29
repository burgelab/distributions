function [p,errbnd]=genchi2cdf_ruben(x,lambda,nu,delta,c,side,tolabs,tolrel,N,bPLOT)
% 
% Returns the CDF of a generalized chi-squared (a weighted sum of
% non-central chi-squares with all weights the same sign), using Ruben's
% [1962] method.
%
%   example call: genchi2cdf_ruben(1,0.5,0,1,1,0)
%
% cdf of generalized chi-squared distribution, a weighted sum of 
% non-central chi-squares, obtained via differentiation of the cdf
% using Ruben's 1962 method. 
%
% NOTE! METHOD VALID ONLY WHEN ALL WEIGHTS (lambda) ARE OF THE SAME SIGN
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
% N:        number of terms in approximation
%           default -> 100
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:        generalized chi-squared  cdf
% errbnd    upper error bound of the cdf

% INPUT HANDLING
if ~exist('side','var')   || isempty(side)   side   = 'lower'; end
if ~exist('tolabs','var') || isempty(tolabs) tolabs =   1e-10; end
if ~exist('tolrel','var') || isempty(tolrel) tolrel =    1e-6; end
if ~exist('N','var')      || isempty(N)      N      =    100; end
if ~exist('bPLOT','var')  || isempty(bPLOT)  bPLOT  =      0; end

if ~all(lambda>0) && ~all(lambda<0) error(['genchi2df_ruben: WARNING! method only valid when all weights (lambda) are of the same sign: \lambda=[' num2str(lambda,'%.2f ') ']']); end
% addParameter(parser,'N',1e2,@(x) ismember(x,1:x));

% BETA PARAMETER
beta = 0.90625*min(lambda);
% TOTAL DEGREES OF FREEDOM
NU   = sum(nu);
% VECTOR OF TERM NUMBERS
n    = (1:N-1)';
% COMPUTE G TERM
g    = sum(nu.*(1-beta./lambda).^n,2) + beta*n.*((1-beta./lambda).^(n-1))*(delta./lambda)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE EXPANSION COEFFICIENTS %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
a=nan(N,1); % premalloc
a(1)=sqrt(exp(-sum(delta))*beta^NU*prod(lambda.^(-nu)));
for j=1:N-1
    a(j+1)=dot(flip(g(1:j)),a(1:j))/(2*j);
end
% CHECK FOR UNDERFLOW
if a(1)<realmin, error('Underflow error: some expansion coefficients are smaller than machine precision.'); end

% CENTRAL CHI-SQUARE INTEGRALS
[xg,mg]=meshgrid((x-c)/beta,NU:2:(NU+2*(N-1)));

%%%%%%%%%%%%%%%%%%%%%%%%
% COMPUTE THE INTEGRAL %
%%%%%%%%%%%%%%%%%%%%%%%%
F=arrayfun(@(x,nu) chi2cdf(x,nu),xg,mg);
p=a'*F;
if sign(lambda(1)) < 0
    p = 1 - p;
end
if strcmpi(side,'upper')
    p = 1 - p;
end

% TRUNCATION ERROR
errbnd=(1-sum(a))*chi2cdf((x-c)/beta,NU+2*N);

if bPLOT == 1
    figure;
    plot(x,p,'k','linewidth',2);
    formatFigure('X','Probability',['\lambda=[' num2str(lambda) '],\nu=[' num2str(nu) '],\delta=[' num2str(delta) '],\sigma=0,c=' num2str(c) ]); 
    axis square;
end