function [a,b] = chi22gamparam(nu)

% function [a,b] = chi22gamparam(nu)
% 
%   example call: [a,b] = chi22gamparam(2)
%
% chi-squared params to equivalent gamma distribution params
%
% nu:   degrees of freedom of chi-squared random variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:    shape parameter of  gamma distribution
% b:    scale parameter of gamma distribution

% INPUT HANDLING
if ~exist('nu'  ,'var') || isempty(nu),   
    nu   = 1; 
    disp('WARNING! chi22gamparam.m: No degrees of freedom specified for chi-square. Running with default of 1'); 
end
if nu < 0 || nu ~= ceil(nu), 
    nu = abs(ceil(nu));   
    disp(['WARNING! chi22gamparam.m: Degrees of freedom should be a positive integer. Imposing positive sign and rounding to ', num2str(nu)]); 
end

% CONVERT PARAMS
a = nu/2;
b = 2;    % NOTE: b (scale parameter) is always 2 for gamma equivalent of a chi-squared-distributed rv.