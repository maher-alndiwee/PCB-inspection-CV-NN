function [bw_def def_box] = fnd_def(bw_ref,bw_tst)
bw_def= xor(bw_ref,bw_tst);
[def_label def_num]= bwlabel(bw_def);
def_props=regionprops(def_label);
def_box=[def_props.BoundingBox];
def_box= reshape(def_box,[4 def_num]);