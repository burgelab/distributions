function X = invgamrnd(a,b,nSmp,bPLOT)

% function X = invgamrnd(a,b,nSmp,bPLOT)
%
%   example call: X = invgamrnd(3,1,1000,1);
%
% random samples from the inverse gamma distribution function 
% 
% a:    shape parameter
% b:    scale parameter
% nSmp: number of samples
%%%%%%%%%%%%%%%%%
% X:    random samples

% INPUT HANDLING
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if a <= 0 || b <= 0, error(['invgamvar: WARNING! invalid parameters a=' num2str(a) ',b=' num2str(b) '. Both must be greater than 0']); end

% UNIFORM RANDOM SAMPLES
U = rand(nSmp,1);

% INVERSE GAMMA PDF SAMPLES
X = invgaminv(U,a,b,0);

if bPLOT
    figure; hold on;
	Qlohi = quantile(X,[.005 .995]);
    % INV GAMMA FIT PDF
    Xpdf = linspace(Qlohi(1),Qlohi(2),1001);
    PDF  = invgampdf(Xpdf,a,b);
    % BINS
    B    = linspace(Qlohi(1),Qlohi(2),31);
    % HISTOGRAM
    H    = hist(X,B);
    % PLOT (SCALED HISTOGRAMMED DATA DATA
    bar(B(1:end-1),max(PDF).*H(1:end-1)./max(H),1,'w');
    plot(Xpdf,PDF,'k');
    formatFigure('X','Probability',['Inverse Gamma Fit; aFit=' num2str(a) ', bFit=' num2str(b)]);
    axis square
end