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
dists=getmags(minmag);
[xfiles,yfiles,zfiles,times]=findrecord(minmag);
monthstr=cell2mat(month(times,'name'));

xfilenames=strcat('/data2/seismometer/',monthstr,num2str(day(times)),'/',xfiles);
yfilenames=strcat('/data2/seismometer/',monthstr,num2str(day(times)),'/',yfiles);
zfilenames=strcat('/data2/seismometer/',monthstr,num2str(day(times)),'/',zfiles);
Seisx=readsac(xfilenames);
Seisy=readsac(yfilenames);
Seisz=readsac(zfilenames);
localmagx=max(Seisx,[],2);

figure
scatter3(mags,dists,localmagx);


% Optional output
varns={};
varargout=varns(1:nargout);

