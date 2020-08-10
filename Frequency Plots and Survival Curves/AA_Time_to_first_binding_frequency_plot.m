x_no_events=(cia(:,1)==-2|cia(:,1)==0|cia(:,1)==2);
no_events_matrix=cia(x_no_events,:);
total_no_event_time=sum(no_events_matrix(:,5));
x_events=cia(:,1)==-2;
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
x_events2=cia2(:,1)==-2;
events_matrix2=cia2(x_events2,:);
tot_event_time_vs_time2=[];
max_duration2=max(events_matrix2(:,5));
for index=[0:3:max_duration2]+.1
    events_larger_than_index2=events_matrix2(:,5)>index;
    tot_event_time_vs_time2=[tot_event_time_vs_time2; index-.1 sum(events_larger_than_index2)];
end

figure(40);hold on; 
plot(tot_event_time_vs_time(:,1)+.5,tot_event_time_vs_time(:,2)/total_no_event_time,'.','MarkerEdgeColor', [1,0,0]);
length(events_matrix(:,5));
plot(tot_event_time_vs_time2(:,1)+.5,tot_event_time_vs_time2(:,2)/total_no_event_time2,'.','MarkerEdgeColor', [0,0,0]);
length(events_matrix2(:,5));


xlabel('seconds','FontName','Arial')
ylabel('frequency')
l=legend({'MCMs with Unphos ORC','Mcms with Phos ORC','mcm time to first binding frequency unphos orc','mcm time to first bidning frequency with phos orc' },'Box','off')
