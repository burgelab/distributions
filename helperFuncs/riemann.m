function integral = riemann(x,y,z,w)



% 1-D RIEMANN SUM
if nargin == 2 
	% riemann areas
	dx = x(2:end)-x(1:end-1);
	% average function height in bin
    if min(size(y)) == 1
    yAvg = 0.5*(y(2:end)+y(1:end-1));
    else
	yAvg = 0.5*(y(2:end,:)+y(1:end-1,:));
    end
	% sum the areas under the curve
	integral = sum(bsxfun(@times,dx,yAvg));
% 2-D RIEMANN SUM
elseif nargin == 3 
    if length(z) == 1
        z = z.*ones(size(x));
    end
    dx = x(1,2)-x(1,1);    
    dy = y(2)-y(1);
    area = dx*dy*ones(size(z));
    integral = sum(sum(area.*z));
elseif nargin == 4
    dx = diff(x(1:2));
    dy = diff(y(1:2));
    dz = diff(z(1:2));
    integral = sum(w(:).*dx.*dy.*dz);
elseif nargin > 2 & (length(unique(diff(x))) == 1 | length(unique(diff(y))) == 1) % 2-D riemann sum
    error('riemann.m: WARNING! non-functional for unequally spaced x,y positions');
else
    disp(['riemann: WARNING! error with input']);
end
