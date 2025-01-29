function [aFit,bFit] = invgamfit(X,bPLOT,gca)

% function [aFit bFit] = invgamfit(X,bPLOT,gca)
%
%   example call: [aFit bFit] = invgamfit(X,1)
%
% method of moments (MM) estimates of inverse gamma distribution parameters
% 
% NOTE: max likelihood estimates of inverse gamma distribution also useful
% 
% reference: Llera & Beckmann (2016) arXiv:1605.01019v2 [stat.ME], July 7th
% 
% X:     data          [ nSmp x nDim ]
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
% gca:   plot on current axis w.o. new figure (temporary variable)
%%%%%%%%%%%%%%%%%
% aFit:  shape parameter fit
% bFit:  scale parameter fit

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if min(size(X))==1, X = X(:); end

% SAMPLE MEAN & VARIANCE
MU  = mean(X,1);
% HARD TO READ (EASY TO COMPUTE)
VR = bsxfun(@rdivide, sum( bsxfun(@minus,X,MU).^2 , 1), (size(X,1)-1) );
% EASY TO READ (HARD TO COMPUTE)
% VR = sum( (X - MU).^2 , 1)./(size(X,1)-1);

% METHOD OF MOMENTS (MM) ESTIMATES SHAPE PARAMETER
aFit = (MU.^2)./VR + 2;
bFit = MU.*((MU.^2)./VR + 1);

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
	Qlohi = quantile(X,[.001 .999]);
    % INV GAMMA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit    = invgampdf(xFit,aFit,bFit);
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),31);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % bar(B(1:end-1),max(pFit).*H(1:end-1)./max(H),1,'w');
    % plot(xFit,pFit,'k');
    formatFigure('X','Probability',['Inverse Gamma Fit; aFit=' num2str(aFit) ', bFit=' num2str(bFit)]);
    axis square
end
