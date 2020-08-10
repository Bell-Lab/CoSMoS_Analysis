
[f1,x1,flow1,fup1]=ecdf(y1,'function','survivor','alpha',.05);
[f2,x2,flow2,fup2]=ecdf(y2,'function','survivor','alpha',.05);
%alpha gives confidence intervals, for 95% do 0.05
fig2=figure(31);
st1=stairs(x1,f1,'-b','LineWidth',1);
hold on
st2=stairs(x2,f2,'-r','LineWidth',1)
stairs(x1,flow1,':b')
stairs(x1,fup1,':b')
stairs(x2,flow2,':r')
stairs(x2,fup2,':r')

xlabel('seconds','FontName','Arial')
ylabel('fraction bound')
l=legend({'Cdc6 Unphos','Cdc6 Phos'},'Box','off')
