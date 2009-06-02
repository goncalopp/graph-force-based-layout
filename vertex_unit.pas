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

end.

