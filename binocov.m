function C = binocov(pX,pY,N,bPLOT)

% function C = binocov(pX,pY,N,bPLOT)
%
%   example call: binocov(.25,.5,100,1);
%
% computes covaraince between binomial random variables
%
% pX:   probability of X
% pY:   probability of Y
% N:    number of observations

if length(pX) ~= 1 || length(pY) ~= 1
   error('binocov: WARNING! input variables must be scalars');
end
%%
pdfX = binopdf(1:N,N,pX);
pdfY = binopdf(1:N,N,pY);
C = pdfY'*pdfX - pX.*pY;

if bPLOT
   figure; 
   imagesc(1:N,1:N,C);
   formatFigure('X','Y',['pX=' num2str(pX,'%.2f') ', pY=' num2str(pY,'%.2f')]);
   axis square
   axis xy
   set(gca,'ytick',get(gca,'xtick')) 
end