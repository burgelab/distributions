function p = chi2smode(nu,S,bPLOT)

% function p = chi2smode(nu,S,bPLOT)
%
%   example call: p = chi2smode(1,1,1);
%
% mode of scaled chi2 pdf
%
% NOTE! the scaled chi2 distribution is the distribution of a squared 
%       mean zero gaussian random variable with variance S where
%
%                chi2s = S.*chi2
%                chi2s = ( sqrt(S).*randn(100000,1) ).^2
%
% nu:    degrees of freedom (default = 1) 
% S:     scale parameter    (default = 1)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MD:    mode of scaled chi2s pdf
%
%               *** see chi2s*.m ***

% INPUT HANDLING
if ~exist('nu'   ,'var') || isempty(nu)    nu    = 1; end
if ~exist('S'    ,'var') || isempty(S)     S     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% GAMMA PARAMS EQUIVALENT TO SCALED CHI2 PDF
[a,b] = chi2s2gamparam(nu,S,0);

% SCALED CHI2 PDF (GAMMA EQUIVALENT)
MD = gammode(x,a,b);
