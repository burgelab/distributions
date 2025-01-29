function SD = asymmlaplacestd(m,b1,b2)

% function SD = asymmlaplacestd(m,b1,b2) 
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   SD = asymmlaplacestd(0,1,1/2)
%                    
% standard deviation of asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS   
%
% m:      location of mode                                                    (default = 0) 
% b1:     expected power (i.e. mean = var) of exponential RV to left  of mode (default = 1)
% b2:     expected power (i.e. mean = var) of exponential RV to right of mode (default = 1)
%         NOTE! b1 = 1/2 and b2 = 2   yields a rightward skew
%         NOTE! b1 = 2   and b2 = 1/2 yields a leftward  skew
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% SD:     standard deviation
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if ~exist('m'    ,'var') || isempty( m)    m     = 0; end
if ~exist('l'    ,'var') || isempty( l)    l     = 1; end
if ~exist('k'    ,'var') || isempty( k)    k     = 1; end

% INPUT CHECKING
if b1 <= 0, error('asymmlaplacekurtosis: WARNING! PARAMETER b1 MUST BE LARGER THAN 0'); end
if b2 <= 0, error('asymmlaplacekurtosis: WARNING! PARAMETER b2 MUST BE LARGER THAN 0'); end

% VARIANCE
SD =  sqrt( asymmlaplacevar(m,b1,b2) );