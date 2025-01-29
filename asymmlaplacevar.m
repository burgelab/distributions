function VAR = asymmlaplacevar(m,b1,b2)

% function VAR = asymmlaplacevar(m,b1,b2)
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   VAR = asymmlaplacevar(0,1/2,2);
%                    
% variance of asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%
% x:      values of x 
% m:      location of mode                                                    (default = 0) 
% b1:     expected power (i.e. mean = var) of exponential RV to left  of mode (default = 1)
% b2:     expected power (i.e. mean = var) of exponential RV to right of mode (default = 1)
%         NOTE! b1 = 1/2 and b2 =   2 yields rightward skew
%         NOTE! b1 =   2 and b2 = 1/2 yields leftward  skew
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VAR:    variance
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if ~exist('m'   ,'var') || isempty( m)    m      = 0; end
if ~exist('b1'  ,'var') || isempty(b1)    b1     = 1; end
if ~exist('b2'  ,'var') || isempty(b2)    b2     = 1; end

% INPUT CHECKING
if b1 <= 0, error('asymmlaplacevar: WARNING! PARAMETER b1 MUST BE LARGER THAN 0'); end
if b2 <= 0, error('asymmlaplacevar: WARNING! PARAMETER b2 MUST BE LARGER THAN 0'); end

% VARIANCE
VAR = b1^2 + b2^2;