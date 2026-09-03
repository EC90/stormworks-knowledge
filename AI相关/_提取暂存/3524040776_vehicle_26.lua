-- source: steam id 3524040776 / vehicle.xml block#26
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
slots={'tws','radio','sonar','kbd'}
touched=false
sl=1
function onTick()
    touchx=input.getNumber(3)
    touchy=input.getNumber(4)
    touch=input.getBool(1)
    tradio={input.getNumber(5),input.getNumber(6),input.getNumber(7)}
    tsonar={input.getNumber(8),input.getNumber(9),input.getNumber(10)}
    tkbd={input.getNumber(11),input.getNumber(12),input.getNumber(13)}
    if touch and not touched then
        sl=math.min((touchy/8)-(touchy/8)%1+1,4)
    end
    touched=touch
    if sl==2 then
        output.setNumber(1,tradio[1])
        output.setNumber(2,tradio[2])
        output.setNumber(3,tradio[3])
    elseif sl==3 then
        output.setNumber(1,tsonar[1])
        output.setNumber(2,tsonar[2])
        output.setNumber(3,tsonar[3])
    elseif sl==4 then
        output.setNumber(1,tkbd[1])
        output.setNumber(2,tkbd[2])
        output.setNumber(3,tkbd[3])
    else
        output.setNumber(1,0)
        output.setNumber(2,0)
        output.setNumber(3,0)
    end
end
function onDraw()
    screen.setColor(8,8,8)
    screen.drawClear()
    w,h=screen.getWidth(),screen.getHeight()
    screen.setColor(22,222,22)
    for i=1,#slots do
        if sl==i then
            screen.setColor(22,222,22)
        else
            screen.setColor(36,36,36)
        end
        screen.drawTextBox(0,8*i-8,w,8,slots[i],0,0)
    end
end