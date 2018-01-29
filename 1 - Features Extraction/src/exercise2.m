% Exercise 3

close all;

IMG_NAME1 = 'images/HN1.jpg';
IMG_NAME2 = 'images/HN2.jpg';

% read in image
img1 = im2double(imread(IMG_NAME1));
img2 = im2double(imread(IMG_NAME2));

img1 = imresize(img1, 1);
img2 = imresize(img2, 1);

% convert to gray image
imgBW1 = rgb2gray(img1);
imgBW2 = rgb2gray(img2);

% Task 3.1 - extract Harris corners
sigma = 3;
thres_harris = 0.001;
[corners1, H1] = extractHarrisCorner(imgBW1', thres_harris, sigma);
[corners2, H2] = extractHarrisCorner(imgBW2', thres_harris, sigma);

% show images with Harris corners
showImageWithCorners(img1, corners1, 10);
showImageWithCorners(img2, corners2, 11);

% Task 3.2 - extract your own descriptors
descr1 = extractDescriptor(corners1, imgBW1');
descr2 = extractDescriptor(corners2, imgBW2');

% Task 3.3 - match the descriptors
thresh_matches = 0.15;
[matches, val] = matchDescriptors(descr1, descr2, thresh_matches);

showFeatureMatches(img1, corners1(:, matches(1,:)), img2, corners2(:, matches(2,:)), 20);

% Task 3.4 - SIFT features
peak_thresh = 0.05;
SIFTdescriptor(img1,peak_thresh,2)
SIFTmatches(img1,img2,peak_thresh,3)