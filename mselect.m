function varargout=mselect(input,k,surfaces)
% [coords,mermaid,loc,value,time]=mselect(input,k,surfaces)
%
% Selects which mermaid will surfaces closest to a given path at a similar
% timeframe
%
% INPUT:
%
% input        0 plot all mermaid points
%              1 plot closest wrt path
%              2 plot closest wrt time correspondence
% k            Number of floats to return
% surfaces     The prediction that number of surfaces later 
%
% OUTPUT:
%
% coords       The coordinates of predicted mermaid surfaces
% mermaid      The mermaid that will be closest to ship path 
% loc          The coordinates of the closest mermaid
% value        The distance of mermaid from path of ship in degrees
% time         The time of surfacoing in days after the ship sets off 
%
% Last modified by fge@princeton.edu on 6/28/19

defval('surfaces',1);
defval('k',4);

% ship data
date_time = [{'05-Aug-2019 08:00:00'},{'06-Aug-2019 18:00:00'},{'07-Aug-2019 08:00:00'},...
    {'07-Aug-2019 23:00:00'},{'08-Aug-2019 13:00:00'}, {'09-Aug-2019 04:00:00'},...
    {'10-Aug-2019 08:00:00'}, {'11-Aug-2019 23:00:00'}, {'13-Aug-2019 01:00:00'},...
    {'14-Aug-2019 19:00:00'}, {'17-Aug-2019 01:00:00'}, {'18-Aug-2019 19:00:00'},...
    {'19-Aug-2019 08:00:00'}, {'20-Aug-2019 02:00:00'}, {'20-Aug-2019 20:00:00'},...
    {'21-Aug-2019 14:00:00'}, {'22-Aug-2019 13:00:00'}, {'23-Aug-2019 02:00:00'},...
    {'23-Aug-2019 15:00:00'}, {'24-Aug-2019 05:00:00'}, {'24-Aug-2019 19:00:00'},...
    {'25-Aug-2019 12:00:00'}, {'26-Aug-2019 04:00:00'}, {'26-Aug-2019 21:00:00'},...
    {'27-Aug-2019 14:00:00'}, {'30-Aug-2019 18:00:00'}, {'31-Aug-2019 08:00:00'}];
slon = [-149.3, -151.0, -150.0, -149.0, -148.0, -146.0, -144.0, -142.0, -135.0,...
    -136.0, -141.0, -149.0, -151.0, -154.0, -157.0, -160.0, -164.0, -166.0,...
    -168.0, -170.0, -172.0, -174.9, -177.6, -179.0, -180.0, -166.3, -166.3];
slat = [-17.3, -12.0, -10.0, -8.0, -6.0, -5.0, -6.0, -8.0, -13.0, -17.0, -22.0,...
    -27.0, -28.0, -29.0, -30.0, -31.0, -30.0, -29.0, -28.0, -27.0, -26.0, -25.65...
    -25.63, -25.0, -24.0, -22.2, -22.2];

seconds=3600*24;
%launch=date_time{1};
%run code from current day
launch=datetime('today');

% surface coords
coords=zeros(25,2);
times=zeros(1,25);
mermaids=[1:13 16:25];

% endtime=zeros(1,25);
for i=mermaids
    float_name=strcat('P0',sprintf('%02d',i));
    [nextlat,nextlon,~,~,time]=mpredict(float_name,[],[],surfaces);
    coords(i,1)=nextlat;
    coords(i,2)=nextlon;
    times(i)=time;    
end

switch input
    case 0
        % plot all mermaid locations for qualitative view
        shipplt;
        hold on;
        p=geoshow(coords(:,1),coords(:,2),'DisplayType','Point','Marker','o',...
            'MarkerFaceColor','b','MarkerEdgeColor','b','Markersize',5);
        legend(p,'Mermaid Locations','Location','NorthWest');
        x=1:25;
        textm(coords(:,1)+1,coords(:,2),strcat(sprintfc('%d',x)));
        textm(coords(:,1),coords(:,2),datestr(datenum(launch)+times(x)/seconds,'mm-dd-yy'));
        mermaid=[];
        loc=[];
        value=[];
        time=[];
        
    case 1
        % closest mermaid that surfaces on the path of ship independent of time
        closest=zeros(1,25);
        for i=mermaids
            mindist=inf;
            for j=7:20
                dist=distance(coords(i,1),coords(i,2),slat(j),slon(j));
                if dist<mindist
                    mindist=dist;
                end
                closest(i)=mindist;
            end
        end
        closest(closest==0)=inf;
        [value,i]=min(closest);
        mermaid=strcat('P0',sprintf('%02d',i));
        loc=coords(i,:);
        time=times(i)/seconds;

        % plot
        shipplt;
        hold on
        p=geoshow(loc(1),loc(2),'DisplayType','Point','Marker','o',...
                'MarkerFaceColor','b','MarkerEdgeColor','b','Markersize',10);
        legend(p,'Closest to Path','Location','NorthWest');
        textm(loc(1),loc(2),datestr(datenum(launch)+time,'mm-dd-yy'));
        textm(loc(1)+1,loc(2),mermaid);

    case 2
        % closest mermaid that surfaces near ship
        closetimes=zeros(1,25);
        closeindex=zeros(1,25);
        for i=mermaids
            mintime=inf;
            for j=7:20    
                timepass=abs(times(i)-(datenum(date_time{j})-datenum(launch))*seconds);
                if timepass<mintime
                    mintime=timepass;
                    minindex=j;
                end
            end
            closetimes(i)=mintime;
            closeindex(i)=minindex;
        end
        
        newcoords=zeros(1,25);
        for i=mermaids
            newcoords(i)=distance(coords(i,1),coords(i,2),slat(closeindex(i)),slon(closeindex(i)));
        end
        newcoords(newcoords==0)=inf;
        [value,i]=mink(newcoords,k);
        mermaid=strings(1,k);
        count=1;
        for j=i
            mermaid(count)=strcat('P0',sprintf('%02d',j));
            count=count+1;
        end
        loc=coords(i,:);
        time=times(i)/seconds;

        % plot
        shipplt;
        hold on
        p=geoshow(loc(:,1),loc(:,2),'DisplayType','Point','Marker','o',...
                'MarkerFaceColor','b','MarkerEdgeColor','b','Markersize',8,...
                'DisplayName','Closest Time Correspondence');
        legend(p,'Closest Time Correspondence','Location','NorthWest');
        textm(loc(:,1),loc(:,2),datestr(datenum(launch)+time,'mm-dd-yy'));
        textm(loc(:,1)+1,loc(:,2),mermaid);
end
    
% Optional output
varns={coords,mermaid,loc,value,time};
varargout=varns(1:nargout);