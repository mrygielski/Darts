Function CzyPlikIstnieje(Plik : String) : Boolean;

Var
   F : File of Byte;

Begin
     {$I-}
     Assign(F,Plik);
     Reset(F);
     Close(F);
     {$I+}
     CzyPlikIstnieje:=IOResult=0;
End;

Var
   Fc, Fbak : Byte;
   Kolejka : Array [0..3000] of Record X,Y : Integer; End;
   Ilosc, Kolpos : Integer;

Procedure Usun(Pos : Integer);
Begin
     Kolejka[Pos]:=Kolejka[Ilosc];
     Dec(Ilosc);
End;

Procedure Dodaj(X, Y : Integer);
Var
   I : Integer;
   Bylo : Boolean;

Begin
     Bylo:=False;
     If Ilosc>0 then
     For I:= 1 to Ilosc do
     Begin
          If (Kolejka[I].X=X) and (Kolejka[I].Y=Y) then Bylo:=True;
     End;
     If Not Bylo then
     Begin
          Inc(Ilosc);
          Kolejka[Ilosc].X:=X;
          Kolejka[Ilosc].Y:=Y;
     End;
End;

Procedure Ffill;

Var
   X, Y : Integer;

Begin
     X:=Kolejka[Kolpos].X;
     Y:=Kolejka[Kolpos].Y;
     Putpixel1(X,Y,Fc);
     Usun(Kolpos);
     If (x>1) and (y>0) and (x<320) and (y<200) then
     Begin
          If Getpixel1(X+1,Y)=Fbak then Dodaj(X+1,Y);
          If Getpixel1(X,Y-1)=Fbak then Dodaj(X,Y-1);
          If Getpixel1(X,Y+1)=Fbak then Dodaj(X,Y+1);
          If Getpixel1(X-1,Y)=Fbak then Dodaj(X-1,Y);
     End;
End;

Procedure Flood(X, Y : Integer; Col : Byte);

Var
   I : Integer;
   A, B : Integer;

Begin
     if getpixel1(x,y)=col then
     begin
     end else
     begin
     Fbak:=Getpixel1(X,Y);
     Fc:=Col;
     Kolejka[1].X:=X;
     Kolejka[1].Y:=Y;
     Ilosc:=1;
     Kolpos:=1;
     Repeat
           Kolpos:=(Round(Kolpos*5.2) + 113) mod Ilosc +1;
           Ffill;
     Until (Ilosc=0) or (Ilosc=12999);
     end;
End;