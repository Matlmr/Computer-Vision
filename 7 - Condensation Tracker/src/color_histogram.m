function [ hist ] = color_histogram( xMin, yMin, xMax, yMax, frame, hist_bin )
%COLOR_HISTOGRAM calculates the normalized histogram of RGB colors
% within the bounding box
%   Detailed explanation goes here
    xMin = round(max(1,xMin));
    yMin = round(max(1,yMin));
    xMax = round(min(xMax,size(frame,2)));
    yMax = round(min(yMax,size(frame,1)));

    %Split into RGB Channels
    R = frame(yMin:yMax,xMin:xMax,1);
    G = frame(yMin:yMax,xMin:xMax,2);
    B = frame(yMin:yMax,xMin:xMax,3);

    %Get histValues for each channel
    [yR, x] = imhist(R, hist_bin);
    [yG, ~] = imhist(G, hist_bin);
    [yB, ~] = imhist(B, hist_bin);

    %hist = [yR/255; yG/255; yB/255];
    hist = [yR; yG; yB];
    hist = hist/sum(hist);
    %figure(2)
    %plot(x,yR,'r',x,yG,'g',x,yB,'b')
    %sum(hist)
end

