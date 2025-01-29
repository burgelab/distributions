function [MU] = betamean(a,b)

% function [MU] = betamean(a,b)
%
%   example call: [MU] = betamean(a,b)
%
% mean of beta distribution from shape parameters a and b
% 
% reference: https://en.wikipedia.org/wiki/beta_distribution
% 
% a:     shape parameter #1
% b:     shape parameter #2
%%%%%%%%%%%%%%%%%
% MU:    mean

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['betamean: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% GAMMA MEAN
[MU] = betastat(a,b); 
