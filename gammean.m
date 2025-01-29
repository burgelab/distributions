function [MU] = gammean(a,b)

% function [MU] = gammean(a,b)
%
%   example call: [MU] = gammean(a,b)
%
% mean of gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%
% MU:    mean

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['gammean: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% GAMMA MEAN
[MU] = gamstat(a,b); 
