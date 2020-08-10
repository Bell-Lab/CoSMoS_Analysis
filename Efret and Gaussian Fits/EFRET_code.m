%Load spotpicker file
[fn fp]=uigetfile 
eval( ['load ' [fp fn] ' -mat' ] );
cia=Intervals.CumulativeIntervalArray;

%Restrict to only binding events (1 means high signal, 3 means high that
%lasted till the end
x=cia(:,1)==1|cia(:,1)==3;

%Define these binding as events
events=cia(x,:);

%Define array P1 = (#AOI, start frame, end frame)
P1=[events(:,7), events(:,2), events(:,3)];

%Load green bg subtracted file and define as aoifitsGreen
[fn fp]=uigetfile
eval(['load ' [fp fn] ' -mat']);
aoifitsGreen=aoifits;

 
%Load fret bg subtracted file (GexRem) and define as aoifitsFret
[fn fp]=uigetfile
eval(['load ' [fp fn] ' -mat']);
aoifitsFret=aoifits;


dat=draw_aoifits_aois_v1(aoifitsGreen,'y');
datG=dat;

dat=draw_aoifits_aois_v1(aoifitsFret,'y');
datF=dat;

%[aoinumber framenumber amplitude xcenter ycenter sigma offset integrated_aoi (integrated pixnum) (original aoi#)]
%output is a stacked matrix, one layer (row) is one aoi




%Make and EFRET matrix from your bk-subtracted traces (aoifits)

%[fn fp]=uigetfile                % Load your video file to get time base for green file
%eval(['load ' [fp fn] ' -mat'])

tb=vid.ttb;

tb=(tb-tb(1))*1e-3;

 
% Plot G and R traces,  Int intensity vs frame#

%figure(5);plot(datG(:,2,1),datG(:,8,1),'g');shg
%hold on
%figure(5);plot(datF(:,2,1),datF(:,8,1),'r');shg
% or G and R traces, Int intensity vs time (if trace begins at frm 1)
%figure(6);plot(tb(datG(:,2,1)),datG(:,8,1),'g');shg


% Now want to create EFRET traces from our P1frm and datG and datR variables

 
P1rows = size(P1,1);
EFRET=[];
EFRET_numerator=[];  % initialize our final matrix [time (EFRET value)]

for indx=1:P1rows   % Loop through all rows of P1frms to capture all FRET events %For each binding event
    
    aoinum=P1(indx,1);  %Set to aoi# of the current event

    logik=P1(indx,2)==datG(:,2,aoinum);        % Pick out the index of the start frame for this event

    Is=find(logik);                                % Index of starting frame

    logik=P1(indx,3)==datG(:,2,aoinum);        % Pick out the index of the end frame for this event

    Ie=find(logik);                        % Index of starting frame

    F=datF(Is:Ie,8,aoinum).*(datF(Is:Ie,8,aoinum)+datG(Is:Ie,8,aoinum)).^(-1);
    
    EFRET = [EFRET;F]; %Puts all EFRET values for each frame of binding event into an array


end

histogram(EFRET, 'BinLimits',[-1.5, 1.5]) %plot all EFRET values onto a histogram from -1.5 to 1.5
mean(EFRET)
