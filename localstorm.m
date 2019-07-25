function varargout=localstorm(lat,lon,isotime,index,k)
% [start,value]=localstorm(lat,lon,index)

% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

dists=distance(lat(index),lon(index),Guyotlat,Guyotlon);
[value,i]=mink(dists,k);
start=index(i);
date=isotime(start);
for n=1:k
    figure
    maxlat=max(lat(index(i(n)):index(i(n)+1)-1));
    maxlon=max(lon(index(i(n)):index(i(n)+1)-1));
    minlat=min(lat(index(i(n)):index(i(n)+1)-1));
    minlon=min(lon(index(i(n)):index(i(n)+1)-1));
    worldmap([minlat-5 maxlat+5],[minlon-5 maxlon+5])
    load coastlines
    geoshow(coastlat,coastlon);
    geoshow(lat(index(i(n)):index(i(n)+1)-1),lon(index(i(n)):index(i(n)+1)-1),'Marker','.','Markersize',10,'LineStyle','none')
    geoshow(Guyotlat,Guyotlon,'DisplayType','Point','Marker','o','MarkerFaceColor','red','Markersize',15);
    textm(lat(index(i(n)):7:index(i(n)+1)-1),lon(index(i(n)):7:index(i(n)+1)-1)+0.05,datestr(isotime(index(i(n)):7:index(i(n)+1)-1),'mm/dd'));
end
% Optional output
varns={start,date,value};
varargout=varns(1:nargout);