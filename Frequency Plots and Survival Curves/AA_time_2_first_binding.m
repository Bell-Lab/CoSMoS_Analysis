%time to first bidning plots

time_2_bind_x=cia(:,1)==-2;
time2bind_matrix=cia(time_2_bind_x,:);
total_time=sum(time2bind_matrix(:,5));

bound_at_start_x=cia(:,1)==-3;
fraction_bound_at_start=sum(bound_at_start_x)/max(cia(:,7));


tot_t2btime=[0 fraction_bound_at_start];
for index=[1:1:(max(time2bind_matrix(:,5))+1)]+.1;
    t2b_smaller_than_index_x=time2bind_matrix(:,5)<index;
    t2b_smaller_than_index=time2bind_matrix(t2b_smaller_than_index_x,5);
    tot_t2btime=[tot_t2btime; index-.1 (sum(t2b_smaller_than_index)/total_time+fraction_bound_at_start)];
end

figure(50);hold on;
plot(tot_t2btime(:,1)+.5,tot_t2btime(:,2),'.','MarkerEdgeColor', 'b');

time_2_bind_x2=cia3(:,1)==-2;
time2bind_matrix2=cia3(time_2_bind_x2,:);
total_time2=sum(time2bind_matrix2(:,5));

bound_at_start_x2=cia3(:,1)==-3;
fraction_bound_at_start2=sum(bound_at_start_x2)/max(cia3(:,7));

tot_t2btime2=[0 fraction_bound_at_start2];
for index=1:1:(max(time2bind_matrix2(:,5))+1)+.1;
    t2b_smaller_than_index2_x=time2bind_matrix2(:,5)<index;
    t2b_smaller_than_index2=time2bind_matrix2(t2b_smaller_than_index2_x,5);
    tot_t2btime2=[tot_t2btime2; index-.1 (sum(t2b_smaller_than_index2)/total_time2+fraction_bound_at_start2)];
end

plot(tot_t2btime2(:,1)+.5,tot_t2btime2(:,2),'.','MarkerEdgeColor', [1,0,0]);



xlabel('time to first binding (seconds)','FontName','Arial')
ylabel('fraction bound')
l=legend({'MCMs with Unphos ORC','Mcms with Phos ORC'},'Box','off')

