function p = invgampdf(x,a,b,bPLOT)

% function p = invgampdf(x,a,b,bPLOT)
%
%   example call: p = invgampdf(linspace(0,3,101),2,1,1);
%
% inverse-gamma probability density function 
%
% relationships to other distributions
%  X ~ invgampdf(x,a,1/2)   ->        inverse chi2 pdf: X ~ invchi2( 2a)
%  X ~ invgampdf(x,a/2,1/2) -> scaled inverse chi2 pdf: X ~ sinvchi2(a,1/a)
%  X ~ invgampdf(x,1/2,c/2) -> Levy distribution      : X ~ L(0,c)
%
% x:    x-values
% a:    shape parameter
% b:    scale parameter
%%%%%%%%%%%%%%%%%
% p:    probability

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if a <= 0 || b <= 0, error(['invgamvar: WARNING! invalid parameters a=' num2str(a) ',b=' num2str(b) '. Both must be greater than 0']); end

% INVERSE GAMMA PDF
p  = b.^a/gamma(a).*x.^(-a-1).*exp(-b./x);

if bPLOT
    figure(1111); hold on
    plot(x,p,'k','linewidth',2);
    formatFigure('X','Probability',['Inverse Gamma pdf; a=' num2str(a) ', b=' num2str(b)]);
    axis square
end