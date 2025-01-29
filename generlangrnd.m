function [X,Xindi] = generlangrnd(nSmp,lambda,bPLOT,B)

% function [X,Xindi] = generlangrnd(nSmp,lambda,bPLOT,B)
%
%    example call: [X,Xindi] = generlangrnd(1000000,[1 2 3],1);       
%                  M = [mean(X) generlangmean([1 2 3])], V = [std(X) generlangstd([1 2 3])], S = [skewness(X) generlangskew([1 2 3])]
%
% random samples of generalized erlang (or hypoexponetial) random variables
% 
% nSmp:    number of samples
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [1 x k]
%                                      where k = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale
%          PDF AND CDF HAVE NASTY FORMS FOR MORE THAN THREE RVs
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
% B:       bins for histogram...
%          number of bins OR [scalar] or vector of bins [ 1 x nBin ]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:     generalized erlang random samples [nSmp x 1]
% Xindi: individual random samples         [nSmp x k]
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
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT =  0; end
if ~exist('B',  'var')   || isempty(B)     B     = 51; end

% INPUT HANDLING
if length(unique(lambda)) == 1, 
    disp('generlangrnd.m: WARNING! lambdas should be different... else generlangpdf -> erlangpdf OR if k = 1 -> exppdf'); 
end

%%%%%%%%%%%%%%%%%%
% RANDOM SAMPLES %
%%%%%%%%%%%%%%%%%%
if nargout <= 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % HARD TO READ, FAST TO COMPUTE %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    X = sum(exprnd(repmat(1./lambda,nSmp,1),nSmp,length(lambda)),2);
elseif nargout > 1
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % EASY TO READ, SLOW TO COMPUTE %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % RANDOM VARIABLES
    Xindi = zeros(nSmp,length(lambda));
    for i = 1:length(lambda)
        Xindi(:,i) = exprnd(1./lambda(i),nSmp,1);
    end
    % GENERALIZED ERLANG RV
    X = sum(Xindi,2);
end

% PLOT STUFF
if bPLOT == 1
    figure; hold on
    % HISTOGRAM RANDODM SAMPLES
    [H B] = hist(X,B);
    % CONVERT TO PROBABILITY 
    P = H./(sum(H.*diff(B(1:2))));
    % PDF
    p = generlangpdf(B,lambda);
    % PLOT HISTOGRAMMED SMAPLES
    bar(B,P,1,'w');
    % PLOT PDF
    plot(B,p,'k','linewidth',2)
    % PRETTIFY IT
    formatFigure('X','Probability',['generlangpdf: \lambda=[' num2str(lambda) ']']);
    axis square;
end
