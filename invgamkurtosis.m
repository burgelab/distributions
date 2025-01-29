function [KR] = invgamkurtosis(a,b)

% function [KR] = invgamkurtosis(a,b)
%
%   example call: [KR] = invgamkurtosis(a,b)
%
% excess kurtosis of inverse gamma distribution from shape and scale parameters
% NOTE! excess kurtosis of gaussian is 0.0
%
% reference: https://en.wikipedia.org/wiki/Inverse-gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%%%%%%%%
% KR:    kurtosis of inv gamma pdf where kurtosis of a gaussian equals 3
%        excess kurtosis of gaussian equals 3 
%        excess kurtosis of inverse gamma equals KR - 3

% INPUT HANDLING
for i = 1:length(a)
    if a(i) <= 0 || b(i) <= 0
        error(['invgamkurtosis: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
    end
end

% INVERSE GAMMA KURTOSIS
if a > 4
    KR  = (30.*a - 66)./((a-3).*(a-4));
else
    KR  = NaN;    
end
