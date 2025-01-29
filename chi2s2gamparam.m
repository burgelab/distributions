function [a,b] = chi2s2gamparam(nu,S,bPLOT)

% function [a,b] = chi2s2gamparam(nu,S,bPLOT)
% 
%   example call: % SQUARED STANDARD NORMAL RANDOM VARIABLE (RV)
%                   [a,b] = chi2s2gamparam(1,1)
%
%                 % SQUARED GAUSS RANDOM VARIABLE WHERE GRV HAS SD=2->VAR=4 
%                   [a,b] = chi2s2gamparam(1,4)
%
%                 % SUM OF 2 SQUARED GAUSS RANDOM VARIABLE W GRV HAS SD=2->VAR=4  
%                   [a,b] = chi2s2gamparam(2,4)
%
% convert scaled chi-squared params to equivalent gamma distribution params
% 
% NOTE! the scaled chi2 distribution is the distribution of a squared 
%       mean zero gaussian random variable with variance S where
%
%                chi2s = S.*chi2
%                chi2s = ( sqrt(S).*randn(100000,1) ).^2
%
% nu:    degrees of freedom of scaled chi-squared random variable
% S:     variance of gaussian random variable that is squared 
%        to yield the scaled chi-squared random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% a:     shape parameter of gamma distribution
% b:     scale parameter of gamma distribution
%
%           *** see gam2chi2sparam.m ***

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if nu < 0 || nu ~= ceil(nu), 
    nu = abs(ceil(nu));   
    disp(['WARNING! chi2s2gamparam.m: Degrees of freedom should be a positive integer. Imposing positive sign and rounding to ', num2str(nu)]); 
end

% CONVERT PARAMS
a = nu/2;
b = 2.*S;    % NOTE: b (scale parameter) is always 2 for gamma equivalent of      a chi-squared-distributed rv
%                %      b (scale parameter) is 2.*S  for gamma equivalent of scaled chi-squared-distributed rv

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% PLOT SCALED CHI2 AGAINST GAMMA %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
if bPLOT
    %% RANDOM SAMPLES
    nSmp = 1000000; 
    xCHI2 = S.*chi2rnd(nu,nSmp,1); 
    xGAM  = gamrnd(a,b,nSmp,1);
    % HISTOGRAMS OF RANDOM SAMPLES
    [Hchi,Bchi]=hist([xCHI2],61); 
    [Hgam Bgam]=hist([xGAM ],61);
    % PDFS
    xplt = linspace(min(Bchi),max(Bchi),1001);
    pdfCHI2 = chi2pdf(xplt./S,nu);
    pdfGAM  = gampdf(xplt,a,b); 
    
    %%%%%%%%%%%%%%
    % PLOT STUFF %
    %%%%%%%%%%%%%%

    figure('position',[199   420   969   378]);

    % QQPLOT OF RANDOM SAMPLES
    subplot(1,3,1); hold on
    qqplot(xCHI2,xGAM);
    formatFigure('Scaled Chi2 Quantiles','Gamma Quantiles','qq plot');
    axis(max(abs(axis)).*[0 1 0 1]);
    axis square; plot(xlim,xlim,'k--')
    
    % CHI2 SAMPLES
    subplot(1,3,2); hold on
    bar(Bchi,Hchi./riemann(Bchi,Hchi),1,'w'); xlims = xlim;
    plot(xplt,pdfCHI2./riemann(xplt,pdfCHI2),'k')
    formatFigure([],[],['Scaled \chi^2_{' num2str(nu) '}: \nu=' num2str(nu) ',\sigma=' num2str(S)]); 
    axis square; xlim(xlims)
    
    % GAMMA SAMPLES
    subplot(1,3,3); hold on 
    bar(Bgam,Hgam./riemann(Bgam,Hgam),1,'w'); xlims = xlim;
    plot(xplt,pdfGAM./riemann(xplt,pdfGAM),'k')
    formatFigure([],[],['Gamma: a=' num2str(a) ',b=' num2str(b)]); 
    axis square; xlim(xlims)
end