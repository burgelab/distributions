function [nu,S] = gam2chi2sparam(a,b,bPLOT)

% function [nu,S] = gam2chi2sparam(a,b,bPLOT)
% 
%   example call: % GAMMA SPECIAL CASE: EXPONENTIAL DISTRIBUTION
%                   [nu,S] = gam2chi2sparam(1,2)
%
%                 % GAMMA SPECIAL CASE: CHI2 W. 1 DEG OF FREEDOM
%                   [nu,S] = gam2chi2sparam(4,2)
%
% gamma distribution params to scaled chi2 distribution params
%
% a:     shape parameter of gamma distribution
% b:     scale parameter of gamma distribution
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% nu:    degrees of freedom of chi-squared random variable
% S:     variance of normal random variable that is squared
%        to obtain scaled chi2 distribution
%
%                  *** see chi2s2gamparam.m ***

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if ~exist('a'  ,'var') || isempty(a), error('gam2chi2param.m: WARNING! No shape parameter specified for gamma distribution. Perhaps use a default of a = 1'); end
if ~exist('b'  ,'var') || isempty(b), error('gam2chi2param.m: WARNING! No scale parameter specified for gamma distribution. Perhaps use a default of b = 2'); end

%%%%%%%%%%%%%%%%%%
% CONVERT PARAMS %
%%%%%%%%%%%%%%%%%%
% DEGREES OF FREEDOM
nu    = 2*a; 
% VARIANCE OF GAUSSIAN RV THAT IS SQUARED
S = (b./2);

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
    formatFigure([],[],['Scaled \chi^2_{' num2str(nu) '}: \nu=' num2str(nu) ',S=' num2str(S)]); 
    axis square; xlim(xlims)
    
    % GAMMA SAMPLES
    subplot(1,3,3); hold on 
    bar(Bgam,Hgam./riemann(Bgam,Hgam),1,'w'); xlims = xlim;
    plot(xplt,pdfGAM./riemann(xplt,pdfGAM),'k')
    formatFigure([],[],['Gamma: a=' num2str(a) ',b=' num2str(b)]); 
    axis square; xlim(xlims)
end