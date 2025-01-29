function X2 = genchi2rndParams(nSmp,lambda,nu,delta,sigma,c,bPLOT)

% function X2 = genchi2rndParams(nSmp,lambda,nu,delta,sigma,c,bPLOT)
%   
%   example call:  [lambda,nu,delta,sigma,c] = genchi2mvnpdf2params([0 0],diag([1 1/10]));
%                  genchi2rndParams(10000,lambda,nu,delta,sigma,c,1);
%
% generate random samples from generalized chi2 random variable associated
% with arbitrary quadratic combination of a n-d gaussian random variable
%
% the generalized chi-squared can be equivalently represented as the 
%     quadratic sum of multi-variate Gaussian random variables 
%
%   genchi2  =  x'*Q2p*x + Q1p'*x + Q0p  =  z'*Q2*z + Q1'*z + Q0    
%
%       where Q2p, Q1p, Q0p are quad coeffs for    arbitrary    x
%         and Q2,  Q1,  Q0  are quad coeffs for standard normal x
%
%                              OR AS THE
%
%      weighted  sum of non-central chi-squares plus a Gaussian  
%
%          genchi2  =   lambda(:)'*y(:)  +  sigma.*z  +  c
%     
%        where y_i ~ chi2( nu_i, delta_i ) is non-central chi2
%       where nu_i is DOF, delta_i is non-centrality parameter,
%     z ~ N(0,1), sigma is standard deviation, and c is a constant
% 
% nSmp:     number of random samples
% MU:       mean of target n-d gaussian random variable    [ 1    x nDim ]
% COV:      cov  of target n-d gaussian random variable    [ 1    x nDim ]
% MU1:      mean vector of       multivariate Gaussian 1   [ 1    x nDim ]
% COV1:     covariance matrix of multivariate Gaussian 1   [ nDim x nDim ]
% MU2:      mean vector of       multivariate Gaussian 2   [ 1    x nDim ]
% COV2:     covariance matrix of multivariate Gaussian 2   [ nDim x nDim ]
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X2:       generalized chi2 random samples

% INPUT HANDLING


% GAUSSIAN RANDOM SAMPLES
Y = ncx2rnd(repmat(nu,nSmp,1),repmat(delta,nSmp,1),nSmp,size(nu,2));

% GENCHI2 PARAMETERS
X2 = Y*lambda(:) + sigma.*randn(nSmp,1) + c;

% PREDICTED MEANS AND VARIANCES
MU = genchi2mean(lambda,nu,delta,sigma,c);
SD = genchi2std(lambda,nu,delta,sigma,c);

% PLOT
if bPLOT == 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % COMPUTE STUFF FOR PLOTTING %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % NUMBER OF STANDARD DEVIATIONS TO EXTEND
    nS = 5;
    % BINS
    Bsmp = linspace(MU-nS.*SD,MU+nS.*SD,81);
    Bpdf = linspace(MU-nS.*SD,MU+nS.*SD,2.*numel(Bsmp));
    % GENCHI2PDF
    fGCH = genchi2pdf(Bpdf,lambda,nu,delta,sigma,c,1e-8,1e-8,1e-8);
    % GAUSSPDF
    fGSS = normpdf(Bpdf,MU,SD);

    % FIGURE
    figure('position',[ 679   411   878   413]);
    for i = 1:2
        % SELECT SUBPLOT
        subplot(1,2,i);
        % PLOT PROBABILITY HISTOGRAMS (EXACT SAMPLES FROM GENCHI2)
        [P]=histprob(X2,Bsmp,0,1,gcf); hold on;
        plot(Bpdf,fGCH,'k','linewidth',2);
        % ANALYTIC GAUSSIAN APPROXIMATION
        plot(Bpdf,fGSS,'k','linewidth',1);
        % MAKE IT PRETTY
        if i == 1
            formatFigure('Random Sample','Probability',['Gen \chi^2: \mu=' num2str(MU,'%.2f') ' \sigma=' num2str(SD,'%.2f')]);
            legend('Data','Gen\chi^2','Gauss')
        elseif i == 2
            formatFigure('Random Sample',[],[]);
            set(gca,'yscale','log')
            ylim([min(fGCH) max(ylim)]);
        end
        axis square;
    end
end