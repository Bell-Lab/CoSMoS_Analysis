
x=ciaGREEN(:,1)==-2;
y1=ciaGREEN(x,5);
x2=ciaGREEN_PhosORC(:,1)==-2;
y2=ciaGREEN_PhosORC(x2,5);
bins=[1:100:1200];
%fig=figure(34);
%h1=histogram(y1,bins);
%hold on
%h2=histogram(y2,bins);
%h2.FaceColor='none';
%h2.EdgeColor='r'
%h2.LineWidth=2



fig=figure(35);
c1 = histcounts(y1,bins);  % count up elements in bins\
c1Norm = c1./sum(c1);  % divide by total count (probability)
bin_widths=diff(bins); % bin width calculations
c1_PDF=c1Norm./bin_widths
bin_centers=bins(2:end)-diff(bins)
bar1=bar(bin_centers,c1_PDF,'b')
ax=gca;
ax.XLim(1)=-5
hold on
%errorbar(bin_centers,c1_PDF,negError,posError,'.');
c2 = histcounts(y2,bins);  % count up elements in bins\
c2Norm = c2./sum(c2);  % divide by total count (probability)
c2_PDF=c2Norm./bin_widths
bar2=bar(bin_centers,c2_PDF,'r')
bar2.FaceColor='none';
bar2.EdgeColor='r'
bar2.LineWidth=2

fig=figure(36);
c1 = histcounts(y1,bins);  % count up elements in bins\
c1Norm = c1./sum(c1);  % divide by total count (probability)
bin_widths=diff(bins); % bin width calculations
bin_centers=bins(2:end)-diff(bins)
bar1=bar(bin_centers,c1Norm,'b')
ax=gca;
ax.XLim(1)=-5
hold on
%errorbar(bin_centers,c1_PDF,negError,posError,'.');
c2 = histcounts(y2,bins);  % count up elements in bins\
c2Norm = c2./sum(c2);  % divide by total count (probability)
bar2=bar(bin_centers,c2Norm,'r')
bar2.FaceColor='none';
bar2.EdgeColor='r'
bar2.LineWidth=2

