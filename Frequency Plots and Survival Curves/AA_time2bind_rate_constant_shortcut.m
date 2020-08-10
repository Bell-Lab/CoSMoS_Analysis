%time to first binding rate constant short cut
%k=sum(total time to first bidning including non events)/sum(time to first
%binding of successful events)

%note: i have written this for a fictional "cia111" so ASSIGN cia111 to
%whichever cia you would like to analyze hte time to first binding for

cia111=cia3;

time_2_bind_x=cia111(:,1)==-2;
time2bind_matrix=cia111(time_2_bind_x,:);

t2bind_successful=[]


for index=1:length(time2bind_matrix(:,1));
    if time2bind_matrix(index,5)<1200;
       t2bind_successful=[t2bind_successful; 
           time2bind_matrix(index,:)];
     end
 end
sum_successful=sum(t2bind_successful(:,5));
sum_all=sum(time2bind_matrix(:,5));

tau=sum_all/sum_successful
k=sum_successful/sum_all
