function [defacts_pat_pos] = scan_def_pos(def_box,hols_box,lins_box)

x = size(def_box);
def_num = x(2);
x = size(hols_box);
hols_num = x(2);
x = size(lins_box);
lins_num = x(2);
pat_num = hols_num + lins_num ;
 pat_pos = cell(pat_num,4);
defacts_pat_pos = cell(def_num,2);
for i = 1 : def_num
    x_def = def_box(1,i);
    y_def = def_box(2,i);
    w_def = def_box(3,i);
    l_def = def_box(4,i);
 
   
[seg_lins_idx , seg_lins_num , seg_hols_idx , seg_hols_num] = fnd_seg_lins_hols(x_def,y_def,w_def,l_def,lins_box,hols_box);
        pat_cnt = 0;
    if (seg_lins_num + seg_hols_num == 0)
       
         if((x_def - w_def/4)>0)
        x_seg = x_def - w_def/4;
         else
        x_seg = 1;
         end
        if((y_def - l_def/4) >0)
        y_seg = y_def - l_def/4;
        else
        y_seg = 1;
        end
    w_seg = 1.5 * w_def;
    l_seg = 1.5 * l_def;
    [seg_lins_idx , seg_lins_num , seg_hols_idx , seg_hols_num] = fnd_seg_lins_hols(x_seg,y_seg,w_seg,l_seg,lins_box,hols_box);
    end
     if (seg_lins_num + seg_hols_num ~= 0)       
        for h = 1 : seg_hols_num
            hol_idx = seg_hols_idx(h);
            pat_cnt = pat_cnt + 1;
            x_hol = hols_box(1,hol_idx);
            y_hol = hols_box(2,hol_idx);
            w_hol = hols_box(3,hol_idx);
            l_hol = hols_box(4,hol_idx);
            pat_pos{pat_cnt,1} = 'hole' ;
            pat_pos{pat_cnt,2} = hol_idx;
            pat_pos{pat_cnt,3} = get_pos(x_def,y_def,w_def,l_def,x_hol,y_hol,w_hol,l_hol);
            
           
        
        
        end
        
        
        
         for l = 1 : seg_lins_num
            lin_idx = seg_lins_idx(l);
            pat_cnt = pat_cnt + 1;
            x_lin = lins_box(1,lin_idx);
            y_lin = lins_box(2,lin_idx);
            w_lin = lins_box(3,lin_idx);
            l_lin = lins_box(4,lin_idx);
            pat_pos{pat_cnt,1} = 'line' ;
            pat_pos{pat_cnt,2} = lin_idx;
            pat_pos{pat_cnt,3} = get_pos(x_def,y_def,w_def,l_def,x_lin,y_lin,w_lin,l_lin);
            
           
        
        
        end
    
    
    
    defacts_pat_pos{i,1} = pat_pos;
    defacts_pat_pos{i,2} = pat_cnt;
    else
         defacts_pat_pos{i,1} = 0;
    defacts_pat_pos{i,2} = 0;
     end
end