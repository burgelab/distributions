function p = uniformpdf(x,a,b,bPLOT)

% function p = uniformpdf(x,a,b,bPLOT)
%
%   example call: uniformpdf(linspace(-5,5,101),-3,3,1);
%
% probability density function for uniform distribution
%
% x:     values of x
% a:     lower boundary (default = 0)
% b:     upper boundary (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:     probability density
%
%           *** see uniform*.m ***

% INPUT HANDLING
if ~exist('a'    ,'var') || isempty( a)    a     = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% GOOD INDICES
indGd    = x>=a & x<=b;

% UNIFORM PDF
p        = zeros(size(x));
p(indGd) = 1./(b-a);

if bPLOT
   figure; 
   plot(x,p,'k','linewidth',2);
   formatFigure('X','Probability'); axis square;
end
