function[adj_img]=img_rotation(I)

corners=find_corner(I);
[teta crop_rec]=find_rotation(I,corners)
J=imrotate(I,teta,'bicubic');

corners=find_corner(J);

[teta crop_rec]=find_rotation(J,corners)
adj_img=imcrop(J,crop_rec);
