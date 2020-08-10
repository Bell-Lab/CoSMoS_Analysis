
figure(30)
x=cia2(:,1)==1|cia(:,1)==3;
y1=cia2(x,5);
x2=cia4(:,1)==1|cia3(:,1)==3;
y2=cia4(x2,5);
bins=[0:40:400];
%fig=figure(30);
h1=histogram(y1,bins);
hold on
h2=histogram(y2,bins);
h2.FaceColor='none';
h2.EdgeColor='r'
h2.LineWidth=2



fig=figure(39); %PDF
c1 = histcounts(y1,bins);  % count up elements in bins\
c1Norm = c1./sum(c1);  % divide by total count (probability)
bin_widths=diff(bins); % bin width calculations
c1_PDF=c1Norm./bin_widths
bin_centers=bins(2:end)-diff(bins)/2
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

fig=figure(32); %normalized histogram
c1 = histcounts(y1,bins);  % count up elements in bins\
c1Norm = c1./sum(c1);  % divide by total count (probability)
bin_widths=diff(bins); % bin width calculations
bin_centers=bins(2:end)-diff(bins)/2
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

