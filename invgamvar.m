function [VR] = invgamvar(a,b)

% function [VR] = invgamvar(a,b)
%
%   example call: [VR] = invgamvar(a,b)
%
% variance of inverse gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/Inverse-gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%
% VR:    variance

% INPUT HANDLING
for i = 1:length(a)
    if a(i) <= 0 || b(i) <= 0
        error(['invgamvar: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
    end
end

% INVERSE GAMMA VARIANCE
if a > 2
    VR  = b.^2./((a-2).*(a-1).^2);
else
    VR  = NaN;
end
