function b = laplacestd2b(SD)

% function b = laplacestd2b(SD)
%
%   example call: laplacestd2b(1);
%
% convert standard deviation of laplace distribution to scale parameter (b)
%
% SD:    standard deviation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% b:     scale parameter
%
%               *** see laplace*.m ***

% LAPLACE SCALE PARAMETER (b)
b = SD./sqrt(2);
