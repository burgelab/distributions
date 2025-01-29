function [lambdafit] = generlangfit(X,k,bPLOT,B)

% function [lambdafit] = generlangfit(X,k,bPLOT,B)
%
%    example call: X         = generlangrnd(10000000,[1 3],1);       
%                  lambdafit = generlangfit(X,2,1);       
%
% fit parameters to random samples from generalized erlang
% using method of moments fits
% 
% X:       random samples
% k:       number of comonent exponential random variables
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
% B:       bins for histogram...
%          number of bins OR [scalar] or vector of bins [ 1 x nBin ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lambdafit: fitted values of 
%
% BACKGROUND: generalized Erlang (or hypoexponential) distribution results 
% from the sum of k independent exponentially distributed random variables 
%                      w/ DIFFERENT lambda parameter
% 
%                  X ~ generlang(lambda1,lambda2,...,lambdak)
%                                    where
%                            X = X1 + X2 + ... + Xk
%                                  and where 
% X1 ~ exppdf(1./lambda1), X2 ~ exppdf(1./lambda2), ..., Xk ~ exppdf(1./lambdak)
%
% NOTE! current implementation handles the sum of only two or three exp RVs
%             because there is no simple closed form expression
%                        for the more general form
%
% NOTE! when k equals 1, the erlangpdf is an exponential pdf
% NOTE! when lambda(1)=...= lambda(k), generlangpdf = erlangpdf
%
%  *** FOR RELATED FUNCTIONS TYPE >> ls generlang*.m AND erlang*.m ***

% INPUT HANDLING
if k ~= 2, error('generlangfit.m: WARNING! parameter estimation on ly valid if k = 2'); end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end
if ~exist('B',    'var') || isempty(B)     B     = 51; end

% INPUT CHECKING
if isscalar(B) nBin = B; else nBin = length(B); end
if nBin > 150, disp(['generlangfit: WARNING! histogram bins may not display in plot b.c. nBin=' num2str(nBin) '>150... Reduce number of bins?']); end



% SAMPLE MEAN
MUs = mean(X);
% SAMPLE STDDEV
SDs = std(X);
% SAMPLE COEFF OF VARIATION
CVs = SDs./MUs;

% FITTED PARAMETERS
lambdafit(1) = 2./( MUs.*(1 + sqrt(1 + 2.*(CVs.^2 - 1))) );
lambdafit(2) = 2./( MUs.*(1 - sqrt(1 + 2.*(CVs.^2 - 1))) );

if bPLOT == 1
    figure; hold on
    % HISTOGRAM RANDODM SAMPLES
    [H B] = hist(X,B);
    % CONVERT TO PROBABILITY 
    P = H./(sum(H.*diff(B(1:2))));
    % PDF
    p = generlangpdf(B,lambdafit);
    % PLOT STUFF
    bar(B,P,1,'w');
    plot(B,p,'k','linewidth',2)
    % PRETTIFY IT
    formatFigure('X','Probability',['generlangpdf: \lambdafit=[' num2str(lambdafit,'%.2f ') ']']);
    axis square;
end
