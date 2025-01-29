function [VR] = gamvar(a,b)

% function [VR] = gamvar(a,b)
%
%   example call: [VR] = gamvar(a,b)
%
% variance of gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%
% VR:    mean

% INPUT HANDLING
for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['gamvar: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% GAMMA VARIANCE
[~,VR] = gamstat(a,b); 
