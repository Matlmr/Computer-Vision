function SIFTmatches(img1,img2,peak_thresh,fig)

figure(fig) ; clf ;
imshow(cat(2, img1, img2),[]);
Ia = single(rgb2gray(img1));
Ib = single(rgb2gray(img2));
[fa, da] = vl_sift(Ia,'PeakThresh',peak_thresh);
[fb, db] = vl_sift(Ib,'PeakThresh',peak_thresh);
[matches, scores] = vl_ubcmatch(da, db);

% plot the matches

xa = fa(1,matches(1,:)) ;
xb = fb(1,matches(2,:)) + size(Ia,2) ;
ya = fa(2,matches(1,:)) ;
yb = fb(2,matches(2,:)) ;

hold on ;
h = line([xa ; xb], [ya ; yb]) ;
set(h,'linewidth', 1, 'color', 'b');

vl_plotframe(fa(:,matches(1,:)));
fb(1,:) = fb(1,:) + size(Ia,2);
vl_plotframe(fb(:,matches(2,:)));
axis image off;