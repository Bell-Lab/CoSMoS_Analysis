%plots of mcms after cdt1 leaves
%and dwell times of the events where they leave together

%input should be cia=Unphos_mcms_silmultaneous_with_Cdt1
%cia2=Unphos_Cdt1_silmultaneous_with_Mcms
%cia3=Phos_mcms_silmultaneous_with_Cdt1
%cia4=Phos_Cdt1_silmultaneous_with_Mcms


UnPhos_Mcms_after_cdt1_leaves=(cia(:,5)-cia2(:,5));
Phos_Mcms_after_cdt1_leaves=(cia3(:,5)-cia4(:,5));

fig=figure(42);

nbins=10;

x=UnPhos_Mcms_after_cdt1_leaves';
[bin_centers, y, bins, se]=binned_pdf(x',nbins);
h1=histogram('BinEdges',bins,'BinCounts',y)
h1.FaceColor='b';
h1.EdgeColor='b';
h1.LineWidth=2;

hold on
x=Phos_Mcms_after_cdt1_leaves';
[bin_centers, y, bins, se]=binned_pdf(x',nbins);
h2=histogram('BinEdges',bins,'BinCounts',y)
h2.FaceColor='none';
h2.EdgeColor='r';
h2.LineWidth=2;


xlabel('seconds','FontName','Arial')
ylabel('PDF')
l=legend({'Mcms after Cdt1 leaves with Unphosphorylated ORC','Mcms after Cdt1 leaves with Phosphorylated ORC'},'Box','off');


fig=figure(43);
y1=UnPhos_Mcms_after_cdt1_leaves;
y2=Phos_Mcms_after_cdt1_leaves;
bins=[0:150:1200];
%fig=figure(30);
%h1=histogram(y1,bins);
%hold on
%h2=histogram(y2,bins);
%h2.FaceColor='none';
%h2.EdgeColor='r'
%h2.LineWidth=2



%PDF
c1 = histcounts(y1,bins);  % count up elements in bins\
c1Norm = c1./sum(c1);  % divide by total count (probability)
bin_widths=diff(bins); % bin width calculations
c1_PDF=c1Norm./bin_widths;
bin_centers=bins(2:end)-diff(bins)/2;
bar1=bar(bin_centers,c1_PDF,'b');
ax=gca;
ax.XLim(1)=-5;
hold on
%errorbar(bin_centers,c1_PDF,negError,posError,'.');
c2 = histcounts(y2,bins);  % count up elements in bins\
c2Norm = c2./sum(c2);  % divide by total count (probability)
c2_PDF=c2Norm./bin_widths;
bar2=bar(bin_centers,c2_PDF,'r');
bar2.FaceColor='none';
bar2.EdgeColor='r';
bar2.LineWidth=2;

xlabel('seconds','FontName','Arial')
ylabel('PDF')
l=legend({'Mcms after Cdt1 leaves with Unphosphorylated ORC','Mcms after Cdt1 leaves with Phosphorylated ORC'},'Box','off');


Unphos_silmultaneous_Departures_Mcm_values=[];
Phos_silmultaneous_Departures_Mcm_values=[];
for index=[1:1:length(cia(:,7))];
    if abs(cia(index,3)-cia2(index,3))<=2
    Unphos_silmultaneous_Departures_Mcm_values=[Unphos_silmultaneous_Departures_Mcm_values; cia(index,:)];
    end
end

for index=[1:1:length(cia3(:,7))];
    if abs(cia3(index,3)-cia4(index,3))<2
    Phos_silmultaneous_Departures_Mcm_values=[Phos_silmultaneous_Departures_Mcm_values; cia(index,:)];
    end
end

fig=figure(44);

nbins=5;

x=Unphos_silmultaneous_Departures_Mcm_values(:,5)';
[bin_centers, y, bins, se]=binned_pdf(x',nbins);
h1=histogram('BinEdges',bins,'BinCounts',y)
h1.FaceColor='b';
h1.EdgeColor='b';
h1.LineWidth=2;

hold on
x=Phos_silmultaneous_Departures_Mcm_values(:,5)';
[bin_centers, y, bins, se]=binned_pdf(x',nbins);
h2=histogram('BinEdges',bins,'BinCounts',y);
h2.FaceColor='none';
h2.EdgeColor='r';
h2.LineWidth=2;


xlabel('seconds','FontName','Arial')
ylabel('PDF')
l=legend({'Mcms/Cdt1 dwell time when leave silmultaneously with Unphosphorylated ORC','Mcms/Cdt1 dwell time when leave silmultaneously  with Phosphorylated ORC'},'Box','off');


fig=figure(45);
y1=Unphos_silmultaneous_Departures_Mcm_values(:,5);
y2=Phos_silmultaneous_Departures_Mcm_values(:,5);
bins=[0:150:1200];
%fig=figure(30);
%h1=histogram(y1,bins);
%hold on
%h2=histogram(y2,bins);
%h2.FaceColor='none';
%h2.EdgeColor='r'
%h2.LineWidth=2



%PDF
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

xlabel('seconds','FontName','Arial')
ylabel('PDF')
l=legend({'Mcms/Cdt1 dwell time when leave silmultaneously with Unphosphorylated ORC','Mcms/Cdt1 dwell time when leave silmultaneously  with Phosphorylated ORC'},'Box','off')

        
        