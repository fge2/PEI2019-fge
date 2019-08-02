function varargout=threshdist(startnum,threshold,lat,lon,index)
%

start=find(index==startnum);
i=index(start):index(start+1)-1;

Guyotlat=40.35;
Guyotlon=-74.65;
dists=distance(lat(i),lon(i),Guyotlat,Guyotlon);
close=find(dists <= threshold);
closest=close(1)+index(start);

% Optional output
varns={closest};
varargout=varns(1:nargout);



