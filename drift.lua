-- https://runtime.fivem.net/doc/natives/?_0x29439776AAA00A62
local vehicleClassWhitelist = {0, 1, 2, 3, 4, 5, 6, 7, 9}

local handleMods = {
	{"fInitialDragCoeff", 90.22},
	{"fDriveInertia", .31},
	{"fSteeringLock", 22},
	{"fTractionCurveMax", -1.1},
	{"fTractionCurveMin", -.4},
	{"fTractionCurveLateral", 2.5},
	{"fLowSpeedTractionLossMult", -.57}
}

local ped, vehicle
local driftMode = false
isDrift = false

Citizen.CreateThread( function()
	while true do
		local wait = 1200
		local ped = PlayerPedId()

		if IsPedInAnyVehicle(ped) then
			local vehicle = GetVehiclePedIsIn(ped, false)
			if (GetPedInVehicleSeat(vehicle, -1) == ped) then
				wait = 0			 
				if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") ~= 1 and IsVehicleOnAllWheels(vehicle) and isDrift and IsVehicleClassWhitelisted(GetVehicleClass(vehicle)) then
					--ToggleDrift(vehicle)
				end
				if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") < 90 then
					SetVehicleEnginePowerMultiplier(vehicle, 0.0)
				else
					if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fDriveBiasFront") == 0.0 then
						SetVehicleEnginePowerMultiplier(vehicle, 190.0)
					else
						SetVehicleEnginePowerMultiplier(vehicle, 100.0)
					end
				end
			end
		end
		Wait(wait)
	end
end)

RegisterCommand('toggledrift', function()
	isDrift = not isDrift
	local ped = PlayerPedId()
	local vehicle = GetVehiclePedIsIn(ped, false)
	ToggleDrift(vehicle)
end)

function ToggleDrift(vehicle)
	local modifier = 1
	print(vehicle)
	if GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff") > 90 then
		driftMode = true
	else 
		driftMode = false
	end
	
	if driftMode then
		modifier = -1
	end
	
	for index, value in ipairs(handleMods) do
		SetVehicleHandlingFloat(vehicle, "CHandlingData", value[1], GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]) + value[2] * modifier)
	end
	
	if driftMode then
		
		DrawNotif("Control de tracción activado!")
	else
		
		DrawNotif("Control de tracción desactivado!")
	end
	
end

function DrawNotif(text)
	ESX.ShowNotification(text)
end

function PrintDebugInfo(mode)
	ped = GetPlayerPed(-1)
	local vehicle = GetVehiclePedIsIn(ped, false)
	print(mode)
	for index, value in ipairs(handleMods) do
		print(GetVehicleHandlingFloat(vehicle, "CHandlingData", value[1]))
	end
end

function IsVehicleClassWhitelisted(vehicleClass)
	for index, value in ipairs(vehicleClassWhitelist) do
		if value == vehicleClass then
			return true
		end
	end

	return false
end

