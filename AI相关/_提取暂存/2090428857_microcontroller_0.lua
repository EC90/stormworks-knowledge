-- source: steam id 2090428857 / microcontroller.xml block#0
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=2090428857

function onTick()
    s=input.getNumber(1)
    c=input.getNumber(2)
end

function onDraw()
    screen.setColor(0,0,150)

	-- drawText(x, y, text, fontsize) fontsize 1 => normal fontsize, fontsize 2 => 200% zoom
    drawText(1,2, "ABCdefasd987123hjad", 3)
    drawText(1,30, "kaf123098)dasdklasd78zf2'*", 3)
end














-- DONT EDIT BELOW THIS LINE!!!!



BITMAPS={0,526472,340,1439220,1879374,461880,739656,136,297092,541768,1236690,40064,1081344,7168,524288,1116228,867180,279748,2000172,1846332,147250,1850654,867596,279614,863532,798508,32896,557184,299140,115136,1082512,526424,988972,1261356,1916220,864556,1913660,2039070,1121566,866060,1261362,559240,860706,1268050,2035984,1258482,1259442,865068,1121596,1012524,1269052,1846542,559260,865074,611668,1307442,1256754,559444,2034750,821388,280848,803916,328,1966080,72,435200,830600,427520,435746,429664,282178,796324,699528,278592,401922,707208,410692,769536,699392,304128,576064,158272,280064,402528,279780,961024,305664,1044480,674304,272032,410208,825484,557192,1608856,5280,0}
PM={}
PMS={}

function compile()
    for _,bm in pairs(BITMAPS) do
        pm={}
        for y=1,5 do
            pm[y]={}
            for x=1,4 do
                pm[y][x] = ( bm & (2^((y-1)*4+5-x)) ) == (2^((y-1)*4+5-x))
            end
        end
        PM[_] = pm
    end
end

compile()

function generatePixelMapForSize(pm)
    pms={}
    for y=1,5 do
        for x=1,4 do
            if pm[math.floor(0.5+y)] and pm[math.floor(0.5+y)][math.floor(0.5+x)] then
                table.insert(pms,{x=x,y=y})
            end
        end
    end
    return pms
end

function drawChar(px,py,c,size)--size: 1=normal
    id = string.byte(c)-31
    
    if not PM[id] then
        return
    end
    
    if not PMS[id] then
        PMS[id]=generatePixelMapForSize(PM[id])
    end
    
	if id == 72 or id == 75 or id == 81 or id == 82 or id == 90 then
		py = py + size * 2
	end

    for _,p in pairs(PMS[id]) do
        screen.drawRectF(px+(p.x-1)*size, py+(p.y-1)*size, size, size)
    end
end

function drawText(x,y,text,size)
    for i=1,string.len(text) do
        drawChar(x+(i-1)*5*size, y, string.sub(text, i, i+1), size)
    end
end
