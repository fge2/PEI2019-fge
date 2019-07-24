function varargout=localstorm(lat,lon,index)
% [start,value]=localstorm(lat,lon,index)

% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

dists=distance(lat(index),lon(index),Guyotlat,Guyotlon);
k=3;
[value,i]=mink(dists,k);
start=index(i);
for n=1:k
    figure
    maxlat=max(lat(index(i(n)):index(i(n)+1)-1));
    maxlon=max(lon(index(i(n)):index(i(n)+1)-1));
    minlat=min(lat(index(i(n)):index(i(n)+1)-1));
    minlon=min(lon(index(i(n)):index(i(n)+1)-1));
    worldmap([minlat-5 maxlat+5],[minlon-5 maxlon+5])
    load coastlines
    geoshow(lat(index(i(n)):index(i(n)+1)-1),lon(index(i(n)):index(i(n)+1)-1),'Marker','o','LineStyle','none')
end
% Optional output
varns={start,value};
varargout=varns(1:nargout);