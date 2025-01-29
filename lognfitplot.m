function [param] = lognfitplot(X,bPLOT)

% function [param] = lognfitplot(X,bPLOT)
%
%   example call: % LOG-NORMAL FIT
%                   [param] = lognfitplot( lognrnd(log(1),log(1.1),1000000,1),1)
%
% fit parameters of log-normal distribution to samples of random variable 
% via maximum likelihood estimation (MLE) and plot the results
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param: log-normal pdf parameters
%        param(1) -> shape parameter
%        param(2) -> scale parameter

if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% FIT PARAMETERS
[param] = lognfit(X);

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
	Qlohi = quantile(X,[.005 .995]);
    % INV GAMMA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit = lognpdf(xFit,param(1),param(2));
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),41);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % bar(B(1:end-1),max(pFit).*H(1:end-1)./max(H),1,'w');
    % plot(xFit,pFit,'k');
    formatFigure('X','Probability',['Log-Normal Fit; mFit=' num2str(param(1)) ', vFit=' num2str(param(2))]);
    axis square
    xlim([0 max(xlim)]);
end

