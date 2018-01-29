% extract harris corner
%
% Input:
%   img           - n x m gray scale image
%   thresh        - scalar value to threshold corner strength
%   
% Output:
%   corners       - 2 x k matrix storing the keypoint coordinates
%   H             - n x m gray scale image storing the corner strength
function [corners, H] = extractHarrisCorner(img, thresh, sigma)

% filtering
F = fspecial('gaussian',max(1,2*sigma),sigma);
img_f = imfilter(img,F);

% non-maximum suppresion parameter
max_size = 3;

% gradient and convolution
[Ix, Iy] = gradient(img_f);
C = [1,1,1;1,0,1;1,1,1];
Ix2 = conv2(Ix.^2,C);
Iy2 = conv2(Iy.^2,C);
Ixy = conv2(Ix.*Iy,C);

% Harris response
H = (Ix2.*Iy2-Ixy.^2)./(Ix2+Iy2);

% non-max suppresion and respone threshold
non_max = ordfilt2(H,max_size^2,ones(max_size));
H = (H==non_max) & (H>thresh);
[corners(1,:), corners(2,:)] = find(H);
end