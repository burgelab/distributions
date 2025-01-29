function P = laplaceasymmcdf(x,m,l,k,bPLOT)

% function P = laplaceasymmcdf(x,m,l,k,bPLOT)
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   P = laplaceasymmcdf(linspace(-10,10,101),0,1,1/2,1);
%                 
%                 % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0 WHERE b = 1/k 
%                   P = laplaceasymmcdf(linspace(-10,10,101),0,  1,1,1);
%                   P = laplacecdf(     linspace(-10,10,101),0,  1,1);
%                    
% cumulative distribution function for asymmetric laplace distribution
%
% x:      values of x 
% m:      location                                                        (default = 0) 
% l:      scale     param... analog to inverse power in exponential dstb  (default = 1)
% k:      asymmetry param... analog to inverse power in exponential dstb  (default = 1)
%         NOTE! k = 1/2 and k = 2 are yield rightward and leftward skews, respectively  
%               k = 1/3 and k = 3 are yield rightward and leftward skews, respectively 
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P:      cumulative distribution function
%
%               *** see laplaceasymm*.m ***

% INPUT HANDLING
if ~exist('m'   ,'var')  || isempty( m)    m     = 0; end
if ~exist('l'    ,'var') || isempty( l)    l     = 1; end
if ~exist('k'    ,'var') || isempty( k)    k     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if k <= 0, error('laplaceasymmpdf: WARNING! THE ASYMMETRY PARAMETER k MUST BE LARGER THAN 0'); end

% INDICES LESS THAN MEAN
indLT = find(x <= m);
% INDICES MORE THAN MEAN
indGT = find(x >  m);

% CDF FOR INDICES LESS THAN MEAN
P(indLT) =     (k^2./(1 + k^2)).*exp( (l/k).*(x(indLT)-m) );
% CDF FOR INDICES MORE THAN MEAN
P(indGT) = 1 - (  1./(1 + k^2)).*exp(-(l*k).*(x(indGT)-m) );

[(k^2./(1 + k^2)); 1 - (  1./(1 + k^2))]
if bPLOT
   figure; hold on;
   plot(x,P,'k','linewidth',2);
   plot(x, cumsum( laplaceasymmpdf(x,m,l,k).*diff(x(1:2)) ),'b--','linewidth',4);
   formatFigure('X','Probability',['m=' num2str(m) ' \lambda=' num2str(l) ' \kappa=' num2str(k)]); 
   axis square;
end
