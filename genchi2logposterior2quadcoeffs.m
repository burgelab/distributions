function [Q2p,Q1p,Q0p] = genchi2logposterior2quadcoeffs(MU1,COV1,MU2,COV2,PRIOR1,PRIOR2)

% function [Q2p Q1p Q0p] = genchi2logPost2quadCoeffs(MU1,COV1,MU2,COV2,PRIOR1,PRIOR2);
%
%   example call: R = rotMatrix(2,45); COV1 = diag([1 1/10]); COV2 = R*COV1*R';
%                 [Q2p,Q1p,Q0p] = genchi2logposterior2quadcoeffs([0 0],COV1,[0 0],COV2);
% 
% portion of quadratic coefficients for computing log-posterior odds for 
% classification from generalized chi2 distribution based on the 
% means, covariances, and priors of underlying Gaussian distributions
% 
%  ln(p(Y1|X)/p(Y2|X)) = ln( p(X|Y1) ) - ln( p(X|Y2) ) + ln(p(Y1)/p(Y2))
%        where p(X|Y1) and p(X|Y2) are multi-variate Gaussians
%
% the generalized chi-squared can be equivalently represented as the 
%   quadratic sum of multi-variate Gaussian random variables 
%                             OR 
%   weighted  sum of non-central chi-squares plus a Gaussian  
%     genchi2  =  x'*Q2p*x + Q1p'*x + Q0p  =  z'*Q2*z + Q1'*z + Q0
%         
%       where Q2p, Q1p, Q0p are quad coeffs for    arbitrary    x
%         and Q2,  Q1,  Q0  are quad coeffs for standard normal x
%
%                             OR 
% 
%     genchi2  =   lambda(:)'*y(:)  +  sigma.*z  +  c
%     
%       y_i ~ chi2( nu_i, delta_i ) 
%       where nu_i is DOF and delta_i is non-centrality parameter
%       z   ~ normrnd(0,1) 
%       where sigma is a scale parameter
%
% MU1:      mean vector of       multivariate Gaussian 1   [ 1    x nDim ]
% COV1:     covariance matrix of multivariate Gaussian 1   [ nDim x nDim ]
% MU2:      mean vector of       multivariate Gaussian 2   [ 1    x nDim ]
% COV2:     covariance matrix of multivariate Gaussian 2   [ nDim x nDim ]
% PRIOR1:   prior probability of multivariate Gaussian 1
% PRIOR2:   prior probability of multivariate Gaussian 2
%           (redundant with PRIOR1 b/c PRIOR2 = 1-PRIOR1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Q2p:      coefficients on squared terms                  [ nDim x nDim ]
% Q1p:      coefficients on linear  term                   [ 1    x nDim ]
% Q0p:      constant term                                  [    scalar   ]

% INPUT HANDLING
if ~exist('PRIOR1','var') || isempty(PRIOR1) bPRIOR1 = 0; else bPRIOR1 = 1; end
if ~exist('PRIOR2','var') || isempty(PRIOR2) bPRIOR2 = 0; else bPRIOR2 = 1; end

if     bPRIOR1 == 0 && bPRIOR2 == 0 
    PRIOR1 = 0.5; PRIOR2 = 0.5; 
elseif bPRIOR1 == 1 && bPRIOR2 == 0 
    PRIOR2 = 1 - PRIOR1; 
elseif bPRIOR1 == 0 && bPRIOR2 == 1 
    PRIOR1 = 1 - PRIOR2; 
elseif bPRIOR1 == 1 && bPRIOR2 == 1 
    if   PRIOR2 == (1-PRIOR1) % DO NOTHING... EVERYTHING IS COOL
    else error(['genchi2logposterior2quadcoeffs: WARNING! priors must sum to equal 1.0... PRIOR1+PRIOR2=' num2str(PRIOR1+PRIOR2) ]);
    end
end

% NUMBER OF DIMENSIONS
nDim    = size(COV1,1);

% INVERSE COVARIANCE MATRICES
COV1inv = pinv(COV1);
COV2inv = pinv(COV2);

% LOG OF NORMALIZING CONSTANTS FOR EACH PDF: GAUSS = (1/Z1)*exp( ... )
LZ1 = 0.5.*( logdet( COV1 ) ) + 0.5.*nDim.*log(2.*pi);
LZ2 = 0.5.*( logdet( COV2 ) ) + 0.5.*nDim.*log(2.*pi);

% LOG OF PRIOR PROBABILITIES
LP1 = log(PRIOR1);
LP2 = log(PRIOR2);

% COEFFS ON SQUARED TERMS
Q2p = 0.5.*(COV2inv - COV1inv);
% COEFFS ON  LINEAR TERMS
Q1p = (MU1*COV1inv - MU2*COV2inv);
% CONSTANT TERM                              
Q0p = 0.5.*(MU2*MU2' - MU1*MU1') - LZ1 + LZ2 + LP1 - LP2;