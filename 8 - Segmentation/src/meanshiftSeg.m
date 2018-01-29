function [map, peak] = meanshiftSeg(img)
    % create X
    img = double(img);
    L = size(img,1)*size(img,2);
    img1 = img(:,:,1); img2 = img(:,:,2); img3 = img(:,:,3);
    X = [img1(:),img2(:),img3(:)];
    Xh = [X';ones(1,size(X,1))];
    [Xn,T] = normalise3dpts(Xh);
    Xn = Xn(1:3,1:end)';
    id = 1;
    map = zeros(size(img1));
    
    % parameters and declarations
    peak = [];
    r = 3;
    pause(1)
    for i = 1:L
        % Find peak for each pixel 
        mode = find_peak(Xn,Xn(i,:),r);
        % create first peak
        if i == 1
            peak(1,:) = mode;
            map(1) = id;
        else
            % calculate distance with existing peaks
            dists = sqrt(sum(((peak-repmat(mode,[id,1])).^2),2));
            index = find(dists < r/2,1);
            % create a new peak
            if isempty(index)
                peak(end+1,:) = mode;
                id = id + 1;
                map(i) = id;
            % cluster with previous one
            else
                map(i) = index;
            end
        end 
    end
    % Unormalize the peaks
    peakh = [peak';ones(1,id)];
    peaku = T \ peakh;
    peak = peaku(1:3,1:end)';
end