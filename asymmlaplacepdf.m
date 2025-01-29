function [p, logp] = asymmlaplacepdf(x,m,b1,b2,bPLOT)

% function [p logp] = asymmlaplacepdf(x,m,b1,b2,bPLOT)
%
%   example call: % ASYMMETRIC LAPLACE
%                   p = asymmlaplacepdf(linspace(-10,10,101),0,1/2,2,1);
%                 
%                 % EXACTLY EQUALS LAPLACE PDF WHEN b1=b2 EQUALS 0.0
%                   p = asymmlaplacepdf(linspace(-10,10,101),0,2,2,1);
%                   p = laplacepdf(     linspace(-10,10,101),0,2,1);
%                    
% probability density function for asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%
% x:      values of x 
% m:      location of mode                                                    (default = 0) 
% b1:     expected power (i.e. mean = var) of exponential RV to left  of mode (default = 1)
% b2:     expected power (i.e. mean = var) of exponential RV to right of mode (default = 1)
%         NOTE! b1 = 1/2 and b2 = 2   yields a rightward skew
%         NOTE! b1 = 2   and b2 = 1/2 yields a leftward  skew
% bPLOT:  plot or not
%         1 -> plot
%         0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:     probability 
% logp:  log probability
%
%               *** see laplaceasymm*.m ***

% INPUT HANDLING
% if ~exist('m'   ,'var')   || isempty( m)    m      = 0; end
% if ~exist('b1'    ,'var') || isempty( b1)   b1     = 1; end
% if ~exist('b2'    ,'var') || isempty( b2)   b2     = 1; end
if ~exist('bPLOT','var')  || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if ~isscalar(m)  error('asymmlaplacepdf: WARNING! PARAMETER m   MUST BE A SCALAR! CHECK INPUTS!!!'); end
if ~isscalar(b1) error('asymmlaplacepdf: WARNING! PARAMETER b1  MUST BE A SCALAR! CHECK INPUTS!!!'); end
if ~isscalar(b2) error('asymmlaplacepdf: WARNING! PARAMETER b2  MUST BE A SCALAR! CHECK INPUTS!!!'); end
if b1 <= 0,      error('asymmlaplacepdf: WARNING! PARAMETER b1  MUST BE LARGER THAN 0'); end
if b2 <= 0,      error('asymmlaplacepdf: WARNING! PARAMETER b2  MUST BE LARGER THAN 0'); end

% INDICES LESS THAN MODE
indLT = ((x-m) <  0);
% INDICES MORE THAN MODE
indGT = ((x-m) >= 0);

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % EASIER TO READ... LESS STABLE TO COMPUTE %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % ASYMMETRIC LAPLACE PDF FOR VALUES LESS THAN MODE
% p(indLT,1) = ( 1./(b1 + b2) ).*exp( +(1./b1).*(x(indLT)-m) );
% % ASYMMETRIC LAPLACE PDF FOR VALUES MORE THAN MODE
% p(indGT,1) = ( 1./(b1 + b2) ).*exp( -(1./b2).*(x(indGT)-m) );

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% HARDER TO READ... MORE STABLE TO COMPUTE %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% LOG ASYMMETRIC LAPLACE PDF FOR VALUES LESS THAN MODE
logp(indLT,1) = -log( b1 + b2 )  +(1./b1).*(x(indLT)-m) ;
% LOG ASYMMETRIC LAPLACE PDF FOR VALUES MORE THAN MODE
logp(indGT,1) = -log( b1 + b2 )  -(1./b2).*(x(indGT)-m) ;

% PROBABILITY
p = exp(logp);

if bPLOT
   figure; 
   plot(x,p,'k','linewidth',2);
   formatFigure('X','Probability',['m=' num2str(m) ' b1=' num2str(b1) ' b2=' num2str(b2)]); 
   axis square;
end
