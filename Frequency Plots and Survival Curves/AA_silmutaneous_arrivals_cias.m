% to isolate mcms/cdt1 that arrive silmutaneously


%your Mcm cia needs to be named "cia"
%your Cdt1 cia needs to be named "cia2"
Mcm_Events_with_Cdt1_cia=[];
Cdt1_Events_with_Mcms_cia=[];
num_DNA_AOIs=max(cia(:,7))
for index=[1:1:num_DNA_AOIs]
    index
    x1=cia(:,7)==index; 
    x2=cia2(:,7)==index;
    red=cia(x1,:);     %define matrices for each DNA aoi for each color
    green=cia2(x2,:);
    
    x1_events=(red(:,1)==1|red(:,1)==3);
    x2_events=(green(:,1)==1|green(:,1)==3);
    red_events=red(x1_events,:);      %isolate just the middle and end events where we can resolve that a 
    green_events=green(x2_events,:);  %silmultaneous arrival happened, and gets rid of silmultaneous non-events, ie empty DNA 
    
     silmultaneous_events=[intersect(red_events(:,2),green_events(:,2));0]   %find intersection of starting frames for red and green
    silmultaneous_events_plus1=[intersect(red_events(:,2)+1,green_events(:,2));0] %calls if events off by 1 in one direction
    silmultaneous_events_minus1=[intersect(red_events(:,2)-1,green_events(:,2));0] %if events are off by one in the other direction
    
   silm_ev_x1=red_events(:,2)==(silmultaneous_events(1));
    for index2=[2:1:length(silmultaneous_events)];
        placeholder=red_events(:,2)==(silmultaneous_events(index2));
        silm_ev_x1=[silm_ev_x1+placeholder];
    end
    
    silm_ev_x2=red_events(:,2)==(silmultaneous_events_plus1(1)-1);
    for index3=[2:1:length(silmultaneous_events_plus1)];
        placeholder=red_events(:,2)==(silmultaneous_events_plus1(index3)-1);
        silm_ev_x2=[silm_ev_x2+placeholder];
    end
    
      silm_ev_x3=red_events(:,2)==(silmultaneous_events_minus1(1)+1);
    for index4=[2:1:length(silmultaneous_events_minus1)];
        placeholder=red_events(:,2)==(silmultaneous_events_minus1(index4)+1);
        silm_ev_x3=[silm_ev_x3+placeholder];
    end
    
    %x_sim_ev=red_events(:,2)==(silmultaneous_events)|red_events(:,2)==(silmultaneous_events_plus1-1)|red_events(:,2)==(silmultaneous_events_minus1+1)
    
    Gsilm_ev_x1=green_events(:,2)==(silmultaneous_events(1));
    for index5=[2:1:length(silmultaneous_events)];
        placeholder=green_events(:,2)==(silmultaneous_events(index5));
        Gsilm_ev_x1=[Gsilm_ev_x1+placeholder];
    end
    
    Gsilm_ev_x2=green_events(:,2)==(silmultaneous_events_plus1(1));
    for index6=[2:1:length(silmultaneous_events_plus1)];
        placeholder=green_events(:,2)==(silmultaneous_events_plus1(index6));
        Gsilm_ev_x2=[Gsilm_ev_x2+placeholder];
    end
    
      Gsilm_ev_x3=green_events(:,2)==(silmultaneous_events_minus1(1));
    for index7=[2:1:length(silmultaneous_events_minus1)];
        placeholder=green_events(:,2)==(silmultaneous_events_minus1(index7));
        Gsilm_ev_x3=[Gsilm_ev_x3+placeholder];
    end
    
    x_sim_ev_red=[silm_ev_x1+silm_ev_x2+silm_ev_x3];
    x_sim_ev_red_logical=logical(x_sim_ev_red);
    x_sim_ev_green=[Gsilm_ev_x1+Gsilm_ev_x2+Gsilm_ev_x3];
    x_sim_ev_green_logical=logical(x_sim_ev_green)
    if x_sim_ev_red~=0
        Mcm_Events_with_Cdt1_cia=[Mcm_Events_with_Cdt1_cia; red_events(x_sim_ev_red_logical,:)] %takes those rows and puts then in a matrix
        Cdt1_Events_with_Mcms_cia=[Cdt1_Events_with_Mcms_cia; green_events(x_sim_ev_green_logical,:)];
    else end
end