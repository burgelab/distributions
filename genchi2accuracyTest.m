%%
%%%%%%%%%%%%%%%%%%%
% TWO-DIMENSIONAL %
%%%%%%%%%%%%%%%%%%%

% TEST POINT
X = [.25 .5]';
% ROTATION MATRIX
R = rotMatrix(2,45); 
% MEANS
MU1 = [1 1];
MU2 = [0 0];
% COVARIANCES
COV1 = 4.*diag([1 1/10]); 
COV2 = R*COV1*R';

% LOG LIKELIHOOD PARAMETERS OF QUAD FORM
[Q2p Q1p Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1);
% QUAD FORM
X2 = X'*Q2p*X + Q1p'*X + Q0p;
% LL FROM MATLAB BUILT-IN
LLmlb = log( mvnpdf(X',MU1,COV1) )
% LL FROM QUAD FORM
LLcde = X2

% LOG LIKELIHOOD RATIO
[Q2p Q1p Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2);
X2 = X'*Q2p*X + Q1p'*X + Q0p;
% LLR FROM MATLAB BUILT-IN
LLRmlb = log( mvnpdf(X',MU1,COV1)./mvnpdf(X',MU2,COV2) )
% LLR FROM QUAD FORM
LLRcde = X2 

%%%%%%%%%%%%%%%%%%%%
% FOUR DIMENSIONAL %
%%%%%%%%%%%%%%%%%%%%
% TEST POINT
X = [.25 0 .25 .5]';
% ROTATION MATRIX
R = kron(eye(2),R);
% R = [R zeros(2); zeros(2) diag([1 1])];
% MEANS
MU1 = [1 1 1 1];
MU2 = [0 0 0 0];
% COVARIANCES
COV1 = 4.*diag([1 1/10 2 1/2]); 
COV2 = R*COV1*R';

% LOG LIKELIHOOD PARAMETERS OF QUAD FORM
[Q2p,Q1p,Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1);
% QUAD FORM
X2 = X'*Q2p*X + Q1p'*X + Q0p;
% LL FROM MATLAB BUILT-IN
LLmlb = log( mvnpdf(X',MU1,COV1) )
% LL FROM QUAD FORM
LLcde = X2

% % LOG LIKELIHOOD RATIO
% [Q2p,Q1p,Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2);
% X2 = X'*Q2p*X + Q1p'*X + Q0p;
% % LLR FROM MATLAB BUILT-IN
% LLRmlb = log( mvnpdf(X',MU1,COV1)./mvnpdf(X',MU2,COV2) )
% % LLR FROM QUAD FORM
% LLRcde = X2 

MU = MU1; 
COV = COV1;

[lambda,nu,delta,sigma,c] = mvnpdf2genchi2params(MU,COV,MU1,COV1); %,MU2,COV2);
y = genchi2pdf(X2,lambda,nu,delta,sigma,c);
%%
% SIMULATE GENCHI2 RANDOM VARIABLE
Y = genchi2simulate(MU,COV,MU1,COV1,MU2,COV2);

%%

quad.q2 = Q2p; quad.q1 = Q1p; quad.q0 = Q0p;
[lambda,m,delta,sigma,c]=norm_quad_to_gx2_params(MU',COV,quad)


%%
% LIKELIHOOD RATIO
[Q2p Q1p Q0p] = genchi2loglikelihood2quadcoeffs(MU1,COV1,MU2,COV2);

quad.q2 = Q2p; quad.q1 = Q1p; quad.q0 = Q0p
[lambda,nu,delta,sigma,c] = mvnpdf2genchi2params(MU1,COV1,Q2p,Q1p,Q0p); 
y = genchi2pdf(X2,lambda,nu,delta,sigma,c,[],[],[],0)


[lambda,m,delta,sigma,c]=norm_quad_to_gx2_params(mu,v,quad);