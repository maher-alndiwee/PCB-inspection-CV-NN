function[bw_hols] = fnd_hols(bw_ref)

cc_hols=bwconncomp(bw_ref,4);
bw_hols = false(size(bw_ref));
hols_area= struct2cell(regionprops(cc_hols,'Area'));
avr_area = 0;
for i=2:cc_hols.NumObjects
  
avr_area = hols_area{i} + avr_area;



end
avr_area = avr_area/cc_hols.NumObjects - 1 ;

for i=2:cc_hols.NumObjects
   
if((hols_area{i} < 3 * avr_area)&&(hols_area{i} >  avr_area/3))
bw_hols(cc_hols.PixelIdxList{i}) = true;
end
end








