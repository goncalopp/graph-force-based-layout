unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, mypointunit;

type

  { TForm1 }



  TForm1 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    img: TImage;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure imgMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer);
    procedure imgMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
    { private declarations }
  public
    { public declarations }
  end; 

var
  Form1: TForm1; 
  points: array of mypoint;
  draggin: integer;

implementation

{ TForm1 }


procedure draw(size: integer);
var i:integer; p: mypoint;
begin
Form1.img.canvas.Clear;
for i:=0 to length(points)-1 do
    begin
    p:=points[i];
    Form1.img.canvas.Ellipse(trunc(p.x-size), trunc(p.y-size), trunc(p.x+size), trunc(p.y+size));
    Form1.img.canvas.line(trunc(p.x), trunc(p.y), trunc(p.x+5*p.vx), trunc(p.y+5*p.vy));
    end;
end;

procedure simulation_step();
var i,j:integer; p1,p2: mypoint;
begin
Form1.img.canvas.Clear;
for i:=0 to length(points)-1 do
    begin
    p1:=points[i];
    //p1.vx:=0;
    //p1.vy:=0;


    for j:=0 to length(points)-1 do
        begin
        p2:=points[j];
        if p1<>p2 then
           begin
           p1.vx:=p1.vx+ p1.attractionVector(p2,100,1.01).x;
           p1.vy:=p1.vy+ p1.attractionVector(p2,100,1.01).y;

           end;
        end;
    p1.vx:=p1.vx/(length(points)-1 );
    p1.vy:=p1.vy/(length(points)-1 );
    end;

for i:=0 to length(points)-1 do
    begin
    p1:=points[i];
    p1.x:=p1.x+p1.vx;
    p1.y:=p1.y+p1.vy;
    end;

end;



procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
begin
 setlength(points, 20);
 for i:=0 to 19 do
     points[i]:=mypoint.create(random()*512, random()*512);
     draw(4);

end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin

for i:=0 to 9999 do
    begin
    simulation_step();
    draw(4);
    application.processmessages();
    sleep(0);
    //if (i mod 1000 = 0)  then
    //  for j:=0 to 19 do
    // points[j]:=mypoint.create(random()*512, random()*512);

    end;

end;

procedure TForm1.imgMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i: integer;
begin
for i:=0 to length(points)-1 do
    if points[i].distance(mypoint.create(X,Y))<5 then
       draggin:=i;
end;

procedure TForm1.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
  );
begin
  if draggin>0 then
     begin
     points[draggin].x :=x;
     points[draggin].y :=y;
     end;
end;

procedure TForm1.imgMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  draggin:=-1;
end;

initialization
  {$I unit1.lrs}

end.

