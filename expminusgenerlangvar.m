function VR = expminusgenerlangvar(lambdaS, lambdaD)
% function VR = expminusgenerlangvar(lambdaS, lambdaD)
%
%   example call: expminusgenerlangvar([1 2 3], [4 5 6])
%
% variance of an exponential minus a generalized Erlang (or hypoexponential) random variable
%
% lambdaS:  rate of the exponential in the sum  (1/E[X])                        [  scalar  ]
% lambdaD:  parameters of generalized erlang RV                                 [  1 x k2  ]
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VR:       variance...  variance of sum and/or difference of independent 
% %         random variables is equal to sum and/or difference of variances
%           
%
% BACKGROUND: the result of an exponentially distributed random variable 
% minus a generalized Erlang (or hypoexponential) random variable (see wikipedia)
% 
%                  X ~ expminusgenerlang(lambdaS,lambdaD)
%                                    where
%                            X = X1 - X2
%                                  and where 
% X1 ~ exppdf(1./lambdaS), X2 ~ generlangpdf(lambdaD), lambdaD = [l1,...,lk]

VR = sum(1./(lambdaS.^2)) + sum(1./(lambdaD.^2));