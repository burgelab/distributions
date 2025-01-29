function genchi2simulate(nSmp,MU,COV,MU1,COV1,MU2,COV2,bPLOT)

% function genchi2simulate(nSmp,MU,COV,MU1,COV1,MU2,COV2,bPLOT)
%
%   example call: % 1D --> genchi2 
%                 MU1 = [0]; MU2 = [0]; COV1 = 2; COV2= 4;
%                
%                 % 2D --> genchi2 param delta ~= 0 & sigma  = 0 % GOOD PERFORMANCE W. IMHOF TAIL APPROX 
%                 MU1 = [0 0]; MU2 = [0 0]; COV1 = diag([1 4]); R = rotMatrix(2,30); COV2 = R*COV1*R';
%                 MU1 = [0 0]; MU2 = [1 2]; COV1 = diag([1 4]); R = rotMatrix(2,30); COV2 = R*COV1*R';
%                 % 2D --> genchi2 param delta ~= 0 & sigma  = 0 % BAD  PERFORMANCE W. IMHOF TAIL APPROX 
%                 MU1 = [0 0]; MU2 = [1 1]; COV1 = diag([1 4]); R = rotMatrix(2,30); COV2 = R*diag([1 9])*R';  
%                 % 2D --> genchi2 param delta ~= 0 & sigma ~= 0 % GOOD PERFORMANCE W. DAVIES APPROX           
%                 MU1 = [0 0]; MU2 = [1 1]; COV1 = diag([1 4]); COV2 = diag([1 9]);  
%
%                 % 3D --> genchi2 param delta  = 0 & sigma  = 0  %  GOOD PERFORMANCE 
%                 MU1 = [0 0 0]; MU2 = [0 0 0]; COV1 = diag([1 4 10]); COV2 = diag([1 5 10]);  
%                 % 3D --> genchi2 param delta ~= 0 & sigma  = 0 %  BAD PERFORMANCE W. IMHOF CDF  
%                 MU1 = [0 0 0]; MU2 = [1 1 1]; COV1 = diag([5 5 5]); COV2 = diag([4 10 8]);
%                 % 3D --> genchi2 param delta ~= 0 & sigma = 0  % ?GOOD? PERFORMANCE W. DAVIES CDF, BAD PERFORMANCE   W. IMHOF TAIL APPROX   
%                 MU1 = [0 0 0]; MU2 = [1 1 1]; COV1 = diag([2 4 9]); COV2 = diag([1 5 10]);  
%                 % 3D --> genchi2 param delta ~= 0 & sigma ~= 0 %  GOOD PERFORMANCE W. DAVIES CDF  
%                 MU1 = [0 0 0]; MU2 = [1 1 1]; COV1 = diag([1 4 9]); COV2 = diag([1 5 10]); 
%                 
%                 % 4D --> genchi2 param delta  = 0 & sigma = 0 
%                 MU1 = [0 0 0 0]; MU2 = [0 0 0 0]; COV1 = diag([1 0.1 0.2 1.2]); R=rotMatrix(2,30); R=[R zeros(2); zeros(2) R']; COV2 = R*COV1*R';   
%                 % 4D --> genchi2 param delta ~= 0 & sigma = 0
%                 MU1 = [0 0 0 0]; MU2 = [5 5 5 5]; COV1 = diag([1 0.1 0.2 1.2]); R=rotMatrix(2,30); R=[R zeros(2); zeros(2) R']; COV2 = R*COV1*R';   
%                 % 4D --> genchi2 param delta ~= 0 & sigma ~= 0 
%                 MU1 = [0 0 0 0]; MU2 = [0.2 0.2 0.2 0.2]; COV1 = diag([1 2 3 4]); COV2 = diag([1 3 4 5]); 
%
%                 % 5D --> genchi2 param delta ~= 0 & sigma == 0 
%                 MU1 = [0.0 0.0 0.0 0.0 0.0]; MU2 = [0.2 0.2 0.2 0.2 0.2]; COV1 = diag([1 2 3 4 5]); COV2 = diag([2 3 4 5 6]); 
%                 % 5D --> genchi2 param delta ~= 0 & sigma ~= 0 
%                 MU1 = [0.0 0.0 0.0 0.0 0.0]; MU2 = [0.2 0.2 0.2 0.2 0.2]; COV1 = diag([1 2 3 4 5]); COV2 = diag([1 3 4 5 6]); 
%                 % 5D --> genchi2 param delta ~= 0 & sigma ~= 0 w. rotation 
%                 MU1 = [0 0 0 0 0]; MU2 = [1 1 1 1 1]; COV1 = diag([1 0.1 0.2 1.2 2]); R=rotMatrix(3,30,[1 0 0]); R=[R(2:3,2:3) zeros(2,3); zeros(3,2) R']; COV2 = R*COV1*R';   
%
%                 % 6D --> genchi2 param delta ~= 0 & sigma ~= 0 
%                 MU1 = [0.0 0.0 0.0 0.0 0.0 0.0]; MU2 = [0.2 0.2 0.2 0.2 0.2 0.2]; COV1 = diag([1 2 3 4 5 6]); COV2 = diag([1 3 4 5 6 7]); 
%
%                 % 20D --> genchi2 param delta ~= 0 & sigma ~= 0 
%                 nDim = 9; MU1 = zeros(1,nDim); MU2 = 0.2.*ones(1,nDim); COV1 = diag([1:nDim]); COV2 = diag([1 3:(nDim+1)]); 
% 
%                 %%%%%%%%%%%%%%%%%%%%%%%%
%                 % SIMULATE THE GENCHI2 %
%                 %%%%%%%%%%%%%%%%%%%%%%%%
%                 genchi2simulate(1000000,MU1,COV1,MU1,COV1,MU2,COV2,1)
%
% simulate from genchi2 distribution
%
% nSmp:  number of samples
% MU:    mean of target n-d gaussian random variable
% COV:   cov  of target n-d gaussian random variable
% MU1:   mean of n-d gaussian #1
% COV1:  cov  of n-d gaussian #1
% MU2:   mean of n-d gaussian #2
% COV2:  cov  of n-d gaussian #2
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%
%   *** see also: genchi2*.m and mvnpdf2genchi2params.m  ***

if ~exist('MU2','var')   || isempty(MU2)   MU2  = []; end
if ~exist('COV2','var')  || isempty(COV2)  COV2 = []; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT= []; end

% GEN CHI2 RANDOM SAMPLES
X2rnd = genchi2rnd(nSmp,MU,COV,MU1,COV1,MU2,COV2);

% GENCHI2 PARAMETERS
[lambda,nu,delta,sigma,c] = mvnpdf2genchi2params(MU,COV,MU1,COV1,MU2,COV2);

% MEAN & VARIANCE
[m,v] = genchi2stat(lambda,nu,delta,sigma,c);

% HISTOGRAM BINS
B = linspace(m-5*sqrt(v),m+5*sqrt(v),101);

% HISTOGRAM RANDOM SAMPLES
H = hist(X2rnd,B);

% CONVERT TO PROBABILITY
P = (H./sum(H))./diff(B(1:2));

%%%%%%%%%%%%%%
% PLOT STUFF %
%%%%%%%%%%%%%%
if bPLOT == 1
    % FOR PLOTTING PDF
    Bplt = linspace(m-4*sqrt(v),m+4*sqrt(v),201);
    Yplt = genchi2pdf(Bplt,lambda,nu,delta,sigma,c);
    
    % OPEN FIGURE
    if numel(MU) <= 2
        % PLOT GENCHI2 AND CONSTITUTE GAUSSIANS
        figure('position',[603 608 1215 594]); 
        subplot(1,2,1); hold on; 
    else
        % PLOT GENCHI2 ONLY
        figure('position',[434   471   752   707]); 
        hold on; 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    % PLOT GENCHI2 DISTRIBUTION W. HISTOGRAM OF RANDOM SAMPLES %
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % PLOT HISTOGRAMMED SAMPLES
    bar(B,P,1,'w'); ylims = ylim;
    % PLOT PREDICTION
    plot(Bplt,Yplt,'k','linewidth',2);
    % MAKE IT LOOK PRETTY    
    formatFigure('X2','Probability',['\lambda=[' num2str(lambda,'%.2f ') '],\nu=[' num2str(nu,'%d ') '],\delta=[' num2str(delta,'%.2f ') '],\sigma=' num2str(sigma,'%0.2f') ',c=' num2str(c,'%.2f')])
    axis square;
    xlim([minmax(B)-mean(minmax(B))]*1.05 + mean(minmax(B)));
    ylim([0 max(ylims)*1.2]);
    
    %%%%%%%%%%%%%%%%%%
    % PLOT GAUSSIANS %
    %%%%%%%%%%%%%%%%%%
    if numel(MU) == 1
        % PLOT 1D GAUSSIANS %
        subplot(1,2,2); hold on;
        Xplt = linspace(min([MU1-4.*sqrt(COV1) MU2-4.*sqrt(COV2)]),max([MU1+4.*sqrt(COV1) MU2+4.*sqrt(COV2)]),1001);
        plot(Xplt,normpdf(Xplt,MU1,sqrt(COV1)),'b','linewidth',2);
        try
        plot(Xplt,normpdf(Xplt,MU2,sqrt(COV2)),'r','linewidth',2);
        end
        axis square;
        formatFigure([],[],['MU1=' num2str(MU1,'%.2f') ',SD1=' num2str(sqrt(COV1),'%.2f') ',MU2=' num2str(MU2,'%.2f') ',SD2=' num2str(sqrt(COV2),'%.2f')]);
    elseif numel(MU) == 2
        % PLOT 2D GAUSSIANS %
        subplot(1,2,2); hold on;
        plotEllipse(MU1,COV1,95,[],3,'b');
        [V1max,V1min] = cov2varMjrMnr(COV1);   % VARIANCE ON MJR/MIN AXES
        [V1ort]       = cov2orientation(COV1); % ORIENTATION OF COV1
        try
        plotEllipse(MU2,COV2,95,[],3,'r');
        [V2max,V2min] = cov2varMjrMnr(COV2);   % VARIANCE ON MJR/MIN AXES
        [V2ort]       = cov2orientation(COV2); % ORIENTATION OF COV2
        end
        try
        plotEllipse(MU,COV,95,[],1.5,'k--');
        [Vmax,Vmin] = cov2varMjrMnr(COV);   % VARIANCE ON MJR/MIN AXES
        [Vort]       = cov2orientation(COV); % ORIENTATION OF COV2
        end
        axis(max(abs(axis)).*[-1 1 -1 1]);
        axis square;
        try   formatFigure([],[],['\mu1=[' num2str(MU1,'%.1f ') '],V1=[' num2str([V1max V1min],'%.1f ') '],\theta1=' num2str(V1ort,'%.0f') ',\mu2=[' num2str(MU2,'%.1f ') '],V2=[' num2str([V2max V2min],'%.1f ') '],\theta2=' num2str(V2ort,'%.0f') ]);
        catch formatFigure([],[],['\mu1=[' num2str(MU1,'%.1f ') '],V1=[' num2str([V1max V1min],'%.1f ') '],\theta1=' num2str(V1ort,'%.0f')  ]);
        end
    end
end