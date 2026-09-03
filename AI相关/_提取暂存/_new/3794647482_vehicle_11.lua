-- source: steam id 3794647482 / vehicle.xml block#11
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3794647482
m= math
MaxSample=300
timer = 0
nx = {}
ny = {}
nz = {}

for i=1, MaxSample do
	table.insert(nx, 0)
	table.insert(ny, 0)
	table.insert(nz, 0)
end

function onTick()
	x=input.getNumber(1)
	y=input.getNumber(2)
	z=input.getNumber(3)
	dely=input.getNumber(4)
	MaxSamplen=math.floor(input.getNumber(5)+0.5)
	s=input.getBool(1)
	
	if not s then
	x = 0
	y = 0
	z = 0
	end
	
	if s then
	 timer = timer+1
	else
	 timer =0
	end

	for i=MaxSample, 2, -1 do
		nx[i] = nx[i-1]
		ny[i] = ny[i-1]
		nz[i] = nz[i-1]
	end
	
	nx[1] = x
	ny[1] = y
	nz[1] = z
	
	ax = 0
	ay = 0
	az = 0
	dt = 0
	at = -0.5*MaxSamplen -0.5
	
	for i=1, MaxSamplen do
	 dt = dt + (-i - at)^2
	 ax = ax+nx[i]
	 ay = ay+ny[i]
	 az = az+nz[i]
	end
	dt=dt/MaxSamplen
	ax=ax/MaxSamplen
	ay=ay/MaxSamplen
	az=az/MaxSamplen

	dx = 0
	dy = 0
	dz = 0
	
	for i=1, MaxSamplen do
	 t = -i-at
	 dx = dx+((nx[i]-ax))*t
	 dy = dy+((ny[i]-ay))*t
	 dz = dz+((nz[i]-az))*t
	end
	dx=dx/MaxSamplen
	dy=dy/MaxSamplen
	dz=dz/MaxSamplen
	
	
if timer > MaxSamplen then	
	msx = dx/dt
	msy = dy/dt
	msz = dz/dt
	
	nnx = (ax-msx*at)+msx*dely
	nny = (ay-msy*at)+msy*dely
	nnz = (az-msz*at)+msz*dely

else

	msx = 0
	msy = 0
	msz = 0
	
	nnx = 0
	nny = 0
	nnz = 0

	s = false
	
end
	output.setNumber(1,nnx)
	output.setNumber(2,nny)
	output.setNumber(3,nnz)
	output.setNumber(4,msx)
	output.setNumber(5,msy)
	output.setNumber(6,msz)
	output.setBool(1,s)

end

