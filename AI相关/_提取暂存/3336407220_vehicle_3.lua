-- source: steam id 3336407220 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3336407220
--datalink3main
GN=input.getNumber
SN=output.setNumber
SB=output.setBool
z=2.5
mox,moy=0,0
mapofsto=false
opt=false
menu=false
sosf,sosa,sosm,sosr=false,false,false,false
dmx=-24
page=1
touchx,touchy=0,0
toucho=false
M=math
Mf=M.floor
S=screen
sC=S.setColor
DL=S.drawLine
DR=S.drawRect
DRF=S.drawRectF
DT=S.drawText
DTB=S.drawTextBox
msg={'spg','tank','ifv','aa','air','heli','msl','navy','logi','uav','cv','ally','enem','unk'}
optms={{56,54},{21,13},{56,54},{56,54}}
U=233
V=15
function DNATO(d,C,F,T)--x,y,faction,type
	local a,b,c,e,f,g,A,B,D,E=d-3,d-2,d-1,d+1,d+2,d+3,C-2,C-1,C+1,C+2
	if F==1 then--ally
		sC(V,64,U) DRF(a,A-1,7,7) sC(V,V,V) DR(a,A-1,6,6) 
	else 
		sC(U,V,V) S.drawTriangleF(a,D,e,A-1,g+2,D) S.drawTriangleF(a,D,e,E+3,g+2,D) sC(V,V,V) DL(d,A-2,a-1,C) DL(a-1,C,d,E+2) DL(d,E+2,g+1,C) DL(g+1,C,d,A-2) 
	end
	if T==1 then DL(d,C,d,D) end 
	if T==2 then DL(c,B,f,B) DL(c,D,f,D) DL(b,C,c,C) DL(f,C,e,C) end 
	if T==3 then DL(b,A,g,E+1) DL(f,A,a,E+1) end 
	if T==4 then DL(b,E,c,D) DL(f,E,e,D) DL(c,D,f,D) end 
	if T==5 then DL(b,C,d,A) DL(c,D,f,A) DL(e,D,g,B) end 
	if T==6 then DL(b,B,b,E) DL(c,C,f,C) DL(f,B,f,E) end 
	if T==7 then DL(d,B,d,C) DL(c,E,c,B) DL(e,E,e,B) end 
	if T==8 then DL(d,B,d,D) DL(c,D,f,D) end 
	if T==9 then DL(b,D,g,D) end 
	if T==10 then DL(c,B,e,D) DL(e,B,c,D) end 
	if T==11 then DL(c,B,c,D) DL(c,C,f,C) DL(d,D,b,B) end 
end
function onTick()
	draw=input.getBool(28)
	tgttp=GN(22)
end
function onDraw()
	w=S.getWidth()
	h=S.getHeight()
	dox=w-4-optms[page][1]
	if draw then
		sC(V,U,V)
		DT(dox+1,6,'tgt type')
		for i=0,11 do
			ln2=Mf(i/6)
			DNATO(dox+4+ln2*28,8*(i-ln2*5)+14-ln2*8,2,i)
			if i>0 then
				sC(V,U,V)
				DT(dox+9+ln2*28,8*(i-ln2*5)+12-ln2*8,msg[i])
			end
		end
		DR(dox+Mf(tgttp/6)*28,(tgttp%6)*8+10,28-ln2,8)
	end
end