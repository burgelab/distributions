function erlangcdf(x,k,lambda,bPLOT)

% function erlangcdf(x,k,lambda,bPLOT)
%
%   example call: erlangpdf(linspace(0,10,101),2,1,1)
%
% the Erlang distribution results from the sum of k independent
% exponentially distributed random variables with lambda parameter
%
% cumulative density function of Erlang distribution
% 
% x:       values of x
% k:       shape (i.e. number of i.i.d. RVs that are being summed)
% lambda:  rate  (i.e. rate or time constant or inverse scale: lambda = 1/Pbar) 
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       cumulative probability

% INPUT HANDLING
if ~exist('bPLOT','var') bPLOT = 0; end

p = erlangpdf(x,k,lambda);

P = gammainc( lambda.*x, k );

if bPLOT == 1
    figure; hold on
    plot(x,p,'k','linewidth',1);
    plot(x,P,'k','linewidth',2);
    % NUMERICAL VALIDATION
    % plot(x,cumsum(p).*diff(x(1:2)),'k--')
    formatFigure('X','Probability',['Erlang cdf: k=' num2str(k) ' \lambda=' num2str(lambda)]);
    axis square;
end
