function varargout=mpredict(float_name,f,next,surfaces,points,order)
% [nextlat,nextlon,nextm,nextt,next]=mpredict(float_name,f,next,surfaces,points,order)
% [nextlat,nextlon,nextm,nextt,next]=mpredict(float_name,f)
%
% Predicts and plots future mermaid location and returns future position 
% and velocity
%
% INPUT:
%
% float_name  The name of the mermaid float
% f           The figure handle of positionplt
% next        The hours out that is predicted 
% surfaces    The prediction that number of surfaces later
%             ex. surfaces=2 predicts 2 surfaces later, default=1
% points      The number of previous points to perform regression on
% order       The order of regression
%
% OUTPUT:
%
% nextlat     The latitude prediction a week later
% nextlon     The longitude prediction a week later
% nextm       The predicted magnitude of velocity
% nextt       The predicted angle of velocity
% next        The time of the new prediction in seconds
%
% Last modified by fge@princeton.edu on 6/28/19

defval('float_name','P017')
defval('points',4);
defval('order',2);
defval('surfaces',1);
[name,t,lat,lon]=mread(float_name);

input=1;
switch input
    case 0
        nextlat=lat(end);
        nextlon=lon(end);
        figure(f)
        geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
        'MarkerFaceColor','b','MarkerEdgeColor','b''Markersize',5)
        
    case 1
        [mag,theta]=vplt(float_name,0);
        [dive,~]=indexsplit(t);
        
        % setting x and y for regression
        start=length(dive)-points+1;
        mset=mag(dive(start:end));
        tset=theta(dive(start:end));
        ellapsed_time=date2sec(t);
        dive_time=ellapsed_time(dive);
        timeframe=zeros(1,points);
        for i=2:points
            timeframe(i)=timeframe(i-1)+dive_time(start+i-1);
        end
        
        % predicting new latitude and longitude
        defval('next',mean(dive_time)*surfaces/3600);
        next=next*3600;
        [changelat,changelon,nextm,nextt]=llpredict(mset,tset,timeframe,...
            next,order);
        nextlat = changelat + lat(end);
        nextlon = changelon + lon(end);
        
        % plotting prediction
        % plot or not
        plot=0;
        
        if plot
            figure(f)
            hold on
            geoshow(nextlat,nextlon,'DisplayType','Point','Marker','o',...
            'MarkerFaceColor','b','MarkerEdgeColor','b','Markersize',5,...
            'DisplayName','Prediction')
            trajectory = quiverm(lat(end),lon(end),changelat,changelon,'c');
            trajectory(1).HandleVisibility = 'off';
            trajectory(2).HandleVisibility = 'off'; 
        end
end

% Optional output
varns={nextlat,nextlon,nextm,nextt,next};
varargout=varns(1:nargout);
