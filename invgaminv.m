function x = invgaminv(P,a,b,bPLOT)

% function x = invgaminv(P,a,b,bPLOT)
%
%   example call: x = invgaminv(linspace(0,1,101),3,1,1);
%
% inverse of the inverse gamma cumulative distribution function (cdf)
% 
% P:    cumulative probability
% a:    shape parameter
% b:    scale parameter
%%%%%%%%%%%%%%%%%
% x:    x-values

if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INVERSE GAMMA CDF
x = 1./gaminv(1 - P,a,1./b);

if bPLOT
    figure(1113); hold on
    plot(P,x,'k','linewidth',2);
    formatFigure('Probability','X',['Inverse Gamma Inv; a=' num2str(a) ', b=' num2str(b)]);
    axis square
end