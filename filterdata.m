function varargout=filterdata(start,endtime,minmag,order,Wn,type)
% [xfilts,yfilts,zfilts,Hdrx,Hdry,Hdrz]=filterdata(start,endtime,minmag,order,Wn,type)
%
% This function filters and returns the vectors for events specified by the
% arguement drawn from iris
%
% INPUT:
%
% start         The start time
% endtime       The end time
% minmag        Cutoff magnitude
% order         Order of filter
% Wn            The cutoff frequencies of the filter
% type          Low,High,etc
%
% OUTPUT:
%
% xfilt         Filtered x data in a struct array
% yfilt         Filtered y data in a struct array
% zfilt         Filtered z data in a struct array
% Hdrx          x Headerdata
% Hdry          y Headerdata
% Hdrz          z Headerdata
%
% last modified by fge@princeton.edu on 7/23/2019

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
varns={xfilts,yfilts,zfilts,Hdrx,Hdry,Hdrz};
varargout=varns(1:nargout);

