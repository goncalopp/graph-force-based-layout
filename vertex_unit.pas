unit vertex_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils;

type
  vertex = class
        edgesTo: array of vertex;
        edgesFrom: array of vertex;
        mypoint: pointer;
        procedure addEdgeTo(destination: vertex);
        procedure addEdgeFrom(source: vertex);
        function hasEdgeTo(destination: vertex):boolean;
        function hasEdgeFrom(source: vertex):boolean;

        end;


implementation

procedure vertex.addEdgeTo(destination: vertex);
begin
setLength(edgesTo, length(edgesTo)+1);
edgesTo[length(edgesTo)-1]:=destination;
setLength(destination.edgesFrom, length(destination.edgesFrom)+1);
destination.edgesFrom[length(destination.edgesFrom)-1]:=self;
end;

procedure vertex.addEdgeFrom(source: vertex);
begin
setLength(edgesFrom, length(edgesFrom)+1);
edgesFrom[length(edgesFrom)-1]:=source;
setLength(source.edgesTo, length(source.edgesTo)+1);
source.edgesTo[length(source.edgesTo)-1]:=self;
end;

function vertex.hasEdgeTo(destination: vertex):boolean;
var i:integer;
begin
result:=false;
for i:= 0 to length(edgesTo)-1 do
    if edgesTo[i]=destination then
       result:=true;
end;

function vertex.hasEdgeFrom(source: vertex):boolean;
var i:integer;
begin
result:=false;
for i:= 0 to length(edgesFrom)-1 do
    if edgesFrom[i]=source then
       result:=true;
end;

end.

