function varargout=plotallcomp(year,startmonth,startday,indexno,days)
%

[m1,f1,t1]=mergeseisdays(year,startmonth,startday,indexno,days,'X');
[m2,f2,t2]=mergeseisdays(year,startmonth,startday,indexno,days,'Y');
[m3,f3,t3]=mergeseisdays(year,startmonth,startday,indexno,days,'Z');
[yupper1,ylower1]=envelope(m1,240,'rms');
[yupper2,ylower2]=envelope(m2,240,'rms');
[yupper3,ylower3]=envelope(m3,240,'rms');


f=figure;

tl=suptitle(strcat('Seismogram record of Guyot Hall beginning on',{' '},startmonth,'/',startday,'/',year));
tl.Position=[tl.Position(1) tl.Position(2)+0.03 0];

a=subplot(311);
plot(t1,[m1,yupper1,ylower1])
title('X component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])


b=subplot(312);
plot(t2,[m2,yupper2,ylower2])
title('Y component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])

c=subplot(313);
plot(t3,[m3,yupper3,ylower3])
title('Z component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])

lim=a.YLim;
b.YLim=lim;
c.YLim=lim;

% Optional output
varns={f};
varargout=varns(1:nargout);

