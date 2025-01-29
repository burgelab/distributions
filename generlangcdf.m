function p = generlangcdf(x,lambda,bPLOT)

% function p = generlangcdf(x,lambda,bPLOT)
%
%   example call: generlangcdf(linspace(0,10,101),[1 2 3],1)
%
% cumulative distribution function of generalized Erlang probability density
%
% x:       values of x
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [1 x k]
%                                      where k = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale
%          PDF AND CDF HAVE NASTY FORMS FOR MORE THAN THREE RVs
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       cumulative density function
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

% INPUT HANDLING
if ~exist('bPLOT','var') bPLOT = 0; end

k = length(lambda);

% INPUT CHECKING
if k ~= 2 && k~= 3,             error(['generlangcdf.m: WARNING! closed form expressions available only for k = 2 or k == 3... Currently k = ' num2str(k) '! Check inputs!!!']); end
if length(unique(lambda)) == 1, error(['generlangcdf.m: WARNING! lambdas must be different... else generlangpdf -> erlangpdf OR if k = 1 -> exppdf']); end

% COEFFICIENT OF DETERMINATION
c = generlangcv(lambda);


[~,indS] = sort(lambda);
lambda = lambda(flip(indS));

p = generlangpdf(x,lambda);

Z1 = lambda(2)./( lambda(2) - lambda(1) );
Z2 = lambda(1)./( lambda(2) - lambda(1) );

P = 1 - Z1.*( exp(-x.*lambda(1) )  +  Z2.*exp(-x.*lambda(2)) );

if bPLOT == 1
    figure; hold on
    plot(x,p,'k','linewidth',1);
    plot(x,P,'k','linewidth',2);
    % NUMERICAL VALIDATION
    plot(x,cumsum(p).*diff(x(1:2)),'k--')
    formatFigure('X','Probability',['Generalized Erlang cdf: k=' num2str(k) ' \lambda=[' num2str(lambda) ']']);
    axis square; ylim([-0.05 1.05])
end
