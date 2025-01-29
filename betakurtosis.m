function K = betakurtosis(a,b)

% function K = betakurtosis(a,b)
%
%   example call: % KURTOSIS OF BETA
%                   betakurtosis(df/2,2)
%
% excess kurtosis of beta distribution
% NOTE! excess kurtosis of gaussian is 0.0
% 
% a:    shape parameter #1
% b:    shape parameter #2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% K:    kurtosis of beta pdf,      where         kurtosis of gaussian = 3.0
%       excess kurtosis equals K-3, where excess kurtosis of gaussian = 0.0
%    

% EXCESS KURTOSIS OF BETA
if a == b
    K = 3 - 6./(2.*a+3);
else
    K = 3 + 6.*( (a-b).^2.*(a+b+1)- a.*b.*(a+b+2) )./( a.*b.*(a+b+2).*(a+b+3) );
end


