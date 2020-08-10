
fig=figure(41);

nbins=10

x=UnphosMcmsilmultaneous38(:,5)';
[bin_centers, y, bins, se]=binned_pdf(x',nbins)
h1=histogram('BinEdges',bins,'BinCounts',y)
h1.FaceColor='b';
h1.EdgeColor='b'
h1.LineWidth=2

hold on
x=cia3(:,5)';
%[bin_centers, y, bins, se]=binned_pdf(x',nbins)
h2=histogram('BinEdges',bins,'BinCounts',x)
h2.FaceColor='none';
h2.EdgeColor='r'
h2.LineWidth=2


xlabel('seconds','FontName','Arial')
ylabel('PDF')
l=legend({'Cdt1 with Unphosphorylated ORC','Cdt1 with Phosphorylated ORC'},'Box','off')
