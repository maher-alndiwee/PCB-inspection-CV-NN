function [def_type]=def_classifier2(pat_type,pat_idx,pat_pos,def_idx ,lvq1,lvq2,lvq3,bw_ref,bw_tst,bw_def,lins_box,hols_box,def_box)



if (strcmp(pat_type,'line'))
    if (strcmp(pat_pos,'match'))
    c_pat = imcrop(bw_ref,def_box(:,def_idx));
     in_pat = reshape(norm_fun2(c_pat),64,1);
      type = sim(lvq1,in_pat);
      def_type =vec2ind(type);
    elseif(strcmp(pat_pos,'too close'))
        c_pat = imcrop(bw_def,def_box(:,def_idx));
         in_pat = reshape(norm_fun2(c_pat),64,1);
         type = sim(lvq1,in_pat);
      def_type = vec2ind(type);
    elseif(strcmp(pat_pos,'inside'))
        c_pat = imcrop(bw_tst,lins_box(:,pat_idx));
         in_pat =  reshape(norm_fun2(c_pat),64,1);
         type = sim(lvq3,in_pat);
     def_type = vec2ind(type);
    end

    
       
  
elseif((strcmp(pat_pos,'match')|| strcmp(pat_pos,'inside'))&& strcmp(pat_type,'hole'))
     c_pat = imcrop(bw_def,hols_box(:,pat_idx));
       in_pat = reshape(norm_fun2(c_pat),64,1);
         type = sim(lvq2,in_pat);
   def_type = vec2ind(type);
elseif(strcmp(pat_pos,'apart of'))
  
      c_pat = imcrop(bw_def,def_box(:,def_idx));

   
        in_pat = reshape(norm_fun2(c_pat),64,1);
         type = sim(lvq3,in_pat);
      def_type =vec2ind(type);
     
else
    def_type = ' Spurious Copper or  Etching defeat ' ;
    
end
    
    
