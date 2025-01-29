function [P B] = histprob(X,B,bDiscrete,bPLOT,figh)

% function [P B] = histprob(X,B,bDiscrete,bPLOT,figh)
%
%   example call:
%
% histogram converted from counts to probabilities
%
% X:         data in number of data points by number of conditions [ nDta x nCnd ]
% B:         bins (or number of bins)
% bDiscreet: normalize to for data with discrete support
%            1 -> do it
%            0 -> don't (default: normalize for data with continuous support)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P:         probability in each bin
% B:         bins

if ~exist('B','var')         || isempty(B)         B         = []; end
if ~exist('bDiscrete','var') || isempty(bDiscrete) bDiscrete =  0; end
if ~exist('bPLOT','var')     || isempty(bPLOT)     bPLOT     =  0; end
if ~exist('figh','var')      || isempty(figh)      figh      =  []; end

% HISTOGRAM
[H, B] = hist(X,B);
% ENSURE H IS A COLUMN VECTOR
H = reshape(H,numel(B),size(X,2));

% PROBABILITY
P = bsxfun(@rdivide,H,sum(H,1));

% NORMALIZE FOR CONTINUOUS VARIABLES
if bDiscrete == 0
    for i = 1:size(P,2)
    P(:,i) = P(:,i)./riemann(B(:),P(:,i));
    end
end

% PLOT
if bPLOT == 1
    if isempty(gcf) figure; else, figure(gcf); end
    bar(B,P,size(P,2).*1,'w');
end
