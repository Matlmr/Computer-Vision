function [K, R, P, t, error, r_xy] = runDLT(xy, XYZ)

n = size(xy,2);

%normalize data points
%xy_normalized = [];
%XYZ_normalized = [];
[xy_normalized, XYZ_normalized, T, U] = normalization(xy,XYZ);

%compute DLT
[P_normalized] = dlt(xy_normalized, XYZ_normalized);

%denormalize camera matrix
P = T^-1*P_normalized*U;

% un-normalized version
% P = P_normalized;

%factorize camera matrix in to K, R and t
[K, R, C, t] = decompose(P);!

%compute reprojection error
error = 0;
r_xy = [];
for i = 1:n
    r = P*XYZ(:,i);
    r_xy = [r_xy r./r(end)];
    error = error + sum((r_xy(:,i) - xy(:,i)).^2);
end

end