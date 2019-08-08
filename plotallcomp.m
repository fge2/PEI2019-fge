function varargout=plotallcomp(year,startmonth,startday,indexno,days)
%

[m1,f1,t1]=mergeseisdays(year,startmonth,startday,indexno,days,'X');
[m2,f2,t2]=mergeseisdays(year,startmonth,startday,indexno,days,'Y');
%[m3,f3,t3]=mergeseisdays(year,startmonth,startday,indexno,days,'Z');
t1(m1==0)=[];
m1(m1==0)=[];
t2(m2==0)=[];
m2(m2==0)=[];
%t3(m3==0)=[];
%m3(m3==0)=[];
n=length(m1);
[r1,r2]=envelope(m1,n,'rms');
[r3,r4]=envelope(m2,n,'rms');
%[r5,r6]=envelope(m3,n,'rms');
[yupper1,ylower1]=envelope(m1,14400,'rms');
[yupper2,ylower2]=envelope(m2,14400,'rms');
%[yupper3,ylower3]=envelope(m3,14400,'rms');

f=figure;
tx=suptitle(strcat('Clipped Seismogram record of Guyot Hall beginning on',{' '},startmonth,'/',startday,'/',year));
tx.Position=[tx.Position(1) tx.Position(2)+0.03 0];

a=subplot(211);
plot(t1,[m1,yupper1,ylower1,r1,r2])
legend('signal','upper rms','lower rms','location','northwest')
title('X component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])

b=subplot(212);
plot(t2,[m2,yupper2,ylower2,r3,r4])
legend('signal','upper rms','lower rms','location','northwest')
title('Y component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])

%{
c=subplot(313);
plot(t3,[m3,yupper3,ylower3])
legend('signal','upper rms','lower rms')
title('Z component')
ylabel('Uncorrected Counts')
axis normal
xlim([t1(1) t1(end)])
%}

lim=a.YLim;
b.YLim=lim;
%c.YLim=lim;

Superset = datenum(t1);
Subset = [datenum(2018, 9, 13); datenum(2018, 9, 14)];
Indices = datefind(Subset, Superset, 0.05);
xerror1 = (yupper1(Indices)-r1(Indices))./r1(Indices);
xerror2 = (ylower1(Indices)-r2(Indices))./r2(Indices);
xcomperr = [nanmean(xerror1) nanmean(xerror2)];

Superset2 = datenum(t2);
Subset2 = [datenum(2018, 9, 13); datenum(2018, 9, 14)];
Indices2 = datefind(Subset2, Superset2, 0.05);
yerror1 = (yupper2(Indices2)-r3(Indices2))./r3(Indices2);
yerror2 = (ylower2(Indices2)-r4(Indices2))./r4(Indices2);
ycomperr = [nanmean(yerror1) nanmean(yerror2)];

% Optional output
varns={f,xcomperr,ycomperr};
varargout=varns(1:nargout);

