function [SK] = invgamskewness(a,b)

% function [SK] = invgamskewness(a,b)
%
%   example call: [SK] = invgamskewness(a,b)
%
% skewness of inverse gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/Inverse-gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%
% SK:    skewness

for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['invgamskewness: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% INVERSE GAMMA SKEWNESS
if a > 3
    SK  = 4.*sqrt(a-2)./(a-3);
else
    SK  = NaN;    
end
