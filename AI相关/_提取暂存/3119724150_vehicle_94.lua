-- source: steam id 3119724150 / vehicle.xml block#94
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3119724150
    target_x = 0
    target_y = 0
    target_z = 0
    current_X = 0
    current_y = 0
    tau = math.pi*2
function onTick()
    local_target_x = input.getNumber(1)
    local_target_y = input.getNumber(2)
    local_target_z = input.getNumber(3)
    sensor_pitch = input.getNumber(4)
    sensor_roll = input.getNumber(5)
    sensor_up = input.getNumber(6)
    compass = input.getNumber(7)
    current_X = input.getNumber(8)
    current_y = input.getNumber(9)
    tiltSensor =
    {
        forward = sensor_pitch,
        left = sensor_roll,
        up = sensor_up

    }

    --Apply Pitch (Around X axis)
    --target_x_ppitch,target_y_ppitch,target_z_ppitch = rotateXAxis(local_target_x,local_target_y,local_target_z, sensor_pitch)
    --target_x_proll,target_y_proll,target_z_proll = rotateYAxis(target_x_ppitch,target_y_ppitch,target_z_ppitch, sensor_roll)

    --Jumper's rotation matrix
    ang = Vec3(tiltSensor.forward*tau, math.asin(math.sin(tiltSensor.left*tau)/math.sin((.25-tiltSensor.forward)*tau)), compass*tau)
    if tiltSensor.up < 0 then ang.y = math.pi-ang.y end

    local sx,sy,sz, cx,cy,cz = math.sin(ang.x),math.sin(ang.y),math.sin(ang.z), math.cos(ang.x),math.cos(ang.y),math.cos(ang.z)
    rotationMatrixZXY = {
      {cz*cy-sz*sx*sy,    sz*cy+cz*sx*sy,        -cx*sy },
      {-sz*cx,            cz*cx,                sx,    },
      {cz*sy+sz*sx*cy,    sz*sy-cz*sx*cy,        cx*cy }
    }

    --Multiply matrices
    finalCoordinates = MatrixMul(rotationMatrixZXY, {{local_target_x,local_target_y,local_target_z}})[1]
    --Add rows together (DON'T)
    --finalCoordinates = {outputMatrix[1][1]+outputMatrix[2][1]+outputMatrix[3][1],outputMatrix[2][1]+outputMatrix[2][2]+outputMatrix[2][3],outputMatrix[3][1]+outputMatrix[3][2]+outputMatrix[3][3]}

    target_x = finalCoordinates[1]
    target_y = finalCoordinates[2]
    target_z = finalCoordinates[3]
    output.setNumber(1,finalCoordinates[1])
    output.setNumber(2,finalCoordinates[2])
    output.setNumber(3,finalCoordinates[3])

end

function onDraw()
    centerW = screen.getWidth()/2
    centerH = screen.getHeight()/2
    true_x = current_X + target_x
    true_y = current_X + target_y
    screen.drawMap(true_x, true_y, 1)
    screen.setColor(255,0,0,255)
    screen.drawCircle(centerW, centerH, 4)
    pixelX, pixelY = map.mapToScreen(true_x, true_y, 1, screen.getWidth(), screen.getHeight, current_X, current_y)
    screen.drawLine(centerW,centerH,pixelX,pixelY)

end

--Vector3 Class
function Vec3(x,y,z) return
    {x=x or 0;y=y or 0;z=z or 0;
    add = function(a,b) return Vec3(a.x+b.x, a.y+b.y, a.z+b.z) end;
    sub = function(a,b) return Vec3(a.x-b.x, a.y-b.y, a.z-b.z) end;
    scale = function(a,b) return Vec3(a.x*b, a.y*b, a.z*b) end;
    dot = function(a,b) return (a.x*b.x + a.y*b.y + a.z*b.z) end;
    cross = function(a,b) return Vec3(a.y*b.z-a.z*b.y, a.z*b.x-a.x*b.z, a.x*b.y-a.y*b.x) end;
    len = function(a) return math.sqrt(a:dot(a)) end}
end

MatrixMul = function(m1,m2) --Assuming matrix multiplication is possible
    local r = {}
    for i=1,#m2 do
        r[i] = {}
        for j=1,#m1[1] do
            r[i][j] = 0
            for k=1,#m1 do
                r[i][j] = r[i][j] + m1[k][j] * m2[i][k]
            end
        end
    end
    return r
end
