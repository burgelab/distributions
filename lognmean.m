function [MU] = lognmean(mu,sigma)

% function [MU] = lognmean(mu,sigma)
%
%   example call: [MU] = lognmean(mu,sigma)
%
% mean of log-normal distribution from m and v parameters
% 
% reference: https://en.wikipedia.org/wiki/Log-normal_distribution
% 
% param: parameters of log normal
%        param(1) -> m
%        param(2) -> v
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:    mean

% INPUT HANDLING
for i = 1:size(mu,1)
if mu(i) <= 0 | sigma(i) <= 0
 error(['lognmean: WARNING! invalid parameters m(' num2str(i) ')=' num2str(mu(i)) ',sigma(' num2str(i) ')=' num2str(sigma(i)) '. Both must be greater than 0']);
end
end

% INVERSE GAMMA MEAN
MU  = exp(mu + (sigma.^2)./2);
