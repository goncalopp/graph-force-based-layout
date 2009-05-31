unit Unit1; 

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, LResources, Forms, Controls, Graphics, Dialogs,
  ExtCtrls, StdCtrls, graphicgraph_unit, mypointUnit;

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
  thegraph: graphicgraph;
  draggin: integer;

implementation

{ TForm1 }






procedure TForm1.Button1Click(Sender: TObject);
var i: integer;
begin
thegraph:=graphicgraph.create(false);
 for i:=0 to 19 do
     thegraph.addvertex(random()*512, random()*512);
 thegraph.draw(Form1.canvas, 4);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin

for i:=0 to 9999 do
    begin
    thegraph.simulation_step();
    thegraph.draw(Form1.canvas, 4);
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
for i:=0 to length(thegraph.points)-1 do
    if thegraph.points[i].distance(mypoint.create(X,Y))<5 then
       draggin:=i;
end;

procedure TForm1.imgMouseMove(Sender: TObject; Shift: TShiftState; X, Y: Integer
  );
begin
  if draggin>0 then
     begin
     thegraph.points[draggin].x :=x;
     thegraph.points[draggin].y :=y;
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

