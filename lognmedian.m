function [MED] = lognmedian(mu,sigma)

% function [MED] = lognmedian(param)
%
%   example call: [MED] = lognmedian(param)
%
% median of log-normal distribution from mu and sigma parameters
%
% reference: https://en.wikipedia.org/wiki/Log-normal_distribution
% 
% param: parameters of log normal
%        param(1) -> mu
%        param(2) -> sigma
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MD:    median


% INPUT HANDLING
for i = 1:size(mu,1)
if mu(i) <= 0 | sigma(i) <= 0
 error(['lognmedian WARNING! invalid parameters m(' num2str(i) ')=' num2str(mu(i)) ',sigma(' num2str(i) ')=' num2str(sigma(i)) '. Both must be greater than 0']);
end
end

% LOG-NORMAL MEDIAN
MED  = exp(mu);
