-- source: steam id 3603910667 / vehicle.xml block#97
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3603910667
GN=input.getNumber
GB=input.getBool
SN=output.setNumber
SB=output.setBool
pN=property.getNumber
pB=property.getBool
M=math
abs=M.abs
sin=M.sin
cos=M.cos
tan=M.tan
sqrt=M.sqrt
asin=M.asin
atan=M.atan
exp=M.exp
pi=M.pi
pi2=M.pi*2
floor=M.floor
T=true
F=false

--time all in tick
--dis all in meter
--
freq=12700

--/s /s /m /m /m/s 
MSLDATA=
		{{22,3,8000,1500,350,T,1}
		,{46,4,19000,100,420,T,1}
		,{0,0,0,0,100,F,0}
		,{0,0,0,0,100,F,0}}
MSLDATA[0]={0,0,0,0,100,F,0}

--
-- wltgt -w -l -tgt
wltgt={}
wltgt[0]={0,0,0}
--id
tgtid={}
--
tgtwl={}
-- wstgt -w -s -tgt
wstgt={}
wstgt[0]={0,0,0}
-- lltgt -l -l -tgt
lltgt={}
--
clrate={}
--eta
eta={}

--
--
tgttimer={0,0,0,0}
--
tgtdata={{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
--
tgtspd={{0,0,0},{0,0,0},{0,0,0},{0,0,0}}
--
tgtwlb={0,0,0,0}
--
tgtsta={F,F,F,F}

--
numlaunch={}
numlaunch[0]=0
--
newtgttimer={}
newtgttimer[0]=0
--
tgtposbuf={}
tgtposbuf[0]={0,0,0}

--id
idlaunch={0,0,0,0}
--
frlaunch={11400,11400,11400,11400}
--
fllaunch={F,F,F,F}
fllaunch[0]=T
--
msfreq=0

--VLS
launchedbuf=F
--id
launchid=0

function onTick()
	--VLS
	vlsdata=GN(1)
	--VLSID
	weapon={floor((vlsdata/100000)%100),floor((vlsdata/1000)%100),floor((vlsdata/10))%100}
	launched=floor(vlsdata%2)
	--
	med=M.floor(freq/100)-M.floor(freq/100000)*1000
	freq=(med)^2
	--
	channel=0

	--
	for i=1,6 do
		-- wltgt -w -l -tgt
		wltgt[i]={GN(9+(i-1)*4),GN(10+(i-1)*4),GN(11+(i-1)*4)}
		-- wlslo -w -l -slo
		wlslo={GN(5),GN(6),GN(7)}
		--id
		tgtid[i]=M.floor(GN(12+(i-1)*4))
		--
		tgtwl[i]=(GN(12+(i-1)*4)%1)*10

		--id
		if numlaunch[tgtid[i]]==nil then
			numlaunch[tgtid[i]]=0
			newtgttimer[tgtid[i]]=120
			tgtposbuf[tgtid[i]]=wltgt[i]
		end

		-- wstgt -w -s -tgt
		wstgt[i]=sub(wltgt[i],tgtposbuf[tgtid[i]])
		-- lltgt -l -l -tgt
		lltgt[i]=sub(wltgt[i],wlslo)
		--
		clrate[i]=-dmux(lltgt[i],wstgt[i])/dis(lltgt[i])
		--eta
		eta[i]=dis(lltgt[i])/clrate[i]
		--
		tgtposbuf[tgtid[i]]=wltgt[i]
		--
		if newtgttimer[tgtid[i]]>0 then
			newtgttimer[tgtid[i]]=newtgttimer[tgtid[i]]-1
		end
	end

	--
	for n=1,4 do
		--
		if tgttimer[n]>0 then
			tgttimer[n]=tgttimer[n]-1
		end
		--,
		if fllaunch[n] then
			curid=0
			--id
			for i=1,6 do
				if tgtid[i]==idlaunch[n] then
					curid=i
				end
			end
			
			if curid==0 then
				--
				tgtsta[n]=F
			else
				--
				tgtdata[n]=wltgt[curid]
				tgtspd[n]=wstgt[curid]
				tgtwlb[n]=tgtwl[curid]
				tgtsta[n]=T
			end
			
		--,
		elseif fllaunch[n-1] then
			for i=1,6 do
				--
				if not (idlaunch[1]==tgtid[i] or idlaunch[2]==tgtid[i] or idlaunch[3]==tgtid[i] or idlaunch[4]==tgtid[i]) and tgtid[i]>0 then
					--
					for j=1,3 do
						--
						--
						MAXETA=MSLDATA[weapon[j]][1]*60
						--
						MINETA=MSLDATA[weapon[j]][2]*60
						--
						MAXRAN=MSLDATA[weapon[j]][3]
						--
						MINRAN=MSLDATA[weapon[j]][4]
						--
						MSSPD=MSLDATA[weapon[j]][5]/60
						--//
						--mainedg=dis(lltgt[i])-clrate[i]*MAXETA<MAXRAN and dis(lltgt[i])-clrate[i]*MAXETA>MINRAN
						mainedg=dis(lltgt[i])<MAXRAN and dis(lltgt[i])>MINRAN and tgtwl[i]>0.5 and tgtwl[i]<2.5 and tgttimer[n]<1 and launchid<0.5 and newtgttimer[tgtid[i]]<1
						--
						--vlsedg=MSLDATA[weapon[j]][6] and weapon[j]>0.5 and eta[i]>600 and (weapon[j]~=1 or numlaunch[tgtid[i]]<1 or MSLDATA[weapon[1]][7]+MSLDATA[weapon[2]][7]+MSLDATA[weapon[3]][7]<1.5)
						vlsedg=MSLDATA[weapon[j]][6] and weapon[j]>0.5 and eta[i]>600 and (weapon[j]~=1 or numlaunch[tgtid[i]]<1 or MSLDATA[weapon[1]][7]+MSLDATA[weapon[2]][7]+MSLDATA[weapon[3]][7]<1.5)
						if mainedg and vlsedg then
							--launchtruelaunchid
							fllaunch[n]=T
							idlaunch[n]=tgtid[i]
							frlaunch[n]=freq
							tgtsta[n]=T
							--+1
							numlaunch[tgtid[i]]=numlaunch[tgtid[i]]+1
							--ID
							launchid=weapon[j]
							msfreq=freq
							--
							tgttimer[n]=dis(lltgt[i])/(clrate[i]+MSSPD)+200
						end
					end
				end

			end
		end
		--
		-- if tgtwlb[idlaunch[n]]>2.5 or tgtwlb[idlaunch[n]]<0.5 then
		-- 	tgttimer[idlaunch[n]]=0
		-- end
		--false0
		if tgttimer[n]<1 then
			fllaunch[n]=F
			idlaunch[n]=0
			frlaunch[n]=0
		end
	end

	for j=1,4 do
		SN(floor(1.5+(j-1)*6),tgtdata[j][1])
		SN(floor(2.5+(j-1)*6),tgtdata[j][2])
		SN(floor(3.5+(j-1)*6),tgtdata[j][3])
		SN(floor(4.5+(j-1)*6),tgtspd[j][1])
		SN(floor(5.5+(j-1)*6),tgtspd[j][2])
		SN(floor(6.5+(j-1)*6),tgtspd[j][3])
		if tgtsta[j] then
			SN(M.floor(24.5+j),frlaunch[j])
		else
			SN(M.floor(24.5+j),0)
		end
	end

	--false,ID0
	if launched>0.5 and not launchedbuf then
		launchid=0
	end
	launchedbuf=launched>0.5

	--SN(29,msfreq)
	SN(30,floor(tgttimer[1])*1000+tgttimer[2])
	--SN(31,launched)
	--SN(32,launchid)
	SN(31,launchid)
	SN(32,msfreq)
	SB(32,fllaunch[channel])
end

function Mv(M,v)
	local t={}
	for i=1,3 do
		_=0
		for j=1,3 do
			_=_+M[j][i]*v[j]
		end
		t[i]=_
	end
	return t
end
function L2W(_)
	return Mv(tM(E2R(Euler)),{_[1],_[2],_[3]})
end
function W2L(_)
	return Mv(E2R(Euler),{_[1],_[2],_[3]})
end
function R2L(r) return {r[1]*cos(r[3]*pi2)*sin(r[2]*pi2),r[1]*cos(r[3]*pi2)*cos(r[2]*pi2),r[1]*sin(r[3]*pi2)} end
function pid(data,setpoint,coff,En,down,up)
	if En then
		data[2]=clamp(data[2]+(setpoint-data[1])*coff[2],down,up)
		local out=(setpoint-data[1])*coff[1]+(data[2])+(setpoint-data[1]-data[3])*coff[3]
		data[3]=setpoint-data[1]
		return data,out
	else
		data,out={0,0,0},0
		return data,out
	end
end
function dis(y) return sqrt(y[1]^2+y[2]^2+y[3]^2) end
function add(a,b) return {a[1]+b[1],a[2]+b[2],a[3]+b[3]} end
function sub(a,b) return {a[1]-b[1],a[2]-b[2],a[3]-b[3]} end
function mux(a,b) return {a[1]*b,a[2]*b,a[3]*b} end
function cmux(a,b) return {a[2]*b[3]-a[3]*b[2],a[3]*b[1]-a[1]*b[3],a[1]*b[2]-a[2]*b[1]} end
function dmux(a,b) return a[1]*b[1]+a[2]*b[2]+a[3]*b[3] end
function clamp(x,a,b)
	if x<a then x=a end
	if x>b then x=b end
	return x
end

function sgn(x)
	if x<0 then
	y=-1
	else
	y=1
	end
	return x
end
	
function atan2(y,x)
	if x>0 then
	return atan(y/x)
	elseif y<0 then
	return atan(y/x)-pi
	else
	return atan(y/x)+pi
	end
end