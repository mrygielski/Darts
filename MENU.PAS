
uses f13h, mouse_, games;

{$I consts.pas}
{$I proced.pas}

const
     versja = '1^0';

type
    zapis = record
                  speed : byte;
                  detale : string[4];
            end;

var
   ax, ay, k : integer;
   speed : byte;
   det : string;
   f : file of zapis;
   z : zapis;

const
     cur : array[1..5, 1..7] of byte =
     ((0,0,1,1,1,0,0),
      (0,1,0,0,0,1,0),
      (0,1,0,1,0,1,0),
      (0,1,0,0,0,1,0),
      (0,0,1,1,1,0,0));
     dart : array[1..10, 1..7] of byte =
     ((0,3,0,0,0,0,0),
      (0,3,3,0,0,0,0),
      (0,3,1,1,0,0,0),
      (0,0,1,1,0,0,0),
      (0,0,1,1,0,0,0),
      (0,0,2,1,1,2,0),
      (0,0,0,2,2,0,0),
      (0,0,0,2,2,0,0),
      (0,0,2,0,0,2,0),
      (0,0,0,0,0,0,0));

var
   p : tpaleta;
   mx, my : integer;
   ptk : byte;
   typ : string;
   typ1, typ2 : array[1..3] of string[7];
   k1, k2 : real;
   dy : integer;
   tm, ptk1, ptk2 : integer;
   shotn : byte;
   pt, pt2 : array[1..3] of byte;
   exit : boolean;
   i : integer;
   p1, z1, p2, z2, detale : boolean;

procedure tekst(x, y, a, b, c, c2 : integer; tekst : string); forward;

procedure player2;

procedure show_cur;
var
   x, y : integer;
begin
     for x:= 1 to 5 do
     for y:= 1 to 7 do if cur[x,y]<>0 then putpixel2(y+mx-4,x+my-3,56+cur[x,y]);
end;

procedure show_cur0;
var
   x, y : integer;
begin
     for x:= 1 to 5 do
     for y:= 1 to 7 do if cur[x,y]<>0 then putpixel2(y+mx-4,x+my-3,255);
end;

procedure show_dart(px, py : integer; p : shortint);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel2(y+px,x+py,58+dart[x,y]+p);
end;

procedure show_dart_s(px, py : integer; p : shortint);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel1(y+px,x+py,58+dart[x,y]+p);
end;

procedure show_dart0(px, py : integer);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel2(y+px,x+py,255);
end;

procedure przygotuj_tarcze;
var
   i : integer;
begin
loadpaintfile1(55+9,7,'darts.dat',255);
setcol(57,63,63,63);
setcol(55,50,33,10);

setcol(59,45,5,5);
setcol(60,30,0,0);
setcol(61,50,50,50);

setcol(62,5,5,45);
setcol(63,0,0,30);
setcol(64,50,50,50);
flood(98+9,100,1);flood(125+9,100,1);
flood(168+9,100,2);flood(195+9,100,2);
flood(105+9,70,3);flood(125+9,80,3);
flood(135+9,60,11);flood(145+9,70,11);
flood(160+9,60,5);flood(155+9,70,5);
flood(175+9,80,6);flood(180+9,70,6);
flood(175+9,115,7);flood(190+9,120,7);
flood(155+9,115,8);flood(158+9,140,8);
flood(145+9,115,9);flood(138+9,140,9);
flood(125+9,115,10);flood(105+9,130,10);
setcol(210,50,40,30);
for i:= 1 to 3 do setcol(i,45,28,5);
for i:= 5 to 11 do setcol(i,45,28,5);
for i:= 12 to 21 do setcol(i,40,23,0);
for i:= 22 to 41 do setcol(i,35,8,0);
for i:= 42 to 52 do setcol(i,45,18,10);
for i:= 72 to 81 do setcol(i,45,18,10);
setcol(53,35,8,0);
flood(148+9,70,12);flood(148+9,50,12);
flood(148+9,120,13);flood(148+9,150,13);
flood(170+9,105,14);flood(190+9,110,14);
flood(110+9,110,15);flood(130+9,105,15);
flood(110+9,80,16);flood(130+9,90,16);
flood(170+9,95,17);flood(190+9,90,17);
flood(170+9,125,18);flood(180+9,130,18);
flood(130+9,135,19);flood(134+9,120,19);
flood(160+9,85,20);flood(180+9,60,20);
flood(120+9,65,21);flood(130+9,74,21);

flood(150+9,41,22);
flood(150+9,65,23);
flood(150+9,135,24);
flood(150+9,155,25);
flood(180+9,50,26);
flood(169+9,70,27);
flood(184+9,90,28);
flood(205+9,85,29);
flood(205+9,119,30);
flood(185+9,113,31);
flood(169+9,128,32);
flood(180+9,148,33);
flood(129+9,128,34);
flood(120+9,148,35);
flood(98+9,120,36);
flood(119+9,113,37);
flood(116+9,93,38);
flood(95+9,88,39);
flood(128+9,72,40);
flood(117+9,51,41);

flood(140+9,41,42);flood(144+9,65,72);
flood(175+9,44,43);flood(164+9,65,72);
flood(195+9,64,44);flood(178+9,78,74);
flood(208+9,94,45);flood(185+9,98,75);
flood(200+9,128,46);flood(180+9,120,76);
flood(170+9,153,47);flood(165+9,133,77);
flood(140+9,153,48);flood(140+9,133,78);
flood(100+9,128,49);flood(120+9,118,79);
flood(92+9,94,50);flood(114+9,96,80);
flood(102+9,64,51);flood(122+9,76,81);

flood(155+9,100,52);
flood(152+9,100,53);

putpixel1(118,156,210);
putpixel1(116,157,210);
putpixel1(117,156,210);
putpixel1(117,155,210);
putpixel1(118,155,210);
end;

procedure background;
var
   i, j : integer;
begin
     for i:= 100 to 164 do setcol(i,i,i-10,0);
     for i:= 165 to 119 do setcol(i,i,i,i);
     if detale then
     begin
     for i:= 0 to 319 do
     for j:= 0 to 199 do putpixel1(i,j,100+round(3.1+cos(i)*sin(j)*3));
     for i:= 60 to 259 do
     for j:= 10 to 189 do putpixel1(i,j,106+round(3.1+cos(i)*sin(j)*3));
     end else
     bar1(0,0,320,200,0);
end;

procedure pobierz_dane_z_tarczy;
begin
      if getpixel1(mx,my)=12 then begin ptk:=20; typ:='SINGLE'; end;
      if getpixel1(mx,my)=5 then begin ptk:=1; typ:='SINGLE'; end;
      if getpixel1(mx,my)=20 then begin ptk:=18; typ:='SINGLE'; end;
      if getpixel1(mx,my)=6 then begin ptk:=4; typ:='SINGLE'; end;
      if getpixel1(mx,my)=17 then begin ptk:=13; typ:='SINGLE'; end;
      if getpixel1(mx,my)=2 then begin ptk:=6; typ:='SINGLE'; end;
      if getpixel1(mx,my)=14 then begin ptk:=10; typ:='SINGLE'; end;
      if getpixel1(mx,my)=7 then begin ptk:=15; typ:='SINGLE'; end;
      if getpixel1(mx,my)=18 then begin ptk:=2; typ:='SINGLE'; end;
      if getpixel1(mx,my)=8 then begin ptk:=17; typ:='SINGLE'; end;
      if getpixel1(mx,my)=13 then begin ptk:=3; typ:='SINGLE'; end;
      if getpixel1(mx,my)=9 then begin ptk:=19; typ:='SINGLE'; end;
      if getpixel1(mx,my)=19 then begin ptk:=7; typ:='SINGLE'; end;
      if getpixel1(mx,my)=10 then begin ptk:=16; typ:='SINGLE'; end;
      if getpixel1(mx,my)=15 then begin ptk:=8; typ:='SINGLE'; end;
      if getpixel1(mx,my)=1 then begin ptk:=11; typ:='SINGLE'; end;
      if getpixel1(mx,my)=16 then begin ptk:=14; typ:='SINGLE'; end;
      if getpixel1(mx,my)=3 then begin ptk:=9; typ:='SINGLE'; end;
      if getpixel1(mx,my)=21 then begin ptk:=12; typ:='SINGLE'; end;
      if getpixel1(mx,my)=11 then begin ptk:=5; typ:='SINGLE'; end;

      if getpixel1(mx,my)=22 then begin ptk:=40; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=43 then begin ptk:=2; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=26 then begin ptk:=36; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=44 then begin ptk:=8; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=29 then begin ptk:=26; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=45 then begin ptk:=12; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=30 then begin ptk:=20; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=46 then begin ptk:=30; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=33 then begin ptk:=4; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=47 then begin ptk:=34; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=25 then begin ptk:=6; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=35 then begin ptk:=14; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=36 then begin ptk:=16; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=50 then begin ptk:=22; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=39 then begin ptk:=28; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=51 then begin ptk:=18; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=41 then begin ptk:=24; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=42 then begin ptk:=10; typ:='DOUBLE'; end;

      if getpixel1(mx,my)=23 then begin ptk:=60; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=72 then begin ptk:=3; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=27 then begin ptk:=54; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=74 then begin ptk:=12; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=28 then begin ptk:=39; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=75 then begin ptk:=18; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=31 then begin ptk:=30; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=76 then begin ptk:=45; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=32 then begin ptk:=6; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=77 then begin ptk:=51; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=24 then begin ptk:=9; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=78 then begin ptk:=57; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=34 then begin ptk:=21; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=79 then begin ptk:=48; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=37 then begin ptk:=24; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=80 then begin ptk:=33; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=38 then begin ptk:=42; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=81 then begin ptk:=27; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=40 then begin ptk:=36; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=72 then begin ptk:=15; typ:='TRIPLE'; end;

      if getpixel1(mx,my)=53 then begin ptk:=50; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=52 then begin ptk:=25; typ:='SINGLE'; end;

      if getpixel1(mx,my)in[100..164] then begin ptk:=0; typ:='MISS'; end;
      if getpixel1(mx,my)=210 then begin ptk:=0; typ:='MISS'; end;
end;

procedure sincos(x, y, a, b : integer; ka, kb : real; var mx, my : integer; var k1a, k2a : real);
begin
     k1a:=k1a+ka;
     k2a:=k2a+kb;
     mx:=round(a*sin(k1a)+5)+x;
     my:=round(b*cos(k2a)-40)+y;
end;

procedure show_score1;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(4,5+i*20-20,57,1,1,'POINT='+num2str(pt[i]));
          outtextxy2(4,15+i*20-20,57,1,1,typ1[i]);
     end;
end;

procedure show_score1h;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(4,5+i*20-20,255,1,1,'POINT='+num2str(pt[i]));
          outtextxy2(4,15+i*20-20,255,1,1,typ1[i]);
     end;
end;

procedure show_score2;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(240,5+i*20-20,57,1,1,'POINT='+num2str(pt2[i]));
          outtextxy2(240,15+i*20-20,57,1,1,typ2[i]);
     end;
end;

procedure show_score2h;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(240,5+i*20-20,255,1,1,'POINT='+num2str(pt2[i]));
          outtextxy2(240,15+i*20-20,255,1,1,typ2[i]);
     end;
end;

procedure gracz1;
begin
shotn:=0;
z1:=false;
repeat
      ax:=ax div 2;
      getmousepos(ax,ay,k);
      sincos(ax,ay,30,30,0.1,0.05,mx,my,k1,k2);
      outtextxy2(130,5,57,1,1,'PLAYER 1');
      if k=1 then
      begin
           inc(shotn);
           typ1[shotn]:='';
           pt[shotn]:=0;
           tm:=ptk1;
           for dy:= 70 downto my div 3 do
           begin
                show_score1;
                show_cur;
                outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
                outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
                show_dart(mx,dy*3,0);
                movebuf2screen2;delay(speed div 4);
                bar2(0,180,320,200,255);
                show_dart0(mx,dy*3);
           end;
           show_dart_s(mx,dy*3,0);
           typ1[shotn]:=typ;
           pt[shotn]:=ptk;
           if pt[shotn]>ptk1 then z1:=true;
           bar2(0,2,70,60,255);
           bar2(230,2,320,67,255);
           ptk1:=ptk1-pt[shotn];
      end;

      pobierz_dane_z_tarczy;

      show_cur;

      show_score1;
      show_score2;

      outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
      outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));

      line2(ax,ay-7-35,ax,ay-1-35,57);
      line2(ax,ay+1-35,ax,ay+7-35,57);
      line2(ax-7,ay-35,ax-1,ay-35,57);
      line2(ax+7,ay-35,ax+1,ay-35,57);
      movebuf2screen2;delay(speed);
      line2(ax,ay-7-35,ax,ay-1-35,255);
      line2(ax,ay+1-35,ax,ay+7-35,255);
      line2(ax-7,ay-35,ax-1,ay-35,255);
      line2(ax+7,ay-35,ax+1,ay-35,255);

      bar2(0,180,320,200,255);

      show_score1h;

      if ptk1=0 then p1:=true;
      if ptk1<0 then ptk1:=tm;
      if keydown[1] then exit:=true;

      show_cur0;
until (shotn=3) or p1 or z1 or exit;
if p1 then
begin
show_score1;
outtextxy1(135,98,57,1,1,'WINNER');
movebuf2screen;
end;
if z1 then
begin
show_score1;
outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
outtextxy1(145,98,57,1,1,'BUST');
movebuf2screen2;
end;
end;

procedure gracz2;
begin
shotn:=0;
z2:=false;
repeat
      ax:=ax div 2;
      getmousepos(ax,ay,k);
      sincos(ax,ay,30,30,0.1,0.05,mx,my,k1,k2);
      outtextxy2(130,5,57,1,1,'PLAYER 2');
      if k=1 then
      begin
           inc(shotn);
           typ2[shotn]:='';
           pt2[shotn]:=0;
           tm:=ptk2;
           for dy:= 70 downto my div 3 do
           begin
                show_score2;
                show_cur;
                outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
                outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
                show_dart(mx,dy*3,0);
                movebuf2screen2;delay(speed div 4);
                bar2(0,180,320,200,255);
                show_dart0(mx,dy*3);
           end;
           show_dart_s(mx,dy*3,0);
           typ2[shotn]:=typ;
           pt2[shotn]:=ptk;
           if pt2[shotn]>ptk2 then z2:=true;
           bar2(0,2,70,60,255);
           bar2(230,2,320,67,255);
           ptk2:=ptk2-pt2[shotn];
      end;

      pobierz_dane_z_tarczy;

      show_cur;

      show_score1;
      show_score2;

      outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
      outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));

      line2(ax,ay-7-35,ax,ay-1-35,57);
      line2(ax,ay+1-35,ax,ay+7-35,57);
      line2(ax-7,ay-35,ax-1,ay-35,57);
      line2(ax+7,ay-35,ax+1,ay-35,57);
      movebuf2screen2;delay(speed);
      line2(ax,ay-7-35,ax,ay-1-35,255);
      line2(ax,ay+1-35,ax,ay+7-35,255);
      line2(ax-7,ay-35,ax-1,ay-35,255);
      line2(ax+7,ay-35,ax+1,ay-35,255);

      bar2(0,180,320,200,255);

      show_score2h;

      if ptk2=0 then p2:=true;
      if ptk2<0 then ptk2:=tm;
      if keydown[1] then exit:=true;

      show_cur0;
until (shotn=3) or p2 or z2 or exit;
if p2 then
begin
show_score2;
outtextxy1(135,98,57,1,1,'WINNER');
movebuf2screen;
end;
if z2 then
begin
show_score2;
outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
outtextxy1(145,98,57,1,1,'BUST');
movebuf2screen2;
end;
end;

begin
if z.detale='LOW' then detale:=false;
if z.detale='HIGH' then detale:=true;
background;
przygotuj_tarcze;
mousewindow(50,80,270,200);
setmousepos(160,100);
shotn:=0;
for i:= 1 to 3 do pt[i]:=0;
for i:= 1 to 3 do typ1[i]:='------';
ptk1:=1001;
for i:= 1 to 3 do pt2[i]:=0;
for i:= 1 to 3 do typ2[i]:='------';
ptk2:=1001;
p1:=false;
p2:=false;
exit:=false;
repeat
      bar2(0,2,70,80,255);
      bar2(230,2,320,80,255);
      for i:= 1 to 3 do pt[i]:=0;
      for i:= 1 to 3 do typ1[i]:='------';
      for i:= 1 to 3 do pt2[i]:=0;
      for i:= 1 to 3 do typ2[i]:='------';
      bar2(0,0,320,200,255);
      tm:=0;
      if not p2 and not exit then
      begin
      gracz1;
      background;
      przygotuj_tarcze;
      bar2(0,0,320,200,255);
      tm:=0;
      end;
      if not p1 and not exit then
      begin
      gracz2;
      background;
      przygotuj_tarcze;
      end;
until keydown[1] or p1 or p2 or exit;
bar1(0,0,320,200,0);
bar2(0,0,320,200,0);
movebuf2screen2;
bar1(0,0,320,200,255);
bar2(0,0,320,200,255);
background;
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');
mousewindow(14,42,624,227);
setmousepos(320,130);

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
setpal(p);
end;

procedure player1;

procedure show_cur;
var
   x, y : integer;
begin
     for x:= 1 to 5 do
     for y:= 1 to 7 do if cur[x,y]<>0 then putpixel2(y+mx-4,x+my-3,56+cur[x,y]);
end;

procedure show_cur0;
var
   x, y : integer;
begin
     for x:= 1 to 5 do
     for y:= 1 to 7 do if cur[x,y]<>0 then putpixel2(y+mx-4,x+my-3,255);
end;

procedure show_dart(px, py : integer; p : shortint);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel2(y+px,x+py,58+dart[x,y]+p);
end;

procedure show_dart_s(px, py : integer; p : shortint);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel1(y+px,x+py,58+dart[x,y]+p);
end;

procedure show_dart0(px, py : integer);
var
   x, y : integer;
begin
     for x:= 1 to 10 do
     for y:= 1 to 7 do if dart[x,y]<>0 then putpixel2(y+px,x+py,255);
end;

procedure przygotuj_tarcze;
var
   i : integer;
begin
loadpaintfile1(55+9,7,'darts.dat',255);
setcol(57,63,63,63);
setcol(55,50,33,10);

setcol(59,45,5,5);
setcol(60,30,0,0);
setcol(61,50,50,50);

setcol(62,5,5,45);
setcol(63,0,0,30);
setcol(64,50,50,50);
flood(98+9,100,1);flood(125+9,100,1);
flood(168+9,100,2);flood(195+9,100,2);
flood(105+9,70,3);flood(125+9,80,3);
flood(135+9,60,11);flood(145+9,70,11);
flood(160+9,60,5);flood(155+9,70,5);
flood(175+9,80,6);flood(180+9,70,6);
flood(175+9,115,7);flood(190+9,120,7);
flood(155+9,115,8);flood(158+9,140,8);
flood(145+9,115,9);flood(138+9,140,9);
flood(125+9,115,10);flood(105+9,130,10);
setcol(210,50,40,30);
for i:= 1 to 3 do setcol(i,45,28,5);
for i:= 5 to 11 do setcol(i,45,28,5);
for i:= 12 to 21 do setcol(i,40,23,0);
for i:= 22 to 41 do setcol(i,35,8,0);
for i:= 42 to 52 do setcol(i,45,18,10);
for i:= 72 to 81 do setcol(i,45,18,10);
setcol(53,35,8,0);
flood(148+9,70,12);flood(148+9,50,12);
flood(148+9,120,13);flood(148+9,150,13);
flood(170+9,105,14);flood(190+9,110,14);
flood(110+9,110,15);flood(130+9,105,15);
flood(110+9,80,16);flood(130+9,90,16);
flood(170+9,95,17);flood(190+9,90,17);
flood(170+9,125,18);flood(180+9,130,18);
flood(130+9,135,19);flood(134+9,120,19);
flood(160+9,85,20);flood(180+9,60,20);
flood(120+9,65,21);flood(130+9,74,21);

flood(150+9,41,22);
flood(150+9,65,23);
flood(150+9,135,24);
flood(150+9,155,25);
flood(180+9,50,26);
flood(169+9,70,27);
flood(184+9,90,28);
flood(205+9,85,29);
flood(205+9,119,30);
flood(185+9,113,31);
flood(169+9,128,32);
flood(180+9,148,33);
flood(129+9,128,34);
flood(120+9,148,35);
flood(98+9,120,36);
flood(119+9,113,37);
flood(116+9,93,38);
flood(95+9,88,39);
flood(128+9,72,40);
flood(117+9,51,41);

flood(140+9,41,42);flood(144+9,65,72);
flood(175+9,44,43);flood(164+9,65,72);
flood(195+9,64,44);flood(178+9,78,74);
flood(208+9,94,45);flood(185+9,98,75);
flood(200+9,128,46);flood(180+9,120,76);
flood(170+9,153,47);flood(165+9,133,77);
flood(140+9,153,48);flood(140+9,133,78);
flood(100+9,128,49);flood(120+9,118,79);
flood(92+9,94,50);flood(114+9,96,80);
flood(102+9,64,51);flood(122+9,76,81);

flood(155+9,100,52);
flood(152+9,100,53);

putpixel1(118,156,210);
putpixel1(116,157,210);
putpixel1(117,156,210);
putpixel1(117,155,210);
putpixel1(118,155,210);
end;

procedure background;
var
   i, j : integer;
begin
     for i:= 100 to 164 do setcol(i,i,i-10,0);
     for i:= 165 to 119 do setcol(i,i,i,i);
     if detale then
     begin
     for i:= 0 to 319 do
     for j:= 0 to 199 do putpixel1(i,j,100+round(3.1+cos(i)*sin(j)*3));
     for i:= 60 to 259 do
     for j:= 10 to 189 do putpixel1(i,j,106+round(3.1+cos(i)*sin(j)*3));
     end else
     bar1(0,0,320,200,0);
end;

procedure pobierz_dane_z_tarczy;
begin
      if getpixel1(mx,my)=12 then begin ptk:=20; typ:='SINGLE'; end;
      if getpixel1(mx,my)=5 then begin ptk:=1; typ:='SINGLE'; end;
      if getpixel1(mx,my)=20 then begin ptk:=18; typ:='SINGLE'; end;
      if getpixel1(mx,my)=6 then begin ptk:=4; typ:='SINGLE'; end;
      if getpixel1(mx,my)=17 then begin ptk:=13; typ:='SINGLE'; end;
      if getpixel1(mx,my)=2 then begin ptk:=6; typ:='SINGLE'; end;
      if getpixel1(mx,my)=14 then begin ptk:=10; typ:='SINGLE'; end;
      if getpixel1(mx,my)=7 then begin ptk:=15; typ:='SINGLE'; end;
      if getpixel1(mx,my)=18 then begin ptk:=2; typ:='SINGLE'; end;
      if getpixel1(mx,my)=8 then begin ptk:=17; typ:='SINGLE'; end;
      if getpixel1(mx,my)=13 then begin ptk:=3; typ:='SINGLE'; end;
      if getpixel1(mx,my)=9 then begin ptk:=19; typ:='SINGLE'; end;
      if getpixel1(mx,my)=19 then begin ptk:=7; typ:='SINGLE'; end;
      if getpixel1(mx,my)=10 then begin ptk:=16; typ:='SINGLE'; end;
      if getpixel1(mx,my)=15 then begin ptk:=8; typ:='SINGLE'; end;
      if getpixel1(mx,my)=1 then begin ptk:=11; typ:='SINGLE'; end;
      if getpixel1(mx,my)=16 then begin ptk:=14; typ:='SINGLE'; end;
      if getpixel1(mx,my)=3 then begin ptk:=9; typ:='SINGLE'; end;
      if getpixel1(mx,my)=21 then begin ptk:=12; typ:='SINGLE'; end;
      if getpixel1(mx,my)=11 then begin ptk:=5; typ:='SINGLE'; end;

      if getpixel1(mx,my)=22 then begin ptk:=40; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=43 then begin ptk:=2; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=26 then begin ptk:=36; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=44 then begin ptk:=8; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=29 then begin ptk:=26; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=45 then begin ptk:=12; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=30 then begin ptk:=20; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=46 then begin ptk:=30; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=33 then begin ptk:=4; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=47 then begin ptk:=34; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=25 then begin ptk:=6; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=35 then begin ptk:=14; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=36 then begin ptk:=16; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=50 then begin ptk:=22; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=39 then begin ptk:=28; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=51 then begin ptk:=18; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=41 then begin ptk:=24; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=42 then begin ptk:=10; typ:='DOUBLE'; end;

      if getpixel1(mx,my)=23 then begin ptk:=60; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=72 then begin ptk:=3; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=27 then begin ptk:=54; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=74 then begin ptk:=12; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=28 then begin ptk:=39; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=75 then begin ptk:=18; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=31 then begin ptk:=30; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=76 then begin ptk:=45; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=32 then begin ptk:=6; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=77 then begin ptk:=51; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=24 then begin ptk:=9; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=78 then begin ptk:=57; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=34 then begin ptk:=21; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=79 then begin ptk:=48; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=37 then begin ptk:=24; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=80 then begin ptk:=33; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=38 then begin ptk:=42; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=81 then begin ptk:=27; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=40 then begin ptk:=36; typ:='TRIPLE'; end;
      if getpixel1(mx,my)=72 then begin ptk:=15; typ:='TRIPLE'; end;

      if getpixel1(mx,my)=53 then begin ptk:=50; typ:='DOUBLE'; end;
      if getpixel1(mx,my)=52 then begin ptk:=25; typ:='SINGLE'; end;

      if getpixel1(mx,my)in[100..164] then begin ptk:=0; typ:='MISS'; end;
      if getpixel1(mx,my)=210 then begin ptk:=0; typ:='MISS'; end;
end;

procedure sincos(x, y, a, b : integer; ka, kb : real; var mx, my : integer; var k1a, k2a : real);
begin
     k1a:=k1a+ka;
     k2a:=k2a+kb;
     mx:=round(a*sin(k1a)+5)+x;
     my:=round(b*cos(k2a)-40)+y;
end;

procedure show_score1;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(4,5+i*20-20,57,1,1,'POINT='+num2str(pt[i]));
          outtextxy2(4,15+i*20-20,57,1,1,typ1[i]);
     end;
end;

procedure show_score1h;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(4,5+i*20-20,255,1,1,'POINT='+num2str(pt[i]));
          outtextxy2(4,15+i*20-20,255,1,1,typ1[i]);
     end;
end;

procedure show_score2;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(240,5+i*20-20,57,1,1,'POINT='+num2str(pt2[i]));
          outtextxy2(240,15+i*20-20,57,1,1,typ2[i]);
     end;
end;

procedure show_score2h;
begin
     for i:= 1 to 3 do
     begin
          outtextxy2(240,5+i*20-20,255,1,1,'POINT='+num2str(pt2[i]));
          outtextxy2(240,15+i*20-20,255,1,1,typ2[i]);
     end;
end;

procedure gracz1;
begin
shotn:=0;
z1:=false;
repeat
      ax:=ax div 2;
      getmousepos(ax,ay,k);
      sincos(ax,ay,30,30,0.1,0.05,mx,my,k1,k2);
      outtextxy2(130,5,57,1,1,'PLAYER 1');
      if k=1 then
      begin
           inc(shotn);
           typ1[shotn]:='';
           pt[shotn]:=0;
           tm:=ptk1;
           for dy:= 70 downto my div 3 do
           begin
                show_score1;
                show_cur;
                outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
                outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
                show_dart(mx,dy*3,0);
                movebuf2screen2;delay(speed div 4);
                bar2(0,180,320,200,255);
                show_dart0(mx,dy*3);
           end;
           show_dart_s(mx,dy*3,0);
           typ1[shotn]:=typ;
           pt[shotn]:=ptk;
           if pt[shotn]>ptk1 then z1:=true;
           bar2(0,2,70,60,255);
           bar2(230,2,320,67,255);
           ptk1:=ptk1-pt[shotn];
      end;

      pobierz_dane_z_tarczy;

      show_cur;

      show_score1;
      show_score2;

      outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
      outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));

      line2(ax,ay-7-35,ax,ay-1-35,57);
      line2(ax,ay+1-35,ax,ay+7-35,57);
      line2(ax-7,ay-35,ax-1,ay-35,57);
      line2(ax+7,ay-35,ax+1,ay-35,57);
      movebuf2screen2;delay(speed);
      line2(ax,ay-7-35,ax,ay-1-35,255);
      line2(ax,ay+1-35,ax,ay+7-35,255);
      line2(ax-7,ay-35,ax-1,ay-35,255);
      line2(ax+7,ay-35,ax+1,ay-35,255);

      bar2(0,180,320,200,255);

      show_score1h;

      if ptk1=0 then p1:=true;
      if ptk1<0 then ptk1:=tm;
      if keydown[1] then exit:=true;

      show_cur0;
until (shotn=3) or p1 or z1 or exit;
if p1 then
begin
show_score1;
outtextxy1(135,98,57,1,1,'WINNER');
movebuf2screen;
end;
if z1 then
begin
show_score1;
outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
outtextxy1(145,98,57,1,1,'BUST');
movebuf2screen2;
end;
end;

procedure gracz2;
var
   los, ll : byte;
begin
shotn:=0;
z2:=false;
randomize;
los:=0;
ll:=0;
ax:=160;
ay:=130;
repeat
      ll:=random(4);
      outtextxy2(130,5,57,1,1,'PLAYER 2');
      if ll=0 then ax:=ax+1;
      if ll=1 then ay:=ay+1;
      if ll=2 then ax:=ax-1;
      if ll=3 then ay:=ay-1;
      if ay=160 then ay:=ay-1;
      if ay=50 then ay:=ay+1;
      if ax=80 then ax:=ax+1;
      if ax=250 then ax:=ax-1;
      sincos(ax,ay,30,30,0.1,0.05,mx,my,k1,k2);
      los:=random(100);
      if (los=50) then
      begin
           inc(shotn);
           typ2[shotn]:='';
           pt2[shotn]:=0;
           tm:=ptk2;
           for dy:= 70 downto my div 3 do
           begin
                show_score2;
                outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
                outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
                show_dart(mx,dy*3,0);
                movebuf2screen2;delay(speed div 4);
                bar2(0,180,320,200,255);
                show_dart0(mx,dy*3);
           end;
           show_dart_s(mx,dy*3,0);
           typ2[shotn]:=typ;
           pt2[shotn]:=ptk;
           if pt2[shotn]>ptk2 then z2:=true;
           bar2(0,2,70,60,255);
           bar2(230,2,320,67,255);
           ptk2:=ptk2-pt2[shotn];
           los:=0;
      end;

      pobierz_dane_z_tarczy;

      show_score1;
      show_score2;

      outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
      outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));

      movebuf2screen2;delay(speed);

      bar2(0,180,320,200,255);

      show_score2h;

      if ptk2=0 then p2:=true;
      if ptk2<0 then ptk2:=tm;
      if keydown[1] then exit:=true;

until (shotn=3) or p2 or z2 or exit;
if p2 then
begin
show_score2;
outtextxy1(135,98,57,1,1,'WINNER');
movebuf2screen;
end;
if z2 then
begin
show_score2;
outtextxy2(240,190,57,1,1,'SCORE='+num2str(ptk2));
outtextxy2(4,190,57,1,1,'SCORE='+num2str(ptk1));
outtextxy1(145,98,57,1,1,'BUST');
movebuf2screen2;
end;
end;

begin
if z.detale='LOW' then detale:=false;
if z.detale='HIGH' then detale:=true;
background;
przygotuj_tarcze;
mousewindow(50,80,270,200);
setmousepos(160,100);
shotn:=0;
for i:= 1 to 3 do pt[i]:=0;
for i:= 1 to 3 do typ1[i]:='------';
ptk1:=1001;
for i:= 1 to 3 do pt2[i]:=0;
for i:= 1 to 3 do typ2[i]:='------';
ptk2:=1001;
p1:=false;
p2:=false;
exit:=false;
repeat
      bar2(0,2,70,80,255);
      bar2(230,2,320,80,255);
      for i:= 1 to 3 do pt[i]:=0;
      for i:= 1 to 3 do typ1[i]:='------';
      for i:= 1 to 3 do pt2[i]:=0;
      for i:= 1 to 3 do typ2[i]:='------';
      bar2(0,0,320,200,255);
      outtextxy2(130,5,57,1,1,'PLAYER 1');
      tm:=0;
      if not p2 and not exit then
      begin
      gracz1;
      background;
      przygotuj_tarcze;
      bar2(0,0,320,200,255);
      outtextxy2(130,5,57,1,1,'PLAYER 2');
      tm:=0;
      end;
      if not p1 and not exit then
      begin
      gracz2;
      background;
      przygotuj_tarcze;
      end;
until keydown[1] or p1 or p2 or exit;
bar1(0,0,320,200,0);
bar2(0,0,320,200,0);
movebuf2screen2;
bar1(0,0,320,200,255);
bar2(0,0,320,200,255);
background;
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');
mousewindow(14,42,624,227);
setmousepos(320,130);

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
setpal(p);
end;

procedure opcje; forward;

procedure background;
var
   i, j : integer;
begin
     for i:= 100 to 164 do setcol(i,i,i-10,0);
     for i:= 165 to 119 do setcol(i,i,i,i);
     for i:= 0 to 319 do
     for j:= 0 to 199 do putpixel1(i,j,100+round(3.1+cos(i)*sin(j)*3));
     for i:= 60 to 259 do
     for j:= 10 to 189 do putpixel1(i,j,106+round(3.1+cos(i)*sin(j)*3));
     getpal(p);
end;

procedure tekst(x, y, a, b, c, c2 : integer; tekst : string);
begin
outtextxy1(x+5,y,c,a,b,tekst);
outtextxy1(x+3,y,c,a,b,tekst);
outtextxy1(x+3,y-2,c,a,b,tekst);
outtextxy1(x+5,y-2,c,a,b,tekst);
outtextxy1(x+4,y,c,a,b,tekst);
outtextxy1(x+4,y-1,c2,a,b,tekst);
end;

procedure tekst2(x, y, a, b, c, c2 : integer; tekst : string);
begin
outtextxy2(x+5,y,c,a,b,tekst);
outtextxy2(x+3,y,c,a,b,tekst);
outtextxy2(x+3,y-2,c,a,b,tekst);
outtextxy2(x+5,y-2,c,a,b,tekst);
outtextxy2(x+4,y,c,a,b,tekst);
outtextxy2(x+4,y-1,c2,a,b,tekst);
end;

procedure menu;
begin
background;
mousewindow(14,42,624,227);
setmousepos(320,130);
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
setpal(p);
repeat
      getmousepos(ax,ay,k);
      ax:=ax div 2;
      line2(ax,ay-7-35,ax,ay-1-35,31);
      line2(ax,ay+1-35,ax,ay+7-35,31);
      line2(ax-7,ay-35,ax-1,ay-35,31);
      line2(ax+7,ay-35,ax+1,ay-35,31);
      movebuf2screen2;
      line2(ax,ay-7-35,ax,ay-1-35,255);
      line2(ax,ay+1-35,ax,ay+7-35,255);
      line2(ax-7,ay-35,ax-1,ay-35,255);
      line2(ax+7,ay-35,ax+1,ay-35,255);
      if mousein(ax,ay,63,68+30+35,253,90+30+35) and (k=1) then
      begin
      speed:=z.speed*2;
      player2;
background;
mousewindow(14,42,624,227);
setmousepos(320,130);
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
      end;
      if mousein(ax,ay,63,68+35,253,90+35) and (k=1) then
      begin
      speed:=z.speed*2;
      player1;
background;
mousewindow(14,42,624,227);
setmousepos(320,130);
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
      end;

      if mousein(ax,ay,63,68+60+35,253,90+60+35) and (k=1) then begin delay(200); opcje; delay(200); end;
until mousein(ax,ay,63,68+125,253,90+125) and (k=1);
end;

procedure opcje;
begin
background;
tekst(58,20,3,3,4,12,'OPTIONS');
tekst(68,70,2,2,43,44,'GAME SPEED');
tekst(69,90,2,2,43,44,'-        +');
tekst(98,110,2,2,43,44,'DETAILS');
tekst(121,160,2,2,43,44,'BACK');
repeat
      getmousepos(ax,ay,k);
      ax:=ax div 2;
      tekst2(140,90,2,2,43,44,num2str(z.speed));
      tekst2(122,130,2,2,43,44,z.detale);
      line2(ax,ay-7-35,ax,ay-1-35,31);
      line2(ax,ay+1-35,ax,ay+7-35,31);
      line2(ax-7,ay-35,ax-1,ay-35,31);
      line2(ax+7,ay-35,ax+1,ay-35,31);
      movebuf2screen2;
      bar2(150,85,170,105,255);
      bar2(132,125,199,146,255);
      line2(ax,ay-7-35,ax,ay-1-35,255);
      line2(ax,ay+1-35,ax,ay+7-35,255);
      line2(ax-7,ay-35,ax-1,ay-35,255);
      line2(ax+7,ay-35,ax+1,ay-35,255);
      if mousein(ax,ay,79,90+35,98,100+35) and (k=1) and (z.speed>0) then begin z.speed:=z.speed-1; delay(80); end;
      if mousein(ax,ay,223,88+35,242,103+35) and (k=1) and (z.speed<9) then begin z.speed:=z.speed+1; delay(80); end;
      if mousein(ax,ay,132,125+35,199,146+35) and (k=1) then
      begin
           if z.detale='HIGH' then z.detale:='LOW' else z.detale:='HIGH';
           delay(80);
      end;
until mousein(ax,ay,131,155+35,200,177+35) and leftbutton;
assign(f,'darts.cfg');
rewrite(f);
write(f,z);
close(f);
background;
mousewindow(14,42,624,227);
setmousepos(320,130);
tekst(70,20,4,3,4,12,'MENU');
tekst(41,70,3,3,43,44,'1 PLAYER');
tekst(41,100,3,3,43,44,'2 PLAYER');
tekst(55,130,3,3,43,44,'OPTIONS');
tekst(95,160,3,3,43,44,'EXIT');

printfontxy(-6,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,193,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-4,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-6,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,192,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,194,40,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
printfontxy(-5,193,44,'DARTS '+versja+' BY MICHA[ RYGIELSKI');
end;

begin
writeln;
writeln('DARTS 1.0');
writeln('---------');
write('mouse - ');
if initmouse then write('OK') else write('ERROR');
writeln;
write('darts.cfg - ');
if czyplikistnieje('darts.cfg') then write('OK') else write('ERROR');
init13h;
initnewkeyint;
assign(f,'darts.cfg');
reset(f);
read(f,z);
close(f);
menu;
setoldkeyint;
close13h;
writeln('********************');
writeln('*     DARTS 1.0    *');
writeln('*        by        *');
writeln('* Michaˆ Rygielski *');
writeln('*   rpage.prv.pl   *');
writeln('********************');
end.