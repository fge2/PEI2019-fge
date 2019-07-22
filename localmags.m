function varargout=localmags(start,endtime,minmag)
% files=localmags(start,endtime,minmag)
%
% This function returns nearest records of earthquakes above a certain
% threshold
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% endtime        end time
%
% OUTPUT:
%
%
%
% Last modified by fge@princeton.edu on 7/18/19

defval('start','2019-07-01');
defval('endtime','2019-07-08');
defval('minmag',5);

mags=getmags(start,endtime,minmag);
dists=getdist(start,endtime,minmag);
[xfiles,yfiles,zfiles,times]=findrecord(minmag);
monthstr=char(month(times,'name'));
n=length(xfiles);

xfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',xfiles);
yfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',yfiles);
zfilenames=strcat('/data2/seismometer/',monthstr,char(num2str(day(times))),'/',zfiles);
localxmax=zeros(1,n);
localymax=zeros(1,n);
localzmax=zeros(1,n);

for i=1:n
    try
        Seisx=readsac(xfilenames(i,:));
        localxmax(i)=max(Seisx);
        Seisy=readsac(yfilenames(i,:));
        localymax(i)=max(Seisy);
        Seisz=readsac(zfilenames(i,:));
        localzmax(i)=max(Seisz);
    catch
    end
end

f=figure;
stem3(mags,dists,localxmax);
title('Magnitude-Distance Plot')
xlabel('Magnitude')
ylabel('Distances from Guyot (degrees)')
zlabel('Local Measure')

% Optional output
varns={f};
varargout=varns(1:nargout);

