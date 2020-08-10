x_no_events=(cia(:,1)==-2|cia(:,1)==0|cia(:,1)==2);
no_events_matrix=cia(x_no_events,:);
total_no_event_time=sum(no_events_matrix(:,5));
x_events=(cia(:,1)==-3|cia(:,1)==1|cia(:,1)==3);
events_matrix=cia(x_events,:);
tot_event_time_vs_time=[];
max_duration=max(events_matrix(:,5));
for index=[0:3:max_duration]+.1
    events_larger_than_index=events_matrix(:,5)>index;
    tot_event_time_vs_time=[tot_event_time_vs_time; index-.1 sum(events_larger_than_index)];
end

x_no_events2=(cia2(:,1)==-2|cia2(:,1)==0|cia2(:,1)==2);
no_events_matrix2=cia2(x_no_events2,:);
total_no_event_time2=sum(no_events_matrix2(:,5));
x_events2=(cia2(:,1)==-3|cia2(:,1)==1|cia2(:,1)==3);
events_matrix2=cia2(x_events2,:);
tot_event_time_vs_time2=[];
max_duration2=max(events_matrix2(:,5));
for index=[0:3:max_duration2]+.1
    events_larger_than_index2=events_matrix2(:,5)>index;
    tot_event_time_vs_time2=[tot_event_time_vs_time2; index-.1 sum(events_larger_than_index2)];
end


x_no_events3=(cia3(:,1)==-2|cia3(:,1)==0|cia3(:,1)==2);
no_events_matrix3=cia3(x_no_events3,:);
total_no_event_time3=sum(no_events_matrix3(:,5));
x_events3=(cia3(:,1)==-3|cia3(:,1)==1|cia3(:,1)==3);
events_matrix3=cia3(x_events3,:);
tot_event_time_vs_time3=[];
max_duration3=max(events_matrix3(:,5));
for index=[0:3:max_duration3]+.1
    events_larger_than_index3=events_matrix3(:,5)>index;
    tot_event_time_vs_time3=[tot_event_time_vs_time3; index-.1 sum(events_larger_than_index3)];
end


x_no_events4=(cia4(:,1)==-2|cia4(:,1)==0|cia4(:,1)==2);
no_events_matrix4=cia4(x_no_events4,:);
total_no_event_time4=sum(no_events_matrix4(:,5));
x_events4=(cia4(:,1)==-3|cia4(:,1)==1|cia4(:,1)==3);
events_matrix4=cia4(x_events4,:);
tot_event_time_vs_time4=[];
max_duration4=max(events_matrix4(:,5));
for index=[0:3:max_duration4]+.1
    events_larger_than_index4=events_matrix4(:,5)>index;
    tot_event_time_vs_time4=[tot_event_time_vs_time4; index-.1 sum(events_larger_than_index4)];
end

x_no_events5=(cia5(:,1)==-2|cia5(:,1)==0|cia5(:,1)==2);
no_events_matrix5=cia5(x_no_events5,:);
total_no_event_time5=sum(no_events_matrix5(:,5));
x_events5=(cia5(:,1)==-3|cia5(:,1)==1|cia5(:,1)==3);
events_matrix5=cia5(x_events5,:);
tot_event_time_vs_time5=[];
max_duration5=max(events_matrix5(:,5));
for index=[0:3:max_duration5]+.1
    events_larger_than_index5=events_matrix5(:,5)>index;
    tot_event_time_vs_time5=[tot_event_time_vs_time5; index-.1 sum(events_larger_than_index5)];
end

x_no_events6=(cia6(:,1)==-2|cia6(:,1)==0|cia6(:,1)==2);
no_events_matrix6=cia6(x_no_events6,:);
total_no_event_time6=sum(no_events_matrix6(:,5));
x_events6=(cia6(:,1)==-3|cia6(:,1)==1|cia6(:,1)==3);
events_matrix6=cia6(x_events6,:);
tot_event_time_vs_time6=[];
max_duration6=max(events_matrix6(:,5));
for index=[0:3:max_duration6]+.1
    events_larger_than_index6=events_matrix6(:,5)>index;
    tot_event_time_vs_time6=[tot_event_time_vs_time6; index-.1 sum(events_larger_than_index6)];
end


figure(40);hold on; 
plot(tot_event_time_vs_time(:,1)+.5,tot_event_time_vs_time(:,2)/total_no_event_time,'.','MarkerEdgeColor', [1,0,0]);
length(events_matrix(:,5));
plot(tot_event_time_vs_time2(:,1)+.5,tot_event_time_vs_time2(:,2)/total_no_event_time2,'.','MarkerEdgeColor', [0,0,0]);
length(events_matrix2(:,5));
plot(tot_event_time_vs_time3(:,1)+.5,tot_event_time_vs_time3(:,2)/total_no_event_time3,'.','MarkerEdgeColor', [0,1,0]);
length(events_matrix3(:,5));
plot(tot_event_time_vs_time4(:,1)+.5,tot_event_time_vs_time4(:,2)/total_no_event_time4,'.','MarkerEdgeColor', [0,0,1]);
length(events_matrix4(:,5));
plot(tot_event_time_vs_time5(:,1)+.5,tot_event_time_vs_time5(:,2)/total_no_event_time5,'.','MarkerEdgeColor', [0,0.5,0.5]);
length(events_matrix5(:,5));
plot(tot_event_time_vs_time6(:,1)+.5,tot_event_time_vs_time6(:,2)/total_no_event_time6'.','MarkerEdgeColor', [0.5,0.5,0]);
length(events_matrix6(:,5));



xlabel('seconds','FontName','Arial')
ylabel('frequency')
l=legend({'Mcms with Unphosphorylated ORC','Cdt1 with UnPhos ORC','Mcms with Phosphorylated ORC','Cdt1 with Phos ORC','Mcms with no ORC','Cdt1 with no ORC'},'Box','off')
