function MU = expminusgenerlangmean(lambdaS, lambdaD)
% function MU = expminusgenerlangmean(lambdaS, lambdaD)
%
%   example call: expminusgenerlangmean([1 2 3], [4 5 6])
%
% mean of an exponential minus a generalized Erlang (or hypoexponential) random variable
%
% lambdaS:  rate of the exponential in the sum  (1/E[X])                    [  scalar  ]
% lambdaD:  parameters of generalized erlang RV                             [  1 x k2  ]
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MU:      mean... the mean of a sum and/or difference of independent
% %        independent RVs is equal to sum and/or difference of means
%
% BACKGROUND: the result of and exponentially distributed random variable 
% minus a generalized Erlang (or hypoexponential) random variable (see wikipedia)
% 
%                  X ~ expminusgenerlang(lambdaS,lambdaD)
%                                    where
%                                 X = X1 - X2
%                                  and where 
% X1 ~ exppdf(1./lambdaS), X2 ~ generlangpdf(lambdaD), lambdaD = [l1,...,lk]

MU = sum(1./lambdaS) - sum(1./lambdaD);