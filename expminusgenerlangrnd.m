function X = expminusgenerlangrnd(nSmp, lambdaS, lambdaD, bPLOT, B)

% function p = expminusgenerlangrnd(nSmp, lambdaS, lambdaD, bPLOT, B)
%
%   example call: expminusgenerlangrnd(10000, 1, [2 3], 1);
%
%                 expminusgenerlangrnd(10000, 1, [2 3 5], 1);
%
% random samples from a probability density of an exponential random variable 
% minus a generlized Erlang (or Erlang) random variable
%
% nSmp:     number of random samples
% lambdaS:  rate  of exponential        RV in the (s)um          (1/E[X])   [  scalar  ]
% lambdaD:  rates of generalized erlang RV in the (d)ifference              [  1 x k2  ]
%           NOTE! lambdaS, lambdaD must be row vectors
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
% B:        bins for histogram...
%           number of bins OR [scalar] or vector of bins [ 1 x nBin ]
% bQUIET:   warn users or not invalid parameter values (about?)
%           1 -> turn off warnings
%           0 -> don't
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:        random samples                                                  [ nSmp x 1 ] 

% INPUT HANDLING
if ~exist('bPLOT', 'var')                      bPLOT  =   0; end
if ~exist('B',  'var')    || isempty(B)        B      =  51; end
if ~exist('bQUIET','var') || isempty(bQUIET)   bQUIET =   0; end

%%%%%%%%%%%%%%%%%%
% INPUT CHECKING %
%%%%%%%%%%%%%%%%%%
% NUM RANDOM VARIABLES
if numel(lambdaS) ~= 1, error('expminusgenerlangrnd: WARNING! lambdaS must be a scalar. Check inputs!!!'); end

% NUMBER OF INDEPENDENT EXPONENTIALS IN GENERLANG RV
lambdaD = lambdaD(:)';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXPONENTIAL RANDOM SAMPLES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
XS = exprnd(1./lambdaS,nSmp,1);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% GENERLANG RANDOM SAMPLES %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% *** HARD TO READ, FAST TO COMPUTE *** %
XD = sum(exprnd(repmat(1./lambdaD,nSmp,1),nSmp,length(lambdaD)),2);

% % *** EASY TO READ, SLOW TO COMPUTE *** %
% % RANDOM VARIABLES
% XDindi = zeros(nSmp,length(lambdaD));
% for i = 1:length(lambdaD)
%     XDindi(:,i) = exprnd(1./lambdaD(i),nSmp,1);
% end
% % GENERALIZED ERLANG RV
% XD = sum(XDindi,2);

% EXPONENTIAL MINUS GENERLANG RANDOM VARIABLE
X = XS - XD;

if bPLOT == 1
    figure('position',[587   390   618   528]); hold on
    % HISTOGRAM RANDODM SAMPLES
    [H B] = hist(X,B);
    % CONVERT TO PROBABILITY 
    P = H./(sum(H.*diff(B(1:2))));
    % PDF
    p = expminusgenerlangpdf(B,lambdaS,lambdaD);
    % PLOT HISTOGRAMMED SMAPLES
    bar(B,P,1,'w');
    % PLOT PDF
    plot(B,p,'k','linewidth',2)
    % PRETTIFY IT
    formatFigure('X','Probability',['Exp minus GenErlang RV: \lambdaS=' num2str(lambdaS) ' \lambdaD=[' num2str(lambdaD,'%.1f ') ']']);
    axis square;
end
