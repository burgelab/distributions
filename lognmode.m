function MOD = lognmode(mu,sigma)

% function MOD = lognmode(mu,sigma)
%
% returns mode (max) of lognormal pdf with parameters mu and sigma
%
% reference: https://en.wikipedia.org/wiki/Log-normal_distribution
% 
% mu:       location
% sigma:    scale
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MOD:      mode of log normal distribution

MOD  = exp(mu - sigma.^2);
