function[bw_lins]=fnd_lins(bw_ref,bw_hols_dilt,erod_dsk_siz,dilt_sqr_siz)
wb_ref = bw_ref<1;
bw_lins=wb_ref - bw_hols_dilt;
%figure
%imshow(bw_lins)
se_dsk=strel('square',erod_dsk_siz);
se_squr=strel('square',dilt_sqr_siz);

bw_lins_erod=imerode(bw_lins,se_dsk);
bw_lins_dilt=imdilate(bw_lins_erod,se_squr);
bw_lins=im2bw(bw_lins_dilt);  
%figure
%imshow(bw_lins_dilt)
