function [CDF PDF bins] = histCumProb(X,bins,bPLOT)

% function [CDF PDF bins] = histCumProb(X,bins,bPLOT)
%
%   example call: histCumProb(randn(10000,2),51,1);
%
% compute empirical cumlative probability 
% 
% X:      values to histogram              [ n x m ]
% bins:   number of bins or actual bins    
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
% %%%%%%%%%%%%%%%%%%%%
% CDF:   cumulative probability
% PDF:      probability

if ~exist('bins','var')  || isempty(bins),  bins  = 21; end
if ~exist('bPLOT','var') || isempty(bPLOT), bPLOT = 0; end

% HISTOGRAMS
[H,bins] = hist(X,bins);

% HISTOGRAM TO PROBABILITY (EASY TO READ, ANNOYING TO COMPUTE)
% PDF = H./sum(H); 

% HISTOGRAM TO PROBABILITY (HARD TO READ, MORE VERSATILE COMPUTE)
PDF = bsxfun(@rdivide,H,sum(H));

% CUMULATIVE PROBABILITY
CDF = cumsum(PDF);

if bPLOT
   figure('position',[560   562   828   386]);
   subplot(1,2,1); 
   plot(bins,PDF,'k','linewidth',2);  axis square
   formatFigure('X','Probability','PDF');
   % legend(legendLabel('Dim=',1:size(X,2)))
   
   subplot(1,2,2); 
   plot(bins,CDF,'k','linewidth',2);   axis square
   formatFigure('X','Probability','CDF');
   ylim([-0.05 1.05]);
end
