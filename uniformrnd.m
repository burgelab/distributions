function X = uniformrnd(a,b,Xsz,bPLOT)

% function X = uniformrnd(a,b,Xsz,bPLOT)
%
%   example call: uniformrnd(-3,3,100000,1);
%
% random samples from uniform distribution with lower and upper boundaries
%
% a:     lower boundary               (default = 0)
% b:     upper boundary               (default = 1)  
% Xsz:   number of samples or size of matrix of random samples
%        scalar -> number of samples
%        matrix -> size of matrix
% bPLOT: plot or not
%        1 -> plot
%        0 -> not
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:     random samples from uniform distribution
%
%                *** see uniform*.m ***

% INPUT HANDLING
if ~exist('a'    ,'var') || isempty( a)    a     = 0; end
if ~exist('b'    ,'var') || isempty( b)    b     = 1; end
if ~exist('bPLOT','var') || isempty(bPLOT) bPLOT = 0; end

% INPUT CHECKING
if isempty( Xsz) Xsz = 1;       end
if isscalar(Xsz) Xsz = [Xsz 1]; end

% UNIFORM RANDOM SAMPLES ON [0 1)
X = a + (b-a).*rand(Xsz);

% PLOT
if bPLOT
    figure; 
    [H B]=hist(X,31); 
    bar(B,H,1,'w');
    formatFigure('X','Count',['Uniform Samples: a=' num2str(a) ',b=' num2str(b,'%.2f')]);
    axis square;
end