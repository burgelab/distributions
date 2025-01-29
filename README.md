# distributions

This respository contians Matlab m-files for probability distributions that are not included in standard Matlab release packages. M-files are also included to supplement functions associated with distributions that *are* included in standard release packages. For each distribution, functions are available that compute the pdf, cdf, mean, variance, statistical moments, random samples, among others. 

In this repository, the distributions that are represented are: 
Asymmetric Laplace                   (asymmlaplace*.m)      <br />
Beta                                 (beta*.m)        SUPP  <br />
Binominal                            (bino*.m)        SUPP  <br />
Chi-Squared                          (chi2*.m)        SUPP  <br />
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

In this repository, many (but not all) distributions have a functions that compute the associated probability density function (*pdf.m), cumulative distribution function (*cdf.m), inverse cdf (*inv.m), mean (*mean.m), median (*median.m), mode (*mode.m), standard deviation (*std.m), variance (*var.m), skew (*skew.m), kurtosis (*kurtosis.m), and routines for computing random samples (*rnd.m). 

Some distributions also have functions for computing arbitrary raw moments (*moment.m), the coefficient of variation (*cv.m), and performing maximum likelihood fits of the distribution's parameters to random samples (*fit.m or *MLEfit.m).

From the Matlab command line, type the distributional identifier (e.g. >> laplace) and then press tab to see all functions associated with a given distribution. 

The comment section describes each function's purpose, the inputs, and the outputs. In some cases, for less familiar distributions, it additionally describes the properties of the distribution. 

