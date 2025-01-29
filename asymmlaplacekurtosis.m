function KUR = asymmlaplacekurtosis(m,b1,b2)

% function KUR = asymmlaplacekurtosis(m,b1,b2) 
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN b1 EQUALS b2
%                   KUR = asymmlaplacekurtosis(0,1/2,2)
%                    
% raw kurtosis of asymmetric laplace distribution
% NOTE! excess kurtosis--i.e. kurtosis different from gaussian--given by KUR - 3
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%
% m:      location of mode                                                 (default = 0) 
% b1:     expected power / mean of 1st exponential random variable         (default = 1)
% b2:     expected power / mean of 2nd exponential random variable         (default = 1)
%         NOTE! b1 = 1/2 and b2 = 2   yields a rightward skew
%         NOTE! b1 = 2   and b2 = 1/2 yields a leftward  skew
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% KUR:    kurtosis
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if ~exist('m'    ,'var') || isempty( m)    m     = 0; end
if ~exist('b1'   ,'var') || isempty(b1)    b1    = 1; end
if ~exist('b2'   ,'var') || isempty(b2)    b2    = 1; end

% INPUT CHECKING
if b1 <= 0, error('asymmlaplacekurtosis: WARNING! PARAMETER b1 MUST BE LARGER THAN 0'); end
if b2 <= 0, error('asymmlaplacekurtosis: WARNING! PARAMETER b2 MUST BE LARGER THAN 0'); end

% RAW KURTOSIS (EXCESS KURTOSIS--i.e. DIFFERENT FROM GAUSSIAN--IS GIVEN BY RAW - 3) 
KUR = 6*(b1^4 + b2^4)/(b1^2 + b2^2)^2 + 3;
