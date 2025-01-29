function P = laplacecdf(x,mu,b,bPLOT)

% function P = laplacecdf(x,mu,b,bPLOT)
%
%   example call: laplacecdf(linspace(-5,5,101),0,0.5,1);
%
% cumulative distribution function for laplace distribution
%
% x:     values of x
% mu:    mean              (default = 0)
% b:     scale parameter   (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P:     cumulative probability
%
%               *** see laplace*.m ***

% INPUT HANDLING
if ~exist('mu'   ,'var') || isempty(mu)    mu    = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% CUMULATIVE DISTRIBUTION FUNCTION
P = 0.5 + 0.5.*sign(x-mu).*( 1 - exp(-abs(x-mu)./b));

% PLOT
if bPLOT
   figure; 
   plot(x,P,'k','linewidth',2);
   formatFigure('X','Probability',['mu=' num2str(mu) ' b=' num2str(b) ]); 
   axis square;
end