function X = asymmlaplacernd(nSmp,m,b1,b2,bPLOT,B)

% function X = asymmlaplacernd(nSmp,m,b1,b2,bPLOT,B)
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   X = asymmlaplacernd(10000,0,1/2,2,1,linspace(-12,12,61));
%                    
% inverse cumulative distribution function of asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%
% nSmp:   number of samples
% m:      location of mode                                                    (default = 0) 
% b1:     expected power (i.e. mean = var) of exponential RV to left  of mode (default = 1)
% b2:     expected power (i.e. mean = var) of exponential RV to right of mode (default = 1)
%         NOTE! b1 = 1/2 and b2 = 2   yields a rightward skew
%         NOTE! b1 = 2   and b2 = 1/2 yields a leftward  skew
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:      random samples
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if isscalar(nSmp)                        nSmp = [nSmp 1];   end
if ~exist('m'    ,'var') || isempty( m)        m     = 0;   end
if ~exist('b1'   ,'var') || isempty( b1)       b1    = 1;   end
if ~exist('b2'   ,'var') || isempty( b2)       b2    = 1;   end
if ~exist('bPLOT','var') || isempty(bPLOT)     bPLOT = 0;   end
if ~exist('B','var')     || isempty(B)         B     = 61;  end


% INPUT CHECKING
if b1 <= 0, error('asymmlaplacernd: WARNING! PARAMETER b1 MUST BE LARGER THAN 0'); end
if b2 <= 0, error('asymmlaplacernd: WARNING! PARAMETER b2 MUST BE LARGER THAN 0'); end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % RANDOM SAMPLES VIA TRANSFORM OF UNIFORM RANDOM VARIABLE (THRU INVERSE CDF) %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % UNIFORM SAMPLE ON sqrt([ -b2/b1  b1/b2 ])
% U = -sqrt(b1/b2) + ( sqrt(b2/b1) + sqrt(b1/b2) ).*rand(nSmp);
% % SIGN OF UNIFORM SAMPLES
% s = sign(U);
% % RANDOM SAMPLES
% X = m - ( 1./( sqrt(1/b2)*sqrt(1/b1).*s.*sqrt(b1/b2).^s ) ).*log( 1 - U.*s.*sqrt(b1/b2).^s);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% RANDOM SAMPLES FROM DIFFERENCE OF INDEPENDENT EXPONENTIAL RANDOM VARIABLES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
X = m + exprnd(b2,nSmp) - exprnd(b1,nSmp);

% PLOT
if bPLOT
    figure; hold on;
    [H B]=hist(X,B); axis square;
    P = H./sum(H.*diff( B(1:2) ));
    bar(B,P,1,'w');
    p = asymmlaplacepdf(B,m,b1,b2);
    plot(B,p,'k','linewidth',2);
    formatFigure('X','Count',['Asymm Laplace Samples: m=' num2str(m) ' b1=' num2str(b1) ' b2=' num2str(b2)]);
end