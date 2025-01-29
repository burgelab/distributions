function p = erlangpdf(x,k,lambda,bPLOT)

% function p = erlangpdf(x,k,lambda,bPLOT)
%
%   example call: erlangpdf(linspace(0,10,101),2,1,1)
%
%     the     Erlang                     distribution results 
% from the sum of k i.i.d. exponentially distributed random 
% variables with the SAME lambda parameter
%
% NOTE! when k equals 1, the erlangpdf is an exponential pdf
%
% probability density of Erlang distribution
% 
% x:       values of x                                              [ 1 x n  ]        
% k:       shape (number of i.i.d. RVs being summed)                [ scalar ]    
% lambda:  scale (rate OR time constant OR inverse expected value   [ scalar ]    
%          of each component random variable s.t. lambda = 1/Pmu)
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       probability density

% INPUT HANDLING
if ~exist('bPLOT','var') bPLOT = 0; end

p = (lambda.^k).*x.^(k-1).*exp(-lambda.*x)./factorial(k-1);

if bPLOT == 1
    figure;
    plot(x,p,'k','linewidth',2);
    formatFigure('X','Probability',['Erlang pdf: k=' num2str(k) ' \lambda=' num2str(lambda)]);
    axis square;
end
