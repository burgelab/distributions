function H = uniformentropy(a,b,bitsORnats)

% function H = uniformentropy(a,b,bitsORnats)
%
%   example call: % ENTROPY OF UNIFORM ON [-1 1]  
%                   uniformentropy(-1,1)
%
%                 % ENTROPY OF UNIFORM W. 1.0 VARIANCE VS ENTROPY OF NORMAL
%                   uniformentropy(-sqrt(3),sqrt(3)), normentropy(0,1)
%                   
% entropy of uniform distribution with support between a and b
%
% a:         lower boundary
% b:         upper boundary
% bitsORnat: string indicating whether to return entropy in bits or nots
%            'bits' -> entropy in log-base-2 (default)
%            'nats' -> entropy in log-base-e
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% H:         entropy

% INPUT HANDLING
if ~exist('bitsORnats','var') || isempty(bitsORnats) bitsORnats = 'bits'; end


% KURTOSIS
if     strcmp(bitsORnats,'bits')
    H = log2(b-a);
elseif strcmp(bitsORnats,'nats')
    H = log( b-a);
end