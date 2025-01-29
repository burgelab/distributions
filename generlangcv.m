function CV = generlangcv(lambda)

% function CV = generlangcv(lambda)
%
%   example call: generlangcv([1 2 3])
%
% coefficient of variation of generalized erlang (CV = SD/MU) 
% 
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [1 x k]
%                                      where k = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale
%          PDF AND CDF HAVE NASTY FORMS FOR MORE THAN THREE RVs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% CV:      coefficient of variation
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


% INPUT CHECKING
if length(unique(lambda)) == 1, error(['generlangcv.m: WARNING! lambdas must be different... else generlangpdf -> erlangpdf']); end

% STANDARD DEVIATION
SD = generlangstd(lambda);
% MEAN  
MU = generlangmean(lambda);

% COEFFICIENT OF VARIATION
CV = SD./MU;

% THE SQUARE OF THE COEFFICIENT OF DETERIMINATION 
% IS CONSTRAINED TO LIE ON THE INTERVAL [0.5 1.0]
if CV^2 < 0.5 || CV^2 > 1
    disp(['generlangcv.m: WARNING! CV^2 = ' num2str(CV^2) ', which is not on [0.5 1.0]'])
end