unit graphicgraph_unit;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, graph_unit, mypointUnit, Graphics;

type
  graphicgraph = class(graph)
        points: array of mypoint;
        constructor create(oriented_graph: boolean);
        procedure addvertex();
        procedure addvertex(x0,y0: double);
        procedure draw(thecanvas: TCanvas; vertexsize: integer);
        procedure drawVertex(thecanvas: TCanvas; vertexsize: integer; vertexindex: integer);
        procedure drawVertexEdges(thecanvas: TCanvas; vertexindex: integer);
        procedure simulation_step();
        end;


implementation

constructor graphicgraph.create(oriented_graph: boolean);
begin
inherited create(oriented_graph);
setlength(points, 0);
end;

procedure graphicgraph.addvertex();
begin
inherited addvertex();
setlength(points, length(points)+1);
points[length(points)-1]:= mypoint.create(0,0);
vertices[length(vertices)-1].mypoint:= points[length(points)-1];
end;

procedure graphicgraph.addvertex(x0,y0: double);
begin
inherited addvertex();
setlength(points, length(points)+1);
points[length(points)-1]:= mypoint.create(x0,y0);
vertices[length(vertices)-1].mypoint:= points[length(points)-1];
end;



procedure graphicgraph.draw(thecanvas: TCanvas; vertexsize: integer);
var i:integer; p: mypoint;
begin
thecanvas.Clear;
for i:=0 to length(points)-1 do
    begin
    drawVertex(thecanvas, vertexsize, i);
    drawVertexEdges(thecanvas, i);
    //thecanvas.line(trunc(p.x), trunc(p.y), trunc(p.x+5*p.vx), trunc(p.y+5*p.vy));
    end;
end;

procedure graphicgraph.drawVertex(thecanvas: TCanvas; vertexsize: integer; vertexindex: integer);
var p: mypoint;
begin
p:=points[vertexindex];
thecanvas.Ellipse(trunc(p.x-vertexsize), trunc(p.y-vertexsize), trunc(p.x+vertexsize), trunc(p.y+vertexsize));
end;

procedure graphicgraph.drawVertexEdges(thecanvas: TCanvas; vertexindex: integer);
var p1,p2: mypoint; i: integer;
begin
p1:=points[vertexindex];
for i:=0 to length(vertices[vertexindex].edgesTo) -1 do
    begin
    p2:=mypoint(graphicgraph(vertices[vertexindex].edgesTo[i].mypoint));
    thecanvas.Line(trunc(p1.x), trunc(p1.y), trunc(p2.x), trunc(p2.y));
    end;
end;


procedure graphicgraph.simulation_step();
var i,j:integer; tmpx,tmpy: double; p1,p2: mypoint;
begin
for i:=0 to length(points)-1 do
    begin
    p1:=points[i];
    tmpx:=0; tmpy:=0;
    for j:=0 to length(points)-1 do
        begin
        p2:=points[j];
        if p1<>p2 then
           begin
           tmpx:=tmpx+ p1.attractionVector(p2,10*10,1.01).x;
           tmpy:=tmpy+ p1.attractionVector(p2,10*10,1.01).y;
           end;
        end;
    p1.vx:=p1.vx*0.8+tmpx/(length(points)-1 );
    p1.vy:=p1.vy*0.8+tmpy/(length(points)-1 );
    end;

for i:=0 to length(points)-1 do
    begin
    p1:=points[i];
    p1.x:=p1.x+p1.vx;
    p1.y:=p1.y+p1.vy;
    end;
end;

end.

