function p = laplacepdf(x,mu,b,bPLOT)

% function p = laplacepdf(x,mu,b,bPLOT)
%
%   example call: p = laplacepdf(linspace(-10,10,101),0,2,1);
%
% probability density function for laplace distribution
%
%         p = (0.5*./b).*exp(-abs(x-mu)./b)
%
% x:     values of x
% mu:    mean               (default = 0) 
% b:     scale parameter    (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:     probability density
%
%               *** see laplace*.m ***

% INPUT HANDLING
if ~exist('mu'   ,'var') || isempty(mu)    mu    = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% LAPLACE PDF
p = (0.5./b).*exp( -abs(x-mu)./b );

if bPLOT
   figure; 
   plot(x,p,'k','linewidth',2);
   formatFigure('X','Probability',['\mu=' num2str(mu) ' b=' num2str(b) ]); axis square;
end
