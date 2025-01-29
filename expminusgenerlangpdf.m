function [p] = expminusgenerlangpdf(x, lambdaS, lambdaD, bPLOT, bQUIET)

% function [p] = expminusgenerlangpdf(x, lambdaS, lambdaD, bPLOT, bQUIET)
%
%   example call: x = linspace(-15,15,1000);
%                 expminusgenerlangpdf(x, 1, [2 3], 1);
%
% probability density of an exponential random variable 
% minus a generalized erlang random variable
%
% x:        values of x
% lambdaS:  rate of the exponential RV s.t. mu = 1./lambda            [  scalar  ]
% lambdaD:  parameters of generalized erlang RV                       [  1 x kD   ]
%
% NOTE! lambdaD must be row vector
%
% bPLOT:    plot or not
%           1 -> plot
%           0 -> not
% bQUIET:   warn users or not (about?)
%           1 -> turn off warnings
%           0 -> don't
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% p:       probability density
%
% ONLINE RESOURCE: https://en.wikipedia.org/wiki/Hypoexponential_distribution
%
% BACKGROUND: the result of and exponentially distributed random variable 
% minus a generalized Erlang (or hypoexponential) random variable (see wikipedia)
% 
%                  X ~ expminusgenerlang(lambdaS,lambdaD)
%                                    where
%                            X = X1 - X2
%                                  and where 
% X1 ~ exppdf(1./lambdaS), X2 ~ generlangpdf(lambdaD), lambdaD = [l1,...,lk]

% INPUT HANDLING
if ~exist('bPLOT', 'var') bPLOT  = 0; end
if ~exist('bQUIET','var') bQUIET = 0; end

%%%%%%%%%%%%%%%%%%
% INPUT CHECKING %
%%%%%%%%%%%%%%%%%%
% SIZES OF PARAMETERS
kS    = numel(lambdaS);
kD    = numel(lambdaD);
kDunq = numel(unique(lambdaD));

%%%%%%%%%%%%%%%%%%
% INPUT CHECKING %
%%%%%%%%%%%%%%%%%%
if kS ~= 1
    if bQUIET == 0
        warning('expminusgenerlangpdf.m: WARNING! expminusgenerlangpdf invalid when lambdaS is NOT a scalar. Using generlangminusgenerlangpdf.m! See comments for explanation... SET bQUIET = 1 TO SILENCE WARNINGS!')
    end
end

% X-INDICES LESS THAN AND MORE THAN ZERO
indLT = x <  0;
indGT = x >= 0;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% EXPONENTIAL MINUS GENERALIZED ERLANG PDF %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if kD == 1
    if bQUIET == 0
        warning('expminusgenerlangpdf.m: WARNING! expminusgenerlangpdf invalid when lambdaD is a scalar. Using asymmlaplace.m! See comments for explanation... SET bQUIET = 1 TO SILENCE WARNINGS!')
    end
    [p] = asymmlaplacepdf(x,0,1./lambdaD,1./lambdaS);
end

if kD == 2 % HARD CODED FOR GENERLANG COMPONENT WITH DOF = 2
    if kDunq == 2
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES LESS THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING SCALAR OF GENERALIZED ERLANG COMPONENT
        Zn       = (lambdaD(1).*lambdaD(2))./( lambdaD(1) - lambdaD(2) );
        % EXTRA NORMALIZING TERMS FOR EXP MINUS GEN ERLANG
        Zn1      = (lambdaS./(lambdaS+lambdaD(1)) );
        Zn2      = (lambdaS./(lambdaS+lambdaD(2)) );
        % PDF FOR X-VALUES LESS THAN ZERO
        p(indLT) = Zn.*( Zn2.*exp(x(indLT).*lambdaD(2))  -  Zn1.*exp(x(indLT).*lambdaD(1)) );
    
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES MORE THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING TERM FOR EXPONENTIAL COMPONENT
        Zp       = prod([lambdaS lambdaD])./( (lambdaS + lambdaD(1)).*(lambdaS + lambdaD(2)) );
        % PDF FOR X-VALUES MORE THAN ZERO
        p(indGT) = Zp.*exp( -lambdaS.*x(indGT));

    elseif kDunq == 1
        % if bQUIET == 0
        % warning('expminusgenerlangpdf.m: WARNING! hard-coded 3-channel erlang implementation not working. Still using symbolic approach. WRITE CODE!!!')
        % end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES LESS THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING SCALARS
        Zn       = (lambdaS.*lambdaD(1).^2)./(lambdaS+lambdaD(1));
        Zn1      = 1./(lambdaS+lambdaD(1));
        % PDF FOR X-VALUES LESS THAN ZERO
        p(indLT) = Zn.*(Zn1.*exp(lambdaD(1).*x(indLT)) - x(indLT).*exp(lambdaD(1).*x(indLT)));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES MORE THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING SCALAR OF EXPONENTIAL COMPONENT
        Z1 = (lambdaS.*lambdaD(1).^2)/(lambdaS+lambdaD(1)).^2; 
        % PDF FOR X-VALUES LESS THAN ZERO
        p(indGT) = Z1.*exp( -lambdaS.*x(indGT));
    end
elseif kD == 3
    if kDunq == 3
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES LESS THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING SCALARS OF GENERALIZED ERLANG COMPONENT
        Zn1      = ( lambdaS.*prod(lambdaD)/( ( lambdaS + lambdaD(1) ).*( lambdaD(2)-lambdaD(1)).*( lambdaD(3)-lambdaD(1) ) ) );
        Zn2      = ( lambdaS.*prod(lambdaD)/( ( lambdaS + lambdaD(2) ).*( lambdaD(1)-lambdaD(2)).*( lambdaD(3)-lambdaD(2) ) ) );
        Zn3      = ( lambdaS.*prod(lambdaD)/( ( lambdaS + lambdaD(3) ).*( lambdaD(1)-lambdaD(3)).*( lambdaD(2)-lambdaD(3) ) ) );
        % PDF FOR X-VALUES LESS THAN ZERO
        p(indLT) = Zn1.*exp(lambdaD(1).*x(indLT)) + Zn2.*exp(lambdaD(2).*x(indLT)) + Zn3.*exp(lambdaD(3).*x(indLT));

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES MORE THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % NORMALIZING TERM FOR EXPONENTIAL COMPONENT
        Zp       = ( lambdaS.*prod(lambdaD)/( ( lambdaS + lambdaD(1) ).*( lambdaS+lambdaD(2)).*( lambdaS+lambdaD(3) ) ) );
        % PDF FOR X-VALUES MORE THAN ZERO
        p(indGT) = Zp.*exp( -lambdaS.*x(indGT) );
        killer = 1;
    else
        if bQUIET == 0
        warning('expminusgenerlangpdf.m: WARNING! hard-coded 4-channel expminusgenerlang not working bc all lambdas not unique. Using symbolic approach. Will be slow! WRITE CODE?!?')
        end
        % DEFINE SYMBOLIC VARIABLES
        syms t w 
        % CHARACTERISTIC FUNCTION IN SYMBOLIC FORM W FIXED PARAMETERS
        cf = @(t) (lambdaS(:)./(lambdaS(:)-1i.*t)).*prod(lambdaD(:)./(lambdaD(:)+1i.*t),1);
        % CHANGE CONVENTION TO -2*pi AND FOURIER TRANSFORM
        sympref('FourierParameters',[1 -2.*pi]);
        % PDF IN SYMOBLIC FORM (FROM FT OF CF W APPROPRIATE CHANGE OF VARIABLES)   
        f = fourier(cf(2.*pi.*t), w);
        % NUMERIC VALUES OF W
        w = x;
        % PDF IN NUMERIC FORM
        p = double(subs(f));
        % CHANGE FOURIER CONVENTION BACK TO DEFAULT
        sympref('FourierParameters','default');
    end
elseif kD >= 4
    if kDunq == kD
        %%
        % INITIALIZE PDF VALUES TO ZERO
        p = zeros(size(x));
        % NUMERATOR OF ALL NORMALIZING CCONSTANT
        Znum = ( lambdaS.*prod(lambdaD) ); 

        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % FOR X VALUES LESS THAN ZERO %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % DENOMINATOR OF NORMALIZING CONSTANT FOR NEGATIVE X-VALUES
        for i = 1:length(lambdaD) 
            for j = 1:length(lambdaD)
                if j == i
                    ZnDen(i,j) = (lambdaS    + lambdaD(j));
                else
                    ZnDen(i,j) = (lambdaD(j) - lambdaD(i));
                end
            end
            % NORMALIZING CONSTANTS FOR NEGATIVE X-VALUES
            Zn(i) = Znum./prod(ZnDen(i,:),2);
            % PDF FOR X-VALUES LESS THAN ZERO
            p(indLT) = p(indLT) + Zn(i).*exp(lambdaD(i).*x(indLT));

            % DENOMINATOR OF NORMALIZING CONSTANT FOR POSITIVE X-VALUES
            ZpDen(i) = (lambdaS    + lambdaD(i));
        end
        % NORMALIZING CONSTANTS FOR POSITIVE X-VALUES
        Zp = Znum./prod(ZpDen);
        % PDF FOR X-VALUES MORE THAN ZERO
        p(indGT) = Zp.*exp( -lambdaS.*x(indGT) );
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % EXPONENTIAL MINUS GENERALIZED ERLANG PDF %
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % START TO WRITE CASES FOR 1-3 PARAMETERS
        syms t w
        % CHARACTERISTIC FUNCTION IN SYMBOLIC FORM
        cf = @(t) ( lambdaS./(lambdaS-1i.*t) ).*prod( lambdaD(:)./(lambdaD(:)+1i.*t) ,1);
        % CHANGE CONVENTION TO -2*pi AND FOURIER TRANSFORM
        sympref('FourierParameters',[1 -2.*pi]);
        % PDF IN SYMOBLIC FORM (FROM FT OF CF W APPROPRIATE CHANGE OF VARIABLES) 
        f = fourier(cf(2.*pi.*t), w);
        % NUMERIC VALUES OF W
        w = x;
        % PDF IN NUMERIC FORM
        p = double(subs(f));
        % CHANGE FOURIER CONVENTION BACK TO DEFAULT
        sympref('FourierParameters','default');
    end
end

% LOG PROBABILITY
if nargout >= 2
logp = log(p);
end

%%%%%%%%%%%%%%
% PLOT STUFF %
%%%%%%%%%%%%%%
if bPLOT == 1
    figure;
    plot(x,p,'kD','linewidth',2);
    formatFigure('X','Probability',['Exponential Minus Generalized Erlang pdf: \lambda_S=' num2str(lambdaS) ' \lambda_D=' num2str(lambdaD)]);
    axis square;
end