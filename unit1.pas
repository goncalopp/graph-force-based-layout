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
    Button3: TButton;
    img: TImage;
    Timer1: TTimer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);

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
thegraph.free();
thegraph:=graphicgraph.create(false);
 for i:=0 to 50 do
     thegraph.addvertex(random()*512, random()*512);
 for i:=0 to 45 do
     thegraph.addedge(trunc(random()*50), trunc(random()*50));

 thegraph.draw(Form1.canvas, 4);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin
timer1.enabled:=true;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  timer1.enabled:=false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
     thegraph.simulation_step(1.01, 0.999);
     thegraph.draw(Form1.canvas, 4);
     application.processmessages();
end;


initialization
  {$I unit1.lrs}

end.

