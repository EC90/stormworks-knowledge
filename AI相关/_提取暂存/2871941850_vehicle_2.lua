-- source: steam id 2871941850 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2871941850
-- Author: Jumper
-- GitHub: https://github.com/Jumper-44
-- Workshop: https://steamcommunity.com/profiles/76561198084249280/myworkshopfiles/
--
-- Developed & Minimized using LifeBoatAPI - Stormworks Lua plugin for VSCode
-- https://code.visualstudio.com/download (search "Stormworks Lua with LifeboatAPI" extension)
--      By Nameous Changey
-- Minimized Size: 1377 (1760 with comment) chars

j=false
C=input.getBool
l=table.unpack
function aa(a,b,d)for _=1,#a do
d[_]=a[_]+b[_]end
return d
end
function V(a,W,d)for _=1,#a do
d[_]=a[_]*W
end
return d
end
function ae(a,b,d)d[1],d[2],d[3]=a[2]*b[3]-a[3]*b[2],a[3]*b[1]-a[1]*b[3],a[1]*b[2]-a[2]*b[1]return d
end
function D(ad,c)c=c or{}for Z in property.getText(ad):gmatch"[+%w.-]+" do
c[#c+1]=tonumber(Z)end
return c
end
local n,f,p,i,w,P,N,r,K,J,o,x
n={}f=1
i,w,P,N=l(D "LaserSum, tickDelay, PointOUTSum, OutBufferSize")r={}K={}J={}o=j
x=j
do
local I={}local M=.125+.017
for _=1,i do
local k,q,v,z
k=D("Laser".._)r[_]={l(k,1,3)}q={l(k,4,6)}v={l(k,7,9)}z=ae(q,v,{})K[_]={v,z,q}aa(r[_],V(q,M,{}),r[_])local L,F={},{}for E=1,w do
L[E]=j
F[E]=j
end
n[_]={h=L,g=F}local H,y,b,c=l(k,10,13)I[_]={(y+H)/2,y-H,(c+b)/2,c-b}J[_]=k[14]end
local s=(1+5^.5)/2
local O=s*s
local A=s/10
local S=A/i
function R(B,T,ab,X,Q)local c=s*B%1
local h=c-.5
local g=(O*B)%1-.5
return T+ab*h,X+Q*g
end
local function G()p=0
end
G()function ac()p=p+1
f=f%w+1
o=C(1)x=C(2)if x then
G()end
end
function Y()local e,m,h,g
if o then
for _=1,i do
m=I[_]h,g=R(p*A+(_-1)*S,m[1],m[2],m[3],m[4])e=n[_]e.h[f]=h
e.g[f]=g
end
else
for _=1,i do
e=n[_]e.h[f]=j
e.g[f]=j
end
end
end
end
local U=i*2
local t=output.setNumber
function onTick()ac()Y()if o then
local u,e
for _=1,i do
u=(_-1)*2
e=n[_]t(u+1,e.h[f])t(u+2,e.g[f])end
else
for _=1,U do
t(_,0)end
end
end
