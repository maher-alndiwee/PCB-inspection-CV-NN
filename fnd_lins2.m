function[lins_box,lins_num]=fnd_lins2(bw_lins)
[lins_label lins_num] = bwlabel(bw_lins);
lins_props = regionprops(lins_label);
lins_box = [lins_props.BoundingBox]; 
lins_box = reshape(lins_box,[4 lins_num]);