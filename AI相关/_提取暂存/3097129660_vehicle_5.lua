-- source: steam id 3097129660 / vehicle.xml block#5
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3097129660
GN=input.getNumber
SN=output.setNumber
aT={100,1000,4000,20000}
sA=1000
M=math
Ma=M.abs
Mc=M.cos
Mf=M.floor
Ms=M.sin
Mr=M.sqrt
P2=M.pi*2
T=table
function dst(p1,p2)
	return Mr((p1.x-p2.x)^2+(p1.y-p2.y)^2)
end
function pnts(c1,c2)
	local d=dst(c1,c2)
	if d<=c1.R+c2.R and d>=M.abs(c1.R-c2.R) then
		local a=(c1.R^2-c2.R^2+d^2)/(2*d)
		local h=M.sqrt(c1.R^2-a^2)
		local x0=c1.x+a*(c2.x-c1.x)/d
		local y0=c1.y+a*(c2.y-c1.y)/d
		return {{x=x0+h*(c2.y-c1.y)/d,y=y0-h*(c2.x-c1.x)/d},{x=x0-h*(c2.y-c1.y)/d,y=y0+h*(c2.x-c1.x)/d}}
	else return {}
	end
end
function E2R(E) local x,y,z=E[1],E[2],E[3] return {{Mc(y)*Mc(z),Mc(x)*Mc(y)*Ms(z)+Ms(x)*Ms(y),Ms(x)*Mc(y)*Ms(z)-Mc(x)*Ms(y)},{-Ms(z),Mc(x)*Mc(z),Ms(x)*Mc(z)},{Ms(y)*Mc(z),Mc(x)*Ms(y)*Ms(z)-Ms(x)*Mc(y),Ms(x)*Ms(y)*Ms(z)+Mc(x)*Mc(y)}} end
function tM(M) local t={{},{},{}} for i=1,3 do for j=1,3 do t[i][j]=M[j][i] end end return t end
function Mv(M,v) local t={} for i=1,3 do _=0 for j=1,3 do _=_+M[j][i]*v[j] end t[i]=_ end return t end
function R2G(r) local t=Mv(tM(E2R(Eu)),{r[1]*Mc(r[3])*Ms(r[2]),r[1]*Mc(r[3])*Mc(r[2]),r[1]*Ms(r[3])}) return {t[1]+sp[1],t[2]+sp[2],t[3]+sp[3]} end
function cpr(a,b)
	return a.e<b.e
end
function erc(ps,c,lst)
	if ps~={} then
		local temp={}
		for i=1,#ps do
			T.insert(temp,{x=ps[i].x,y=ps[i].y,e=M.abs(dst(ps[i],c)-c.R),A=c.A})
		end
		if #temp>1 then
			T.sort(temp,cpr)
			T.insert(lst,temp[1])
		end
	end
end
cnt1=-3
cnt2=0
cnt3=1
flst={}
md=-1--0=src,1=trk
debug=333
spc={0,1111,2222,3333,4444,5555,6666,7777,8888,9999,11111,114514,1919,1919810,7355608,1234,12345,123456,1999,2000,2023,2022,1024,2048,3090,3080,65535}
hst={}
delay=4
if #hst<delay then T.insert(hst,{0,250,500,750,1111}) end
function onTick()
	if GN(22)>0 then if md==-1 then md=0 end else md=-1 end
	sp={GN(1),GN(3),GN(2)} Eu={GN(4),GN(6),GN(5)}
	if md==0 then
		for i=1,4 do
			if GN(i+10)>0.01 and cnt1>delay and hst[1][i]~=GN(21) then
				T.insert(flst,hst[1][i])
			end
		end
		if GN(15)>0.01 and cnt1>delay and cnt1<=#spc+delay then T.insert(flst,hst[1][5]) end
		debug=#flst
		--
		SN(11,cnt1)
		SN(12,cnt1+250)
		SN(13,cnt1+500)
		SN(14,cnt1+750)
		if cnt1>0 and cnt1<=#spc then C5=spc[cnt1] else C5=255255 end
		SN(15,C5)
		T.insert(hst,{cnt1,cnt1+250,cnt1+500,cnt1+750,C5})
		if #hst>5 then T.remove(hst,1) end
		cnt1=cnt1+1
	end
	if cnt1>250+delay then if #flst>0 then md=1 cnt1=-delay else cnt1=-delay end end
	for i=1,8 do
		SN(i,0)
	end
	if md==1 then
		if cnt3<=#flst then
			for i=1,4 do
				SN(i+10,flst[cnt3])
			end
			if cnt2>5 then
				--calculate
				rH={}
				rV={}
				for i=1,#aT do
					cF={x=0,y=4.5,R=(1-GN(11))*(aT[i]+sA),A=i}
					cC={x=0,y=0,R=(1-GN(12))*(aT[i]+sA),A=i}
					cR={x=5,y=0,R=(1-GN(14))*(aT[i]+sA),A=i}
					erc(pnts(cC,cR),cF,rH)
				end
				if rH~={} then
					T.sort(rH,cpr)
					a=rH[1].A
					cC={x=0,y=0,R=(1-GN(12))*(aT[a]+sA),A=a}
					cT={x=3,y=0,R=(1-GN(13))*(aT[a]+sA),A=a}
					cF={x=0,y=4.5,R=(1-GN(11))*(aT[a]+sA),A=a}
					erc(pnts(cC,cT),cF,rV)
					if rV[1] then
						T.sort(rV,cpr)
						--xo=M.atan(rH[1].x,rH[1].y)
						--yo=M.atan(rV[1].x,rV[1].y)
						--xf=xo/Mc(yo)
						--Tg=R2G({cC.R,xf,yo})
						temp=Mv(tM(E2R(Eu)),{rH[1].x,rH[1].y,rV[1].x})
						Tg={temp[1]+sp[1],temp[2]+sp[2],temp[3]+sp[3]}
						SN(1,flst[cnt3])
						SN(5,Tg[1])
						SN(6,Tg[2])
						SN(7,Tg[3])
					end
				end
				--send
				cnt2=0
				cnt3=cnt3+1
			end
			cnt2=cnt2+1
		else
			flst={} md=0 cnt3=1 cnt4=0
		end
	end
	SN(2,0)
	SN(3,0)
	SN(4,0)
	--
	SN(32,GN(23))
end
