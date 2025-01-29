function [V,D] = eigsparse(M,blkSz)

% function [V,D] = eigsparse(M,blkSz)
%
%   example call: 
%
% eigenvalue and eigenvector decomposition of sparse
% matrix M with block diagonal structure
%
% ALGORITHM: eigendecomosition of each block and reassemble
%
% NOTE!      eigenvalues & eigenvectors sorted from 
%            small -> large to be consistent w eig.m behavior
%
% M:         sparse matrix w block diagonal structure    [ m x m  ]
% blkSz:     block size to be entered as a scalar        [ scalar ]
%            (e.g. 6 -> [6 x 6] block)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% V:         sparse block diagonal matrix w eigenvectors as columns
% D:         sparse       diagonal matrix w eigenvalues  as entries


% INPUT CHECKING
if ~issparse(M)
    error(['eigsparse.m: WARNING! matrix input M is not sparse. Use sqrtm.m instead!']); 
end
if ~isscalar(blkSz) 
    error(['eigsparse.m: WARNING! blkSz inputs must be square... currently blkSz=[ ' num2str(blkSz(1)) ' ' num2str(blkSz(2)) ']']); 
end

% NUMBER OF BLOCKS
nBlk = size(M,1)./blkSz;

% K BLOCKS TO SIMULTANEOUSLY ANALYZE 
kBlk = cumprod( factor( size(M,1)./blkSz ) );

% MAX BLOCK CHUNK SIZE
maxSzBlkChnk = 64; % EMPIRICALLY DETERMINED TO MAXIMIZE SPEED

% NUMBER OF BLOCKS TO ANALYZE SIMULTANEOUSLY (REDUCES NUMBER OF LOOPS)
n = kBlk( findnear(kBlk.*blkSz,maxSzBlkChnk) ); 

% ALLOCATE MEMORY FOR SPARSE MATRIX
V = spalloc(size(M,1),size(M,2),blkSz.*size(M,1));
D = spalloc(size(M,1),size(M,2),       size(M,1));

% LOOP OVER BLOCKS
for i = 1:nBlk./n
    % INDICES OF CURRENT BLOCK
    ind = [1:blkSz.*n] + (i-1)*blkSz*n;
    % EIGEN VECTORS AND VALUES
    [V(ind,ind),D(ind,ind)] = eig( full( M(ind,ind) ) );
end
