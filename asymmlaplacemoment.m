function Exn = asymmlaplacemoment(n,m,b1,b2)

% function Exn = asymmlaplacemoment(n,m,b1,b2)
%
%   example call: % EXACTLY EQUALS LAPLACE PDF WHEN k EQUALS 0.0
%                   Exn = asymmlaplacemoment(2,0,1/2,2);
%                    
% nth raw moment of asymmetric laplace distribution
%
% REF: https://en.wikipedia.org/wiki/Asymmetric_Laplace_distribution
% SET l=((1/b1)*(1/b2)) & k=(b1/b2) AND TAKE SQRT OF b1^2 AND b2^2 TERMS 
%
% n:        order of moment
%           n = 1 -> E[x]   = mean
%           n = 2 -> E[x^2] = var(x) - E[x]^2
%           etc.
% m:        location of mode                                                    (default = 0) 
% b1:       expected power (i.e. mean = var) of exponential RV to left  of mode (default = 1)
% b2:       expected power (i.e. mean = var) of exponential RV to right of mode (default = 1)
%           NOTE! k = 1/2 and k = 2 are yield rightward and leftward skews, respectively  
%                 k = 1/3 and k = 3 are yield rightward and leftward skews, respectively 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Exn:     nth raw moment 
%
%               *** see asymmlaplace*.m ***

% INPUT HANDLING
if ~exist('n'    ,'var') || isempty( n)     n     = 1;  end
if ~exist('m'    ,'var') || isempty( m)     m     = 0;  end
if ~exist('l'    ,'var') || isempty( l)     l     = 1;  end
if ~exist('k'    ,'var') || isempty( k)     k     = 1;  end
if ~exist('bPLOT','var') || isempty(bPLOT)  bPLOT = 0;  end
if ~exist('B','var')     || isempty(B)      B     = 61; end

% INPUT CHECKING
if k <= 0, error('asymmlaplaceinv: WARNING! THE ASYMMETRY PARAMETER k MUST BE LARGER THAN 0'); end

if m == 0
    Exn = factorial(n)./( (b1 + b2)/(b1*b2) ).*( sqrt(b1/b2)^(-(n+1)) - ( -sqrt(b1/b2))^((n+1))  );
  % Exn = factorial(n)./( (l^n)*(k + 1/k) ).*( k^(-(n+1)) -( -k)^(n+1)  );
else
    % Exn = ( (l*m^(n+1))/(k+1/k) )*( exp(m*l*k)*genexpint(-n,m*l*k)   - exp(m*l/k)*genexpint(-n,-m*l/k)  );
    error('asymmlaplacemoment: WARNING! still getting debugged for m ~= 0')
end


function v = genexpint(n,x)

% function genexpint(n,x)
%
%   example call: 
%
% generalized exponential integral function
%
% n:    order
% x:    argument
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% v:    value of generalized exp integral func

v = (x^(n-1)).*gammainc( x,1-n,'lower' );