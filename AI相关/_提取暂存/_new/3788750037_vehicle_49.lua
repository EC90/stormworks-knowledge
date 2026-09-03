-- source: steam id 3788750037 / vehicle.xml block#49
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3788750037
function onTick()
MaxT=input.getNumber(11)
end
function onDraw()
MaxBT=1
NMax=MaxT/10
N1Max=MaxBT/10
screen.setColor(85,85,85)
screen.drawLine(86,47,86+((8)*math.cos(((NMax*0/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*0/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*2/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*2/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*3/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*3/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*4/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*4/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*5/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*5/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*6/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*6/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*7/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*7/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*8/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*8/MaxT)-4.96)*4.575)))
screen.setColor(85,0,0)
screen.drawLine(86,47,86+((8)*math.cos(((NMax*9/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*9/MaxT)-4.96)*4.575)))
screen.drawLine(86,47,86+((8)*math.cos(((NMax*10/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((NMax*10/MaxT)-4.96)*4.575)))
screen.setColor(20,20,20)
screen.drawCircleF(86, 47, 4)
screen.drawCircle(86, 47, 4)
screen.setColor(50,50,50)
screen.drawCircle(86, 47, 8)

screen.setColor(85,85,85)
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*0/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*0/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*2/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*2/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*3/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*3/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*4/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*4/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*5/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*5/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*6/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*6/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*7/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*7/MaxBT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*8/MaxBT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*8/MaxBT)-4.96)*4.575)))
screen.setColor(85,0,0)
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*9/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*9/MaxT)-4.96)*4.575)))
screen.drawLine(10,47,10+((8)*math.cos(((N1Max*10/MaxT)-4.96)*4.575)), 47+((8)*math.sin(((N1Max*10/MaxT)-4.96)*4.575)))
screen.setColor(20,20,20)
screen.drawCircleF(10, 47, 4)
screen.drawCircle(10, 47, 4)
screen.setColor(50,50,50)
screen.drawCircle(10, 47, 8)

--screen.drawLine(10,47,10+((6)*math.cos(((STrim/1)-4.96)*4.575)), 47+((6)*math.sin(((STrim/1)-4.96)*4.575)))

--screen.drawLine(86,47,86+((6)*math.cos(((STEMP/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((STEMP/MaxT)-4.96)*4.575)))
--screen.drawLine(87,47,86+((6)*math.cos(((NMax*9/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((NMax*9/MaxT)-4.96)*4.575)))
--screen.drawLine(87,47,86+((6)*math.cos(((NMax*10/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((NMax*10/MaxT)-4.96)*4.575)))
--screen.drawLine(87,47,86+((6)*math.cos(((NMax*11/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((NMax*11/MaxT)-4.96)*4.575)))
--screen.drawLine(87,47,86+((6)*math.cos(((NMax*12/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((NMax*12/MaxT)-4.96)*4.575)))

--screen.drawLine(87,47,86+((6)*math.cos(((NMax*15/MaxT)-4.96)*4.575)), 47+((6)*math.sin(((NMax*15/MaxT)-4.96)*4.575)))
end