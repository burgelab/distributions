function [p,bDoubt,tolabs] = genchi2cdf(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel,N)

% function [p,bDoubt,tolabs] = genchi2cdf(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel,N)
%
%   example call: genchi2cdf(1,0.5,0,1,1,0)
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
% N:        number of terms in approximation
%           default -> 1000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:        generalized chi-squared cumulative distribution function 
% bDoubt:   boolean indicating if output is too close to 0 or 1 
%           to doubt the computational result
%           1 -> doubt the result
%           0 -> don't
% tolabs:   absolute tolerance

% INPUT HANDLING
if ~exist('side','var')   || isempty(side)   side   = 'lower'; end
if ~exist('tolabs','var') || isempty(tolabs) tolabs =   1e-10; end
if ~exist('tolrel','var') || isempty(tolrel) tolrel =    1e-6; end
if ~exist('N','var')      || isempty(N)      N      =    1000; end

if (sum(nu(:)) == 0 || isempty(nu)) && sigma ~= 0
    % DEGENERATE CASE: USE NORMAL CDF
    disp('genchi2pdf: using normcdf.m ...');
    p = normcdf(x,c,sigma);
elseif length(unique(lambda))==1 && sigma == 0
    % COMPUTE SCALED NON-CENTRAL CHI-SQUARED CDF
    p = ncxs2cdf(x-c,sum(nu),sum(delta),unique(lambda));
elseif (all(lambda>0)||all(lambda<0)) && sigma == 0
    try %%%%%%%%%%%%%%%%%%%%%
        % USE RUBEN  METHOD %
        %%%%%%%%%%%%%%%%%%%%%
        disp(['genchi2cdf: trying genchi2cdf_ruben.m method...']);
        [p,errbnd] = genchi2cdf_ruben(x,lambda,nu,delta,c,       side,tolabs,tolrel,N);
        disp(['            succeeded!']);
    catch %%%%%%%%%%%%%%%%%%%
        % USE DAVIES METHOD %
        %%%%%%%%%%%%%%%%%%%%%
        disp(['genchi2cdf: trying genchi2cdf_davies.m method...']);
        if sum(nu) <= 3 && sigma == 0
            % tolabs = 0.5e-5; tolrel = 0.5e-5;
            % disp(['genchi2cdf: WARNING! changing tolabs and tolsrel to ' num2str(tolabs,'%g') ' and ' num2str(tolrel,'%g') ]); 
        end
        [p,bDoubt] = genchi2cdf_davies(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel);
    end
else
    %%%%%%%%%%%%%%%%%%%
    % USE DAVIES METHOD %
    %%%%%%%%%%%%%%%%%%%%%
    disp(['genchi2cdf: using  genchi2cdf_davies.m method...']);
    if sum(nu) <= 3 && sigma == 0
        % tolabs = 0.5e-5; tolrel = 0.5e-5;
        % disp(['genchi2cdf: WARNING! changing tolabs and tolrel to ' num2str(tolabs,'%g') ' and ' num2str(tolrel,'%g') ]); 
    end
    [p,bDoubt] = genchi2cdf_davies(x,lambda,nu,delta,sigma,c,side,tolabs,tolrel);
end