function varargout=localstorm(lat,lon,isotime,index,k,name,wind)
% [start,date,value]=localstorm(lat,lon,isotime,index,k,name)
%
% This function returns the closest hurricanse to the local Guyot station
%
% INPUT:
% 
% lat                 lat vector
% lon                 lon vector
% isotime             time vector
% index               index vector
% k                   number of results wanted
% name                name vector
% wind                wind vector
%
% OUTPUT:
%
% start               indices of closest hurricanes
% date                dates of selected hurricanes
% value               distance away of selected hurricanes
%
% last modified by fge@princeton.edu on 7/30/19

% Guyot coords
Guyotlat=40.35;
Guyotlon=-74.65;

mindists=[];
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
    worldmap([minlat-5 maxlat+5],[minlon-5 maxlon+5]);
    load coastlines
    geoshow(coastlat,coastlon);

    cmap=colormap(gca,parula(max(wind)-min(wind)));
    c=colorbar();
    caxis([min(wind) max(wind)]);
    c.Position=[c.Position(1)+0.1 c.Position(2) c.Position(3)/3 c.Position(4)/1.1];
    set(get(c,'Title'),'String','Windspeed (km/h)');
    
    w=wind(index(i(n)):index(i(n)+1)-1);
    nans=find(isnan(w));
    w(nans)=w(nans-1);
    scatterm(lat(index(i(n)):index(i(n)+1)-1),lon(index(i(n)):index(i(n)+1)-1),10,cmap(w,:),'filled');
    g=geoshow(Guyotlat,Guyotlon,'DisplayType','Point','Marker','+','MarkerFaceColor','red','Markersize',8);
    legend(g,'Guyot Location');
    title(strcat('Track of Hurricane',{' '},name(start(n)),' Recorded by ibtracs Datasets'));
    textm(lat(index(i(n)):21:index(i(n)+1)-1),lon(index(i(n)):21:index(i(n)+1)-1)+0.05,datestr(isotime(index(i(n)):21:index(i(n)+1)-1),'mm/dd/yyyy'),'Rotation',30);
end
% Optional output
varns={start,date,value};
varargout=varns(1:nargout);