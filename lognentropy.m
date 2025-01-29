function H = lognentropy(mu,sigma,bitsORnats)

% function lognentropy(mu,sigma,bitsORnats)
%
%   example call: lognentropy(0,1)
%
% entropy of log-normal distribution with support between a and b
%
% mu:        mean
% sigma:     standard deviation
% bitsORnat: string indicating whether to return entropy in bits or nots
%            'bits' -> entropy in log-base-2 (default)
%            'nats' -> entropy in log-base-e
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H:         entropy

% INPUT HANDLING
if ~exist('bitsORnats','var') || isempty(bitsORnats) bitsORnats = 'bits'; end

% ENTROPY
if     strcmp(bitsORnats,'bits')
    H = log2(sigma.*exp(mu+0.5).*sqrt(2.*pi));
elseif strcmp(bitsORnats,'nats')
    H = log( sigma.*exp(mu+0.5).*sqrt(2.*pi));
end