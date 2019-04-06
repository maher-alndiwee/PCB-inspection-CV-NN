function new_pat=norm_fun(pat)
  
       %#ok old pattern
temp_pat=[];    %#ok temporally pattern
new_pat=[];     %#ok new pattern (final pattern / output pattern)
syms fr fc p r c
sa=NaN(1,8);    %normalization factors for rows
sb=NaN(1,8);    %normalization factors for columns
%normalization loop
             %old pattern 
    [row_cnt,col_cnt]=size(pat);      %size of old pattern
    
    if(row_cnt > 8)
        temp_pat=ones(8,col_cnt); %use 1's because the dominant value in AND operation is 0
        temp_pat(1,:)=pat(1,:);sa(1)=1;   %first row in temporally pattern
        temp_pat(8,:)=pat(row_cnt,:);sa(8)=1;  %final row in temporally pattern
        rest_row=row_cnt-2;
        row_num=round(rest_row/6);
        row_check=rest_row-(5*row_num);
        %finding the normalization factors for rows sa
        if (row_check > 0) 
            sa(2:6)=row_num;sa(7)=row_check;    
        elseif (row_check < 0)
            sa(2:4)=row_num;sa(5:7)=1;
        else
            sa(2:5)=row_num;sa(7)=1;sa(6)=sa(2)-sa(7);
        end
        
        %filling the temporally pattern with values
        for r=sa(1)+1:sa(1)+sa(2);temp_pat(2,:)=temp_pat(2,:) & pat(r,:);end
        for r=sum(sa(1:2))+1:sum(sa(1:2))+sa(3);temp_pat(3,:)=temp_pat(3,:) & pat(r,:);end
        for r=sum(sa(1:3))+1:sum(sa(1:3))+sa(4);temp_pat(4,:)=temp_pat(4,:) & pat(r,:);end
        for r=sum(sa(1:4))+1:sum(sa(1:4))+sa(5);temp_pat(5,:)=temp_pat(5,:) & pat(r,:);end
        for r=sum(sa(1:5))+1:sum(sa(1:5))+sa(6);temp_pat(6,:)=temp_pat(6,:) & pat(r,:);end
        for r=sum(sa(1:6))+1:sum(sa(1:6))+sa(7);temp_pat(7,:)=temp_pat(7,:) & pat(r,:);end
        
    elseif row_cnt < 8
        temp_pat=NaN(8,col_cnt);
        row_num=round(8/row_cnt);
        switch row_cnt
            case 1
                sa(1)=row_num;sa(2:8)=0;
                for fr=1:8;temp_pat(fr,:)=pat(1,:);end
            case 2
                sa(1:2)=row_num;sa(3:8)=0;
                for fr=1:4;temp_pat(fr,:)=pat(1,:);end
                for fr=5:8;temp_pat(fr,:)=pat(2,:);end
            case 3
                sa(1:2)=row_num;sa(3)=2;sa(4:8)=0;
                for fr=1:3;temp_pat(fr,:)=pat(1,:);end
                for fr=4:6;temp_pat(fr,:)=pat(2,:);end
                for fr=7:8;temp_pat(fr,:)=pat(3,:);end
            case 4
                sa(1:4)=row_num;sa(5:8)=0;
                for fr=1:2;temp_pat(fr,:)=pat(1,:);end
                for fr=3:4;temp_pat(fr,:)=pat(2,:);end
                for fr=5:6;temp_pat(fr,:)=pat(3,:);end
                for fr=7:8;temp_pat(fr,:)=pat(4,:);end
            case 5
                sa(1:3)=row_num;sa(4:5)=1;sa(6:8)=0;
                for fr=1:2;temp_pat(fr,:)=pat(1,:);end
                for fr=3:4;temp_pat(fr,:)=pat(2,:);end
                for fr=5:6;temp_pat(fr,:)=pat(3,:);end
                temp_pat(7,:)=pat(4,:);
                temp_pat(8,:)=pat(5,:);
            case 6
                sa(1:4)=row_num;sa(5:6)=2;sa(7:8)=0;
                for fr=1:2;temp_pat(fr,:)=pat(1,:);end
                temp_pat(3,:)=pat(2,:);
                temp_pat(4,:)=pat(3,:);
                temp_pat(5,:)=pat(4,:);
                temp_pat(6,:)=pat(5,:);
                for fr=7:8;temp_pat(fr,:)=pat(6,:);end
            case 7
                sa(1:6)=row_num;sa(7)=2;sa(8)=0;
                for fr=1:6;temp_pat(fr,:)=pat(fr,:);end
                for fr=7:8;temp_pat(fr,:)=pat(7,:);end
        end
        
       
    else
     
        temp_pat=pat;
    end
    
    if (col_cnt > 8)
        new_pat=ones(8,8);
        new_pat(:,1)=temp_pat(:,1);sb(1)=1;
        new_pat(:,8)=temp_pat(:,col_cnt);sb(8)=1;
        rest_col=col_cnt - 2;
        col_num=round(rest_col/6);
        col_check=rest_col - (5*col_num);
        
        if (col_check > 0) 
            sb(2:6)=col_num;sb(7)=col_check;    
        elseif (col_check < 0)
            sb(2:4)=col_num;sb(5:7)=1;
        else
            sb(2:5)=col_num;sb(7)=1;sb(6)=sb(2)-sb(7);
        end
        
    
        for c=sb(1)+1:sb(1)+sb(2);new_pat(:,2)=new_pat(:,2) & temp_pat(:,c);end
        for c=sum(sb(1:2))+1:sum(sb(1:2))+sb(3);new_pat(:,3)=new_pat(:,3) & temp_pat(:,c);end
        for c=sum(sb(1:3))+1:sum(sb(1:3))+sb(4);new_pat(:,4)=new_pat(:,4) & temp_pat(:,c);end
        for c=sum(sb(1:4))+1:sum(sb(1:4))+sb(5);new_pat(:,5)=new_pat(:,5) & temp_pat(:,c);end
        for c=sum(sb(1:5))+1:sum(sb(1:5))+sb(6);new_pat(:,6)=new_pat(:,6) & temp_pat(:,c);end
        for c=sum(sb(1:6))+1:sum(sb(1:6))+sb(7);new_pat(:,7)=new_pat(:,7) & temp_pat(:,c);end
        
    elseif col_cnt < 8
        new_pat=NaN(8,8);
        col_num=round(8/col_cnt);
        switch col_cnt
            case 1
                sb(1)=col_num;sb(2:8)=0;
                for fc=1:8;new_pat(:,fc)=temp_pat(:,1);end
            case 2
                sb(1:2)=col_num;sb(3:8)=0;
                for fc=1:4;new_pat(:,fc)=temp_pat(:,1);end
                for fc=5:8;new_pat(:,fc)=temp_pat(:,2);end
            case 3
                sb(1:2)=col_num;sb(3)=2;sb(4:8)=0;
                for fc=1:3;new_pat(:,fc)=temp_pat(:,1);end
                for fc=4:6;new_pat(:,fc)=temp_pat(:,2);end
                for fc=7:8;new_pat(:,fc)=temp_pat(:,3);end
            case 4
                sb(1:4)=col_num;sb(5:8)=0;
                for fc=1:2;new_pat(:,fc)=temp_pat(:,1);end
                for fc=3:4;new_pat(:,fc)=temp_pat(:,2);end
                for fc=5:6;new_pat(:,fc)=temp_pat(:,3);end
                for fc=7:8;new_pat(:,fc)=temp_pat(:,4);end
            case 5
                sb(1:3)=col_num;sb(4:5)=1;sb(6:8)=0;
                for fc=1:2;new_pat(:,fc)=temp_pat(:,1);end
                for fc=3:4;new_pat(:,fc)=temp_pat(:,2);end
                for fc=5:6;new_pat(:,fc)=temp_pat(:,3);end
                new_pat(:,7)=temp_pat(:,4);
                new_pat(:,8)=temp_pat(:,5);
            case 6
                sb(1:4)=col_num;sb(5:6)=2;sb(7:8)=0;
                for fc=1:2;new_pat(:,fc)=temp_pat(:,1);end
                new_pat(:,3)=temp_pat(:,2);
                new_pat(:,4)=temp_pat(:,3);
                new_pat(:,5)=temp_pat(:,4);
                new_pat(:,6)=temp_pat(:,5);
                for fc=7:8;new_pat(:,fc)=temp_pat(:,6);end
            case 7
                sb(1:6)=col_num;sb(7)=2;sb(8)=0;
                for fc=1:6;new_pat(:,fc)=temp_pat(:,fc);end
                for fc=7:8;new_pat(:,fc)=temp_pat(:,7);end
        end
        
     
        
    else
        new_pat=temp_pat;
    end
  
    
end