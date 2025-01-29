function [VAR] = betavar(a,b)

% function [VAR] = betavar(a,b)
%
%   example call: [VAR] = betavar(a,b)
%
% variance of beta distribution from shape parameters a and b
% 
% reference: https://en.wikipedia.org/wiki/beta_distribution
%
% IMPORTANT SPECIAL CASES
%   a=b=0.5 -> arcsin  dstb: var(B) = 1/8
%   a=b=1.0 -> uniform dstb: var(B) = 1/12
% 
% a:     shape parameter #1
% b:     shape parameter #2
%%%%%%%%%%%%%%%%%
% VAR:   variance

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['betavar: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% BETA VARIANCE
% if a==b, VAR = 1./(8.*a+4);
% else,    VAR = a.*b./( (a+b).^2.*(a+b+1) );
% end

% BETA VARIANCE
[~,VAR] = betastat(a,b);
