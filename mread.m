function varargout=mread(url)
% [name,t,lat,lon]=mread(url)
% 
% Reads in mermaid float data from given url
%
% INPUT:
%
% url     Website containing mermaid information
%         Ex:http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt
%
% OUTPUT:
%
% name    The name of the float
% lat     The latitude vector
% lon     The longitude vector
% t       The datetime vector
%
% Last modified by fge@princeton.edu on 6/24/19

defval('url','http://geoweb.princeton.edu/people/simons/SOM/P017_030.txt');

% read and parse data
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


