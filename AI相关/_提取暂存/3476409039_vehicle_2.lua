-- source: steam id 3476409039 / vehicle.xml block#2
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3476409039
--[[ /
 (Input):
1:  (Distance) (0-4000m)
2: FOV (FOV Value) (0.0-1.0)
 (Output):
1: FOV (FOV Output)
]]

-- 
local m=math
local s,c,t,f,n,x,p,a=m.sin,m.cos,m.tan,m.floor,m.min,m.max,m.pi,m.atan

-- 
local S=screen or{}
local dL,dC,dCF,dR,dRF,dT,dTB,sC=S.drawLine,S.drawCircle,S.drawCircleF,S.drawRect,S.drawRectF,
S.drawText,S.drawTextBox,S.setColor

-- IO
local i,o=input,output
local G,H,N,M=i.getNumber,i.getBool,o.setNumber,o.setBool

--  {(m):(m)}
local D={
    MG={
        [0]=0.000, [100]=0.269, [200]=1.267, [300]=3.532, [400]=8.484, [500]=24.468
    },
    LAC={
        [0]=0.000, [100]=0.183, [200]=0.717, [300]=1.798, [400]=3.622, [500]=6.589, [600]=11.520, [700]=20.673
    }
}

-- 
local P={
    S={MG={3,4,5},LAC={3,5,7},RF={1,2,3,4,5,6,7,8}}, -- (*100m)
    C={bg={255,255,255,255},sight={0,0,0,255},scale={255,10,0,255},text={255,0,0,255}}, -- 
    D={r=75,t=3,c=3,y=8,w=5,crossSize=4,rangeLineY=8,charWidth=5}, -- 
    T={h=2.25} -- 
}

-- 
local RANGE,FOV=0,0.2846 -- FOV
local screenW,screenH,screenCW,screenCH=0,0,0,0 -- 

-- 
local function k(v,a,b) return x(n(v,a),b) end

-- 
local function Q(w_type,dist)
    local drops=D[w_type]
    if not drops then return 0 end
    
    -- 
    if drops[dist] then return drops[dist] end
    
    -- 
    local lower_dist,upper_dist=0,0
    for d in pairs(drops) do
        if d <= dist and d > lower_dist then lower_dist = d end
        if d >= dist and (upper_dist == 0 or d < upper_dist) then upper_dist = d end
    end
    
    -- 
    if lower_dist == 0 then return drops[upper_dist] end
    if upper_dist == 0 then return drops[lower_dist] end
    
    -- 
    local ratio = (dist - lower_dist) / (upper_dist - lower_dist)
    return drops[lower_dist] + ratio * (drops[upper_dist] - drops[lower_dist])
end

-- FOV
local function calculateFOVFromZoom(z)
    return 1-(2*a(t(p/180*35/z))*180/p)/(135-1.43)
end

local function calculateZoomFromFOV(fov_input)
    local fovDeg=135-fov_input*(135-1.43)
    return t(p/180*35)/t(p/180*fovDeg/2)
end

-- 
local function getPixelsPerMeter(fov_input,distance,target_height,screen_dimension)
    if distance<=0 then return 0 end
    local fovDeg=135-fov_input*(135-1.43)
    return target_height/(2*distance*t(fovDeg*p/360))*screen_dimension
end

function onTick()
    RANGE=k(f(G(1)),0,4000) -- 
    FOV=k(G(2),calculateFOVFromZoom(7.0),calculateFOVFromZoom(1.7)) -- FOV
    N(1,FOV)
end

-- 
local function drawSightBackground()
    sC(table.unpack(P.C.bg)) dRF(0,0,screenW,screenH)
    sC(table.unpack(P.C.sight)) dCF(screenCW,screenCH,P.D.r)
end

local function drawRangeMeasure()
    sC(table.unpack(P.C.scale))
    local baseX,baseY=screenCW-P.D.r*0.75,screenCH-P.D.rangeLineY
    local endX=screenCW+P.D.r*0.5
    dL(baseX,baseY,endX,baseY)
    
    local heightText=tostring(P.T.h)
    dTB(endX+1,baseY-2,#heightText*P.D.charWidth+1,6,heightText,0,-1)
    
    for i,distance in ipairs(P.S.RF) do
        local dist_m=distance*100
        local pixelHeight=getPixelsPerMeter(FOV,dist_m,P.T.h,P.D.r*2)
        local tickStartX=endX-(i-1)*P.D.crossSize*3
        local tickEndX=tickStartX-P.D.crossSize
        local tickY=baseY-pixelHeight
        if tickY<screenCH-P.D.r then break end
        
        dL(tickStartX,tickY,tickEndX,tickY)
        local indicatorX=tickEndX+P.D.crossSize/2
        dL(indicatorX,tickY,indicatorX,tickY-P.D.crossSize)
        local distText=tostring(distance)
        dT(indicatorX-#distText*P.D.charWidth/2,tickY-P.D.crossSize-10,distText)
    end
end

-- 
local function drawLAC()
    sC(table.unpack(P.C.scale))
    for i,distance in ipairs(P.S.LAC)do
        local drop=Q("LAC",distance*100)
        if not drop then break end
        local pixelHeight=getPixelsPerMeter(FOV,distance*100,drop,P.D.r*2)
        local crossY=screenCH+pixelHeight
        if crossY>screenCH+P.D.r then break end
        local h=P.D.crossSize/2
        dL(screenCW,crossY-h,screenCW,crossY+h)
        dL(screenCW-h,crossY,screenCW+h,crossY)
        dT(screenCW-h-#tostring(distance)*P.D.charWidth-2,crossY-P.D.charWidth/2,tostring(distance))
    end
end

-- 
local function drawMG()
    sC(table.unpack(P.C.scale))
    dT(screenCW+10,screenCH-6,"MG")
    for i,distance in ipairs(P.S.MG)do
        local drop=Q("MG",distance*100)
        if not drop then break end
        local pixelHeight=getPixelsPerMeter(FOV,distance*100,drop,P.D.r*2)
        local x,y=screenCW+10,screenCH+pixelHeight
        if y>screenCH+P.D.r then break end
        dL(x,y-P.D.crossSize,x,y-1)
        dL(x,y+1,x,y+P.D.crossSize)
        dT(x+P.D.crossSize/2+2,y-P.D.charWidth/2,tostring(distance))
    end
end

-- 
local function drawHorizontalScale()
    local fovDeg=135-FOV*(135-1.43)
    if fovDeg<=0 then return end
    local milRad=fovDeg*p/180*1000
    if milRad<=0 then return end
    local pixelsPerMil=P.D.r*2/milRad
    
    sC(table.unpack(P.C.scale))
    dL(screenCW-3,screenCH,screenCW+3,screenCH)
    dL(screenCW,screenCH-3,screenCW,screenCH+3)
    
    local x=screenCW
    for i=1,5 do
        x=x-pixelsPerMil*20
        if x<screenCW-P.D.r then break end
        dL(x,screenCH,x,screenCH+5)
        local mx=x+pixelsPerMil*10
        if mx<screenCW-P.D.r then break end
        dL(mx,screenCH,mx,screenCH+3)
    end
    
    x=screenCW
    for i=1,5 do
        x=x+pixelsPerMil*20
        if x>screenCW+P.D.r then break end
        dL(x,screenCH,x,screenCH+5)
        local mx=x-pixelsPerMil*10
        if mx>screenCW+P.D.r then break end
        dL(mx,screenCH,mx,screenCH+3)
    end
end

-- 
local function drawZoomLevel()
    local zoom=calculateZoomFromFOV(FOV)
    local text=string.format("(%.1fX)",zoom)
    sC(table.unpack(P.C.text))
    dT(screenCW-#text*P.D.charWidth/2,screenCH-0.8*P.D.r,text)
end

function onDraw()
    if not(S and S.drawLine)then
        S=screen or{}
        dL,dC,dCF,dR,dRF,dT,dTB,sC=S.drawLine,S.drawCircle,S.drawCircleF,S.drawRect,
        S.drawRectF,S.drawText,S.drawTextBox,S.setColor
        if not(S and S.drawLine)then return end
    
    end
    screenW,screenH=S.getWidth(),S.getHeight()
    screenCW,screenCH=screenW/2,screenH/2
    
    drawSightBackground()
    drawRangeMeasure()
    drawLAC()
    drawMG()
    drawHorizontalScale()
    drawZoomLevel()
    
end
