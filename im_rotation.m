function[adj_img]=img_rotation(I)

corners=fnd_corner(I);
[teta crop_rec]=find_rotation(I,corners);
J=imrotate(I,teta,'bicubic');

corners=fnd_corner(J);

[teta crop_rec]=find_rotation(J,corners);
adj_img=imcrop(J,crop_rec);
