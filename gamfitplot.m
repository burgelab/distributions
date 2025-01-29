function [param] = gamfitplot(X,bPLOT)

% function [param] = gamfitplot(X,bPLOT)
%
%   example call: % GAMMA FIT
%                   [param] = gamfitplot( gamrnd(2,1,1000000,1),1)
%
%                 % GAMMA FIT
%                   [param] = gamfitplot( gamrnd(4,1,1000000,1),1)
%
% fit parameters of gamma distribution to samples of random variable 
% via maximum likelihood estimation (MLE) and plot the results
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% param: gamma parameters
%        param(1) -> shape parameter
%        param(2) -> scale parameter

if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% FIT PARAMETERS
[param] = gamfit(X);

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
	Qlohi = quantile(X,[.01 .99]);
    % INV GAMMA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit = gampdf(xFit,param(1),param(2));
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),41);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % FORMAT STUFF
    formatFigure('X','Probability',['Gamma Fit; aFit=' num2str(param(1)) ', bFit=' num2str(param(2))]);
    axis square
    xlim([0 max(xlim)]);
end

