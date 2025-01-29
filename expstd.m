function [SD] = expstd(mu)

% function [SD] = expstd(mu)
%
%   example call: expstd(1)
%
% standard deviation of expontential probability distribution with mean mu
%
% mu:   mean
% %%%%%%%%%%%%%%%%%%%%%%%
% SD:  standard deviation

[MU,VAR] = expstat(mu);

SD = sqrt(VAR);