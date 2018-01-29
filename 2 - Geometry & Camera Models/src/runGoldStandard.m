function [K, R, P, t, error, r_xy] = runGoldStandard(xy, XYZ)

n = size(xy,2);

%normalize data points
% xy_normalized = [];
% XYZ_normalized = [];
[xy_normalized, XYZ_normalized, T, U] = normalization(xy,XYZ);

%compute DLT
[Pn] = dlt(xy_normalized, XYZ_normalized);

%minimize geometric error
pn = [Pn(1,:) Pn(2,:) Pn(3,:)];
for i=1:20
    [pn] = fminsearch(@fminGoldStandard, pn, [], xy_normalized, XYZ_normalized, i/5, T, U);
end
Pn = [pn(1:4); pn(5:8); pn(9:12)];

%denormalize camera matrix
P = T^-1*Pn*U;

% un-normalized
% P = Pn;

%factorize camera matrix in to K, R and t
[K, R, C, t] = decompose(P);

%compute reprojection error
error = 0;
r_xy = [];
for i = 1:n
    r = P*XYZ(:,i);
    r_xy = [r_xy r./r(end)];
    error = error + sum((r_xy(:,i) - xy(:,i)).^2);
end

end