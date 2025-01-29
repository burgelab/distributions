function [l] = chi22expparam(nu)

% function [] = chi22expparam(nu)
% 
%   example call: [l] = chi22expparam(2)
%
% chi-squared params to equivalent exponential distribution params
%
% nu:   degrees of freedom of chi-squared random variable
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% l:    mean of exponential 

% INPUT HANDLING
if ~exist('nu'  ,'var') || isempty(nu),   
    nu   = 2; 
    disp('WARNING! chi22expparam.m: No degrees of freedom specified for chi-square. Defaulting to nu=2'); 
end
if nu ~= 2
    error(['WARNING! chi22expparam.m: Degrees of freedom must equal 2.0. Otherwise, the chi2 is not an exponential']); 
end

% CONVERT PARAMS
l = nu/2;