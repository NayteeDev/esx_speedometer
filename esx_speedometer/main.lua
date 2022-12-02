local cruiser

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
		local sleep = true
        local vehicle = GetVehiclePedIsIn(ped, false)
		if IsPedInAnyVehicle(ped, false) then
			local speed = GetEntitySpeed(vehicle) * 3.6 -- Value in KM/H
            local health = GetVehicleEngineHealth(vehicle)
            local fuel = GetVehicleFuelLevel(vehicle)
            if GetIsVehicleEngineRunning(vehicle) and IsControlJustPressed(1, 243) and GetPedInVehicleSeat(vehicle, player) then
                if cruiser == 'on' then
                    cruiser = 'off'
                    SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDriveMaxFlatVel"))
                else
                    cruiser = 'on'
                    SetEntityMaxSpeed(vehicle, speed)
                end
            end
            -- Send all the data to the NUI browser.
            SendNUIMessage({
				isInCoche = vehicle;
				speed = speed;
                vidatexto = math.floor(health + 0.5)
				fueltexto = math.floor(fuel + 0.5),
			})
            sleep = false
		else
			SendNUIMessage({
				isInCoche = vehicle;
			})
		end
		if sleep then Citizen.Wait(1200) end
	end
end)
