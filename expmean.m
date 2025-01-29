function [MU] = expmean(mu)

% function [MU] = expmean(mu)
%
%   example call: expmean(1)
%
% mean of expontential probability distribution with mean mu
%
% mu:   mean
% %%%%%%%%%%%%
% MU:   mean... MU = mu (duh!)

[MU,VAR] = expstat(mu);