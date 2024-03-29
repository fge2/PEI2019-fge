function varargout=plotallspectre(year,startmonth,startday,indexno,nodays,hurricanename)
%

startdate=datetime(strcat(startmonth,'/',startday,'/',year),'InputFormat','MM/dd/yyyy');

[m1,f1,t1]=mergeseisdays(year,startmonth,startday,indexno,nodays,'X');
length(m1);
t1(m1==0)=[];
m1(m1==0)=NaN;

f=figure;
Fs=4;
spectrogram(fillmissing(m1,'pchip'),1024,[],[],Fs,'yaxis');
[~,~,~,ps]=spectrogram(fillmissing(m1,'pchip'),1024,[],[],Fs);
colormap parula
caxis([0 60])
ylim([0.1 0.4])
f.Children(1).Axes.XLim=[0 nodays];
xlabel('Date');
var=0:2:nodays;
xdates=startdate+var;
xticklabels(cellstr(datestr(xdates,'mm/dd/yyyy')));
xtickangle(45);
title({['Spectrogram of Guyot Seismographs Plotted']; ['with ibtracs Wind Data Beginning on ',datestr(startdate)]});

yyaxis right
ylabel('Wind Speed (knots)')
hold on
set(gca,'ycolor','k') 
[name,~,isotime,~,~,wind]=readibtracs('myibtracs.mat');
i=find(name==hurricanename);
h=isotime(i)-startdate;
d=days(h);
p=plot(d,fillmissing(wind(i),'previous'),'r','LineWidth',2);
legend(p,strcat('Windspeed of',{' '},hurricanename));

% Optional output
varns={f,ps};
varargout=varns(1:nargout);