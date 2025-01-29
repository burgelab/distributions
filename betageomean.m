function [MUg] = betageomean(a,b)

% function [MUg] = betageomean(a,b)
%
%   example call: [MUg] = betageomean(a,b)
%
% geometric mean of beta distribution from shape parameters a and b
% 
% reference: https://en.wikipedia.org/wiki/beta_distribution
% 
% a:     shape parameter #1
% b:     shape parameter #2
%%%%%%%%%%%%%%%%%
% MUg:   geometric mean

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['betageomean: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% BETA GEOMETRIC MEAN (where psi.m is the digamma function).
MUg = exp( psi(a)-psi(a+b) );
