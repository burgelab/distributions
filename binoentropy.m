function H = binoentropy(n,p,bitsORnats)

% function binoentropy(n,p,bitsORnats)
%
%   example call: binoentropy(1,.5,'bits')
%
% entropy of binomial distribution with support between a and b
%
% n:         number of trials
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
    H = 0.5.*log2( 2.*pi.*exp(1).*n.*p.*(1-p) );
elseif strcmp(bitsORnats,'nats')
    H = 0.5.*log(  2.*pi.*exp(1).*n.*p.*(1-p) );
end

error(['binoentropy: WARNING! something wrong w. expression. Does not equal 1 bits when n = 1 and p = 0.5']);