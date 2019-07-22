function varargout=filterdata(start,endtime,minmag)
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
for i=1:n
    try
        [Seisx{i},Hdrx{i}]=filtertest(xfilenames(i,:));
        [Seisy{i},Hdry{i}]=filtertest(yfilenames(i,:));
        [Seisz{i},Hdrz{i}]=filtertest(zfilenames(i,:));
    catch
    end
end
xfilts=

% Optional output
varns={};
varargout=varns(1:nargout);

