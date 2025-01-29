function finv = uniforminv(p,a,b,bPLOT)

% function finv = uniforminv(p,a,b,bPLOT)
%   
%   example call: uniforminv(linspace(0,1,51),-3,3,1);
%
% inverse cumulative distribution function for laplace distribution
%
% p:    probability... values must lie on [0 1]
% a:    lower boundary (default = 0)
% b:    lower boundary (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% finv: inverse cumulative uniform distirbution function
%
%           *** see uniform*.m ***

% INPUT HANDLING
if ~exist('a'    ,'var') || isempty( a)    a     = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

finv = a + p.*(b-a); 

% PLOT
if bPLOT
   figure; 
   plot(p,finv,'k','linewidth',2);
   formatFigure('Probability','X'); axis square;
end
