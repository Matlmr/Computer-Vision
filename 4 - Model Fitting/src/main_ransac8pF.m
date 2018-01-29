close all
clear all

% =========================================================================
% Exercise 4
% =========================================================================

%don't forget to initialize VLFeat
run VLFEATROOT/toolbox/vl_setup

% Load images
%set = 1; % ladybug
set = 0; % rect
if set
    imgName1 = 'images/ladybug_Rectified_0768x1024_00000064_Cam0.png';
    imgName2 = 'images/ladybug_Rectified_0768x1024_00000080_Cam0.png';
else
    imgName1 = 'images/rect1.jpg';
    imgName2 = 'images/rect2.jpg';
end

img1_c = (imread(imgName1));
img2_c = (imread(imgName2));

img1 = single(rgb2gray(imread(imgName1)));
img2 = single(rgb2gray(imread(imgName2)));

%extract SIFT features and match
[fa, da] = vl_sift(img1,'PeakThresh',0.01);
[fb, db] = vl_sift(img2,'PeakThresh',0.01);
[matches, scores] = vl_ubcmatch(da, db,2);

%show motion in 1 image
figure(1)

corner1 = fa(1:2, matches(1,:));
corner2 = fb(1:2, matches(2,:));
[sx, sy, sz] = size(img1);
img = img1_c;

imshow(img, []);    
hold on, plot(corner1(1,:), corner1(2,:), '+r');
hold on, plot(corner2(1,:), corner2(2,:), '+r');    
hold on, plot([corner1(1,:); corner2(1,:)], [corner1(2,:); corner2(2,:)], 'b'); 

%show matches
showFeatureMatches(img1_c, fa(1:2, matches(1,:)), img2_c, fb(1:2, matches(2,:)), 2);

% =========================================================================

%run 8-point RANSAC
threshold = 3;
[inliers1, inliers2, outliers1, outliers2, M, F] = ransac8pF(fa(1:2,matches(1,:)), fb(1:2,matches(2,:)), threshold);

%show inliers and outliers
showInliersOutliers(img1_c,inliers1, outliers1, img2_c, inliers2, outliers2,7)

% Motion on 1 image
figure(3)
corner1 = inliers1;
corner2 = inliers2;
[sx, sy, sz] = size(img1);
img = img1;
imshow(img, []);    
hold on, plot(corner1(1,:), corner1(2,:), '+r');
hold on, plot(corner2(1,:), corner2(2,:), '+r');    
hold on, plot([corner1(1,:); corner2(1,:)], [corner1(2,:); corner2(2,:)], 'b'); 

% matches between two images
showFeatureMatches(img1, inliers1, img2, inliers2, 4);

%show number of iterations needed
fprintf('Number of iterations needed: %d\n', M);

%show inlier ratio
fprintf('Inlier ratio: %.2f\n', size(inliers1,2)/(size(inliers1,2)+size(outliers1,2)))

%and check the epipolar geometry of the computed F
[U,S,V] = svd(F);
S(3,3) = 0;
Fh = U*S*V';

figure(5),clf, imshow(img1_c, []); hold on, plot(inliers1(1,:), inliers1(2,:), '*r');
figure(6),clf, imshow(img2_c, []); hold on, plot(inliers2(1,:), inliers2(2,:), '*r');

% draw epipolar lines in img 1
figure(5)
inliers2(3,:) = ones(1,size(inliers2,2));
for k = 1:size(inliers1,2)
    drawEpipolarLines(F'*inliers2(:,k), img1);
end
% draw epipolar lines in img 2
figure(6)
inliers1(3,:) = ones(1,size(inliers1,2));
for k = 1:size(inliers2,2)
    drawEpipolarLines(F*inliers1(:,k), img2);
end

% =========================================================================