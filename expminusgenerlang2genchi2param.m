function [lambda,nu,delta,sigma,c] = expminusgenerlang2genchi2param(lambdaS,lambdaD,bCHECK)

% function [lambda,nu,delta,sigma,c] = expminusgenerlang2genchi2param(lambdaS,lambdaD,bCHECK)
% 
%   example call: [lambda,nu,delta,sigma,c] = expminusgenerlang2genchi2param(1,[2 3],1)
%
% convert parameters of exponential minus generlang pdf to genchi2pdf parameters 
%
% lambdaS:  rate  of exponential RV in sum
% lambdaD:  rates of exponential RV in difference
% bCHECK:   check accuracy or not
%           1 -> check
%           0 -> don't
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     standard deviation of normal term
% c:        constant term

% NON-CENTRAL COEFFICIENTS (EXP TO CHI2 CONVERSION)
lambda = 0.5./[lambdaS(:)' -lambdaD(:)'];
% DEGREES OF FREEDOM OF EACH COMPONENT EXPONENTIAL RANDOM VARIABLE
nu    = 2.*ones(1,numel([lambdaS(:)' lambdaD(:)']));
% NON-CENTRALITY PARAMETER 
delta =   zeros(1,numel([lambdaS(:)' lambdaD(:)']));
% STANDARD DEVIATION OF NORMAL TERM
sigma = 0;
% CONSTANT TERM
c     = 0;

if bCHECK == 1
    x = linspace(-10,10,1001);
    % EXP MINUS GENERLANG
    pIn  = expminusgenerlangpdf(x,lambdaS,lambdaD);
    % GENERLIZED CHI2
    pOut = genchi2pdf(x,lambda,nu,delta,sigma,c);
    
    %%%%%%%%%%%%%%
    % PLOT STUFF %
    %%%%%%%%%%%%%%
    figure('position',[  158         231        1347         660]) 
    subplot(1,2,1); hold on;
    % PLOT PDFS ON TOP OF EACH OTHER
    plot(x,pIn,'b','linewidth',4)
    plot(x,pOut,'r--','linewidth',2)
    formatFigure('X','Probability');
    axis square;
    ylim([min(ylim) max(ylim)*1.25])
    legend({'Exp-GenErlang','GenChi2'},'location','northwest');
    
    % PLOT PROBABILITIES AGAINST EACH OTHER
    subplot(1,2,2); hold on;
    plot(pIn,pOut,'ko','linewidth',0.5,'markersize',8,'markerface','w');
    formatFigure('Exp-GenErlang','GenChi2');
    set(gca,'xscale','log'); 
    set(gca,'yscale','log'); 
    ylim(xlim);
    plot(xlim,xlim,'k--')
    axis square;
end