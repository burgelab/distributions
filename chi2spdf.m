function p = chi2spdf(x,nu,S,bPLOT)

% function p = chi2spdf(x,nu,S,bPLOT)
%
%   example call: p = chi2spdf(linspace(0,10,101),1,1,1);
%
% scaled chi2 probability density function
%
% NOTE! the scaled chi2 distribution is the distribution of a squared 
%       mean zero gaussian random variable with variance S where
%
%                chi2s = S.*chi2
%                chi2s = ( sqrt(S).*randn(100000,1) ).^2
%
% x:     values of x
% nu:    degrees of freedom (default = 1) 
% S:     scale parameter    (default = 1)
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:     probability density
%
%               *** see chi2s*.m ***

% INPUT HANDLING
if ~exist('nu'   ,'var') || isempty(nu)    nu    = 1; end
if ~exist('S'    ,'var') || isempty(S)     S     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% GAMMA PARAMS EQUIVALENT TO SCALED CHI2 PDF
[a,b] = chi2s2gamparam(nu,S,0);

% SCALED CHI2 PDF (GAMMA EQUIVALENT)
p = gampdf(x,a,b);

if bPLOT == 1
   figure(1111); 
   plot(x,p,'k','linewidth',2);
   formatFigure('X','Probability'); axis square;
end

