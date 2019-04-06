function[hols_box,hols_num,bw_hols_dilt] = fnd_hols2(bw_hols,dilt_dsk_size)


se_dsk = strel('disk',dilt_dsk_size);
 bw_hols_dilt= imdilate(bw_hols,se_dsk);
%imshow(bw_hols_dilt)
[hols_label hols_num] = bwlabel(bw_hols_dilt);

hols_props = regionprops(hols_label);
hols_box = [hols_props.BoundingBox]; 
hols_box = reshape(hols_box,[4 hols_num]);







