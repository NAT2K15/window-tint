local display = false

RegisterCommand("tint", function()
    local perms = true
    if(config.useFramework.enabled) then
        if(config.useFramework.checkPerm()) then
            perms = true
        else
            perms = false
        end
    end
    if(perms and not display) then
        local ped = PlayerPedId()
        local playerPos = GetEntityCoords(ped)
        local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(ped, 0.0, 5.0, 0.0 )
        local vehicle;
        
        if IsPedInAnyVehicle(ped, false) then
            vehicle = GetVehiclePedIsIn(ped, false)
        elseif GetVehicleInDirection(playerPos, inFrontOfPlayer) then
            vehicle = GetVehicleInDirection(playerPos, inFrontOfPlayer)
        end

        if vehicle > 0 then
            local tint = GetVehicleWindowTint(vehicle)
            local text = config.windowsTints[tonumber(tint)]
            SetNuiFocus(true, true)
            SendNUIMessage({
                type = "ui",
                tint = text,
            })
            display = true
        else 
            TriggerEvent('chat:addMessage', {color = {255, 0, 0}, multiline = true, args = {"Window Tint", "You are not in a vehicle or near a vehicle."}})
        end
    else 
        TriggerEvent('chat:addMessage', {color = {255, 0, 0}, multiline = true, args = {"Window Tint", "You do not have permission to use this command."}})
    end
end)

function GetVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed(-1), 0)
    local _, _, _, _, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end

RegisterNUICallback('exit', function()
    SetNuiFocus(false, false)
    display = false
end)