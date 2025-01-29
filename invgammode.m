function [MD] = invgammode(a,b)

% function [MD] = invgammode(a,b)
%
%   example call: [MD] = invgammode(a,b)
%
% mode of inverse gamma distribution from shape and scale parameters
% 
% reference: https://en.wikipedia.org/wiki/Inverse-gamma_distribution
% 
% a:     shape parameter
% b:     scale parameter
%%%%%%%%%%%%%%%%%
% MD:    mode

for i = 1:length(a)
if a(i) <= 0 || b(i) <= 0
 error(['invgammode: WARNING! invalid parameters a(' num2str(a(i)) ')=' num2str(a(i)) ',b(' num2str(b(i)) ')=' num2str(b(i)) '. Both must be greater than 0']);
end
end

% INVERSE GAMMA MODE
MD  = b./(a+1);
