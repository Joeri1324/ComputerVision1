function [matches, scores, img1_f, img2_f] = keypoint_matching(img1, img2)

[img1_f, img1_d] = vl_sift(im2single(img1));
[img2_f, img2_d] = vl_sift(im2single(img2));

[matches, scores] = vl_ubcmatch(img1_d, img2_d) ;

end