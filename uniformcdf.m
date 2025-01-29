function p = uniformcdf(x,a,b,bPLOT)

% function p = uniformcdf(x,a,b,bPLOT)
%
%   example call: uniformcdf(linspace(-5,5,101),-3,3,1);
%
% cumulative distribution function for uniform distribution
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
indLo    = x <  a;
indGd    = x >= a & x <= b;
indHi    = x >  b;

% UNIFORM CDF
p        = zeros(size(x));
p(indGd) = ( x(indGd)-a )./( b-a );
p(indHi) = 1;

if bPLOT
   figure; 
   plot(x,p,'k','linewidth',2);
   formatFigure('X','Probability'); axis square;
end
