function [aFit,bFit] = uniformfit(X)

% function [aFit bFit] = uniformfit(X)
%
%   example call: [aFit,bFit] = uniformfit( uniformrnd(10000,0,1) )
%
% fit parmaeters uniform distribution to samples of 
% random variable via unbiased minimum variance estimation (UMVE)
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aFit:  UMVE estimate of lower boundary
% bFit:  UMVE estimate of upper boundary
%
%           *** see uniform*.m ***

Xmax    = max(X);

% UMVE OF UPPER BOUNDARY
bFit    = Xmax+Xmax./size(X,1);

% UMVE OF MIDPOINT
midFit  = sum([min(X); max(X)],1)./2;

% UMVE OF LOWER BOUNDARY
aFit    = 2.*midFit - bFit;







