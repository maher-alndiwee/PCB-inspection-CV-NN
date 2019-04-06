function[LVQ_net1,LVQ_net2,LVQ_net3]= creat_classifier()
input = zeros(64,1);
LVQ_net1=newlvq(input,20,[],0.1);
LVQ_net2=newlvq(input,40,[],0.1);
LVQ_net3=newlvq(input,50,[],0.1);


init(LVQ_net1);

init(LVQ_net2);

init(LVQ_net3);
