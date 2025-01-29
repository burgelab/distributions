function [VAR] = bernoullivar(p)

% function [VAR] = bernoullivar(p)
%
%   example call: [VAR] = bernoullivar(p)
%
% variance of bernoulli distribution from shape parameters a and b
% 
% reference: https://en.wikipedia.org/wiki/bernoulli_distribution
% 
% p:     probability of success
%%%%%%%%%%%%%%%%%
% VAR:   variance

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['bernoullivar: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% BERNOULLI VARIANCE
VAR = p.*(1-p);

