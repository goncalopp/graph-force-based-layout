unit mypointUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes, Math;

type


  mypoint = class
        x,y: double;
        vx,vy: double;
        constructor create();
        constructor create(x0: double; y0: double);
        function distance(p: mypoint): double;
        function attractionVector(p:mypoint; dist: double; k1: double ):mypoint;
        function vector(p:mypoint): mypoint;
        procedure multiplyBy(p:mypoint);
        procedure unitarize();
        end;

implementation


constructor mypoint.create();
begin
x:=0; y:=0; vx:=0; vy:=0;
end;

constructor mypoint.create(x0, y0: double);
begin
x:=x0; y:=y0; vx:=0; vy:=0;
end;

function mypoint.distance(p:mypoint):double;
begin
Result:= sqrt((x-p.x)*(x-p.x)+(y-p.y)*(y-p.y));
end;

function mypoint.vector(p:mypoint): mypoint;
begin
result:= mypoint.create(p.x-x, p.y-y);
end;

procedure mypoint.multiplyBy(p:mypoint);
begin
x:=x*p.x;
y:=y*p.y;
end;

procedure mypoint.unitarize();
var tmp: double;
begin
tmp:=sqrt(x*x+y*y);
x:=x/tmp;
y:=y/tmp;
end;

function mypoint.attractionVector(p:mypoint; dist: double; k1:double):mypoint;
var vp : mypoint;
begin
//k1= 1.01;
vp:=vector(p);
Result:= mypoint.create(
                     power(k1, abs(vp.x) - dist) - power(k1, -(abs(vp.x) - dist)),
                     power(k1, abs(vp.y) - dist) - power(k1, -(abs(vp.y) - dist))
                     );
vp.unitarize();
Result.multiplyBy(vp);
vp.free();
end;

end.

