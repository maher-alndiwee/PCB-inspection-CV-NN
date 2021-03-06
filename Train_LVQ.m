function [T_LVQ_net1,T_LVQ_net2,T_LVQ_net3,cnt1,cnt2,cnt3]=Train_LVQ(LVQ_net1,LVQ_net2,LVQ_net3,training_set,sample_num,Epochs,L1,L2,L3)
cnt1 = 1;%init counters
cnt2=1;
cnt3=1;
T1=zeros(2,sample_num);
T2=zeros(3,sample_num);
T3=zeros(5,sample_num);
for i =1:sample_num %scaning training set and classfication of samples in groups 
    if (training_set{i,3}==1)
        in_1{cnt1} = reshape(norm_fun2(training_set{i,1}),64,1); % resizing and reshiping the sample image to victor 64*1;
        T1(training_set{i,2},cnt1) = 1;           %set the target value of this input
        cnt1 = cnt1+1;
    elseif (training_set{i,3}==2)
        in_2{cnt2} = reshape(norm_fun2(training_set{i,1}),64,1);
        T2(training_set{i,2},cnt2) = 1;
        cnt2 = cnt2+1;
    elseif (training_set{i,3}==3)
        in_3{cnt3} = reshape(norm_fun2(training_set{i,1}),64,1);
        T3(training_set{i,2},cnt3) = 1;
        cnt3 = cnt3+1;
    end
end


%initialization of training operation

LVQ_net1.trainparam.epochs=Epochs;

LVQ_net2.trainparam.epochs=Epochs;

LVQ_net3.trainparam.epochs=Epochs;

%training the LVQ nets
if ((cnt1 >1)&&(L1 == 1))
    Tt1=T1(:,1:cnt1-1);
    T_LVQ_net1=train(LVQ_net1,cell2mat(in_1),Tt1);
else T_LVQ_net1 = LVQ_net1;
end
if ((cnt2 >1)&&(L2 == 1))
     Tt2=T2(:,1:cnt2-1);
    T_LVQ_net2=train(LVQ_net2,cell2mat(in_2),Tt2);  
else T_LVQ_net2 = LVQ_net2;
end
if ((cnt3 >1)&&(L3 == 1))
     Tt3=T3(:,1:cnt3-1)
   T_LVQ_net3=train(LVQ_net3,cell2mat(in_3),Tt3); 
else T_LVQ_net3 = LVQ_net3;
end




