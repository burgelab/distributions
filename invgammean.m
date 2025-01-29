function [MU] = invgammean(a,b)

% function [MU] = invgammean(a,b)
%
%   example call: [MU] = invgammean(a,b)
%
% mean of inverse gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/Inverse-gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%
% MU:    mean

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['invgammean: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% INVERSE GAMMA MEAN
MU  = b./(a-1);
