function corners =find_corner(J)
I=rgb2gray(J);
[m n]=size(I);
for i=1:m
    for j=1:n
        if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
            y1=i;
            x1=j;
           
            break
        end
           
    end
    if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
             break
         end
end 
for k=1:m
    for l=1:n
        i=m+1-k;
        j=n+1-l;
  
        if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
            y3=i;
            x3=j;
           
            break
        end
           
     end
if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
    break
         end
end 
 for j=1:n
     for i=1:m
   
if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
    y2=i;
            x2=j;
           
            break
        end
           
     end
if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
    break
         end
end 
for k=1:n
    for l=1:m
        i=m+1-l;
        j=n+1-k;
  
if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
    y4=i;
            x4=j;
           
            break
        end
           
     end
if((I(i,j)<230)&&(J(i,j,1)~=J(i,j,2))&&(J(i,j,3)<=J(i,j,2)))
    break
         end
end 
corners=[x1 x2 x3 x4 ;y1 y2 y3 y4];