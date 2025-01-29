function [p,flag]=genchi2cdf_imhof(x,lambda,nu,delta,c,side,tolabs,tolrel,approx)

% function [p,flag]=genchi2cdf_imhof(x,lambda,nu,delta,c,side,tolabs,tolrel,approx)
%   
%   example call:
%
%

% INPUT HANDLING
if ~exist('side','var')   || isempty(side)   side   = 'lower'; end
if ~exist('tolabs','var')                    tolabs =   1e-10; end
if ~exist('tolrel','var')                    tolrel =    1e-6; end
if ~exist('approx','var')                    approx =  'none'; end

flag=false;
u=[]; % pre-allocate in static workspace

if strcmpi(approx,'tail') % compute tail approximations
    j=(1:3)';
    k=sum((lambda.^j).*(j.*delta+nu),2);
    h=k(2)^3/k(3)^2;
    if k(3)>0
        y=(x-c-k(1))*sqrt(h/k(2))+h;
        if strcmpi(side,'lower')
            p=chi2cdf(y,h);
        elseif strcmpi(side,'upper')
            p=1-chi2cdf(y,h,'upper');
        end
    else
        k=sum(((-lambda).^j).*(j.*delta+nu),2);
        y=(-(x-c)-k(1))*sqrt(h/k(2))+h;
        if strcmpi(side,'lower')
            p = chi2cdf(y,h,'upper');
        elseif strcmpi(side,'upper')
            p = 1-chi2cdf(y,h);
        end
    end
    
else
    if ~isempty(tolabs) && ~isempty(tolrel)
        % AREA UNDER CURVE
        area = arrayfun(@(x) integral(@(u) integrand(u,x-c,lambda',nu',delta'),0,inf,'AbsTol',tolabs,'RelTol',tolrel), x);
    else
        syms u
        area = arrayfun(@(x) vpaintegral(@(u) integrand(u,x-c,lambda',nu',delta'),u,0,inf,'AbsTol',tolabs,'RelTol',tolrel,'MaxFunctionCalls',inf), x);
    end
    if strcmpi(side,'lower')
        p=0.5-area/pi;
    elseif strcmpi(side,'upper')
        p=0.5+area/pi;
    end
end
if p<0
    p=0;
    flag=true;
elseif p>1
    p=1;
    flag=true;
end
end

% define the integrand (lambda, nu, delta must be column vectors here)
function area = integrand(u,x,lambda,nu,delta)
    theta=sum(nu(:).*atan(lambda(:)*u)+(delta(:).*(lambda(:)*u))./(1+lambda(:).^2*u.^2),1)/2-u*x/2;
    rho   = prod( ( (1+(lambda(:).^2)*(u.^2)).^(nu(:)/4)).*exp( ( (lambda(:).^2*u.^2).*delta(:))./( 2*( 1+(lambda(:).^2)*(u.^2) ) ) + u.^2*sigma^2/(8.*sum(nu))) ,1);
  % rho   = prod( ( (1+(lambda(:).^2)*(u.^2)).^(nu(:)/4)).*exp( ( (lambda(:).^2*u.^2).*delta(:))./( 2*( 1+(lambda(:).^2)*(u.^2) ) ) + u.^2*sigma^2/8 ) ,1);
    area=sin(theta)./(u.*rho);
end