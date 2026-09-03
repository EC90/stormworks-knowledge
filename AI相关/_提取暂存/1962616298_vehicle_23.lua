-- source: steam id 1962616298 / vehicle.xml block#23
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=1962616298
inp={}
bool={}
c="Include "
wng=property.getBool(c.."Wing Tanks")
cnt=property.getBool(c.."Center Tanks")
aux=property.getBool(c.."Aux Tanks")
tnk={wng, cnt, wng, aux}
btn={}
Line=screen.drawLine
Text=screen.drawText
TextBox=screen.drawTextBox
Rect=screen.drawRect
RectF=screen.drawRectF

function onTick()
go=input.getBool(32)
if go then
	for i=1, 32 do
		inp[i]=input.getNumber(i)
		bool[i]=input.getBool(i)
	end
	a=inp[2]/2
	b=inp[1]/2
	touchX=inp[3] -- touchscreen pixel coords
	touchY=inp[4]
	press=bool[1]
	cx={b/2, b, 3*b/2, b}
	cy={a+5, a/4+11, a+5, 3*a/2+7}
	if press then -- pulses the screen press to prevent flickering
		if x==0 then
			pulse=true
			x=1
		else
			pulse=false
		end
	else
		x=0
		pulse=false
	end
	if btn[1] or btn[2] or btn[3] or btn[4] or btn[5] then
		if pulse and inRect(touchX, touchY, -1, -1, 12, 13) then -- resets selected engine
			for i=1, 5 do
				btn[i]=false
			end
		end
	else
		for i=1, 4 do
			if pulse and inRect(touchX, touchY, cx[i]-15, cy[i]-10, 30, 18) and tnk[i] then
				btn[i]=true
			end
		end
		if pulse and inRect(touchX, touchY, inp[1]-59, -1, 59, 10) then
			btn[5]=true
		end
	end
	for i=1, 5 do
		if btn[i] then
			output.setNumber(1, i) -- sets engine number for detailed view
			det=i
		elseif btn[1] or btn[2] or btn[3] or btn[4] or btn[5] then -- spacer
		else
			output.setNumber(1, 0)
			det=0
		end
	end
end
end

function onDraw()
	screen.setColor(0, 0, 0)
	screen.drawRectF(0, 0, 10000, 10000)
	screen.setColor(200, 200, 200)
	w=screen.getWidth()
	h=screen.getHeight()
	a=h/2
	b=w/2
	if det==0 then
		Line(b-10, a-32, b-10, a+32)
		Line(b+10, a-32, b+10, a+32)
		Line(b-10, a-24, b-32, a-8)
		Line(b-10, a+16, b-32, a+24)
		Line(b+10, a-24, b+32, a-8)
		Line(b+10, a+16, b+32, a+24)
		if cnt then
			screen.setColor(0, 0, 0)
			RectF(b-10, a/4+3.5, 21, 7)
			RectF(b-13, a/4+11.5, 27, 7)
			screen.setColor(200, 200, 200)
			Rect(b-11, a/4+2, 22, 8)
			Rect(b-14, a/4+10, 28, 8)
		end
		if wng then
			screen.setColor(0, 0, 0)
			RectF(b/2-10, a-2.5, 21 ,7)
			RectF(b/2-13, a+5.5, 27, 7)
			screen.setColor(200, 200, 200)
			Rect(b/2-11, a-4, 22, 8)
			Rect(b/2-14, a+4, 28, 8)
			
			screen.setColor(0, 0, 0)
			RectF(3*b/2-10, a-2.5, 21 ,7)
			RectF(3*b/2-13, a+5.5, 27, 7)
			screen.setColor(200, 200, 200)
			Rect(3*b/2-11, a-4, 22, 8)
			Rect(3*b/2-14, a+4, 28, 8)
		end
		if aux then
			screen.setColor(0, 0, 0)
			RectF(b-10, 3*a/2-0.5, 21, 7)
			RectF(b-13, 3*a/2+7.5, 27, 7)
			screen.setColor(200, 200, 200)
			Rect(b-11, 3*a/2-2, 22, 8)
			Rect(b-14, 3*a/2+6, 28, 8)
		end
	end
end
	
function inRect(x, y, rectx, recty, rectw, recth) -- checks if click is inside button
	return x>rectx and y>recty and x<rectw+rectx and y<recth+recty
end