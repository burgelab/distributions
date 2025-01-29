function [aFit,bFit] = betafitplot(X,bPLOT,CIsz)

% function [aFit,bFit] = betafitplot(X,bPLOT,CIsz)
%
%   example call: % BETA FIT
%                   [aFit,bFit] = betafitplot( betarnd(0.5,0.5,1000000,1),1);
%
%                 % BETA FIT
%                   U       = uniformrnd(-pi,pi,100000));
%                   [aFit,bFit] = betafitplot( (sin(U+1)/2,1 );
%
% fit parameters of betama distribution to samples of random variable 
% via maximum likelihood estimation (MLE) and plot the results
%
% NOTE! beta dstb results from projection onto unit vector of random sample
%       on the N-dimensional hypersphere /Papers/LuLuiHand_BICC_2018.pdf
%
%       Nd = 2  -> a=b=0.5
%       Nd = 3  -> a=b=1.0
%       etc.
%
% IMPORTANT PARAMETER VALUES
%       a=b=0.5 -> arcsin    dstb: sin(U) where U is uniform on [-pi pi]
%       a=b=1.0 -> uniform   dstb
%       a=b=2.0 -> parabolic dstb
%
% X:     samples of random variable
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
% CIsz:  confidence interval size
%        99 -> 99% confidence interval (default)
%        95 -> 95% confidence interval
%        90 -> 90% confidence interval
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% aFit:  beta shape parameter #1
% bFit:  beta shape parameter #2

if ~exist('CIsz','var')  || isempty(CIsz)  CIsz  = 99; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0;  end

% FIT PARAMETERS
[paramFit] = betafit(X);

% SHAPE (a) AND SHAPE (b) PARAMETER
aFit = paramFit(1);
bFit = paramFit(2);

if bPLOT
    if exist('gca','var') 
    hold on;
    else
    figure; hold on;
    end
    CIlim = [ (1-CIsz/100)./2  1-(1-CIsz/100)./2];
 	Qlohi = quantile(X,CIlim);
    % INV BETA FIT PDF
    xFit = linspace(Qlohi(1),Qlohi(2),1001);
    pFit = betapdf(xFit,aFit,bFit);
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),41);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1), H(1:end-1)./riemann(B,H),1,'w')
    plot(xFit,pFit./riemann(xFit,pFit),'k');
    % FORMAT STUFF
    formatFigure('X','Probability',['Beta Fit; aFit=' num2str(aFit) ', bFit=' num2str(bFit)]);
    axis square
    xlim([0 1]);
end

