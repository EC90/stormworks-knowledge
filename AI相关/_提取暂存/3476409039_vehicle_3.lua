-- source: steam id 3476409039 / vehicle.xml block#3
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3476409039

-- 
local m=math
local e,l,s,c,t,f,n,x,p,a,b=m.exp,m.log,m.sin,m.cos,m.tan,m.floor,m.min,m.max,m.pi,m.atan,m.abs

-- IO
local I,O=input,output
local GN,GB=I.getNumber,I.getBool
local SN,SB=O.setNumber,O.setBool
local gp,gy,rawGP,lastCR=0,0,0,0 -- 

-- 
local CONFIG={
    FOV_MIN=0.2846, -- FOV (7.0x)
    FOV_MAX=0.9846, -- FOV (1.7x)
    PITCH_DOWN=-8/90, --  (-8)
    PITCH_UP=50/90,   --  (50)
    MAX_PITCH_SPEED=(40/60)/90, --  (40/s)
    MAX_YAW_SPEED=45/60,   --  (45/s)
    YAW_RATIO=32, -- 
    YAW_MULTIPLIER=-5*32, -- 
    ZOOM_MIN=1.7, -- 
    ZOOM_MAX=7.0  -- 
}

-- 
local function clamp(v,min,max) return n(x(v,min),max) end

-- 
local function sgn(x) return x>0 and 1 or x<0 and -1 or 0 end

-- FOV
local function calculateZoom(fov)
    local fovDeg=135-fov*(135-1.43)
    return t(p/180*35)/t(p/180*fovDeg/2)
end

-- FOV
local function calculatePitchSensitivity(fov)
    local zoom=calculateZoom(fov)
    -- 212
    return zoom<2 and 1 or 1/zoom
end

-- FOV
local function calculateYawSensitivity(fov)
    local zoom=calculateZoom(fov)
    -- 212
    return zoom<2 and 1 or 1/zoom
end

-- (ticks)
local FIRE_RATES={
    36, -- 100rpm = 60*60/100 = 36 ticks
    18, -- 200rpm = 60*60/200 = 18 ticks
    7   -- 500rpm = 60*60/500 = 7.2  7 ticks
} 
local FIRE_RATES_RPM={100,200,500} -- RPM
local currentRateIndex=1
local lastFireTick=0
local lastSelectPress=false
local currentTick=0 -- 
local weaponSelectKey=false -- 
local isLACSelected=true -- 

-- 
local currentTurretAngle=0
local LACammoCount=0
local MGammoCount=0
local stabEnabled=false -- 

function onTick()
    -- 
    currentTick=currentTick+1
    
    -- 
    local seatX,seatY=GN(1),GN(2)
    local fov=clamp(GN(3),CONFIG.FOV_MIN,CONFIG.FOV_MAX)
    local cr=GN(5)%1 -- 
    local zTilt=GN(4) -- -0.50.5-9090
    local fireKey=GB(31) -- (31)
    local selectKey=GB(2) -- (f2)
    local stabKey=GB(3) -- (f3)
    local weaponKey=GB(1) -- (f1)
    local NVG=GB(4) -- 
    
    -- 
    LACammoCount=GN(6)
    MGammoCount=GN(7)
    
    -- 
    if weaponKey and not weaponSelectKey then
        isLACSelected=not isLACSelected
    end
    weaponSelectKey=weaponKey
    
    -- ()
    if selectKey and not lastSelectPress and isLACSelected then
        currentRateIndex=currentRateIndex%#FIRE_RATES+1
    end
    lastSelectPress=selectKey
    
    -- 
    local LACFire,MGFire=false,false
    
    if fireKey then
        if isLACSelected then
            -- 
            if currentTick-lastFireTick>=FIRE_RATES[currentRateIndex] then
                LACFire=true
                lastFireTick=currentTick
            end
        else
            -- 
            MGFire=true
        end
    end

    -- 
    local pitchSen=calculatePitchSensitivity(fov)
    local yawSen=calculateYawSensitivity(fov)
    local pitchStep=CONFIG.MAX_PITCH_SPEED*pitchSen -- 
    
    -- 
    if seatY>0.1 then rawGP=rawGP+pitchStep
    elseif seatY<-0.1 then rawGP=rawGP-pitchStep end
    
    -- 
    if b(seatX)>0.1 then
        -- FOV
        gy = seatX * CONFIG.MAX_YAW_SPEED * yawSen
    else
        gy = 0
    end
    
    -- 
    gy=clamp(gy,-CONFIG.MAX_YAW_SPEED,CONFIG.MAX_YAW_SPEED)
    
    -- 
    local tiltCompensation=stabKey and -zTilt*2 or 0
    
    -- 
    rawGP=clamp(rawGP,CONFIG.PITCH_DOWN,CONFIG.PITCH_UP)
    gp=clamp(rawGP+tiltCompensation,CONFIG.PITCH_DOWN,CONFIG.PITCH_UP)
    
    -- 
    SN(1,gp) SN(2,gy) SB(3,LACFire) SB(4,MGFire) SB(5,NVG)
    
    -- 
    currentTurretAngle = GN(5)%1
    
    -- 
    stabEnabled=stabKey
    
    -- 
    NVGEnabled=NVG
end

-- 
function turretdir()
    local cx,cy=30,screenH-30 -- 
    local r=10 -- 
    local angle=currentTurretAngle*p*2 -- 
    
    -- 
    sC(0,255,0,255)
    dL(cx-r,cy+r,cx-r,cy-r)
    dL(cx+r,cy+r,cx+r,cy-r)
    dL(cx-r,cy+r,cx+r,cy+r)
    dL(cx-r,cy-r,cx,cy-r-5)
    dL(cx+r,cy-r,cx,cy-r-5)
    
    -- 
    local dx,dy=s(angle)*r,c(angle)*r
    dL(cx,cy,cx+dx,cy-dy)
    
    -- 
    dR(cx-2,cy-2,6)
    
    -- 
    if stabEnabled then
        dT(cx-10,cy-r-15,"STAB")
    end
end

-- 
function drawWeaponInfo()
    -- 
    sC(0,255,0,255)
    
    -- 
    local weaponName=isLACSelected and "LAC" or "MG"
    dT(5,5,"Weapon: "..weaponName)
    
    -- 
    local ammoCount=isLACSelected and LACammoCount or MGammoCount
    dT(5,15,"Ammo: "..f(ammoCount))
    
    -- (LAC)
    if isLACSelected then
        dT(5,25,"ROF: "..FIRE_RATES_RPM[currentRateIndex].." RPM")
    end
    
    -- 
    if NVGEnabled then
        dT(5,35,"NVG")
    end
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
    
    drawWeaponInfo() -- 
    turretdir() -- 
end