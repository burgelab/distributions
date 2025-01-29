function [X Y Z] = meshgridvec(x,y,z)

% function [X Y Z] = meshgridvec(x,y,z)
%
%   example call: 
%
% vectorize outputs of meshgrid... very useful for use with mvnpdf.m
%
% algorithm: i) [xx yy] = meshgrid(x,y);
%                    X  = [xx(:) yy(:)];
%
% x:    x-positions  [ 
% y:    y-positions
% z:    z-positions
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% X:    vector of xy(z) positions, if nargout == 1 
%    OR vector of x  positions, if nargout == 2 
% Y:    vector of y  positions, if nargout == 2 
% Z:    vector of z, positions, if nargout == 3

if ~exist('z','var') || isempty(z)
    if ~exist('y','var') || isempty(y)
        [xx,yy]= meshgrid(x);
    else
        [xx,yy]= meshgrid(x,y);
    end
else
    [xx,yy,zz]= meshgrid(x,y,z);
end


if nargout == 0 || nargout == 1
    if exist('z','var')
    X = [xx(:) yy(:) zz(:)];
    else
    X = [xx(:) yy(:)];
    end
elseif nargout == 2
    X = xx(:); 
    Y = yy(:);
elseif nargout == 3
    X = xx(:); 
    Y = yy(:);
    Z = zz(:);
end