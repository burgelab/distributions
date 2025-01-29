%%

nStm = 1000000;
nDim = 2;
MU = zeros(1,nDim);

C  = rotMatrix(2,45)*[1 0; 0 1/10]*rotMatrix(2,45)';

% COVARIANCE MATRIX
COV = kron(eye(nDim/2),C)
% COV INVERSE SQUARE ROOT
COVisr = inv(sqrtm(COV));
% MULTIVARIATE NORMAL SAMPLES
R    = mvnrnd(MU,COV,nStm); % [ nStm x nDim ] 
% TRANSPOSE CONVERTS TO size(R) TO [ nDim x nStm ]
Rsym = (COVisr*R')';
% GENERALIZED CHI2 SAMPLES
X2 = sum(R.^2,2);
% GENERALIZED CHI2 SAMPLES
X2sym = sum(Rsym.^2,2);

figure; 
subplot(2,2,1);
[H B] = hist(X2,51);
bar(B,H./sum(H),1,'w');
formatFigure([],[],['Asym; Dim=' num2str(nDim)]);
axis square

subplot(2,2,2);
[Hsym B] = hist(X2sym,B);
bar(B,Hsym./sum(Hsym),1,'w');
formatFigure([],[],['Sym; Dim=' num2str(nDim)]);
axis square

subplot(2,2,3); hold on;
indPlt = 1:1000;
plot(R(indPlt,1),R(indPlt,2),'ko','markersize',8,'markerface','w');
plotEllipse(MU,COV,95,[1 2],2,'k');
axis(max(abs(axis))*[-1 1 -1 1]);
axis square;
formatFigure([],[],['Dims 1 & 2']);

subplot(2,2,4); hold on;
indPlt = 1:1000;
plot(Rsym(indPlt,1),Rsym(indPlt,2),'ko','markersize',8,'markerface','w');
plotEllipse(MU,[1 0; 0 1],95,[1 2],2,'k');
axis(max(abs(axis))*[-1 1 -1 1]);
axis square;
formatFigure([],[],['Norm Dims 1 & 2']);
