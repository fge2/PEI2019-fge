function varargout=localmags(minmag)
% []=(minmag)
%
% This function returns nearest records of earthquakes above a certain
% threshold
%
% INPUT:
%
% minmag         minimum threshold to return
% start          start time 'YYYY-MM-DD HH:MM:SS'
% end            end time
%
% OUTPUT:
%
%
%
% Last modified by fge@princeton.edu on 7/18/19

mags=getmags(minmag);
dists=getdist(minmag);
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
    Seisx=readsac(xfilenames(i,:));
    localxmax(i)=max(Seisx);
    Seisy=readsac(yfilenames(i,:));
    localymax(i)=max(Seisy);
    Seisz=readsac(zfilenames(i,:));
    localzmax(i)=max(Seisz);
end

figure
stem3(mags,dists,localxmax);
xlabel('Magnitude')
ylabel('Distances from Guyot (degrees)')
zlabel('Measured Local Mags')


% Optional output
varns={};
varargout=varns(1:nargout);

