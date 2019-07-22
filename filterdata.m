function varargout=filterdata(start,endtime,minmag,order,Wn,type)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

defval('start','2019-07-01');
defval('endtime','2019-07-08');
defval('minmag',5);
[xfiles,yfiles,zfiles,times,pID]=findrecord(start,endtime,minmag);
monthstr=char(month(times,'name'));
n=length(xfiles);
xfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',xfiles);
yfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',yfiles);
zfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',zfiles);
xfilts=cell(1,n);
yfilts=cell(1,n);
zfilts=cell(1,n);
for i=1:n
    try
        [xfilts{i},Hdrx{i}]=filtertest(xfilenames(i,:),order,Wn,type);
        [yfilts{i},Hdry{i}]=filtertest(yfilenames(i,:),order,Wn,type);
        [zfilts{i},Hdrz{i}]=filtertest(zfilenames(i,:),order,Wn,type);
    catch
    end
end


% Optional output
varns={xfilts,yfilts,zfilts};
varargout=varns(1:nargout);

