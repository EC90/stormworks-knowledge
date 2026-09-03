-- source: steam id 3524040776 / vehicle.xml block#18
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--water monitor
waterLev={}
rooms=11
waterCap={}
RoomStatus={}
--triangles
w=64
h=64
drawT={
	{{	15	,	1	},{	9	,	10	},{	23	,	10	},{	17	,	1	}},
	{{	11	,	10	},{	11	,	18	},{	21	,	18	},{	21	,	10	}},
	{{	11	,	18	},{	11	,	26	},{	21	,	26	},{	21	,	18	}},
	{{	5	,	26	},{	5	,	36	},{	27	,	36	},{	27	,	26	}},
	{{	11	,	36	},{	11	,	46	},{	21	,	46	},{	21	,	36	}},
	{{	5	,	46	},{	6	,	56	},{	26	,	56	},{	27	,	46	}},
	{{	6	,	56	},{	9	,	63	},{	23	,	63	},{	26	,	56	}},
	{{	21	,	10	},{	21	,	26	},{	27	,	26	},{	23	,	10	}},
	{{	9	,	10	},{	5	,	26	},{	11	,	26	},{	11	,	10	}},
	{{	21	,	36	},{	21	,	46	},{	27	,	46	},{	27	,	36	}},
	{{	5	,	36	},{	5	,	46	},{	11	,	46	},{	11	,	36	}},
}
drawXY={
	{	16	,	7	},
	{	16	,	15	},
	{	16	,	23	},
	{	16	,	32	},
	{	16	,	42	},
	{	16	,	52	},
	{	16	,	60	},
	{	23	,	23	},
	{	9	,	23	},
	{	23	,	42	},
	{	9	,	42	},
}
function onTick()
	for i=1,rooms do
		waterLev[i]=input.getNumber(i)
	end
	--capicity if needed..
	for i=1,rooms do
		waterCap[i]=input.getNumber(rooms+i)
	end
	for i=1,rooms do
		if waterCap[i]==0 then
			RoomStatus[i]=false
		else
			RoomStatus[i]=true
		end
	end
end
--draw small number
num={1121112,2212122,1222122,1221212,1222221,2222221,1121122,2222222,1222222}
num[0]=2122222
function DN(x,y,s)
	x,y=math.floor(x+0.5),math.floor(y+0.5)
	s=tostring(s) 
	local l=string.len(s)
	for i=1,l do
		local n,w=s:sub(i,i),5
		if n=='.' then local w=2 end
		local N=tonumber(n)
		if N then
            w=4
			--if N==1 then w=2 end
			local startx,starty,dx,dy=x,y+4,0,0
			for j=1,7 do
				startx,starty=startx+dx*2,starty-dy*2
				if j==5 then starty=starty-2 end
				dx,dy=math.sin(0.25*math.pi*2*(j-1)),math.cos(0.25*math.pi*2*(j-1))
				if string.sub(num[N],j,j)=='2' then
					screen.drawLine(startx,starty,startx+dx*3,starty-dy*3)
				end
			end
		else
			screen.drawText(x,y,n)
		end
		x=x+w
	end
end
function onDraw()
	w,h=screen.getWidth(),screen.getHeight()
	--screen.setColor(8,8,8)
	--screen.drawClear()
	for i=1,rooms do
		if RoomStatus[i] then
			water=waterLev[i]/waterCap[i]
			roomcolorRed=22+200*water
			roomcolorGreen=44-22*water
			screen.setColor(roomcolorRed,roomcolorGreen,22)
			--drawtriangle
			screen.drawTriangleF(drawT[i][1][1],drawT[i][1][2],drawT[i][2][1],drawT[i][2][2],drawT[i][3][1],drawT[i][3][2])
			screen.drawTriangleF(drawT[i][3][1],drawT[i][3][2],drawT[i][4][1],drawT[i][4][2],drawT[i][1][1],drawT[i][1][2])
			screen.setColor(8,8,8)
			DN(drawXY[i][1]-1,drawXY[i][2]-3,string.format('%01.0f',math.min(water*10,9)))
		else
			screen.setColor(22,222,22)
			screen.drawText(drawXY[i][1]-1,drawXY[i][2]-3,'-')
		end
		screen.setColor(22,222,22)
		screen.drawLine(drawT[i][1][1],drawT[i][1][2],drawT[i][2][1],drawT[i][2][2])
		screen.drawLine(drawT[i][2][1],drawT[i][2][2],drawT[i][3][1],drawT[i][3][2])
		screen.drawLine(drawT[i][3][1],drawT[i][3][2],drawT[i][4][1],drawT[i][4][2])
		screen.drawLine(drawT[i][4][1],drawT[i][4][2],drawT[i][1][1],drawT[i][1][2])
	end
end