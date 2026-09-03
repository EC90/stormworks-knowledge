-- source: steam id 2823494546 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2823494546
M=math
S=screen
C=S.setColor
dRF=S.drawRectF
dTx=S.drawText
dTxB=S.drawTextBox
I=input
O=output
ou=0
function cp(s)
C(243,243,243)
if s=="1" then C(146,160,169)end
if s=="2" then C(125,125,125)end
if s=="3" then C(75,75,75)end
if s=="b" then C(15,15,15)end
end
function bs(x,xp,y,s,p,v) a=8 x=x+9*xp if p then cp("3")else if v==1 then cp("2")else cp() end end dRF(x,y+1,a,a-1) dRF(x+1,y,a-2,a+1) cp("b") if s==">" then x=x+1 end dTxB(x,y,a,9,s,0,0) end
function iR(rX,u,rY) return inR(n+9*u,m,9,10) end
function inR(rX,rY,rW,rH) return iX>rX and iY>rY and iX<rX+rW and iY<rY+rH end
function getN(...)local a={}for b,c in ipairs({...})do a[b]=I.getNumber(c)end;return table.unpack(a)end
PC=0
function onTick() sX,sY,iX,iY,app=getN(21,22,23,24,28) t=I.getBool(21) M=true
if t then PC=PC+1 else PC=0 end
n=sX/2-45-1 m=sY-63
onB=t and iR(n,0,m) twB=t and iR(n,1,m) thB=t and iR(n,2,m) foB=t and iR(n,3,m) fiB=t and iR(n,4,m)siB=t and iR(n,5,m) seB=t and iR(n,6,m) eiB=t and iR(n,7,m) niB=t and iR(n,8,m) zeB=t and iR(n,9,m) m=m+10
qB=t and iR(n,0,m) wB=t and iR(n,1,m) eB=t and iR(n,2,m) rB=t and iR(n,3,m) tB=t and iR(n,4,m)yB=t and iR(n,5,m) uB=t and iR(n,6,m)  iB=t and iR(n,7,m) oB=t and iR(n,8,m) pB=t and iR(n,9,m) n=n+2+2 m=m+10
aB=t and iR(n,0,m) sB=t and iR(n,1,m) dB=t and iR(n,2,m) fB=t and iR(n,3,m) gB=t and iR(n,4,m)hB=t and iR(n,5,m) jB=t and iR(n,6,m)  kB=t and iR(n,7,m) lB=t and iR(n,8,m) m=m+10
staB=t and inR(n-4,m,13,21) bacB=t and inR(n+9*8,m,15,10)zB=t and iR(n,1,m) xB=t and iR(n,2,m) cB=t and iR(n,3,m) vB=t and iR(n,4,m) bB=t and iR(n,5,m)nB=t and iR(n,6,m) mB=t and iR(n,7,m) m=m+10
comB=t and iR(n,1,m)fulB=t and iR(n,7,m)spaB=t and inR(n+9*2,m,44,10)et=t and inR(n+9*8,m,15,10)

if bacB then ou=1 end
if et then ou=2 end
if onB then ou=3 end
if twB then ou=4 end
if thB then ou=5 end
if foB then ou=6 end
if fiB then ou=7 end
if siB then ou=8 end
if seB then ou=9 end
if eiB then ou=10 end
if niB then ou=11 end
if zeB then ou=12 end
if qB then ou=13 end
if wB then ou=14 end
if eB then ou=15 end
if rB then ou=16 end
if tB then ou=17 end
if yB then ou=18 end
if uB then ou=19 end
if iB then ou=20 end
if oB then ou=21 end
if pB then ou=22 end
if aB then ou=23 end
if sB then ou=24 end
if dB then ou=25 end
if fB then ou=26 end
if gB then ou=27 end
if hB then ou=28 end
if jB then ou=29 end
if kB then ou=30 end
if lB then ou=31 end
if zB then ou=32 end
if xB then ou=33 end
if cB then ou=34 end
if vB then ou=35 end
if bB then ou=36 end
if nB then ou=37 end
if mB then ou=38 end
if spaB then ou=39 end
if comB then ou=40 end
if fulB then ou=41 end
--or et
if bacB or onB or twB or twB or thB or foB or fiB or siB or seB or eiB or niB or zeB or qB or wB or eB or rB or tB or yB or uB or iB or oB or pB or aB or sB or dB or fB or gB or hB or jB or kB or lB or zB or xB or cB or bB or nB or mB or spaB or comB or fulB then tuu=true else tuu=false end
O.setNumber(9,ou)
if tuu and PC==1 then r=1 else r=0 end
O.setNumber(10,r)
end

function onDraw() w=S.getWidth() h=S.getHeight() cw=w/2 ch=h/2 scrsize=w*h cp("1") dRF(0,0,w,h)
x=cw-45 y=h-62
bs(x,0,y,"1",onB,1)bs(x,1,y,"2",twB,1)bs(x,2,y,"3",thB,1)bs(x,3,y,"4",foB,1)bs(x,4,y,"5",fiB,1)bs(x,5,y,"6",siB,1)bs(x,6,y,"7",seB,1)bs(x,7,y,"8",eiB,1)bs(x,8,y,"9",niB,1)bs(x,9,y,"0",zeB,1)y=y+10
bs(x,0,y,"q",qB)bs(x,1,y,"w",wB)bs(x,2,y,"e",eB)bs(x,3,y,"r",rB)bs(x,4,y,"t",tB)bs(x,5,y,"y",yB)bs(x,6,y,"u",uB)bs(x,7,y,"i",iB)bs(x,8,y,"o",oB)bs(x,9,y,"p",pB)y=y+10 x=x+4
bs(x,0,y,"a",aB)bs(x,1,y,"s",sB)bs(x,2,y,"d",dB)bs(x,3,y,"f",fB)bs(x,4,y,"g",gB)bs(x,5,y,"h",hB)bs(x,6,y,"j",jB)bs(x,7,y,"k",kB)bs(x,8,y,"l",lB)y=y+10 x=x+9
bs(x,0,y,"z",zB)bs(x,1,y,"x",xB)bs(x,2,y,"c",cB)bs(x,3,y,"v",vB)bs(x,4,y,"b",bB)bs(x,5,y,"n",nB)bs(x,6,y,"m",mB)y=y+10
if spaB then cp("3") else cp() end dRF(x+9,y+1,44,7)dRF(x+10,y,42,9)bs(x,0,y,",",comB)bs(x,6,y,".",fulB)x=cw-45 y=y-11
if bacB then cp("3") else cp("2") end dRF(x+76,y+2,13,7)dRF(x+77,y+1,11,9)cp("b")dTx(x+79,y+3,"<-") 
y=y+10
--if et then C(0,0,50-19) else C(0,19,50) end dRF(x+76,y+2,13,7) dRF(x+77,y+1,11,9)cp()dTx(x+79,y+1+2,"=>")
if M then cp("b")dTxB(0,h-9,w,5,"",0,0)end
end

	