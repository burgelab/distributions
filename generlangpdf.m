function [p,logp] = generlangpdf(x,lambda,bPLOT,bQUIET,bSYM)

% function [p logp] = generlangpdf(x,lambda,bPLOT,bQUIET,bSYM)
%
%   example call: generlangpdf(linspace(0,10,101),[1 3],1)
%
%                 generlangpdf(linspace(0,10,101),[1 2 3],1)
%
% probability density of generalized Erlang distribution ( or hypoexponential ) 
%
% BACKGROUND: generalized Erlang (or hypoexponential) distribution results 
% from the sum of n independent exponentially distributed random variables 
%                      w/ DIFFERENT lambda parameter
% 
%                  X ~ generlang(lambda1,lambda2,...,lambdak)
%                                    where
%                            X = X1 + X2 + ... + Xk
%                                  and where 
% X1 ~ exppdf(1./lambda1), X2 ~ exppdf(1./lambda2), ..., Xk ~ exppdf(1./lambdak)
%
% NOTE! when n equals 1, the erlangpdf is an exponential pdf
% NOTE! when lambda(1)=...= lambda(n), generlangpdf = erlangpdf
% 
% ONLINE RESOURCES: https://actuarialmodelingtopics.wordpress.com/2016/08/01/the-hyperexponential-and-hypoexponential-distributions/
%                   https://en.wikipedia.org/wiki/Hypoexponential_distribution
% 
% x:       values of x
% n:       shape (i.e. number of i.i.d. RVs that are being summed)        [ scalar ] 
% lambda:  rate of each component exponential RV s.t. mu = 1./lambda      [ 1 x n  ]
%                                      where n = length(lambda) >= 2 
%          NOTE! rate equals the time constant or inverse scale: lambda = 1/E[x] = 1/Pbar 
% bPLOT:   plot or not
%          1 -> plot
%          0 -> not
% bQUIET:  warn users or not that some generlang*.m parameters are invalid
%          if numel(       lambda ) == 1 -->  exponential random variable
%          if numel(unique(lambda)) == 1 -->  erlang      random variable
%          1 -> turn off warnings
%          0 -> don't
% bSYM:    use symbolic computations (if necessary)
%          1 -> do it
%          0 -> don't
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       probability density
% plog:    logged value of probability density... logp = log(p)
%
%  *** FOR RELATED FUNCTIONS TYPE >> ls generlang*.m OR erlang*.m ***


% INPUT HANDLING
if ~exist('bPLOT', 'var') bPLOT  = 0; end
if ~exist('bQUIET','var') bQUIET = 0; end

%%%%%%%%%%%%%%%%%%
% INPUT CHECKING %
%%%%%%%%%%%%%%%%%%
% NUM RANDOM VARIABLES
n    = numel(lambda);
nUnq = numel(unique(lambda));

%%%%%%%%%%%%%%%%%%
% INPUT CHECKING %
%%%%%%%%%%%%%%%%%%
if n == 1, 
    % WARN USER (SUBJECT TO BEING TURNED OFF BY USER)
    if bQUIET == 0
        warning('generlangpdf.m: WARNING! pdf invalid when number of  lambdas = 1. Using exppdf.m!    See comments for explanation... SET bQUIET = 1 TO SILENCE WARNINGS!'); 
    end
    % EXPONENTIAL PDF 
    p = exppdf(x,1./lambda);
elseif nUnq == 1
    % WARN USER (SUBJECT TO BEING TURNED OFF BY USER)
    if bQUIET == 0 
        warning('generlangpdf.m: WARNING! pdf invalid when num unique lambdas = 1. Using erlangpdf.m! See comments for explanation... SET bQUIET = 1 TO SILENCE WARNINGS!');
    end
    % ERLANG PDF
    p = erlangpdf(x,n,unique(lambda));
elseif nUnq < n
    % WARN USER (SUBJECT TO BEING TURNED OFF BY USER)
    if bQUIET == 0 
        warning('generlangpdf.m: WARNING! pdf invalid when all lambdas not unique. Using symbolic functions. Computations will be slow... SET bQUIET = 1 TO SILENCE WARNINGS!');
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%
    % PDF FROM INVERTING CF % % SYMBOLIC FORMS
    %%%%%%%%%%%%%%%%%%%%%%%%%
    syms t w;
    % CHARACTERISTIC FUNCTION (SYMBOLIC FORM)
    cf = @(t) prod(lambda(:)./(lambda(:)-1i.*t),1);
    % CHANGE CONVENTION TO -2*pi AND FOURIER TRANSFORM
    sympref('FourierParameters',[1 -2.*pi]);
    % PDF IN SYMBOLIC FORM (FROM FT OF CF W APPROPRIATE CHANGE OF VARIABLES)           
    f = fourier(cf(2.*pi.*t), w);
    % NUMERIC VALUES OF W
    w = x;
    % PDF IN NUMERIC FORM
    p = double(subs(f));
else
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    % GENERALIZED ERLANG PDF % (HYPOEXPONENTIAL DISTRIBUTION)
    %%%%%%%%%%%%%%%%%%%%%%%%%%
    if  n == 2 % TWO   INDEPENDENT EXPONENTIAL RVs
        % NORMALIZING SCALAR
        Z = (lambda(1).*lambda(2))./( lambda(1) - lambda(2) );
        % PDF
        p = Z.*( exp(-x.*lambda(2))  -  exp(-x.*lambda(1)) );
        % % trying log probability to improve stability
        % logp = log(Z)+(-x.*lambda(2))+log(1-exp(-x.*(lambda(1)-lambda(2))));
        % p = exp(logp);
    elseif n == 3 % THREE INDEPENDENT EXPOENTIAL RVs
        % NORMALIZING SCALARS
        Z1 = prod(lambda)./( ( lambda(2)-lambda(1) ).*( lambda(3)-lambda(1) ) );
        Z2 = prod(lambda)./( ( lambda(1)-lambda(2) ).*( lambda(3)-lambda(2) ) );
        Z3 = prod(lambda)./( ( lambda(1)-lambda(3) ).*( lambda(2)-lambda(3) ) );
        
        % PDF
        p  = Z1.*exp(-lambda(1).*x) + Z2.*exp(-lambda(2).*x) + Z3.*exp(-lambda(3).*x);
    elseif n >= 4 % N INDEPENDENT EXPOENTIAL RVs
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % GENERLANG PDF GENERAL FORM (USING RECURSIVE FORMULAS) %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        p  = zeros(size(x));
        
        % EASY TO READ
        Znum = prod(lambda); 

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES LESS THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % DENOMINATOR OF NORMALIZING CONSTANT FOR NEGATIVE X-VALUES
        for i = 1:length(lambda) 
            for j = 1:length(lambda)
                if   j == i
                    Zden(i,j) = 1;
                elseif j ~= i
                    Zden(i,j) = (lambda(j) - lambda(i));
                end
            end
            % NORMALIZING CONSTANTS FOR NEGATIVE X-VALUES
            Z(i) = Znum./prod(Zden(i,:),2);
            % PDF            
            p = p + Z(i).*exp(-lambda(i).*x);
            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % IF bSYM == 1, USE SYMBOLIC COMPUTATIONS %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % % NORMALIZING CONSTANTS FOR NEGATIVE X-VALUES
            % Zs(i) = sym(Znum)./prod(sym(Zden(i,:)),2);
            % % PDF            
            % ps = ps + Z(i).*exp( sym(-lambda(i)).*sym('y'));
        end
    end
end

%%%%%%%%%%%%%%%%%%%%%%
% PROBLEM MITIGATION %
%%%%%%%%%%%%%%%%%%%%%%
% COUNT NEGATIVE PROBABILITIES (WHICH COULD RESULT FROM NUMERICAL INSTABILITY OR FROM INACCURACIES IN SYMBOLIC TOOLBOX) 
indNeg = p < 0;
nNeg = sum(indNeg);

% WARN ABOUT NEGATIVE PROBABILITIES (IF bQUIET ~= 1)
if bQUIET == 0
    if nNeg > 0
        warning(['generlangpdf: WARNING! ' num2str(nNeg) ' of the x-values yielded NEGATIVE probabilities bc of numerical under/overflow. BE CAREFUL!!!'])
        disp(    'generlangpdf:           WRITE CODE TO DO SYMBOLIC COMPUTATIONS');
    end
end

% FIX NEGATIVE PROBABILITIES 
p(indNeg) = 0;

% SET EXTRA OUTPUTS
if nargout > 1
    % LOG PROBABILITY
    logp = log(p);
end

if bPLOT == 1
    figure; hold on;
    plot(x,p,'k','linewidth',2);
    formatFigure('X','Probability',['Generalized Erlang pdf: \lambda=[' num2str(lambda,'%.2f ') ']']);
    axis square;
    % ylim([-0.05 1.05])
end
