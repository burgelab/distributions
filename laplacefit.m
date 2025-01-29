function [muFit,bFit] = laplacefit(X,bPLOT)

% function [muFit bFit] = laplacefit(X,bPLOT)
%
%   example call: [muFit,bFit] = laplacefit( laplacernd(0,1,10000),1)
%
% fit parmaeters laplace distribution to samples of 
% random variable via maximum likelihood estimation (MLE)
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% muFit: mean
% bFit:  scale parameter
%
%               *** see laplace*.m ***

if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% MLE ESTIMATE muFit IS SAMPLE MEDIAN
muFit = median(X);

% EASY TO READ... BUT  AN  INFLEXIBLE COMPUTE
% bFit  = mean( abs(X - muFit) );

% HARD TO READ... BUT MORE FLEXIBLE   COMPUTE
bFit  = mean( abs( bsxfun(@minus,X,muFit) ) );

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
	Qlohi = quantile(X,[.0005 .9995]);
    % INV GAMMA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit = laplacepdf(xFit,muFit,bFit);
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),41);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % bar(B(1:end-1),max(pFit).*H(1:end-1)./max(H),1,'w');
    % plot(xFit,pFit,'k');
    formatFigure('X','Probability',['Laplace Fit; \muFit=' num2str(muFit) ', bFit=' num2str(bFit)]);
    axis square
end

