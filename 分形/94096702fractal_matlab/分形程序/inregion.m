function [in, on] = inregion(x,y,xv,yv)
%INREGION True for points inside or on a polygonal region.
%   IN = INREGION(X, Y, XV, YV) returns a matrix IN the size of X and Y.
%   IN(p,q) = 1 if the point (X(p,q), Y(p,q)) is either strictly inside or
%   on the edge of the polygonal region whose vertices are specified by the
%   vectors XV and YV; otherwise IN(p,q) = 0.
%
%   [IN ON] = INREGION returns a second matrix, ON, which is the size of X
%   and Y.  ON(p,q) = 1 if the point (X(p,q), Y(p,q)) is on the edge of the
%   polygonal region; otherwise ON(p,q) = 0.
%
%   INREGION is a modification of INPOLYGON that uses a roundoff error
%   compensating tolerance in the cross product sign test.
%
%   Example:
%     xv = [-3 -3 1 1 3 1 -1 -1 -3];
%     yv = [-3 -1 3 1 1 -1 -1 -3 -3];
%     [x,y] = meshgrid(-3:1/2:3);
%     [in,on] = inregion(x,y,xv,yv);
%     p = find(in-on);
%     q = find(on);
%     plot(xv,yv,'-',x(p),y(p),'ko',x(q),y(q),'ro')
%     axis([-5 5 -4 4])

% If (xv,yv) is not closed, close it.
xv = xv(:);
yv = yv(:);
Nv = length(xv);
if ((xv(1) ~= xv(Nv)) | (yv(1) ~= yv(Nv)))
    xv = [xv ; xv(1)];
    yv = [yv ; yv(1)];
    Nv = Nv + 1;
end

inputSize = size(x);

x = x(:).';
y = y(:).';

mask = (x >= min(xv)) & (x <= max(xv)) & (y>=min(yv)) & (y<=max(yv));
if ~any(mask)
    in = zeros(inputSize);
    on = in;
    return
end
inbounds = find(mask);
x = x(mask);
y = y(mask);


% Choose block_length to keep memory usage of vec_inpolygon around
% 10 Megabytes.
block_length = 1e5;

M = prod(size(x));

if M*Nv < block_length
    if nargout > 1
        [in on] = vec_inpolygon(Nv,x,y,xv,yv);
    else
        in = vec_inpolygon(Nv,x,y,xv,yv);
    end
else
    % Process at most N elements at a time
    N = ceil(block_length/Nv);
    in = false(1,M);
    if nargout > 1
        on = false(1,M);
    end
    n1 = 0;  n2 = 0;
    while n2 < M,
        n1 = n2+1;
        n2 = n1+N;
        if n2 > M,
            n2 = M;
        end
        if nargout > 1
            [in(n1:n2) on(n1:n2)] = vec_inpolygon(Nv,x(n1:n2),y(n1:n2),xv,yv);
        else
            in(n1:n2) = vec_inpolygon(Nv,x(n1:n2),y(n1:n2),xv,yv);
        end
    end
end

if nargout > 1
    onmask = mask;
    onmask(inbounds(~on)) = 0;
    on = reshape(onmask, inputSize);
end

mask(inbounds(~in)) = 0;
% Reshape output matrix.
in = reshape(mask, inputSize);


%----------------------------------------------
function [in, on] = vec_inpolygon(Nv,x,y,xv,yv)
% vectorize the computation.

% Translate the vertices so that the test points are
% at the origin.

Np = length(x);
x = x(ones(Nv,1),:);
y = y(ones(Nv,1),:);
xv = xv(:,ones(1,Np)) - x;
yv = yv(:,ones(1,Np)) - y;

% Compute the quadrant number for the vertices relative
% to the test points.
posX = xv > 0;
posY = yv > 0;
negX = ~posX;
negY = ~posY;
quad = (negX & posY) + 2*(negX & negY) + ...
    3*(posX & negY);

% Compute the sign() of the cross product and dot product
% of adjacent vertices.
% Modified 09/17/03 to use a tolerance in the cross product sign test.
m = 1:Nv-1;
mp1 = 2:Nv;
crossProduct = xv(m,:) .* yv(mp1,:) - xv(mp1,:) .* yv(m,:);
tol = 10*Nv*(max(abs(xv(:)))+max(abs(yv(:))))*eps;
crossProduct(abs(crossProduct)<tol) = 0;
signCrossProduct = sign(crossProduct);
dotProduct = xv(m,:) .* xv(mp1,:) + yv(m,:) .* yv(mp1,:);

% Compute the vertex quadrant changes for each test point.
diffQuad = diff(quad);

% Fix up the quadrant differences.  Replace 3 by -1 and -3 by 1.
% Any quadrant difference with an absolute value of 2 should have
% the same sign as the cross product.
idx = (abs(diffQuad) == 3);
diffQuad(idx) = -diffQuad(idx)/3;
idx = (abs(diffQuad) == 2);
diffQuad(idx) = 2*signCrossProduct(idx);

% Find the inside points.
in = (sum(diffQuad) ~= 0);

% Find the points on the polygon.  If the cross product is 0 and
% the dot product is nonpositive anywhere, then the corresponding
% point must be on the contour.
on = any((signCrossProduct == 0) & (dotProduct <= 0));

in = in | on;

