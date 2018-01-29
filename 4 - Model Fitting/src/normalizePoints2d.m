% Normalization of 2d-pts
% Inputs: 
%           x1s = 2d points
% Outputs:
%           nxs = normalized points
%           T = normalization matrix
function [nxs, T] = normalizePoints2d(x1s)

n = size(x1s,2);
xy_centroid = [mean(x1s(1,:)); mean(x1s(2,:))];

S2D = mean( sqrt( (x1s(1,:)-xy_centroid(1)*ones(1,n)).^2 + (x1s(2,:)-xy_centroid(2)*ones(1,n)).^2 ) ) / (sqrt(2));
T = [S2D,   0, xy_centroid(1);
       0, S2D, xy_centroid(2);
       0,   0,          1]^-1;
   
   %size(T)
   %size(x1s)
nxs = T*x1s;
    
end
