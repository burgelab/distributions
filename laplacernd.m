function X = laplacernd(mu,b,Xsz,bPLOT)

% function X = laplacernd(mu,b,Xsz,bPLOT)
%
%   example call: % LAPLACE RANDOM VARIABLE WITH SCALE = 1.0
%                 laplacernd(0,1,10000,1);
%
%                 % LAPLACE RANDOM VARIABLE WITH SCALE SUCH THAT SD = 1.0
%                 laplacernd(0,laplacestd2b(1),10000,1);
%
% random samples from the laplace distribution with mean mu and scale b
%
% mu:    mean  parameter    (default = 0)
% b:     scale parameter    (default = 1)
% Xsz:   size of matrix of random samples  [ nSmp x nCol ] 
%        NOTE! if isscalar(Xsz) == 1 -->   [ nSmp x 1 ]
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:     random samples from laplace distribution
%
%               *** see laplace*.m ***

% INPUT HANDLING
if ~exist('mu'   ,'var') || isempty(mu)    mu    = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if isempty( Xsz) Xsz = 1;       end
if isscalar(Xsz) Xsz = [Xsz 1]; end

% UNIFORM RANDOM SAMPLES ON [0 1)
% U = rand(Xsz);

% LAPLACE RANDOM SAMPLES BY PUSHING UNIFORM SAMPLES THROUGH INVERSE CDF
% X = laplaceinv(U,mu,b);

% ALTERNATE METHOD 1: DIFFERENCE OF EXPONENTIAL RANDOM VARIABLES
X = mu + exprnd(1./b,Xsz) - exprnd(1./b,Xsz);

% ALTERNATE METHOD 2: EXPONENTIAL SCALE MIXTURE OF NORMAL RANDOM VARIABLE
% refs: see Iyer & Burge (2019) for relevant expression
% X = ???;

% PLOT
if bPLOT
    figure;  hold on;
    [H B]=hist(X,51); 
    P = H./sum(H.*diff(B(1:2)));
    plot(B,laplacepdf(B,mu,b),'k','linewidth',2);
    bar(B,P,1,'w');
    formatFigure('X','Probability',['Laplace Samples: \mu=' num2str(mu) ',b=' num2str(b,'%.2f')]);
    axis square;
    xlim(min(abs(xlim)).*[-1 1])
end