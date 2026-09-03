-- source: steam id 2156436786 / vehicle.xml block#7
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2156436786
function onTick()
	spd=input.getNumber(1)
	hdg=input.getNumber(2)
	depth=input.getNumber(3)
	starspd=input.getNumber(4)
	rpm=input.getNumber(5)
	temp=input.getNumber(6)
	fuel=input.getNumber(7)
	crs=input.getBool(1)
	rpm2=(rpm/4.1)
	temp2=(temp/4.1)
	fuel2=(fuel/19.4)
	ay=31
end

function onDraw()
	screen.setColor(255,255,255)
	screen.drawRect(2,2,28,9)
	screen.drawRect(2,2,28,18)
	screen.drawTextBox(2,4,28,9,"SPD",0)
	

	screen.drawTextBox(2,13,28,9,string.format("%.0f",spd),0)
	
	
	screen.drawRect(33,2,28,9)
	screen.drawRect(33,2,28,18)
	screen.drawRect(2,42,60,8)
	screen.drawRect(2,52,60,8)
	screen.drawRect(2,52,25,8)
	screen.drawTextBox(2,54,25,9,"DPT",0)
	screen.drawTextBox(28,54,25,9,string.format("%.0f",depth),0)



	
	screen.drawTextBox(33,4,28,9,"HDG",0)
	screen.drawTextBox(33,13,28,9,string.format("%.0f",hdg),0)
	

	screen.setColor(255,255,255,50)
	drawArc(11,ay,9,0)
	drawArc(32,ay,9,0)
	drawArc(53,ay,9,0)
	
	screen.setColor(255,255,255)
	drawArc(11,ay,9,0,rpm2)
	screen.drawTextBox(1,(ay+13),20,9,string.format("%.0f",rpm),0)
	screen.drawText(8,(ay-3),"R1")
	drawArc(32,ay,9,0,temp2)
	screen.drawTextBox(21,(ay+13),20,9,string.format("%.0f",temp),0)
	screen.drawText(29,(ay-3),"R2")
	drawArc(53,ay,9,0,fuel2)
	screen.drawTextBox(41,(ay+13),20,9,string.format("%.0f",fuel),0)
	screen.drawText(51,(ay-3),"F")
	
	

end
function drawArc(...)local a,b,c,d,e,f,g=...d=d or 0;e=e or 360;g=g or 22.5;if e<d then e,d=d,e end;local h,i,j,k,l,m=false,0,0,0,0,0;repeat h=h and math.min(h+g,e)or d;m=(h-90)*math.pi/180;i,j=a+c*math.cos(m),b+c*math.sin(m)if h~=d then if f then screen.drawTriangleF(a,b,k,l,i,j)else screen.drawLine(k,l,i,j)end end;k,l=i,j until h>=e end