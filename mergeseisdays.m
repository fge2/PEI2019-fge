function varargout=mergeseisdays(year,startmonth,startday,indexno,days)
%UNTITLED4 Summary of this function goes here

startdate=datetime(strcat(startmonth,'/',startday,'/',year),'InputFormat','MM/dd/yyyy');
merge=zeros(days*360000*24,1);
doubleday=str2double(startday);
doublemonth=str2double(startmonth);
doubleyear=str2double(year);
for i=0:days-1
    seis=mergeseis(year,startmonth,startday,indexno);
    n=length(seis);
    merge(i*n+1:(i+1)*n)=seis;
    if str2double(startday)<eomday(doubleyear,doublemonth)
        startday=sprintf('%02d',doubleday+1);
    else 
        startday='01';
        startmonth=sprintf('%02d',doublemonth+1);
    end
    indexno=indexno+1;
end

figure
t=seconds(0:(length(merge)-1))/100 + startdate;
plot(t,merge);
xlim([t(1) t(end)])
title(strcat('Guyot Seismogram'))
xlabel('Hour')

% Optional output
varns={merge};
varargout=varns(1:nargout);
    

