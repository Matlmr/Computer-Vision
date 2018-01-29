function peak = find_peak( X, x_l, r )
    % find the pixels whose distance in the L*a*b space are smaller than r
    L = size(X,1);
    old_point = x_l;
    tol = 10;
    shift = tol+1;
    while shift > tol    
        dists = sqrt(sum(((X-repmat(old_point,[L,1])).^2),2));
        sphere = X(dists < r,:);
        new_point = mean(sphere,1);
        %shift = sqrt(sum((old_point-new_point).^2));
        shift = norm(old_point-new_point);
        old_point = new_point;
    end
    peak = new_point;
end