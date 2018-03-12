boat1 = single(im2double(imread('./boat1.pgm')));
boat2 = single(im2double(imread('./boat2.pgm')));

[f,d] = vl_sift(boat1);