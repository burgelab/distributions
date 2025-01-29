function P = invgamcdf(x,a,b,bPLOT)

% function P = invgamcdf(x,a,b,bPLOT)
%
%   example call: p = invgampdf(linspace(0,3,101),2,1,1);
%
% x:    x-values
% a:    shape parameter
% b:    scale parameter
%%%%%%%%%%%%%%%%%
% P:    cumulative probability

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if a <= 0 || b <= 0, error(['invgamvar: WARNING! invalid parameters a=' num2str(a) ',b=' num2str(b) '. Both must be greater than 0']); end

% INVERSE GAMMA CDF
P = gammainc(b./x,a,'upper');

if bPLOT
    figure(1112); hold on
    plot(x,p,'k','linewidth',2);
    formatFigure('X','Probability',['Inverse Gamma cdf; a=' num2str(a) ', b=' num2str(b)]);
    axis square
end