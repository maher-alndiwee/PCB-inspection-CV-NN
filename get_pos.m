function[pos]=get_pos(x_def,y_def,w_def,l_def,x_pat,y_pat,w_pat,l_pat)
if((x_pat == x_def)&&(y_pat == y_def)&&(w_pat == w_def)&&(l_pat == l_def))
    pos = 'match';
elseif((x_pat <= x_def)&&(y_pat <= y_def)&&(x_pat + w_pat >= x_def + w_def)&&(y_pat + l_pat >= y_def + l_def))
    pos = 'inside';
    elseif((x_pat >= x_def)&&(y_pat >= y_def)&&(x_pat + w_pat <= x_def + w_def)&&(y_pat + l_pat <= y_def + l_def))
    pos = 'too close';
elseif ((((x_pat <= x_def + w_def)||(x_def <= x_pat + w_pat))&&(y_pat < y_def + l_def)&&(y_def < y_pat + l_pat))||(((y_pat <= y_def + l_def)||(y_def <= y_pat + l_pat))&&(x_pat < x_def + w_def)&&(x_def < x_pat + w_pat)))
    pos = 'apart of';

else
    pos = 'out';
end
