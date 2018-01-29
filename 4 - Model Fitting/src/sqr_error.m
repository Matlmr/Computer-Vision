function err = sqr_error(k,b,pts)
% Calculate the square error of the fit
    theta = atan(-k);
    n = [cos(theta),-sin(theta)];
    pt1 = [0;b];
    err = sqrt(sum((n*(pts-repmat(pt1,1,size(pts,2)))).^2));
end