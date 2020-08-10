% Click track AOIs
% Go to end of movie and picked bright spots/bead spots. 
% Then go to frame 1 and make sure the AOIs are still the same (will often be slightly offset though)
% Enter frame range at top [1:lastframenumber]
% Click ?Fit AOIs? (turn OFF parallel processing)

load('/matlab/data/default.dat','-mat') %Load the aoifits you just made to prepare for Gaussian refinement
dat=draw_aoifits_aois_v1(aoifits,'y');	 % Draw boxes around AOIs in yellow. Break aoifits.data into individual matrices for each AOI
% if you are confused >> help construct_driftlist_time_v1
startpt = 1;
endpt = 1601;

xy_cell{1}.dat=dat(:,:,1);		% Make the cell arrays for the Gaussian spots
%xy_cell{2}.dat=dat(:,:,2);		% used in making the driftlist
%xy_cell{3}.dat=dat(:,:,3);
% xy_cell{4}.dat=dat(:,:,4);

			% Data for the xy locations of the spots in each frame
		%note: I had only 2 spots that I am analyzing for the driftlist. But other verisons of this protocol from larry include things lik:   xy_cell{3}.dat=dat(:,:32);  so perhaps you need a new one of these for each spot???
xy_cell{1}.range=[1 endpt];	% 1 to last frame
%xy_cell{2}.range=[1 endpt];
%xy_cell{3}.range=[1 endpt];
% xy_cell{4}.range=[1 endpt];

xy_cell{1}.userange=[1 endpt]; % Range of frames of usable spots
%xy_cell{2}.userange=[1 endpt]; 
%xy_cell{3}.userange=[1 endpt];
% xy_cell{4}.userange=[1 endpt];


CorrectionRange=[1 endpt]; 	% Frame range over which we correct the drift, may be shorter

SequenceLength=endpt;	       % Total # of frames in the glimpse file, CANNOT change it to number of frames you would like to analyze

[fn fp]=uigetfile	 %Get the protein image file again

eval(['load ' [fp fn] ' -mat'])	 %makes the vid variable

% Run function that constructs a cumulative drift vs (glimpse time)
drifts_time=construct_driftlist_time_v1(xy_cell,vid,CorrectionRange,SequenceLength,[8 8],[2 15 2 15]);

% Run function that constructs drift vs frame number for our file (the vid here need not match the vid above).
%[8 8] can change to [4 4] this is the polynomial degree
% this will create a figure of the drift for each spot. You must then right click on the image once, then right click again on the new image that that produces, at which point you should see a ?drifts_time? variable appear in the workspace sidebar

drifts=driftlist_time_interp(drifts_time.cumdriftlist,vid);
foldstruc.DriftList=drifts.diffdriftlist;		% Assign driftlist to proper member of foldstruc structure
driftlist=drifts.diffdriftlist;			% Also assign driftlist just for saving
%test if this worked by entering:
%foldstruc
% Save all the stuff used to make the driftlist
save /matlab/data/manualdriftlist.dat xy_cell SequenceLength CorrectionRange vid

%save driftlist from workspace, should be a double matrix
%save driflist as .mat
close all