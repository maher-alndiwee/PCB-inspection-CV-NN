function[adj_img]=img_croption(I)



corners=ginput(4)';

[teta crop_rec]=find_rotation(I,corners)
adj_img=imcrop(I,crop_rec);
