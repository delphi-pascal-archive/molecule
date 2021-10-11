unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

 BRGB = record
   B:byte;
   G:byte;
   R:byte;
  end;

  TRgb=array[0..0] of BRGB;
  PRGB=array[0..1000] of ^TRgb;
  TXY=record
  x,y:integer;
 end;

var
  Form1: TForm1;
  bitM:TBitMap;
  BitP:PRGB;
  BitBuffP:PRGB;
  BitBuffM:TBitMap;
  BitBuffP1:PRGB;
  BitBuffM1:TBitMap;
  shape:array[1..3] of  TXY;
  t:double;

implementation

{$R *.dfm}

procedure BitMapToPointer(var PointerBitMap:PRgb; Bitmap:TBitMAp);
var
 i:integer;
 H:integer;
begin
 h:=bitmap.height-1 ;
 for i:=0 to h do
    PointerBitMap[i]:=Bitmap.ScanLine[i];
end;

procedure TForm1.FormCreate(Sender: TObject);
var
i,j:integer;
begin
BitBuffM:=tbitmap.Create;
BitBuffM.PixelFormat:=pf24bit;
BitBuffM.Width:=500;
BitBuffM.height:=500;
BitBuffM.Canvas.Brush.Color:=0;
BitBuffM.Canvas.FillRect(rect(0,0,500,500));
BitMapToPointer(bitbuffp,BitBuffM);
BitBuffM1:=tbitmap.Create;
BitBuffM1.PixelFormat:=pf24bit;
BitBuffM1.Width:=500;
BitBuffM1.height:=500;
BitBuffM1.Canvas.Brush.Color:=0;
BitBuffM1.Canvas.FillRect(rect(0,0,500,500));
BitMapToPointer(bitbuffp1,BitBuffM1);
bitm:=tbitmap.Create;
bitm.PixelFormat:=pf24bit;
bitm.LoadFromFile('1.bmp');
BitMapToPointer(bitp,bitm);
end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
r,g,b:integer;
i,j,k:integer;
xx,yy:integer;
cons:double;
begin
BitBuffM1.Canvas.FillRect(rect(0,0,500,500));
t:=t+0.5;
cons:= 0.106;
for i:=1 to 3 do
begin
 shape[i].x:=round(250+100*cos((t+i*10)/(i*5+10)));
 shape[i].y:=round(250+100*sin((t+i*20)/(i*3+20)));
 for j:=0 to 99 do
    for k:=0 to 99 do
    begin
        xx:=(shape[i].x-50)+j ;
        yy:=(shape[i].y-50)+k ;
        r:=(bitbuffp[yy,xx].R+bitp[k,j].R);
        g:=(bitbuffp[yy,xx].g+bitp[k,j].g);
        b:=(bitbuffp[yy,xx].b+bitp[k,j].b);
        if r> 255 then bitbuffp[yy,xx].R:=255 else bitbuffp[yy,xx].R:=r;
        if g> 255 then bitbuffp[yy,xx].g:=255 else bitbuffp[yy,xx].g:=g;
        if b> 255 then bitbuffp[yy,xx].b:=255 else bitbuffp[yy,xx].b:=b;
    end;
end;
for i:=2 to 498 do
  for j:=2 to 498 do
  begin
  if ((i>0) or (i<500)) and ((j>0) or (j<500)) then
  begin
    bitbuffp[i,j].R:=round(((bitbuffp[i-1,j-1].R+bitbuffp[i-1,j].R+bitbuffp[i-1,j+1].R+bitbuffp[i,j-1].R+bitbuffp[i,j].R+bitbuffp[i,j+1].R+bitbuffp[i+1,j-1].R+bitbuffp[i+1,j].R+bitbuffp[i+1,j+1].R) * cons));
    bitbuffp[i,j].g:=round(((bitbuffp[i-1,j-1].g+bitbuffp[i-1,j].g+bitbuffp[i-1,j+1].g+bitbuffp[i,j-1].g+bitbuffp[i,j].g+bitbuffp[i,j+1].g+bitbuffp[i+1,j-1].g+bitbuffp[i+1,j].g+bitbuffp[i+1,j+1].g) * cons));
    bitbuffp[i,j].b:=round(((bitbuffp[i-1,j-1].b+bitbuffp[i-1,j].b+bitbuffp[i-1,j+1].b+bitbuffp[i,j-1].b+bitbuffp[i,j].b+bitbuffp[i,j+1].b+bitbuffp[i+1,j-1].b+bitbuffp[i+1,j].b+bitbuffp[i+1,j+1].b) * cons));
  end;
end;
  for i:=0 to 499 do
    for j:=0 to 499 do
        begin
            if (bitbuffp[i,j].g >60) and (bitbuffp[i,j].g <70) then
                begin
                    bitbuffp1[i,j].R:= 255;
                    bitbuffp1[i,j].g:= 255;
                    bitbuffp1[i,j].b:=255;
                end;
        if (bitbuffp[i,j].g >90) and (bitbuffp[i,j].g <100) then
            begin
                bitbuffp1[i,j].R:= 255;
                bitbuffp1[i,j].g:= 255;
                bitbuffp1[i,j].b:=255;
            end;
       if (bitbuffp[i,j].g >70) and (bitbuffp[i,j].g <90) then
            begin
                bitbuffp1[i,j].R:= 50;
                bitbuffp1[i,j].g:= 50;
                bitbuffp1[i,j].b:=255;
            end;
        if (bitbuffp[i,j].g >220) and (bitbuffp[i,j].g <235) then
            begin
                bitbuffp1[i,j].R:= 255;
                bitbuffp1[i,j].g:= 155;
                bitbuffp1[i,j].b:=0;
       end;
  end;
 Form1.Canvas.stretchDraw(rect(0,0,width,height),BitBuffM1);
end;

end.
