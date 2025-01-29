function H = bernoullientropy(p,bitsORnats)

% function bernoullientropy(p,bitsORnats)
%
%   example call: bernoullientropy(.5,'bits')
%
% entropy of bernoulli distribution with support between a and b
%
% p:         probability of success
% bitsORnat: string indicating whether to return entropy in bits or nots
%            'bits' -> entropy in log-base-2 (default)
%            'nats' -> entropy in log-base-e
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H:         entropy in bits or nats

% INPUT HANDLING
if ~exist('bitsORnats','var') || isempty(bitsORnats) bitsORnats = 'bits'; end

% ENTROPY
if     strcmp(bitsORnats,'bits')
    H = -sum( p.*log2(p) + (1-p)*log2(1-p) );
elseif strcmp(bitsORnats,'nats')
    H = -sum( p.*log( p) + (1-p)*log( 1-p) );
end
