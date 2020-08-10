%For GR fret experiments (mcm-b1 fret)
%Prerequisite: run EFRET_matrix.m to get EFRET matrix for the current exp

%This script makes 4 subplots in the following order:
%Green bg subtracted trace
%Red bg subtracted trace
%Total Emission (G+R)
%EFRET trace

AOInum=545
781;
save_location_png = '/Volumes/ANNIE2/Data_and_figs/m3nb1fret'; %where the png file is saved
save_location_fig = '/Volumes/ANNIE2/Data_and_figs/m3nb1fret/fig_files'; %where the fig file is saved
fileprefix = 'm3nb1fret03'; %filename prefix, saved file will be named fileprefix_AOI#_colorpair
frame_range = [1 1200]; %x axis (frame) range for top graph


%%
%Plotting graph

fig = figure(24);
% axObjs = fig.Children;
% dataObjs = axObjs.Children;
% greenx = dataObjs(1).XData;
% greeny = dataObjs(1).YData;
greenha = findobj(figure(24),'Type', 'line');
greenx = get(greenha,'XData');
greenx = greenx{1,1};
greeny = get(greenha,'YData');
greeny = greeny{1,1};

fig = figure(25);
% axObjs = fig.Children;
% dataObjs = axObjs.Children;
% redx = dataObjs(1).XData;
% redy = dataObjs(1).YData;
redha = findobj(figure(25),'Type', 'line');
redx = get(redha,'XData');
redx = redx{1,1};
redy = get(redha,'YData');
redy = redy{1,1};


figure(50) 
hold on 
subplot(4,1,1)
plot(greenx, greeny, 'LineWidth',1.2,'Color', [0 0.498039215803146 0])
title(['AOI ', num2str(AOInum)])
set(gca,'FontSize',8, 'xtick',[])
xlim(frame_range)
%ylim([15000 18000])

subplot(4,1,2)
plot(redx, redy, 'LineWidth',1.2,'Color', [1 0 0])
xlim(frame_range)
set(gca,'FontSize',8, 'xtick',[])
%ylim([-500 3000])
%set(gca,'FontSize',24)

subplot(4,1,3)
plot(greenx, greeny+redy, 'LineWidth',1.2,'Color', 'k')
xlim(frame_range)
set(gca,'FontSize',8, 'xtick',[])
%ylim([-1000 3100])

subplot(4,1,4)
plot(greenx, valEFRET(1:1200, AOInum), 'LineWidth',1.2,'Color', 'b')
xlim(frame_range)
ylim([-0.5 1.2])
set(gca,'FontSize',8, 'xtick',[])

ax = subplot(4,1,1);
ax.Position = [.05 .75 .9 .225];
ax = subplot(4,1,2);
ax.Position = [.05 .51 .9 .225];
ax = subplot(4,1,4);
ax.Position = [.05 .03 .9 .225];
ax = subplot(4,1,3);
ax.Position = [.05 .27 .9 .225];
    
%%
%Save Graph

if isfile(strcat(save_location_png, '/', fileprefix, '_AOI', num2str(AOInum), '_4sp.png')) == 0 %if file doesn't already exist, save
    saveas(figure(50),fullfile(save_location_png,strcat(fileprefix, '_AOI', num2str(AOInum), '_pix3_4sp.png')), 'png')
    saveas(figure(50),fullfile(save_location_fig,strcat(fileprefix, '_AOI', num2str(AOInum), '_pix3_4sp.fig')), 'fig')
else
    disp('File already exists. Saving as a different copy')
    pause;
    saveas(figure(50),fullfile(save_location_png,strcat(fileprefix, '_AOI', num2str(AOInum), '_pix3_4sp.png')), 'png')
    saveas(figure(50),fullfile(save_location_fig,strcat(fileprefix, '_AOI', num2str(AOInum), '_pix3_4sp.fig')), 'fig')
end
