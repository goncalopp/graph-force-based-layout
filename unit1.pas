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
 for i:=0 to 10 do
     thegraph.addvertex(random()*512, random()*512);
 thegraph.addedge(1,2);
 thegraph.addedge(1,3);
 thegraph.addedge(1,4);
 thegraph.addedge(4,5);
 thegraph.addedge(4,6);
 thegraph.addedge(4,7);

 thegraph.draw(Form1.canvas, 4);
end;

procedure TForm1.Button2Click(Sender: TObject);
var i,j:integer;
begin

for i:=0 to 5000 do
    begin
    thegraph.simulation_step();
    thegraph.draw(Form1.canvas, 4);
    application.processmessages();
    //sleep(0);
    end;
end;


initialization
  {$I unit1.lrs}

end.

