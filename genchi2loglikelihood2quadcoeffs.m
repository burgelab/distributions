function [Q2p,Q1p,Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2,COV1inv,COV2inv)

% function [Q2p Q1p Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2,COV1inv,COV2inv);
%
%   example call: R = rotMatrix(2,45); COV1 = diag([1 1/10]); COV2 = R*COV1*R';
%                 [Q2p,Q1p,Q0p] = genchi2loglikelihood2quadcoeffs([0 0],COV1,[0 0],COV2);
% 
% quadratic coefficients for computing log-likelihood or log-likelihood
% ratio for eventual purpose of computing generalized chi2 distribution 
% assuming p(X|Y1) and p(X|Y2) are multi-variate Gaussians
%
% for LL:  ln( p(X|Y1) ) 
% for LLR: ln( p(X|Y1)/p(X|Y2) ) = ln( p(X|Y1) ) - ln( p(X|Y2) )
%
% the generalized chi-squared can be equivalently represented as the 
%     quadratic sum of multi-variate Gaussian random variables 
%
%   genchi2  =  x'*Q2p*x + Q1p'*x + Q0p  =  z'*Q2*z + Q1'*z + Q0    
%
%       where Q2p, Q1p, Q0p are quad coeffs for    arbitrary    x
%         and Q2,  Q1,  Q0  are quad coeffs for standard normal x
%
%                              OR 
%
%  a weighted  sum of non-central chi-squares plus a Gaussian  
%
%      genchi2  =   lambda(:)'*y(:)  +  sigma.*z  +  c
%     
%        where y_i ~ chi2( nu_i, delta_i ) is non-central chi2
%       where nu_i is DOF, delta_i is non-centrality parameter,
%     z ~ N(0,1), sigma is standard deviation, and c is a constant
%
% NOTE! CODE CONVENTION IS THAT MUs ARE PASSED AS ROW, NOT COL VECTORS
% EXPRESSIONS MAY LOOK UNFAMILIAR BUT ARE IDENTICAL TO STANDARD FORMS
% UP TO A TRANSPOSE OPERATION
%
% MU1:      mean vector        of multivariate Gaussian 1  [ 1    x nDim ]
% COV1:     covariance  matrix of multivariate Gaussian 1  [ nDim x nDim ]
% MU2:      mean vector        of multivariate Gaussian 2  [ 1    x nDim ]
% COV2:     covariance  matrix of multivariate Gaussian 2  [ nDim x nDim ]
% COV1inv:  inverse cov matrix of multivariate Gaussian 1  [ nDim x nDim ]
% COV2inv:  inverse cov matrix of multivariate Gaussian 2  [ nDim x nDim ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q2p:      coefficients on squared terms                  [ nDim x nDim ]
% Q1p:      coefficients on linear  term                   [ 1    x nDim ]
% Q0p:      constant term                                  [    scalar   ]

% INPUT HANDLING
if ~exist('MU2', 'var')    || isempty(MU2)     MU2     = [];    end
if ~exist('COV2','var')    || isempty(COV2)    COV2    = [];    end

% INPUT CHECKING
if isscalar(MU1) MU1 = MU1.*ones(1,size(COV1,1)); end
if isscalar(MU2) MU2 = MU2.*ones(1,size(COV2,1)); end

% INVERSE COVARIANCE MATRICES
if ~exist('COV1inv','var') || isempty(COV1inv) 
    if     issparse(COV1) == 0, COV1inv = pinv(COV1); 
    elseif issparse(COV1) == 1, error(['genchi2loglikelihood2quadcoeff: WARNING! COV1inv must be entered explicitly because COV1 is sparse'])
    end
end
if ~exist('COV2inv','var') || isempty(COV2inv) 
    if     issparse(COV2) == 0, COV2inv = pinv(COV2); 
    elseif issparse(COV2) == 1, error(['genchi2loglikelihood2quadcoeff: WARNING! COV2inv must be entered explicitly because COV2 is sparse'])
    end
end

% NUMBER OF DIMENSIONS
nDim    = size(COV1,1);

% QUAD & LINEAR COEFFS PLUS CONSTANT
if isempty(MU2) || isempty(COV2)
    %%%%%%%%%%%%%%%%%%
    % LOG-LIKELIHOOD % 
    %%%%%%%%%%%%%%%%%%
    % INVERSE COVARIANCE MATRIX   (SEE ABOVE)
    % COV1inv = pinv(COV1);  
    % LOG NORMALIZING CONSTANT
    LZ1 = 0.5.*( logdet( 2.*pi.*COV1 ) ); % 
    % COEFFS ON SQUARED TERMS
    Q2p = -0.5.*(COV1inv);
    % COEFFS ON  LINEAR TERMS
    Q1p = COV1inv*MU1'; 
    % CONSTANT TERM                              
    Q0p = -0.5.*(MU1*COV1inv*MU1') - LZ1;
else
    %%%%%%%%%%%%%%%%%%%%%%%%
    % LOG-LIKELIHOOD RATIO % 
    %%%%%%%%%%%%%%%%%%%%%%%%
    % INVERSE COVARIANCE MATRICES (SEE ABOVE)
    % COV1inv = pinv(COV1);
    % COV2inv = pinv(COV2);
    % LOG OF NORMALIZING CONSTANTS FOR EACH PDF: GAUSS = (1/Z1)*exp( ... )
    LZ2 = 0.5.*( logdet( 2.*pi.*COV2 ) );
    LZ1 = 0.5.*( logdet( 2.*pi.*COV1 ) );
    % COEFFS ON SQUARED TERMS
    Q2p = 0.5.*(COV2inv - COV1inv);
    % COEFFS ON  LINEAR TERMS
    Q1p = (COV1inv*MU1' - COV2inv*MU2'); 
    % CONSTANT TERM                              
    Q0p = 0.5.*(MU2*COV2inv*MU2' - MU1*COV1inv*MU1') - LZ1 + LZ2 ;
end