-- source: steam id 3791574523 / vehicle.xml block#1
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3791574523
X=1000
x=0
AD=0
WS=0
D1=false
D2=0
jump1=false
FMS=0
RMS=property.getNumber("Reverse max speed")
Y=property.getNumber("Hip max rotation")
Z=property.getNumber("Hip starting position")
W=property.getNumber("Knee max rotation")
A=property.getNumber("Knee starting position")
B=property.getNumber("jump hip")
C=property.getNumber("jump knee")
D=property.getNumber("Jump button")
tglR=property.getBool("Return to starting position when no input")
E=property.getBool("Inverse Clamp (limits max knee extension for smoother walking)")
F=property.getNumber("sit button")
G=property.getNumber("sit hip")
H=property.getNumber("sit knee")
I=property.getNumber("Jump timing")
J=property.getNumber("Jump at")
K=property.getNumber("kick button")
L=property.getNumber("kick hip")
M=property.getNumber("kick knee")
N=property.getNumber("Turn step speed")
O=property.getBool("Toggle turn stepping")
function onTick()
WS=input.getNumber(2)
AD=input.getNumber(1)
tglspd=input.getBool(3)
if tglspd then FMS=-0.14 else FMS=-0.07 end
jump=input.getBool(D)
sit=input.getBool(F)
kick=input.getBool(K)
if WS > 0 then 
	X=X+(WS*FMS)
end
if WS < 0 then 
	X=X+(WS*RMS)
end
if AD > 0 and math.abs(WS)<0.1 and O then 
	X=X+(AD*N)
end
if AD < 0 and math.abs(WS)<0.1 and O then 
	X=X+(AD*N)
end
if math.abs(WS)<0.1 and math.abs(AD)<0.1 and tglR then 
	X=0 
end
if E then
	A1=-1 A2=A 
	else 
	A1=A A2=1
end
leftHip=math.sin(X*math.pi)*Y+Z
rightHip=-math.sin(X*math.pi)*Y+Z
leftKnee=clamp(math.cos(X*math.pi)*W+A,A1,A2)
rightKnee=clamp(-math.cos(X*math.pi)*W+A,A1,A2)
if D then 
	D1=true 
	D2=D2+0.1 
end 
if D2>2 then 
	D1 = false 
end
output.setNumber(1,leftHip)
output.setNumber(2,rightHip)
if math.abs(WS)>.1 then
	output.setNumber(3,leftKnee)
	output.setNumber(4,rightKnee)
	else 
	output.setNumber(3,A)
	output.setNumber(4,A)
end
if jump then
	jump1=true	
end
if jump1 then
	x=x+I
end
if x<J and jump1 then
	output.setNumber(1,G)
	output.setNumber(2,G)
	output.setNumber(3,H)
	output.setNumber(4,H)
end
if x>J and jump1 then
	output.setNumber(1,B)
	output.setNumber(2,B)
	output.setNumber(3,C)
	output.setNumber(4,C)
end
if x>1 then
	x=0
	jump1=false
end
if sit then
	output.setNumber(1,G)
	output.setNumber(2,G)
	output.setNumber(3,H)
	output.setNumber(4,H)
end
output.setNumber(5,x)
if kick then
	output.setNumber(1,leftHip)
	output.setNumber(2,L)
	output.setNumber(3,leftKnee)
	output.setNumber(4,M)
end
if math.abs(AD)>0.1 and math.abs(WS)<0.1 and O then
	output.setNumber(1,Z)
	output.setNumber(2,Z)
	output.setNumber(3,leftKnee)
	output.setNumber(4,rightKnee)
	output.setBool(1,true)
end
end

function clamp(x, min, max)
	return math.min(math.max(x, min), max)
end