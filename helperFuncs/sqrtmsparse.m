function S = sqrtmsparse(M,blkSz)

% function S = sqrtmsparse(M,blkSz)
%
%   example call: sqrtmsparse(M,4)
%
% principle matrix squareroot of sparse matrix M 
% with block diagonal structure
%
% ALGORITHM: sqrtm of each block and reassemble
%
% M:      sparse matrix w block diagonal structure
% blkSz:  block size to be entered as a scalar
%         (e.g. 6 -> [6 x 6] block)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% S:      matrix squareroot in sparse form


% INPUT CHECKING
if ~issparse(M)
    error(['sqrtms.m: WARNING! matrix input M is not sparse. Use sqrtm.m instead!']); 
end
if ~isscalar(blkSz) 
    error(['sqrtms.m: WARNING! blkSz inputs must be a scalar input... currently blkSz=[ ' num2str(size(blkSz)) ']']); 
end

% NUMBER OF BLOCKS
nBlk = size(M,1)./blkSz(1);

% BLOCK CHUNKS TO ANALYZE ( blkSz*nBlk2analyze )
kBlk = cumprod( factor( size(M,1)./blkSz(1) ) );

% BLOCK SIZE
maxSzBlkChnk = 64;

% NUMBER OF BLOCKS TO ANALYZE SIMULTANEOUSLY (REDUCES NUMBER OF LOOPS)
n = kBlk(findnear(kBlk.*blkSz,maxSzBlkChnk) ); 

% ALLOCATE MEMORY FOR SPARSE MATRIX
S = spalloc(size(M,1),size(M,2),blkSz.*size(M,1));

% LOOP OVER BLOCKS
for i = 1:nBlk./n
    % INDICES OF CURRENT BLOCK
    ind = [1:blkSz*n] + (i-1)*blkSz*n;
    % MATRIX SQUAREROOT
    S(ind,ind) = sqrtm( full( M(ind,ind) ) );
end
