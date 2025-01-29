function P = asymmlaplacecdf(x,m,b1,b2,bPLOT)

% function P = asymmlaplacecdf(x,m,b1,b2,bPLOT) 
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   P = asymmlaplacecdf(linspace(-10,10,101),0,1/2,2,1);
%                 
%                 % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0 WHERE b = 1/k 
%                   P = asymmlaplacecdf(linspace(-10,10,101),0,  1,1,1);
%                   P = laplacecdf(     linspace(-10,10,101),0,  1,1);
%                    
% cumulative distribution function for asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%      
% x:      values of x 
% m:      location of mode                                                    (default = 0) 
% b1:     expected power (i.e. mean = var) of 1st exponential random variable (default = 1)
% b2:     expected power (i.e. mean = var) of 2nd exponential random variable (default = 1)
%         NOTE! b1 = 1/2 and b2 =   2 yields rightward skew
%         NOTE! b1 =   2 and b2 = 1/2 yields leftward  skew
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% P:      cumulative distribution function
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if ~exist('m'   ,'var')   || isempty( m)    m      = 0; end
if ~exist('b1'    ,'var') || isempty( b1)   b1     = 1; end
if ~exist('b2'    ,'var') || isempty( b2)   b2     = 1; end
if ~exist('bPLOT','var')  || isempty(bPLOT) bPLOT  = 0; end

% INPUT CHECKING
if ~isscalar(m)  error('asymmlaplacepdf: WARNING! PARAMETER m   MUST BE A SCALAR! CHECK INPUTS!!!'); end
if ~isscalar(b1) error('asymmlaplacepdf: WARNING! PARAMETER b1  MUST BE A SCALAR! CHECK INPUTS!!!'); end
if ~isscalar(b2) error('asymmlaplacepdf: WARNING! PARAMETER b2  MUST BE A SCALAR! CHECK INPUTS!!!'); end
if b1 <= 0,      error('asymmlaplacepdf: WARNING! PARAMETER b1 MUST BE LARGER THAN 0'); end
if b2 <= 0,      error('asymmlaplacepdf: WARNING! PARAMETER b2 MUST BE LARGER THAN 0'); end


% INDICES LESS THAN MODE
indLT = ( (x-m) < 0 );
% INDICES MORE THAN MODE
indGT = ( (x-m) >= 0 );

% CDF FOR INDICES LESS THAN MEAN
P(indLT) =     (b1/(b1 + b2)).*exp( (1/b1).*(x(indLT)-m) );
% CDF FOR INDICES MORE THAN MEAN
P(indGT) = 1 - (b2/(b1 + b2)).*exp(-(1/b2).*(x(indGT)-m) );

if bPLOT
    %%
   figure; hold on
   plot(x,P,'k','linewidth',2);
   % UNCOMMENT TO PLOT RIEMANN SUM OF PDF
   % plot(x,cumsum( asymmlaplacepdf(x,m,b1,b2).*diff(x(1:2)) ),'b--','linewidth',4);
   formatFigure('X','Probability',['m=' num2str(m) ' b1=' num2str(b1) ' b2=' num2str(b2)]); 
   axis square;
end
