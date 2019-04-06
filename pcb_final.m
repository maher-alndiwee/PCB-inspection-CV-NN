close all
clc
REF=imread('pcb.png');
TST=imread('pcbe.png');
ref=rgb2gray(REF);
tst=rgb2gray(TST);

level_ref=graythresh(ref);
level_tst=graythresh(tst);
bw_ref=im2bw(ref,level_ref);
bw_tst=im2bw(tst,level_tst);
bw_def= xor(bw_ref,bw_tst);
wb_ref= bw_ref < 1; 
wb_tst= bw_tst <1;
figure
subplot(2,2,1)
imshow(bw_ref)
subplot(2,2,2)
imshow(bw_tst)
subplot(2,2,3)
imshow(bw_def)

figure,imshow(bw_def)
figure


cc_hols=bwconncomp(bw_ref,4);

bw_hols = false(size(bw_ref));
for i=2:cc_hols.NumObjects
   

bw_hols(cc_hols.PixelIdxList{i}) = true;

end

se_dsk7 = strel('disk',20);
se_dsk2=strel('disk',2);
se_squr2=strel('square',3);

 bw_hols_dilt= imdilate(bw_hols,se_dsk7);
imshow(bw_hols_dilt)
[hols_label hols_num] = bwlabel(bw_hols_dilt);

hols_props = regionprops(hols_label);
hols_box = [hols_props.BoundingBox]; 
hols_box = reshape(hols_box,[4 hols_num]);
figure,imshow(ref)
hold on;
for cnt = 1:hols_num
rectangle('position',hols_box(:,cnt),'edgecolor','r','curvature',[1,1]);
end
hold off





bw_lins=wb_ref - bw_hols_dilt;
figure
imshow(bw_lins)

bw_lins_erod=imerode(bw_lins,se_dsk2);
bw_lins_dilt=imdilate(bw_lins_erod,se_squr2);
bw_lins=bw_lins_dilt;
figure
imshow(bw_lins_dilt)

[lins_label lins_num]=bwlabel(bw_lins);
lins_props = regionprops(lins_label);
lins_box = [lins_props.BoundingBox]; 
lins_box = reshape(lins_box,[4 lins_num]);
figure,imshow(ref)
hold on;
for cnt = 1:lins_num
rectangle('position',lins_box(:,cnt),'edgecolor','r');
end
hold off
[def_label def_num]= bwlabel(bw_def);
def_props=regionprops(def_label);
def_box=[def_props.BoundingBox];
def_box= reshape(def_box,[4 def_num]);
figure, imshow(bw_tst)
hold on
for cnt=1:def_num
    rectangle('position',def_box(:,cnt),'edgecolor','r','curvature',[1,1]);
end
hold off
%detrimin the lins and hols of the segment

seg_hols_idx=zeros(hols_num,1);
seg_lins_idx=zeros(lins_num,1);
seg_lins_num=0;
seg_hols_num=0;
for i=1:lins_num
    x_lins=lins_box(1,i);
    y_lins=lins_box(2,i);
    w_lins=lins_box(3,i);
    l_lins=lins_box(4,i);
if((((0<= x_lins)&&(x_lins <= 200))||((0<= x_lins + w_lins)&&(x_lins + w_lins <= 200))) && (((0 <= y_lins)&&( y_lins <= 200))||((0 <= y_lins + l_lins)&&(y_lins + l_lins <=   200))))
       seg_lins_num = seg_lins_num + 1
    seg_lins_idx(seg_lins_num)= i; 
       
          
    end
   
    
end
