function[teta,crop_rec]=find_rotation(I,corners)
l41=abs(corners(2,4)-corners(2,1));
w41=abs(corners(1,4)-corners(1,1));
l12=abs(corners(2,1)-corners(2,2));
w12=abs(corners(1,1)-corners(1,2));
l23=abs(corners(2,2)-corners(2,3));
w23=abs(corners(1,2)-corners(1,3));
l34=abs(corners(2,3)-corners(2,4));
w34=abs(corners(1,3)-corners(1,4));
w=(sqrt(l12^2+w12^2)+sqrt(l34^2+w34^2))/2;
l=(sqrt(l23^2+w23^2)+sqrt(l41^2+w41^2))/2;
teta=atand((l41+l23+w12+w34)/(w41+w23+l12+l34));
if (w>l)
    t=w;
    w=l;
    l=t;
    teta=teta-90;
end
if((corners(1,1)==corners(1,2))&&(corners(2,1)==corners(2,2)))
    teta =0;
end
xs=min(corners(1,1),corners(1,2))+1;
ys=min(corners(2,1),corners(2,2))+1;
xe=max(corners(1,3),corners(1,4))-1;
ye=max(corners(2,3),corners(2,4))-1;
w=xe-xs;
l=ye-ys;
crop_rec=[xs ys w l];
end