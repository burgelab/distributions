function [lambda,nu,delta,sigma,c] = genchi2mvnpdf2params(MU,COV,MU1,COV1,MU2,COV2,COVinv,COV1inv,COV2inv,blkSz)

% function [lambda,nu,delta,sigma,c] = genchi2mvnpdf2params(MU,COV,MU1,COV1,MU2,COV2,COVinv,COV1inv,COV2inv,blkSz)
%
%   example call: R = rotMatrix(2,45); COV1 = diag([1 1/10]); COV2 = R*COV1*R';
%                 [Q2p,Q1p,Q0p]  = genchi2loglikelihood2quadcoeffs([0 0],COV1,[0 0],COV2)
%                 [lambda,nu,delta,sigma,c] = genchi2mvnpdf2params([0 0],COV1,[0 0],COV1)
%
% the quadratic form of a multivariate normal random variable is 
% distributed as a generalized chi-squared distribution... this function 
% takes the normal parameters and the coeffs of the quadratic combination
% and returns the parameters of the generalized chi-squared distribution
%
% web resources: + https://math.stackexchange.com/questions/442472/sum-of-squares-of-dependent-gaussian-random-variables/442916#442916
%                + https://stats.stackexchange.com/questions/338989/generalized-chi-squared-distribution-pdf
%
% MU:       mean vector        of mvn random variable      [ 1 x nDim ]
% COV:      covariance matrix  of mvn random variable      [ nDim x nDim ]
% MU1:      mean vector        of multivariate Gaussian 1  [ 1    x nDim ]
% COV1:     covariance  matrix of multivariate Gaussian 1  [ nDim x nDim ]
% MU2:      mean vector        of multivariate Gaussian 2  [ 1    x nDim ]
% COV2:     covariance  matrix of mvn random variable      [ nDim x nDim ]
% COVinv:   inverse cov matrix of multivariate Gaussian 1  [ nDim x nDim ]
% COV1inv:  inverse cov matrix of multivariate Gaussian 1  [ nDim x nDim ]
% COV2inv:  inverse cov matrix of multivariate Gaussian 2  [ nDim x nDim ]
% blkSz:    block size to be entered as a scalar           [    scalar   ]
%           (e.g. 6 -> [6 x 6] block)
%           NOTE! blkSz input required for sparse block diagonal inputs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lambda:   coefficients of non                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                -central chi-squares           [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares     [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares)   [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale (i.e. standard deviation) of normal term    [  scalar  ]
% c:        constant offset term                              [  scalar  ]
%
%  *** see genchi2pdf.m, genchi2cdf.m, genchi2mean.m, genchi2var.m  ***
%  ***  genchi2mvnpdf2params.m, genchi2loglikelihood2quadcoeffs.m   *** 
%                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       d                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
%  *** NOTE! PLEASE UPDATE CALLS IN CODE TO genchi2mvnpdf2params.m  ***
%  ***       mvnpdf2genchi2params DOES THE IDENTICAL COMPUTATIONS

% INPUT HANDLING
if ~exist('MU2', 'var') || isempty(MU2)  MU2  = []; end
if ~exist('COV2','var') || isempty(COV2) COV2 = []; end

% INPUT CHECKING
if isscalar(MU)  MU  =  MU.*ones(1,size(COV, 1)); end
if isscalar(MU1) MU1 = MU1.*ones(1,size(COV1,1)); end
if isscalar(MU2) MU2 = MU2.*ones(1,size(COV2,1)); end

% INVERSE COVARIANCE MATRICES
if ~exist('COVinv','var') || isempty(COVinv) 
    if     issparse(COV) == 0, COVinv = pinv(COV); 
    elseif issparse(COV) == 1, error(['genchi2mvnpdf2params: WARNING! COVinv must be entered explicitly because COV is sparse'])
    end
end
if ~exist('COV1inv','var') || isempty(COV1inv) 
    if     issparse(COV1) == 0, COV1inv = pinv(COV1); 
    elseif issparse(COV1) == 1, error(['genchi2mvnpdf2params: WARNING! COV1inv must be entered explicitly because COV1 is sparse'])
    end
end
if ~exist('COV2inv','var') || isempty(COV2inv) 
    if     issparse(COV2) == 0, COV2inv = pinv(COV2); 
    elseif issparse(COV2) == 1, error(['genchi2mvnpdf2params: WARNING! COV2inv must be entered explicitly because COV2 is sparse'])
    end
end

% QUADRATIC COEFFICIENTS
[Q2p,Q1p,Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2,COV1inv,COV2inv);

% INVERSE COVARIANCE MATRIX
% COVinv = pinv(COV); (SEE INPUT HANDLING)

% COMBINE MVN COEFFS W. HAND INPUT COEFFS
if ~issparse(COV)
    % MATRIX SQUAREROOT
    S  = sqrtm(COV);
    % QUADRATIC PARAMETERS ON STANDARD NORMAL VECTOR
    Q2 = S*Q2p*S;     % Q2p =  0.5.*(COV2inv - COV1inv);
    Q1 = S*(2*Q2p*MU' + Q1p);  % Q1p = (COV1inv*MU1' - COV2inv*MU2)'; 
    Q0 = MU*Q2p*MU' + Q1p'*MU' + Q0p;   % Q0p =  0.5.*(MU2*COV2inv*MU2' - MU1*COV1inv*MU1') - LZ1 + LZ2 

    % EIGENVECTORS (P) AND EIGENVALUES (D) %
    % EASY TO READ; SENSITIVE TO SLIGHT ASSYMETRIES 
    % [P,D] = eig(Q2);
    % HARD TO READ;   ROBUST  TO SLIGHT ASSYMETRIES 
    [P,D]  = eig(0.5*(Q2+Q2'));
elseif issparse(COV)
    % MATRIX SQUAREROOT
    S  = sqrtmsparse(COV,blkSz);
    % QUADRATIC PARAMETERS ON STANDARD NORMAL VECTOR
    Q2 = S*Q2p*S;                       % Q2p =  0.5.*(COV2inv - COV1inv);
    Q1 = S*(2*Q2p*MU' + Q1p);           % Q1p = (COV1inv*MU1' - COV2inv*MU2)'; 
    Q0 = MU*Q2p*MU' + Q1p'*MU' + Q0p;   % Q0p =  0.5.*(MU2*COV2inv*MU2' - MU1*COV1inv*MU1') - LZ1 + LZ2 

    % EIGENVECTORS (P) AND EIGENVALUES (D) %
    % EASY TO READ; SENSITIVE TO SLIGHT ASSYMETRIES 
    % [P,D] = eig(Q2);
    % HARD TO READ;   ROBUST  TO SLIGHT ASSYMETRIES 
    [P,D]  = eigsparse(0.5*(Q2+Q2'),blkSz);
end

% EIGENVALUES (IF NONZERO: SCALE PARAM ON EACH SQUARED NON-CENTRAL CHI2)
lambda = full(diag(D)');
% [lambda,~,ic] = unique(nonzeros(d)'); 

% GOOD & BAD INDCES
indGd =  lambda~=0;
indBd = ~lambda;

% DOF FOR EACH EIGENVALUE CHI2 (i.e. 1)
nu    = double(indGd);

% MEAN OF UNDERLYING GAUSSIAN RANDOM VARIABLE OBTAINED BY COMPLETING SQUARE 
% b   = (0.5.*pinv(D)*(P'*Q1) )';    % VALID *ONLY* FOR DIMS WHERE D IS NON-ZERO  
b     =  0.5.*lsqminnorm(D,P'*Q1 )'; % SEE 'TIPS' IN DOCUMENTATION >> doc pinv FOR EXPLANATION OF WHY lsqminnorm(A,v) CAN REPLACE pinv(A)*v

% NON-CENTRALITY FOR EACH (NON-ZERO) EIGENVALUE
delta = b.^2; 

% GAUSSIAN STANDARD DEVIATION FOR DIMENSIONS W. LAMBDA = 0
if sum(indBd) > 0 
    % REDEFINE b FOR DIMS WITHOUT A QUADRATIC TERM (i.e. WHERE lambda = 0)
    b=(P'*Q1)'; 
    % DEFINE STANDARD DEVIATION OF GAUSSIAN CONTRIBUTION
    sigma  = sqrt(sum(b(indBd).^2));
    delta  = delta( indGd);
    nu     = nu(    indGd);
    lambda = lambda(indGd);
else
    sigma = 0;
end

% CONSTANT VALUE
c = Q0-sum(lambda.*delta);
