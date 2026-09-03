-- source: steam id 3524040776 / vehicle.xml block#42
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3524040776
--- START OF FILE -- PYO ANTICAUSAL CAMERA CTRL v5.txt ---

--PYO's Camera Controller vYYYYMMDD (based on FCS CMD v20250505, adjusted)
GN=input.getNumber
GB=input.getBool -- Added for new inputs
SN=output.setNumber
SB=output.setBool
PN=property.getNumber 
M=math
MathAtan=M.atan
MathAbs=M.abs
MathCos=M.cos
MathFlr=M.floor
MathSin=M.sin
MathSq=M.sqrt
Pi=M.pi
P2=M.pi*2

FIXED_ELE_MIN = -0.125 -- -45 degrees in turns
FIXED_ELE_MAX = 0.125  -- +45 degrees in turns

function MathClamp(v,min,max)
	return M.max(M.min(v,max),min)
end

function E2R(e)
	local q,r,s=e[1],e[2],e[3] 
	return {{MathCos(r)*MathCos(s),MathCos(q)*MathCos(r)*MathSin(s)+MathSin(q)*MathSin(r),MathSin(q)*MathCos(r)*MathSin(s)-MathCos(q)*MathSin(r)},{-MathSin(s),MathCos(q)*MathCos(s),MathSin(q)*MathCos(s)},{MathSin(r)*MathCos(s),MathCos(q)*MathSin(r)*MathSin(s)-MathSin(q)*MathCos(r),MathSin(q)*MathSin(r)*MathSin(s)+MathCos(q)*MathCos(r)}}
end

function tM(m)
	local f={{},{},{}}
	for p=1,3 do for j=1,3 do f[p][j]=m[j][p] end end
	return f
end

function Mv(m,u)
	local f={}
	for p=1,3 do e=0 for j=1,3 do e=e+m[j][p]*u[j] end f[p]=e end
	return f
end

function G2L(g_vec)
	return Mv(E2R(HullEu),{g_vec[1],g_vec[2],g_vec[3]})
end

function L2AE(l_vec)
	return MathAtan(l_vec[1],l_vec[2])/P2,MathAtan(l_vec[3],MathSq(l_vec[1]^2+l_vec[2]^2))/P2
end

function L2G(l_vec)
	return Mv(tM(E2R(HullEu)),{l_vec[1],l_vec[2],l_vec[3]})
end

function G2CpsPit(g_vec)
	return MathAtan(g_vec[1],g_vec[2])/P2,MathAtan(g_vec[3],MathSq(g_vec[1]^2+g_vec[2]^2))/P2
end

function Cps2Delta(c,d)
	local c,d=c%1,d%1
	if c-d>0.5 then d=d+1 elseif c-d<-0.5 then d=d-1 end
	return c-d
end

-- Initial states defined globally
HullPos = {0,0,0}
HullEu = {0,0,0} 

camAzimuthLocal = 0     
camElevationLocal = 0   

targetWorldAzimuth = 0  
targetWorldPitch = 0    

prevStabState = false

CAM_SENSITIVITY = 0.001 -- Base manual aiming sensitivity, adjust if needed

-- Zoom related global variables
z = 0.5       -- Initial zoom level (range 0.5 to 32)
zoo = false -- Previous Zoom Out button state
zio = false -- Previous Zoom In button state

function onTick()
	HullPos={GN(1),GN(3),GN(2)} 
	HullEu={GN(4),GN(6),GN(5)} 
	HullCps = GN(17)

	-- Zoom and FOV Calculation
	zi = GB(2) -- Zoom In button state
	zo = GB(3) -- Zoom Out button state
	if zi and not zio then
		z = M.max(z*0.5,0.5)
	end
	if zo and not zoo then
		z = M.min(z*2,32)
	end
	zio, zoo = zi, zo -- Update previous states for next tick

	fov = (2.2-(45.9/z/180)*M.pi)/2.175 -- Calculate FOV
	-- fovd = 45.9/z -- FOV in degrees, if needed elsewhere
	SN(4, fov) -- Output FOV

	-- Read Inputs (New Sources)
	LR = GN(21) -- Left/Right input (-1 to 1 expected)
	UD = GN(22) -- Up/Down input (-1 to 1 expected)
	
	isSlowAimActive = GB(4) -- Slow Aim toggle state (true/false)
	currentStabState = GB(6) -- Stabilizer toggle state (true/false)

	-- Determine dynamic speed factor based on zoom and slow aim state
	if isSlowAimActive then
		dynamicSpeedFactor = 0.2 / z
	else
		dynamicSpeedFactor = 1.0 / z
	end
	effectiveAimRate = dynamicSpeedFactor * CAM_SENSITIVITY

	-- Stabilizer State Transition Logic
	if currentStabState and not prevStabState then
		D = 1 
		localCamDirX = D * MathSin(camAzimuthLocal * P2) * MathCos(camElevationLocal * P2)
		localCamDirY = D * MathCos(camAzimuthLocal * P2) * MathCos(camElevationLocal * P2)
		localCamDirZ = D * MathSin(camElevationLocal * P2)
		localCamVec = {localCamDirX, localCamDirY, localCamDirZ}
		globalCamVec = L2G(localCamVec) 
		raw_target_az, raw_target_el = G2CpsPit(globalCamVec)
		targetWorldAzimuth = raw_target_az 
		targetWorldPitch = MathClamp(Cps2Delta(raw_target_el, 0), FIXED_ELE_MIN, FIXED_ELE_MAX)
	end
	prevStabState = currentStabState

	-- Perform Aiming Logic
	if currentStabState then -- Stabilized Mode
		targetWorldAzimuth = (targetWorldAzimuth + LR * effectiveAimRate) % 1
		targetWorldPitch = targetWorldPitch + UD * effectiveAimRate
		targetWorldPitch = MathClamp(targetWorldPitch, FIXED_ELE_MIN, FIXED_ELE_MAX)

		desiredGlobalDirX = MathSin(targetWorldAzimuth*P2) * MathCos(targetWorldPitch*P2)
		desiredGlobalDirY = MathCos(targetWorldAzimuth*P2) * MathCos(targetWorldPitch*P2)
		desiredGlobalDirZ = MathSin(targetWorldPitch*P2)
		desiredGlobalDir = {desiredGlobalDirX, desiredGlobalDirY, desiredGlobalDirZ}
		desiredLocalDir = G2L(desiredGlobalDir)
		raw_cam_az, raw_cam_el = L2AE(desiredLocalDir) 
		camAzimuthLocal = raw_cam_az 
		camElevationLocal = MathClamp(Cps2Delta(raw_cam_el, 0), FIXED_ELE_MIN, FIXED_ELE_MAX) 
	else -- Manual (Hull-Relative) Mode
		dAz = LR * effectiveAimRate
		camAzimuthLocal = (camAzimuthLocal + dAz) % 1
		
		dEl = UD * effectiveAimRate
		camElevationLocal = MathClamp(camElevationLocal + dEl, FIXED_ELE_MIN, FIXED_ELE_MAX)
	end
	tarAz=Cps2Delta(camAzimuthLocal, 0)
	tarEle=camElevationLocal
	-- Output to camera controls (scaled)
	SN(9, tarAz) -- Azimuth
	SN(10, tarEle)

	-- Output status values
	SN(19, currentStabState and 2 or 1) 
	SN(20, targetWorldAzimuth)
	SN(21, targetWorldPitch)
	SN(22, camAzimuthLocal)
	SN(23, camElevationLocal)  
	onTick_CameraSwitcher()
end
camera_centers = {0.0, 0.25, 0.5, 0.75} 
num_cameras = 4
camera_fov_half_turns = 0.125 -- +/- 45 degrees in turns

function onTick_CameraSwitcher()
    shifted_azimuth = (tarAz + camera_fov_half_turns) % 1.0 
    active_cam_index = MathFlr(shifted_azimuth * num_cameras) + 1 

    -- Deactivate all cameras first (visual state via SB)
    SB(1, false); SB(2, false); SB(3, false); SB(4, false)
    if active_cam_index >= 1 and active_cam_index <= num_cameras then
        SB(active_cam_index, true)
    else
        SB(1, true); active_cam_index = 1 -- Fallback
    end

    -- Calculate and set azimuth outputs for ALL cameras
    az_outputs = {}
    for i = 1, num_cameras do
        delta_to_center = Cps2Delta(tarAz, camera_centers[i])
        
        if i == active_cam_index then
            -- Active camera targets the precise delta
            az_outputs[i] = delta_to_center * 8.0
        else
            -- Inactive cameras aim at their FoV edge closest to the target
            clamped_delta_turns = MathClamp(delta_to_center, -camera_fov_half_turns, camera_fov_half_turns)
            az_outputs[i] = clamped_delta_turns * 8.0
        end
    end

    SN(11, az_outputs[1]) -- Cam 1 Azimuth (Front)
    SN(12, az_outputs[2]) -- Cam 2 Azimuth (Right)
    SN(13, az_outputs[3]) -- Cam 3 Azimuth (Rear)
    SN(14, az_outputs[4]) -- Cam 4 Azimuth (Left)
    
    common_elevation_output = tarEle * 8.0
    SN(15, common_elevation_output) 
    
    SN(16, active_cam_index) 
end