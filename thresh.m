 clc;

          clear all;
          close all;


        im=imread('aqdef2.jpg');
        subplot(3,3,1);
        imshow(im);
        title('original image');
        im=rgb2gray(im);
        im=double(im);

       subplot(3,3,2);    
       imshow(im);
       title('gray scale image');

        [row col]=size(im);
        max_im=max(max(im));
        h=zeros(1,max_im+1);

 !1st block 
      for n=1:1:60
        for m=1:1:60
             a(n,m)=im(n,m);
        end
     end

      a=a+1;
    for n=1:1:60
        for m=1:1:60
            t=a(n,m);
             h(t)=h(t)+1;
        end
    end

      subplot(3,3,3);
         bar(h)
      [X,Y]=ginput(1); 
    for n=1:1:60
         for m=1:1:60
             if a(n,m)<X
                a(n,m)=0;
       else
        a(n,m)=255;
       end
    end
   end

     subplot(3,3,4);
    imshow(uint8(a))
    title('1st block image');

     !2nd block
    for n=1:1:60
       for m=61:1:60
           b(n,m-60)=im(n,m)
       end
     end

      b=b+1;
     for n=1:1:60
           for m=1:1:60
         t=b(n,m);
           h(t)=h(t)+1;
        end
        end

     figure(2)
       bar(h)
       [X,Y]=ginput(1);
        for n=1:1:60
           if b(n,m)<X
             b(n,m)=0;
           else
             b(n,m)=255;
          end
        end


       imshow(uint8(b))

     !3rd block

    for n=61:1:120
         for m=1:1:60
    c(n-60,m)=im(n,m);
     end 
     end

    c=c+1;
  for n=1:1:60
      for m=1:1:60
         t=c(n,m);
    h(t)=h(t)+1;
   end
  end

   figure(3)
  bar(h)
   [X,Y]=ginput(1);
      for n=1:1:60
         for m=1:1:60
     if c(n,m)< X
        c(n,m)=0;
    else
         c(n,m)=255;
      end
   end
  end

  imshow(uint8(c))

  !final block

for n=1:1:row
   for m=61:1:col
    d(n-60,m-60)=im(n,m);
  end
end
   d=d+1;
      for n=1:1:60
    for m=1:1:60
       t=d(n,m);
    h(t)=h(t)+1;
  end
end
 figure(4);

 bar(h);
[X,Y]=ginput(1); 
for n=1:1:60
   for m=1:1:60
    if d(n,m)<X
          d(n,m)=0;
    else
        d(n,m)=255;
     end
   end
 end

  imshow(uint8(d))
  s=[a b;c d];

 figure(5);
  imshow(uint(s))
