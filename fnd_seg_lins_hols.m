function [seg_lins_idx , seg_lins_num , seg_hols_idx , seg_hols_num] = fnd_seg_lins_hols(x_seg,y_seg,w_seg,l_seg,lins_box,hols_box)
x = size(hols_box);
hols_num = x(2);
x = size(lins_box);
lins_num = x(2);

seg_hols_idx=zeros(hols_num,1);
seg_lins_idx=zeros(lins_num,1);
seg_lins_num=0;
seg_hols_num=0;
for i=1:lins_num
    x_lins=lins_box(1,i);
    y_lins=lins_box(2,i);
    w_lins=lins_box(3,i);
    l_lins=lins_box(4,i);
    if(intrsct(x_seg,y_seg,w_seg,l_seg,x_lins,y_lins,w_lins,l_lins))
       seg_lins_num = seg_lins_num + 1;
    seg_lins_idx(seg_lins_num)= i; 
       
          
 end
   
    
end
for i=1:hols_num
    x_hols=hols_box(1,i);
    y_hols=hols_box(2,i);
    w_hols=hols_box(3,i);
    l_hols=hols_box(4,i);
if(intrsct(x_seg,y_seg,w_seg,l_seg,x_hols,y_hols,w_hols,l_hols))
    seg_hols_num = seg_hols_num + 1;
    seg_hols_idx(seg_hols_num)= i; 
       
          
 end
   
    
end