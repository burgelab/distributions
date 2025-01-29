function nu = gam2chi2param(a,b)

% function [a,b] = gam2chi2param(nu)
% 
%   example call: nu = gam2chi2param(1,2)
%
% gamma distribution params to chi2 distribution params
%
% NOTE! if b ~= 2, the gamma is not equivalent to a chi-squared dstb
%       however, if could be equivalent to a scaled chi-squared dstb
%            ***      see gam2chi2sparam.m      ***
%
% a  : shape parameter of  gamma distribution
% b  : scale parameter of gamma distribution
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nu : degrees of freedom of chi-squared random variable
%
%     *** see chi22gamparam.m, gam2chi2sparam.m, chi2s2gamparam.m ***

% INPUT HANDLING
if ~exist('a'  ,'var') || isempty(a),   
    a   = 1; disp('gam2chi2param.m: WARNING! No shape parameter specified for gamma distribution. Running with default of a = 1'); 
end
if ~exist('b'  ,'var') || isempty(b),   
    b   = 2; disp('gam2chi2param.m: WARNING! No scale parameter specified for gamma distribution. Running with default of b = 2'); 
end
if a < 0, 
    a = abs(a); 
    disp(['gam2chi2param.m: WARNING! Shape parameter should be a positive-valued to get valid degrees of freedom for chi-squared dsitribution. Imposing positive sign ', num2str(a)]); end
if b ~= 2, 
    error('gam2chi2param.m: WARNING! Equivalent chi-squared description exists only when the scale parameter of the gamma distribution b = 2'); 
end

% CONVERT PARAMS
nu = 2*a;

% CHECK CONVERTED PARAMS
if nu ~= floor(nu), 
    error('gam2chi2param.m: Non-integer-valued degrees of freedom result from the specified shape parameter a');
end