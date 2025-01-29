function [mufit] = expfitplot(X,bPLOT)

% function [mufit] = expfitplot(X,bPLOT)
%
%   example call: % EXPONENTIAL DISTRIBUTION FIT
%                   [mufit] = gamfitplot( exprnd(1,1000000,1),1)
%
%                 % EXPONENTIAL DISTRIBUTION FIT
%                   [mufit] = gamfitplot( exprnd(4,1000000,1),1)
%
% fit parameters of gamma distribution to samples of random variable 
% via maximum likelihood estimation (MLE) and plot the results
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% mufit: mean = scale = variance


if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% FIT PARAMETERS
[mufit] = expfit(X);

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
	Qlohi = quantile(X,[.005 .995]);
    % INV GAMMA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit = exppdf(xFit,mufit);
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),41);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % bar(B(1:end-1),max(pFit).*H(1:end-1)./max(H),1,'w');
    % plot(xFit,pFit,'k');
    formatFigure('X','Probability',['Gamma Fit; aFit=' num2str(mufit)]);
    axis square
    xlim([0 max(xlim)]);
end

