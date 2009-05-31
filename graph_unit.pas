unit graph_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, vertex_unit;

type
  graph = class
        oriented: boolean;
        vertices: array of vertex;
        constructor create(oriented_graph:boolean);
        procedure addvertex();
        end;

implementation


constructor graph.create(oriented_graph: boolean);
begin
setlength(vertices, 0);
oriented:=oriented_graph;
end;

procedure graph.addvertex();
begin
setlength(vertices, length(vertices)+1);
vertices[length(vertices)-1]:= vertex.create();
end;

end.

