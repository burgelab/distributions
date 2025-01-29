function [MU] = expmedian(mu)

% function [MU] = expmedian(mu)
%
%   example call: expmedian(1)
%
% median of expontential probability distribution with mean mu
%
% mu:   mean
% %%%%%%%%%%%%
% MD:   mode

MD = log(2).*mu;