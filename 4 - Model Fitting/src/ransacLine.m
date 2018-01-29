function [k, b] = ransacLine(data, dim, iter, threshDist, inlierRatio)
% data: a 2xn dataset with #n data points
% num: the minimum number of points. For line fitting problem, num=2
% iter: the number of iterations
% threshDist: the threshold of the distances between points and the fitting line
% inlierRatio: the threshold of the number of inliers

number = size(data,2); % Total number of points
bestInNum = 0;         % Best fitting line with largest number of inliers
k=0; b=0;              % parameters for best fitting line

for i=1:iter
    % Randomly select 2 points
    ind1 = randi(number);
    ind2 = randi(number);
    while (ind1 == ind2)
        ind1 = randi(number);
    end
    p1 = data(:,ind1);
    p2 = data(:,ind2);
    % Compute the distances between all points with the fitting line
    coef2 = polyfit([p1(1) p2(1)], [p1(2) p2(2)], 1);
    k_try = coef2(1);
    b_try = coef2(2);
    distances = abs(k_try*data(1,:)-data(2,:)+b_try)/sqrt(k_try^2+1);
    % Compute the inliers with distances smaller than the threshold
    inliers = find(distances < threshDist);
    % Update the number of inliers and fitting model if better model is found
    if (numel(inliers) > bestInNum && numel(inliers) > number*inlierRatio)
       bestInNum = numel(inliers);
       coef2 = polyfit(data(1,inliers), data(2,inliers), 1);
       k = coef2(1);
       b = coef2(2);
    end
end
end
