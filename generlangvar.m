function VR = generlangvar(lambda)

% function VR = generlangvar(lambda)
%
%   example call: generlangvar([1 2 3])
%
% variance of generalized Erlang (or hypoexponential) random variables
% 
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [1 x k]
%                                      where k = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale
%          PDF AND CDF HAVE NASTY FORMS FOR MORE THAN THREE RVs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% VR:      variance
%
% BACKGROUND: generalized Erlang (or hypoexponential) distribution results 
% from the sum of k independent exponentially distributed random variables 
%                      w/ DIFFERENT lambda parameter
% 
%                  X ~ generlang(lambda1,lambda2,...,lambdak)
%                                    where
%                            X = X1 + X2 + ... + Xk
%                                  and where 
% X1 ~ exppdf(1./lambda1), X2 ~ exppdf(1./lambda2), ..., Xk ~ exppdf(1./lambdak)
%
% NOTE! current implementation handles the sum of only two or three exp RVs
%             because there is no simple closed form expression
%                        for the more general form
%
% NOTE! when k equals 1, the erlangpdf is an exponential pdf
% NOTE! when lambda(1)=...= lambda(k), generlangpdf = erlangpdf
%
%  *** FOR RELATED FUNCTIONS TYPE >> ls generlang*.m AND erlang*.m ***

if length(unique(lambda)) == 1, error(['generlangvar.m: WARNING! lambdas must be different... else generlangpdf -> erlangpdf OR if k = 1 -> exppdf']); end

VR = sum(1./lambda.^2);