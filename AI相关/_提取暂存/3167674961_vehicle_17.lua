-- source: steam id 3167674961 / vehicle.xml block#17
-- url: https://steamcommunity.com/sharedfiles/filedetails/?id=3167674961
positionCharacter = 1
positionWeaponData = 1
chars = {}

function onTick()

    --Input data from properties
    name = property.getText("Name")
    type = property.getNumber("Type")
    subtype = property.getNumber("Subtype")

    --Input weapon data from properties
    weaponProperties = {property.getNumber("Radar FOV Launch Horizontal"),property.getNumber("Radar FOV Launch Vertical"),property.getNumber("Minimum Range (m)"),property.getNumber("Maximum Range (m)")}
	
    --Iterate through characters
    positionCharacter = (positionCharacter % name:len()) + 1

    --ASCII representation of character in name at "position" set to 3 character length.
    asciiCharString = string.format("%03d",string.byte(string.sub(name,positionCharacter,positionCharacter)))

    --Position of ASCII representation at "position" set to 2 character length (max 99 characters)
    positionString = string.format("%02d",tostring(positionCharacter))

    --Type and subtype to string
	typeString = tostring(math.floor(type))..tostring(math.floor(subtype))
    
    --[[
        Output EHCS data
        Position 1: Main Type
        Position 2: Subtype
        Positions 3-5: ASCII Character
        Positions 6-7: Character position
    ]]
    output.setNumber(32,tonumber(typeString..asciiCharString..positionString))

    --Iterate through weapon data
    positionWeaponData = (positionWeaponData%4)+1

    --Output current weapon property
    output.setNumber(31,tonumber(positionWeaponData..weaponProperties[positionWeaponData])+0)

    
end