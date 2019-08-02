function varargout=plotallcomp(year,startmonth,startday,indexno,days)
%

[m1,f1,t1]=mergeseisdays(year,startmonth,startday,indexno,days,'X');
[m2,f2,t2]=mergeseisdays(year,startmonth,startday,indexno,days,'Y');
[m3,f3,t3]=mergeseisdays(year,startmonth,startday,indexno,days,'Z');

f=figure;

subplot(311)
plot(t1,f1)
title('X component')
xlim([t1(1) t1(end)])

subplot(312)
plot(t2,f2)
title('Y component')
xlim([t2(1) t2(end)])

subplot(313)
plot(t3,f3)
title('Z component')
xlim([t1(1) t1(end)])

% Optional output
varns={f};
varargout=varns(1:nargout);

