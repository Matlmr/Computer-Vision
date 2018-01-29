% extract descriptor
%
% Input:
%   keyPoints     - detected keypoints in a 2 x n matrix holding the key
%                   point coordinates
%   img           - the gray scale image
%   
% Output:
%   descr         - m x n matrix, stores for each keypoint a
%                   descriptor. m is the size of the image patch,
%                   represented as vector
function descr = extractDescriptor(corners, img)
n = size(corners,2);

% size of the descriptor
patch_size = 9;
descr = zeros(patch_size^2,n);

% zero padding
shift = (patch_size-1)/2;
img_padded = padarray(img,[shift,shift]);

% patches are added in a column
for i = 1:n
    patch = img_padded(corners(1,i):corners(1,i)+2*shift,corners(2,i):corners(2,i)+2*shift);
    descr(:,i) = patch(:);
end
end