function finv = laplaceinv(P,mu,b,bPLOT)

% function finv = laplaceinv(P,mu,b,bPLOT)
%   
%   example call: laplaceinv(linspace(0,1,51),0,1,1);
%
% inverse cumulative distribution function for laplace distribution
%
% P:     cumulative probability... values must lie on [0 1]
% mu:    mean                      (default = 0)
% b:     scale parameter           (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finv:  inverse cumulative laplace distribution function
%
%               *** see laplace*.m ***

% INPUT HANDLING
if ~exist('mu'   ,'var') || isempty(mu)    mu    = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INVERSE CDF
finv = mu - b.*sign(P - 0.5).*log( 1 - 2.*abs(P-0.5) );

% PLOT
if bPLOT
   figure; 
   plot(P,finv,'k','linewidth',2);
   formatFigure('Probability','X'); axis square;
end