function varargout=localstorm(lat,lon,isotime,index,k,name)
% [start,date,value]=localstorm(lat,lon,isotime,index,k,name)
%
% This function returns the closest hurricanse to the local Guyot station

% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

mindists=zeros();
for i=1:(length(index)-1)
    j=index(i):index(i+1);
    dists=distance(lat(j),lon(j),Guyotlat,Guyotlon);
    mindists(i)=min(dists);
end

[value,i]=mink(mindists,k);
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
    g=geoshow(Guyotlat,Guyotlon,'DisplayType','Point','Marker','o','MarkerFaceColor','red','Markersize',10);
    legend(g,'Guyot Location');
    title(name(start(n)))
    textm(lat(index(i(n)):14:index(i(n)+1)-1),lon(index(i(n)):14:index(i(n)+1)-1)+0.05,datestr(isotime(index(i(n)):14:index(i(n)+1)-1),'mm/dd/yyyy'));
end
% Optional output
varns={start,date,value};
varargout=varns(1:nargout);