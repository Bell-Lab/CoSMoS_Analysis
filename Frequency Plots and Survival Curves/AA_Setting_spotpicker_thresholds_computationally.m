%help plot_spot_number_v2
%make sure your current fp is to the protein file you want to set thresholds for
    %[fn fp]=uigetfile %get your vid file if needed
    %eval(['load ' [fp fn] ' -mat'])
%define your endpt=#frames
roi=roipoly %this was giving me some sort of error to do in script form, so
            %might need to type each line 1 by one, or maybe jsut he roi poly line
aoiRadius=1.5;
%eval(['load ' [fp fn] ' -mat'])
SequenceLength=4000;
frmave=1;
bkgnd=0; %if very non-uniform field of view set the background to 1
frames=[1201];
%help plot_spot_number_v2
fignum=35;
NdSd=[1 5];
Probz=[.5 .7 .9]; %.5 to .9% probability that a background spot will be detected at the threshold it will spit out. 
%thresholds=[1:1:100];
thresholds=[4:1:150];
plot_spot_number_v2(fp,frames,thresholds,NdSd,roi,aoiRadius,SequenceLength,Probz,frmave,bkgnd,fignum)
