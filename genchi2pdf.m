function f = genchi2pdf(x,lambda,nu,delta,sigma,c,dx,tolabs,tolrel,bPLOT)

% function f = genchi2pdf(x,lambda,nu,delta,sigma,c,dx,tolabs,tolrel,bPLOT)
%
%   example call: %
%                 nu = 2; x = .1:.1:20; f = genchi2pdf(x,1,nu,0,0,0);  y2 = chi2pdf(x,nu); 
%                 figure; hold on; plot(x,f,'linewidth',4); plot(x,y2,'r--','linewidth',4); 
%
%                 genchi2pdf(-20:.1:20,lambda,nu,delta,sigma,c,[],[],[],1);
%
% pdf of generalized chi-squared distribution computed via 
% differntiation of the cdf using Davies' method from 1973
%
% the generalized chi-squared can be equivalently represented as the 
%   quadratic sum of multi-variate Gaussian random variables 
%                              OR 
%   weighted  sum of non-central chi-squares plus a Gaussian 
%
%     genchi2  =  x'*Q2p*x + Q1p'*x + Q0p  =  z'*Q2*z + Q1'*z + Q0
%         
%       where Q2p, Q1p, Q0p are quad coeffs for arbitrary gaussian x
%         and Q2,  Q1,  Q0  are quad coeffs for standard  gaussian z
%
%                             OR 
% 
%     genchi2  =   lambda(:)'*y  +  sigma.*z  +  c
%     
%       y_i ~ chi2( nu_i, delta_i ) 
%       where nu_i is DOF and delta_i is non-centrality parameter
%       z   ~ normrnd(0,1) 
%       where sigma is a scale parameter
%
% x:        point at which to evaluate pdf                  [ vector ]
% lambda:   coefficients of non-central chi-squares         [ 1 x nDOF ]
% nu:       degrees of freedom of non-central chi-squares   [ 1 x nDOF ]
% delta:    non-centrality parameters (i.e. sum of squares) [ 1 x nDOF ] 
%           of means of non-central chi-squares 
% sigma     scale of normal term
% c:        constant term
% dx:       resolution at which to numerically different the cdf
% tolabs:   absolute error tolerance for cdf computation
% tolrel:   relative error tolerance for cdf computation
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% f:        generalized chi-squared probability density function

% INPUT HANDLING
if ~exist('dx','var')     || isempty(dx)     dx     = 1e-10; end
if ~exist('tolabs','var') || isempty(tolabs) tolabs = 1e-10; end
if ~exist('tolrel','var') || isempty(tolrel) tolrel = 1e-6;  end
if ~exist('bPLOT','var')  || isempty(bPLOT)  bPLOT  = 0;     end

% INPUT CHECKING
if ~exist('x','var') || isempty(x) error(['genchi2pdf: WARNING! x must be defined']); end 
if min(size(x)) > 1 error(['genchi2pdf: WARNING! x must be a vector. size(x)=[' num2str(size(x)) ']']); end

if (sum(nu(:)) == 0 || isempty(nu)) && sigma ~= 0
    % NORMAL DISTRIBUTION (DEGENERATE CASE)
    disp('genchi2pdf: using normpdf.m ...');
    f = normpdf(x,c,sigma);
elseif length(unique(lambda)) == 1 && sigma == 0
    % SCALED NONCENTRAL CHI-SQUARED
    disp('genchi2pdf: using ncx2spdf.m ...');
    disp('            scaled non-central chi2');
    f = ncx2spdf(x-c,sum(nu),sum(delta),unique(lambda));
% elseif sum(nu) <= 3 && sigma == 0 && sum(delta == 0) == numel(delta)
%     disp('genchi2pdf: using genchi2cdf_imhof.m with ''tail'' option ...');
%     % GENERAL CHI-SQUARED (GENERAL CASE)
%     % WEIGHTED SUM OF CENTRAL CHI2 DISTRIBUTIONS
%     % PROBABILITY ON LEFT
%     pL = genchi2cdf_imhof(x-dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'tail');
%     % PROBABILITY ON RIGHT
%     pR = genchi2cdf_imhof(x+dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'tail');
%     % PROBABILITY 
%     f = (pR-pL)./(2.*dx);
else
    disp('genchi2pdf: using genchi2cdf_davies.m ...');
    if sum(nu) <= 3 && sigma == 0
        % dx = 1e-10; tolabs = 1e-10, tolrel = 1e-6;
        dx = 1e-1; tolabs = 0.1e-5, tolrel = 0.1e-5;
%         dx = 1e-1; tolabs = dx./10000, tolrel = dx./10000 
        disp(['genchi2pdf: WARNING! changing tolabs and tolsrel to ' num2str(tolabs,'%g') ' and ' num2str(tolrel,'%g') ]); 
    end
    % PROBABILITY ON LEFT
    [pL] = genchi2cdf(x-dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
    % PROBABILITY ON RIGHT 
    [pR] = genchi2cdf(x+dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
    % PROBABILITY 
    f = (pR-pL)./(2.*dx);
end
% else    %%%%%%%%%%%%%%%%%%%%%%%%
%         %  USE DAVIES METHOD   %
%         %%%%%%%%%%%%%%%%%%%%%%%%
%         % PROBABILITY ON LEFT
%         pL=genchi2cdf(x-dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
%         % PROBABILITY ON RIGHT 
%         pR=genchi2cdf(x+dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
%         
% else
%    % THROW ERROR
%    error(['genchi2pdf: WARNING! unhandled parameters... debug?']);
% end
% elseif sigma ~= 0 || sum(nu(:)) >= 3
%     disp('genchi2pdf: using genchi2cdf.m ...');
%     % PROBABILITY ON RIGHT   
%     pR = genchi2cdf(      x+dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
%     % PROBABILITY ON LEFT
%     pL = genchi2cdf(      x-dx,lambda,nu,delta,sigma,c,[],tolabs,tolrel);
% elseif sum(nu(:)) <= 3 && sigma == 0 % FOR DOF <= 3
%     disp('genchi2pdf: using genchi2cdf_imhof.m with ''tail'' option ...'); 
%     disp('            prediction quality is idiosyncratic with low DOF'); 
%  % if sum(delta == 0) == numel(delta)
%     % FOR CENTRAL CHI2 DISTRIBUTINOS
%     % PROBABILITY ON RIGHT   
%     pR = genchi2cdf_imhof(x+dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'tail');
%     % PROBABILITY ON LEFT
%     pL = genchi2cdf_imhof(x-dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'tail');
 % else
    % FOR NON-CENTRAL CHI2 DISTRIBUTINOS
    % PROBABILITY ON RIGHT   
    % pR = genchi2cdf_imhof(x+dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'none');
    % PROBABILITY ON LEFT
    % pL = genchi2cdf_imhof(x-dx,lambda,nu,delta,      c,'lower',tolabs,tolrel,'none');
 % end
% end


if bPLOT == 1
    %%
   figure;
   plot(x,f,'k','linewidth',2);
   formatFigure('X','Probability',['\lambda=[' num2str(lambda,'%.2f ') '],\nu=[' num2str(nu) '],\delta=[' num2str(delta,'%.2f ') '],\sigma=' num2str(sigma,'%.2f') ',c=' num2str(c,'%.2f') ]); 
   axis square;
end