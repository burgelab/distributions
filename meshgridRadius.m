function RR = meshgridRadius(X,Y)

% function RR = meshgridRadius(X,Y)
% 
%   example call: RR = meshgridRadius(-64:63)
%
% radius of meshgrid points

if nargin == 1
    [XX YY] = meshgrid(X);
elseif nargin == 2
    [XX YY] = meshgrid(X,Y);
else
    error('meshgridRadius: unhandled nargin');
end
RR = sqrt(XX.^2 + YY.^2);