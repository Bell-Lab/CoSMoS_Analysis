%Maximum_likelihood_curve_fittings for dwell times- by Audra, modified from Larry’s code 
%(just changing variable names)
% First Fit the nonDNA dwell times
xb_events=(cia2(:,1)==-3|cia2(:,1)==1|cia2(:,1)==3);
bkgnd_events_matrix=cia2(xb_events,:);

%set tminimun
tmin=3;

%do the fit:
Bkgnd_fit=fminsearch('expfalltwo_mxl',[.5  1/20 1/500],[],bkgnd_events_matrix(:,5),tmin,1200); 
% for most experiments I average to 3, so tmin=3 and tmax usually =1200 because that is what I set the spotpicker to. 
%this function will out put a vector of [a, tau1, tau2]
%next compute correction factors: i.e. number of events that were missed because they were too short and also and offset, which is the amount asymptoted offset form zero at the end of the expeirmetn. If this is small then you are good, it it is large then you are missing a bunch of long lived events and need to correct for that a different way
Bkgnd_fit_corrections=expfalltwo_mxl_correction(Bkgnd_fit,bkgnd_events_matrix(:,5),tmin,1200) 

%will output a CorrectionFactor= your 1/(ab*Ab+(1-ab*Bb) term
%Nzero= total number of events. Nzero-N= number of events to short for you to have resolved in your experiment
%offset—the different between the end of your experiment and zero, ieie how close the asymptote is, a proxy of how complete your epeirment was and wherther there would have been a bunch of longer lived events if you ahd waited longer

%now fit the actual experiment using he background fit as a fixed parameter

%first need to define total binding frequencies for expeirment and background
% binding Frequency= (# of binding events)/(total wait time)

%define NbTb:
xb_no_events2=(cia2(:,1)==-2|cia2(:,1)==0|cia2(:,1)==2);
bkgnd_no_events_matrix2=cia2(x_no_events2,:);
bkgnd_total_no_event_time=sum(bkgnd_no_events_matrix2(:,5));
NbTb=length(bkgnd_events_matrix(:,5))/bkgnd_total_no_event_time


%define experiment dwell time matrix
x_events=(cia(:,1)==-3|cia(:,1)==1|cia(:,1)==3);
events_matrix=cia(x_events,:);

%define NexpTexp:
x_no_events=(cia(:,1)==-2|cia(:,1)==0|cia(:,1)==2);
no_events_matrix=cia(x_no_events,:);
total_no_event_time=sum(no_events_matrix(:,5));
NexpTexp=length(events_matrix (:,5))/total_no_event_time
    logik=events_matrix(:,5)>3;
%fit the experiment!
Experiment_fit=fminsearch('expfalltwo_mxl_with_background',[.5 1/5 1/200],[],events_matrix(logik,5),tmin,1200,NexpTexp,NbTb,Bkgnd_fit)

%and again correct:
Experiment_fit_corrections=expfalltwo_mxl_correction(Experiment_fit,events_matrix(:,5),tmin,1200)
%in this case it looks like larry said we don’t use the correction coeeficient, instead we use “(NexpTexp-NbTb)”

%second set of Non DNA nad DNA experiemtns
xb_events4=(cia4(:,1)==-3|cia4(:,1)==1|cia4(:,1)==3);
bkgnd_events_matrix4=cia4(xb_events4,:);
Bkgnd_fit4=fminsearch('expfalltwo_mxl',[.5  1/20 1/500],[],bkgnd_events_matrix4(:,5),tmin,1200); 
Bkgnd_fit_corrections4=expfalltwo_mxl_correction(Bkgnd_fit4,bkgnd_events_matrix4(:,5),tmin,1200) 

xb_no_events4=(cia4(:,1)==-2|cia4(:,1)==0|cia4(:,1)==2);
bkgnd_no_events_matrix4=cia4(xb_no_events4,:);
bkgnd_total_no_event_time4=sum(bkgnd_no_events_matrix4(:,5));
NbTb4=length(bkgnd_events_matrix4(:,5))/bkgnd_total_no_event_time4


%define experiment dwell time matrix
x_events3=(cia3(:,1)==-3|cia3(:,1)==1|cia3(:,1)==3);
events_matrix3=cia3(x_events3,:);

%define NexpTexp:
x_no_events3=(cia3(:,1)==-2|cia3(:,1)==0|cia3(:,1)==2);
no_events_matrix3=cia3(x_no_events3,:);
total_no_event_time3=sum(no_events_matrix3(:,5));
NexpTexp3=length(events_matrix3(:,5))/total_no_event_time3
    logik3=events_matrix3(:,5)>3;
%fit the experiment!
Experiment_fit3=fminsearch('expfalltwo_mxl_with_background',[.5 1/5 1/200],[],events_matrix3(logik3,5),tmin,1200,NexpTexp3,NbTb4,Bkgnd_fit4)

%and again correct:
Experiment_fit_corrections3=expfalltwo_mxl_correction(Experiment_fit3,events_matrix3(:,5),tmin,1200)




% Plot the dwell time data and fit
			% cumulative survival distributions for dwells at the DNA vs control sites.

cumdwellexp=[];cumdwellBkgnd=[];
max(bkgnd_events_matrix(:,5))			
for index=[0:1200]+0.1

events_larger_than_index=events_matrix(:,5)>index;
cumdwellexp=[ cumdwellexp; index-.1 sum(events_larger_than_index)];


Bkgnd_events_larger_than_index=bkgnd_events_matrix(:,5)>index;
cumdwellBkgnd =[cumdwellBkgnd; index-.1 sum(Bkgnd_events_larger_than_index)];



end

cumdwellexp3=[];cumdwellBkgnd4=[];
max(bkgnd_events_matrix4(:,5))			
for index=[0:1200]+0.1

events_larger_than_index3=events_matrix3(:,5)>index;
cumdwellexp3=[ cumdwellexp3; index-.1 sum(events_larger_than_index3)];


Bkgnd_events_larger_than_index4=bkgnd_events_matrix4(:,5)>index;
cumdwellBkgnd4 =[cumdwellBkgnd4; index-.1 sum(Bkgnd_events_larger_than_index4)];



end


figure(45);plot(cumdwellexp(:,1)+0.5,cumdwellexp(:,2)/total_no_event_time,'ro');shg
hold on
time=0:1200;
%((OBSERVED 488 freq)-(OBSERVED nonDNA freq))*(correction factor)*(2exp term)
a_exp=1/(1+Experiment_fit(1)^2);
r1=Experiment_fit(2);
r2=Experiment_fit(3);
ab=1/(1+Bkgnd_fit(1)^2);
tau1=Bkgnd_fit(2);
tau2=Bkgnd_fit(3);
CorrectionFactor_Bkgnd=Bkgnd_fit_corrections.CorrectionFactor;
CorrectionFactor_exp=Experiment_fit_corrections.CorrectionFactor;


plot(time,(NexpTexp-NbTb)*CorrectionFactor_exp*(a_exp*exp(-time*r1)+(1-a_exp)*exp(-time*r2))+NbTb*CorrectionFactor_Bkgnd*(ab*exp(-time*tau1)+(1-ab)*exp(-time*tau2)),'r');
% (OBSERVED nonDNA freq) )*(correction factor)*(2exp term)


plot(cumdwellBkgnd(:,1)+.5,cumdwellBkgnd(:,2)/bkgnd_total_no_event_time,'rx');shg
plot(time,NbTb*CorrectionFactor_Bkgnd*(ab*exp(-time*tau1)+(1-ab)*exp(-time*tau2)),'k');shg

%next set
plot(cumdwellexp3(:,1)+0.5,cumdwellexp3(:,2)/total_no_event_time3,'go');shg

a_exp3=1/(1+Experiment_fit3(1)^2);
r1_3=Experiment_fit3(2);
r2_3=Experiment_fit3(3);
ab4=1/(1+Bkgnd_fit4(1)^2);
tau1_4=Bkgnd_fit4(2);
tau2_4=Bkgnd_fit4(3);
CorrectionFactor_Bkgnd4=Bkgnd_fit_corrections4.CorrectionFactor;
CorrectionFactor_exp3=Experiment_fit_corrections3.CorrectionFactor;


plot(time,(NexpTexp3-NbTb4)*CorrectionFactor_exp3*(1*(1-a_exp3)*exp(-time*r2_3))+NbTb4*CorrectionFactor_Bkgnd4*(ab4*exp(-time*tau1_4)+(1-ab4)*exp(-time*tau2_4)),'g');
% (OBSERVED nonDNA freq) )*(correction factor)*(2exp term)
% a_exp3*exp(-time*r1_3)+ went where the *1 is

plot(cumdwellBkgnd4(:,1)+.5,cumdwellBkgnd4(:,2)/bkgnd_total_no_event_time4,'gx');shg
plot(time,NbTb4*CorrectionFactor_Bkgnd4*(ab4*exp(-time*tau1_4)+(1-ab4)*exp(-time*tau2_4)),'k');shg

xlabel('seconds','FontName','Arial')
ylabel('frequency and Max Likelihood Fit')
l=legend({'Unphosphorylated ORC','UnPhos ORC Fit','UnPhos background','UnPhos Background fit','Phosphorylated ORC','Phos ORC fit','Phos background','Phos background fit'},'Box','off')
