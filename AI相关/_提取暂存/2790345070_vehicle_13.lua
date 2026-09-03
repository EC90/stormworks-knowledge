-- source: steam id 2790345070 / vehicle.xml block#13
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2790345070
IN,SC,MA,PRO=input,screen,math,property
igN=IN.getNumber
igB=IN.getBool
sdL=SC.drawLine
ssC=SC.setColor
sdC=SC.drawCircle
sdTB=SC.drawTextBox
sdTF=SC.drawTriangleF
sin=MA.sin
cos=MA.cos
abs=MA.abs
sf=string.format
pgN=PRO.getNumber
pgB=PRO.getBool
floor=MA.floor
ceil=MA.ceil
pi2=2*MA.pi
pi=MA.pi
SSA=pgN("Size of the scanner area")
MaxTN=pgN("Maximum target number")
MinDis=pgN("Minimum distance")
Co,Po,RotA,w,h,T,d,LOK=1,1,0,0,0,0,MinDis,0
step=true
Tail={}
NN=1
for i=1,SSA do
	Tail[i]={}
end
Data={}
for i=1,MaxTN do
	Data[i]={}
end
function onTick()
	iX=igN(3)
	iY=igN(4)
	iP=igB(1)
	TF=igB(10)
	Radar=igB(11)
	Mark=igB(12)
	RUD=igB(13)
	Dis=igN(10)
	Ea=igN(11)
	Rot=igN(12)%1
	if Rot>0.5 then
		Rot=-1+Rot
	end
	CS=igN(13)
	NRL=igN(15)
	MCR=igN(16)
	MCG=igN(17)
	MCB=igN(18)
	MCT=igN(19)
	SCR=igN(20)
	SCG=igN(21)
	SCB=igN(22)
	CCR=igN(23)
	CCG=igN(24)
	CCB=igN(25)
	BZR=igN(26)
	ZStep=igN(27)
	MaxDis=igN(28)
	Dens=igN(29)
	if RUD then
		Q=-1
	else
		Q=1
	end
	U=iPIR(iX,iY,w/2,0,w/2,h) and iP
	D=iPIR(iX,iY,0,0,w/2,h) and iP
	US=U and step
	DS=D and step
	if U or D then
		step=false
		T=T+1/60
	end
	if not iP or T>=0.15 then
		step=true
		T=0
	end
	if US then
		if d==MinDis then
			d=floor(MinDis/ZStep)*ZStep
		end 
		d=d+ZStep
		if d>MaxDis then
			d=MaxDis
		end
	elseif DS then
		if d==MaxDis then
			d=floor(MaxDis/ZStep)*ZStep
		end
		d=d-ZStep
		if d<MinDis then
			d=MinDis
		end
	end
	if Radar then
		if LOK<3 then
			WG=RotA-Rot
			RotA=Rot
			LOK=LOK+1
		end
		for i=1,MaxTN do
			if Data[i].Rot~=nil then
				if Data[i].Rot<=Rot+abs(WG)/2 and Data[i].Rot>=Rot-abs(WG)/2 then
					Data[i].Dis=nil
					Data[i].Ea=nil
					Data[i].Rot=nil
				end
			end
		end
		if TF then
			Data[Co].Dis=Dis
			Data[Co].Ea=Ea
			Data[Co].Rot=Rot
			if Co<MaxTN then
				Co=Co+1
			else
				Co=1
			end
		end
	else
		for i=1, MaxTN do
			Data[i].Dis=nil
			Data[i].Ea=nil
			Data[i].Rot=nil
		end
	end
	output.setBool(1,Dis*cos(pi2*math.abs(Ea))<=d and Dis*cos(pi2*math.abs(Ea))>=BZR)
	output.setNumber(1,d)
end

function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()
	if Mark then
		OS=h/18
	else
		OS=0
	end
	if w<h then
		r=w/2-1-OS
	else
		r=h/2-1-OS
	end
	if Mark then
		ssC(MCR,MCG,MCB)
		sdTF(w/2-1-r/10,floor(h/2-r+1.6),w/2-1+r/10,floor(h/2-r+1.6),w/2-1,h/2-r-OS)
		for i=1,31 do
			if i%8==0 then
				j=1
			elseif i%4==0 and i%8~=0 then
				j=0.80
			else
				j=0.30
			end
			tem=i*pi/16
			sdL(w/2-1+(r+OS*j)*sin(tem),h/2-(r+OS*j)*cos(tem),w/2-1+(r-1)*sin(tem),h/2-(r-1)*cos(tem))
		end
		ssC(CCR,CCG,CCB)
		sdL(w/2-1+(r+OS)*sin(CS*pi2),h/2-(r+OS)*cos(CS*pi2),w/2-1+(r-1)*sin(CS*pi2),h/2-(r-1)*cos(CS*pi2))
	end
	ssC(MCR,MCG,MCB,MCT)
	NCL=NN-1
	for i=0,NCL do
		sdC(w/2-1,h/2,r/(NCL+1)*i)
	end
	for i=1,NRL do
		sdL(w/2-1,h/2,w/2-1+r*sin((1/NRL*i)*pi2),h/2-r*cos((1/NRL*i)*pi2))
	end
	ssC(MCR,MCG,MCB)
	sdC(w/2-1,h/2,r+0.5)
	sdL(w/2-1,h/2,w/2-1+r*Q*sin(Rot*pi2),h/2-r*cos(Rot*pi2))
	if Radar then
		Tail[Po].Rot=Rot
		Tail[Po].Tra=255
		if Po<SSA then
			Po=Po+1
		else
			Po=1
		end

		for i=1,SSA do
			if Tail[i].Rot~=nil then
				Tail[i].Tra=Tail[i].Tra-255/SSA
				for j=1,Dens do
					ssC(MCR,MCG,MCB,math.min(math.max(Tail[i].Tra-255/SSA-(j-1)/Dens*255/SSA,0),255))
					sdL(w/2-1,h/2,w/2-1+r*Q*sin((Tail[i].Rot+WG*(j-1)/Dens)*pi2),h/2-r*cos((Tail[i].Rot+WG*(j-1)/Dens)*pi2))
				end
			end
		end	
	else
		for i=1, SSA do
			Tail[i].Rot=nil
			Tail[i].Tra=nil
		end
	end
	for i=1,MaxTN do
		if Data[i].Dis~=nil then
			SR=Data[i].Dis*cos(pi2*abs(Data[i].Ea))
			SRR=SR/d*r
			if SRR<=r and SR>=BZR then
				ssC(SCR,SCG,SCB)
				screen.drawRectF(w/2-1+SRR*Q*sin(Data[i].Rot*pi2),h/2-SRR*cos(Data[i].Rot*pi2),1,1)
			end
		end
	end
	ssC(SCR,SCG,SCB)
	if h<=32 then
		sdTB(w-11,h-8,10,7,sf("%.0f",d/1000),1,1)
	elseif h<=96 then
		NN,OO=math.modf(d/1000)
		if OO*10>=9.5 then
			OO=0
			NN=NN+1
		end
		sdTB(w-20,h-6,10,5,sf("%.0f",NN),1,0)
		screen.drawText(w-9, h-6, "KM")
	elseif h>64 then
		sdTB(w-35,h-7,30,7,"R:"..sf("%.0f",d),-1,0)
	end
end

function iPIR(x,y,rX,rY,rW,rH)
	return x>rX and y>rY and x<rX+rW and y<rY+rH
end