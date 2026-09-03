-- source: steam id 2545864661 / vehicle.xml block#6
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2545864661
	gN,gB,sB,sN,sC,s,pN=input.getNumber,input.getBool,output.setBool,output.setNumber,screen.setColor,screen,property.getNumber
	dt,dtb,dc,dcf,dr,drf,dtr,dtf,dl=s.drawText,s.drawTextBox,s.drawCircle,s.drawCircleF,s.drawRect,s.drawRectF,s.drawTriangle,s.drawTriangleF,s.drawLine
	tk,fdm,r,mspd,m=0,0,math.random(1000,100000),0,math
	msls={}
	function tf(x, y, rectX, rectY, rectW, rectH)
		return x > rectX and y > rectY and x < rectX+rectW and y < rectY+rectH
	end

	function onTick()
		tk=tk+1
		w=gN(1)
		h=gN(2)
		if w>65 and h<65 then 
			l=true
		else 
			l=false
		end
		GX=gN(3)
		GY=gN(4)
		ALT=gN(5)
		tx=gN(6)
		ty=gN(7)
		z=gN(8)
		mx=gN(9)
		my=gN(10)
		fm=gN(11)
		msx=gN(12)
		msy=gN(13)
		msz=gN(14)
		eta=math.abs(gN(15))
		mtrgx=gN(16)
		mtrgy=gN(17)
		trgx=gN(18)
		trgy=gN(19)
		trgz=gN(20)
		trgm=gN(21)
		t=gB(1)
		f=gB(2)
		mspdm=pN("Missile speed unit:")
		rr=tk%60+r
		sN(31,rr)
		sN(32,r-1)
		sN(5,r+fm)
		sN(1,trgx)
		sN(2,trgy)
		sN(3,trgz)
		sN(4,trgm)
		sB(fm,f)
		dtl=property.getBool("Draw line to target of missile/torpedo")
		if mspdm<2 and mspdm>1.9 then
			mspdmt="kts"
		elseif mspdm<0.01 then
			mspdmt="mach"
		elseif mspdm<3.7 and mspdm>3.5 then
			mspdmt="kmh"
		elseif mspdm<1.1 and mspdm>0.9 then
			mspdmt="mps"
		elseif mspdm<2.3 and mspdm>2.1 then
			mspdmt="mph"
		end

		if msx~=0 then
			for i,v in ipairs(msls) do
				if v[1]==rr and v[1]~=0 then
					f=i
				end
				mspd=((v[7]-v[2])^2+(v[8]-v[3])^2+(v[9]-v[4])^2)^0.5*mspdm
			end
			if msls[f] then
				msls[f]={rr,msx,msy,msz,180,eta,msls[f][2],msls[f][3],msls[f][4],mspd,mtrgx,mtrgy}
			else
				table.insert(msls,{rr,msx,msy,msz,180,eta,msx,msy,msz,mspd,mtrgx,mtrgy})
			end
		end
		for i,v in ipairs(msls) do
			if v[5]>0 then
				v[5]=v[5]-1
			else
				table.remove(msls,i)
			end
		end
	end
	function onDraw()
		for i,v in ipairs(msls) do
			if v[11]~=0 and v[12]~=0 and dtl then
				sC(255,0,0)
				mtrgpx,mtrgpy=map.mapToScreen(mx,my,z,w,h,v[11],v[12])
				dl(mtrgpx,mtrgpy,pX,pY)
			end
			pX,pY=map.mapToScreen(mx,my,z,w,h,v[2],v[3])
			if v[5]>60 then
				sC(255,255,0)
			else
				sC(60,60,60)
			end
			dcf(pX,pY,2)
			dt(pX+4,pY-2,string.format('%02.0f:%02.0f',math.floor(v[6]/60),v[6]%60))
			if mspdm<0.00291545+0.1 and mspdm>0.00291545-0.1 then
				dt(pX+4,pY+5,string.format("%.2f%s",v[10],mspdmt))
			else
				dt(pX+4,pY+5,string.format("%.0f%s",math.floor(v[10]),mspdmt))
			end
			sC(255,255,255)
			dtb(pX-14,pY-3,12,8,string.format("%.0f",v[1]-r-6),1,0.1)
		end
	end