function varargout=plotallspectre(year,startmonth,startday,indexno,days)
%

startdate=datetime(strcat(startmonth,'/',startday,'/',year),'InputFormat','MM/dd/yyyy');

[m1,f1,t1]=mergeseisdays(year,startmonth,startday,indexno,days,'X');
length(m1)
t1(m1==0)=[];
m1(m1==0)=NaN;

f=figure;
spectrogram(m1,256,[],[],4,'yaxis');
f.Children(1).Axes.XLim=[0 days];
xlabel(strcat('Days After',{' '},datestr(startdate)));
title(strcat('Spectrogram of Guyot Seismographs during',{' '},datestr(startdate)));

% Optional output
varns={f};
varargout=varns(1:nargout);