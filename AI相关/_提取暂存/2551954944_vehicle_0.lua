-- source: steam id 2551954944 / vehicle.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2551954944
igN=input.getNumber
igB=input.getBool
sdL=screen.drawLine
ssC=screen.setColor
sdC=screen.drawCircle
sdTB=screen.drawTextBox
sin=math.sin
cos=math.cos
abs=math.abs
sf=string.format
pgN=property.getNumber
floor=math.floor
ceil=math.ceil

FY,w,h,Co,d,Timer,PFY=0,0,0,1,1000,0,0
step=true
pi2=2*math.pi
pi=math.pi

MaxTN=pgN("Maximum target number")
HCR=pgN("Heading color_R")
HCG=pgN("Heading color_G")
HCB=pgN("Heading color_B")
Dens=pgN("Density of the displayed scanner area")

T={}
for i=1,MaxTN do
	T[i]={}
end

function onTick()
	iX=igN(3)
	iY=igN(4)
	iP=igB(1)

	TF=igB(3)
	Radar=igB(4)
	Markings=igB(5)
	Rud=igB(6)
	RDR=igB(7)
	UVP=igB(8)

	Dis=igN(7)
	Str=igN(8)
	Ea=igN(9)
	CS=igN(10)
	RPS=igN(11)
	ZStep=igN(12)
	MinDis=igN(13)
	MaxDis=igN(14)
	MCR=igN(15)
	MCG=igN(16)
	MCB=igN(17)
	MT=igN(18)
	TCR=igN(19)
	TCG=igN(20)
	TCB=igN(21)
	MTT=igN(22)
	SSA=igN(23)
	NCR=igN(24)
	NCG=igN(25)
	NCB=igN(26)
	MACR=igN(27)
	MACG=igN(28)
	MACB=igN(29)
	NRL=igN(30)
	NCL=igN(31)
	BZR=igN(32)

	RD=not (RDR and Rud) and (RDR or Rud)
	if Rud then
		Q=-1
	else
		Q=1
	end

	if RD and Radar then
		FY=FY+RPS/60
		PFY=PFY+RPS/60
	else 
		FY=FY-RPS/60
		PFY=PFY-RPS/60
	end

	if FY>=0.5 and RD then
		FY=-0.5
	elseif FY<=-0.5 and not RD then
		FY=0.5
	elseif not Radar then
		FY=0
		if PFY>=0 then
			PFY=floor(PFY+0.5)
		else
			PFY=ceil(PFY-0.5)
		end
	end		

	Up=iPIR(iX,iY,w/2,0,w/2,h) and iP
	Down=iPIR(iX,iY,0,0,w/2,h) and iP
	UpS=Up and step
	DownS=Down and step
	if Up or Down then
		step=false
		Timer=Timer+1/60
	end
	if not iP or Timer>=0.15 then
		step=true
		Timer=0
	end

	if UpS then
		if d==MinDis then
			d=floor(MinDis/ZStep)*ZStep
		end 
		d=d+ZStep
		if d>MaxDis then
			d=MaxDis
		end
	elseif DownS then
		if d==MaxDis then
			d=floor(MaxDis/ZStep)*ZStep
		end
		d=d-ZStep
		if d<MinDis then
			d=MinDis
		end
	end

	if UVP then
		output.setNumber(1,PFY)
	else
		output.setNumber(1,FY)
	end
	output.setBool(1, Dis*cos(pi2*math.abs(Ea))<=d and Dis*cos(pi2*math.abs(Ea))>=BZR)

	MaxSS=1
	for i=1,MaxTN do
		if T[i].Wik~=nil then
			if T[i].Wik<=FY+RPS/120 and T[i].Wik>=FY-RPS/120 then
				T[i].Dis=nil
				T[i].Str=nil
				T[i].Ea=nil
				T[i].Wik=nil
			end
		end
		if T[i].Str~=nil and T[i].Str>MaxSS then
			MaxSS=T[i].Str
		end
	end

	if Radar then
		if TF then
			T[Co].Dis=Dis
			T[Co].Str=Str
			T[Co].Ea=Ea
			T[Co].Wik=FY
			if Co<MaxTN then
				Co=Co+1
			else
				Co=1
			end
		end
	else
		for i=1, MaxTN do
			T[i].Dis=nil
			T[i].Str=nil
			T[i].Ea=nil
			T[i].Wik=nil
		end
	end	
end

function onDraw()
	w=screen.getWidth()				  
	h=screen.getHeight()
	if Markings then
		OS=h/18
	else
		OS=0
	end

	if w<h then
		r=w/2-1-OS
	else
		r=h/2-1-OS
	end

	if Markings then
		ssC(HCR,HCG,HCB)
		screen.drawTriangleF(w/2-1-r/10,floor(h/2-r+1.6),w/2-1+r/10,floor(h/2-r+1.6),w/2-1,h/2-r-OS)
	end

	ssC(MCR,MCG,MCB)
	sdC(w/2-1,h/2,r)

	ssC(MCR,MCG,MCB,MT)
	for i=0,NCL do
		sdC(w/2-1,h/2,r/(NCL+1)*i)
	end
	
	for i=1,NRL do
		sdL(w/2-1,h/2,w/2-1+r*sin((1/NRL*i)*pi2),h/2-r*cos((1/NRL*i)*pi2))
	end

	ssC(MCR,MCG,MCB)
	sdL(w/2-1,h/2,w/2-1+Q*r*sin(FY*pi2),h/2-r*cos(FY*pi2))
	if Radar then
		for i=1,SSA*h/32 do
			ssC(MCR,MCG,MCB,255-255/((SSA*h/32))*(i-1))
			if RD then
				sdL(w/2-1,h/2,w/2-1+Q*r*sin((FY-60/r*Dens*i)*pi2),h/2-r*cos((FY-60/r*Dens*i)*pi2))
			else
				sdL(w/2-1,h/2,w/2-1+Q*r*sin((FY+60/r*Dens*i)*pi2),h/2-r*cos((FY+60/r*Dens*i)*pi2))
			end
		end
	end

	ssC(TCR,TCG,TCB)
	if h<=32 then
		sdTB(w-8,h-8,7,7,sf("%.0f",d/1000),1,1)
	elseif h<=64 then
		NN,OO=math.modf(d/1000)
		if OO*10>=9.5 then
			OO=0
			NN=NN+1
		end
		sdTB(w-13,h-7,11,5,sf("%.0f",NN))
		sdTB(w-9,h-7,11,5,".")
		sdTB(w-9,h-7,11,5,sf("%.0f",OO*10),0,0)
	elseif h>64 then
		sdTB(w-35,h-7,30,7,"R:"..sf("%.0f",d),-1,0)
	end

	for i=1,MaxTN do
		if T[i].Dis~=nil then
			SR=T[i].Dis*cos(pi2*abs(T[i].Ea))
			SRR=SR/d*r
			if SRR<=r and SR>=BZR then
				ssC(TCR,TCG,TCB,T[i].Str/MaxSS*(255-MTT)+MTT)
				screen.drawRectF(w/2-1+Q*SRR*sin(T[i].Wik*pi2),h/2-SRR*cos(T[i].Wik*pi2),1,1)
			end
		end
	end
end

function iPIR(x,y,rX,rY,rW,rH)
	return x>rX and y>rY and x<rX+rW and y<rY+rH
end