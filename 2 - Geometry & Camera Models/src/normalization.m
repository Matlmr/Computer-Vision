function [xyn, XYZn, T, U] = normalization(xy, XYZ)

n = size(xy,2);

%data normalization
%first compute centroid
xy_centroid = [mean(xy(1,:)); mean(xy(2,:))];
XYZ_centroid = [mean(XYZ(1,:)); mean(XYZ(2,:)); mean(XYZ(3,:))];

%then, compute scale
s2D = mean(sqrt((xy(1,:)-xy_centroid(1)*ones(1,n)).^2+(xy(2,:)-xy_centroid(2)*ones(1,n)).^2))/(sqrt(2));
s3D = mean(sqrt((XYZ(1,:)-XYZ_centroid(1)*ones(1,n)).^2+(XYZ(2,:)-XYZ_centroid(2)*ones(1,n)).^2+(XYZ(3,:)-XYZ_centroid(3)*ones(1,n)).^2))/sqrt(3);

%create T and U transformation matrices
T = [eye(2)*s2D,xy_centroid;
     0,0,1]^-1;
U = [eye(3)*s3D,XYZ_centroid;
     0,0,0,1]^-1;

%and normalize the points according to the transformations
xyn = T*xy;
XYZn = U*XYZ;

% un normalized version
% xyn = xy;
% XYZn = XYZ;

end