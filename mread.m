function varargout=mread(float_name)
% [name,t,lat,lon]=mread(float_name)
% 
% Reads in mermaid float data using webread given float name
%
% INPUT:
%
% float_name     Name/number of mermaid float

%
% OUTPUT:
%
% name           The name of the float
% lat            The latitude vector
% lon            The longitude vector
% t              The datetime vector
%
% Last modified by fge@princeton.edu on 6/26/19

defval('float_name','P017');

% read and parse data
url=strcat('http://geoweb.princeton.edu/people/simons/SOM/',float_name,'_030.txt');
data=webread(url);
data_split=strsplit(data);
date=data_split(2:15:end);
time=data_split(3:15:end);
latstr=data_split(4:15:end);
lonstr=data_split(5:15:end);

name=data_split(1);
lat=str2double(latstr);
lon=str2double(lonstr);
t=datetime([strcat(date,{' '},time)],'InputFormat','dd-MMM-yyyy HH:mm:ss');

% Optional output
varns={name,t,lat,lon};
varargout=varns(1:nargout);


