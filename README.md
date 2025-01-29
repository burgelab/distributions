# distributions

Matlab m-files for probability distributions that are not included in standard Matlab release packages. M-files are also included to supplement functions associated with distributions that *are* included in standard release packages. For each distribution, functions are available that compute the pdf, cdf, mean, variance, statistical moments, random samples, among others. 

In this repository, the distributions that are represented are: 
Asymmetric Laplace                   (asymmlaplace*.m)
Beta                                 (beta*.m)        SUPP
Binominal                            (bino*.m)        SUPP
Chi-Squared                          (chi2*.m)        SUPP
Chi-Squared Scaled                   (chi2s*.m)
Erlang                               (erlang*.m)
Exponential                          (exp*.m)         SUPP
Exponential minus Generalized Erlang (expminusgenerlang*.m) 
Gamma                                (gam*.m)         SUPP
Generalized Chi-Squared              (genchi2*.m)
Generalized Erlang [same as hypoexp] (generlang*.m) 
Generalized Multivariate Gaussian    (gengauss*.m)
Hypoexponential  [same as generlang] (hypoexp*.m)
Inverse Gamma                        (invgam*.m)      SUPP
Laplace                              (laplace*.m)
Log Normal                           (logn*.m)        SUPP
Non-central Chi-Squared              (nxc2*.m)        SUPP
Non-central Chi-Squared Scaled       (nxc2s*.m)
Uniform                              (uniform*.m)

In this repository, many (but not all) distributions have a functions that compute the associated probability density function (*pdf.m), cumulative distribution function (*cdf.m), mean (*mean.m), median (*median.m), mode (*mode.m), standard deviation (*std.m), variance (*var.m), skew (*skew.m), kurtosis (*kurtosis.m), and routines for computing random samples (*rnd.m). 

Some distributions also have functions for computing arbitrary raw moments (*moment.m), the coefficient of variation (*cv.m), and performing maximum likelihood fits of the distribution's parameters to random samples (*fit.m or *MLEfit.m).

From the Matlab command line, type the distributional identifier (e.g. >> laplace) and then press tab to see all functions associated with a given distribution. 

The comment section describes each function's purpose, the inputs, and the outputs.

For less familiar distributions, the comment section additionally describes the properties of the distribution. For example, for the Generalized Erlang distribution, it reads:

% function [p logp] = generlangpdf(x,lambda,bPLOT,bQUIET,bSYM)
%
%   example call: generlangpdf(linspace(0,10,101),[1 3],1)
%
%                 generlangpdf(linspace(0,10,101),[1 2 3],1)
%
% probability density of generalized Erlang distribution ( or hypoexponential ) 
%
% BACKGROUND: generalized Erlang (or hypoexponential) distribution results 
% from the sum of n independent exponentially distributed random variables 
%                      w/ DIFFERENT lambda parameter
% 
%                  X ~ generlang(lambda1,lambda2,...,lambdak)
%                                    where
%                            X = X1 + X2 + ... + Xk
%                                  and where 
% X1 ~ exppdf(1./lambda1), X2 ~ exppdf(1./lambda2), ..., Xk ~ exppdf(1./lambdak)
%
% NOTE! when n equals 1, the erlangpdf is an exponential pdf
% NOTE! when lambda(1)=...= lambda(n), generlangpdf = erlangpdf
% 
% ONLINE RESOURCES: https://actuarialmodelingtopics.wordpress.com/2016/08/01/the-hyperexponential-and-hypoexponential-distributions/
%                   https://en.wikipedia.org/wiki/Hypoexponential_distribution
% 
% x:       values of x
% n:       shape (i.e. number of i.i.d. RVs that are being summed)        [ scalar ] 
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [ 1 x n  ]
%                                      where n = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale: lambda = 1/E[x] = 1/Pbar 
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
% bQUIET:  warn users or not that some generlang*.m parameters are invalid
%          if numel(       lambda ) == 1 -->  exponential random variable
%          if numel(unique(lambda)) == 1 -->  erlang      random variable
%          1 -> turn off warnings
%          0 -> don't
% bSYM:    use symbolic computations (if necessary)
%          1 -> do it
%          0 -> don't
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       probability density
% plog:    logged value of probability density... logp = log(p)
%
%  *** FOR RELATED FUNCTIONS TYPE >> ls generlang*.m OR erlang*.m ***
