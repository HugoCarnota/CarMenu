local disableShuffle = true
function disablec_conducir(flag)
	disableShuffle = flag
end

Citizen.CreateThread(function()
	while true do
        Citizen.Wait(10)
        local ped = PlayerPedId()
		if IsPedInAnyVehicle(ped, false) and disableShuffle then
			if GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), 0) == ped then
				if GetIsTaskActive(ped, 165) then
					SetPedIntoVehicle(ped, GetVehiclePedIsIn(ped, false), 0)
				end
			end
		else
            Citizen.Wait(500)
        end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000)
        Citizen.Wait(10)
        ClearAreaOfPeds(-552.17, 831.21, 197.88, 50.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(-1133.7, -1993.8, 13.17, 300.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(-1193.63, -2027.8, 13.74, 300.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(327.16, -2033.87, 20.94, 300.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(1986.79, 3049.21, 47.22, 300.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(526.49, -3188.99, 6.07, 200.0, 1) --merry
        Citizen.Wait(10)
        ClearAreaOfPeds(971.83, -122.62, 74.35, 50.0, 1)
        Citizen.Wait(10)
        ClearAreaOfPeds(-555.5, 284.88, 82.18, 50.0, 1)--Tequilla       
        Citizen.Wait(100)
        ClearAreaOfVehicles(-1193.12, -2024.96, 14.76, 300.0, true, false, false, false, false)
        Citizen.Wait(100)
        ClearAreaOfVehicles(-1135.75, -1993.47, 13.18, 300.0, true, false, false, false, false)
        Citizen.Wait(100)
        ClearAreaOfVehicles(-260.75, 6403.48, 31.03, 300.0, true, false, false, false, false)
        Citizen.Wait(100)
        ClearAreaOfVehicles(182.95, 6608.38, 31.85, 100.0, true, false, false, false, false)
        Citizen.Wait(100)
        ClearAreaOfVehicles(1224.72, 2709.43, 38.01, 15.0, true, false, false, false, false)
    end
end)

RegisterNetEvent("c_conducir")
AddEventHandler("c_conducir", function()
	if IsPedInAnyVehicle(PlayerPedId(), false) then
		disablec_conducir(false)
		Citizen.Wait(10000)
		disablec_conducir(true)
	else
		CancelEvent()
	end
end)

RegisterCommand("conducir", function(source, args, raw)
	TriggerEvent("c_conducir")
end, false)

RegisterCommand("maletero", function(source, args, raw)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 5

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification("[Vehículo] ~g~Maletero cerrado.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification("[Vehículo] ~g~Maletero abierto.")
        end
    else
        if distanceToVeh < 6 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification("[Vehículo] ~g~Maletero cerrado.")
            else
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification("[Vehículo] ~g~Maletero abierto.")
            end
        else
            ESX.ShowNotification("[Vehículo] ~y~Muy lejos del vehículo.")
        end
    end
end)

RegisterCommand("capo", function(source, args, raw)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    local door = 4

    if IsPedInAnyVehicle(ped, false) then
        if GetVehicleDoorAngleRatio(veh, door) > 0 then
            SetVehicleDoorShut(veh, door, false)
            ESX.ShowNotification("[Vehículo] ~g~Capó cerrado.")
        else	
            SetVehicleDoorOpen(veh, door, false, false)
            ESX.ShowNotification("[Vehículo] ~g~Capó abierto.")
        end
    else
        if distanceToVeh < 4 then
            if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                SetVehicleDoorShut(vehLast, door, false)
                ESX.ShowNotification("[Vehículo] ~g~Capó cerrado.")
            else	
                SetVehicleDoorOpen(vehLast, door, false, false)
                ESX.ShowNotification("[Vehículo] ~g~Capó abierto.")
            end
        else
            ESX.ShowNotification("[Vehículo] ~y~Muy lejos del vehículo.")
        end
    end
end)

RegisterCommand("puerta", function(source, args, raw)
    local ped = PlayerPedId()
    local veh = GetVehiclePedIsUsing(ped)
    local vehLast = GetPlayersLastVehicle()
    local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(ped), GetEntityCoords(vehLast), 1)
    
    if args[1] == "1" then
        door = 0
    elseif args[1] == "2" then
        door = 1
    elseif args[1] == "3" then
        door = 2
    elseif args[1] == "4" then
        door = 3
    elseif args[1] == "5" then
        door = 4
    elseif args[1] == "6" then
        door = 5
    else
        door = nil
        ESX.ShowNotification("Uso: ~n~~b~/puerta [1,2,3,4]")
        ESX.ShowNotification("~y~Puertas:")
        ESX.ShowNotification("1(Delantera izquierda), 2(Delantera derecha)")
        ESX.ShowNotification("3(Trasera izquierda), 4(Trasera derecha)")
    end

    if door ~= nil then
        if IsPedInAnyVehicle(ped, false) then
            if GetVehicleDoorAngleRatio(veh, door) > 0 then
                SetVehicleDoorShut(veh, door, false)
                TriggerEvent("^*[Vehículo] ~g~Puerta cerrada.")
            else	
                SetVehicleDoorOpen(veh, door, false, false)
                TriggerEvent("^*[Vehículo] ~g~Puerta abierta.")
            end
        else
            if distanceToVeh < 4 then
                if GetVehicleDoorAngleRatio(vehLast, door) > 0 then
                    SetVehicleDoorShut(vehLast, door, false)
                    TriggerEvent("[Vehículo] ~g~Puerta cerrada.")
                else	
                    SetVehicleDoorOpen(vehLast, door, false, false)
                    TriggerEvent("[Vehículo] ~g~Puerta abierta.")
                end
            else
                TriggerEvent("[Vehículo] ~y~Muy lejos del vehículo.")
            end
        end
    end
end)


-- false no se enciende cuando te vuelves a montar, true cada vez que te montes se enciende solo si estaba apagado
OnAtEnter = true

local vehicles = {}; RPWorking = true

RegisterNetEvent('EngineToggle:Engine')
AddEventHandler('EngineToggle:Engine', function()
    if IsPedInAnyVehicle(PlayerPedId(), false) then 
        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
		if (GetPedInVehicleSeat(veh, -1) == PlayerPedId()) then
             print(veh)
             print( GetIsVehicleEngineRunning(veh))
            if GetIsVehicleEngineRunning(veh) == false then
                SetVehicleEngineOn(veh, true, true, false)
				SetVehicleJetEngineOn(veh, true)
				ESX.ShowNotification("Motor ~g~encendido")
			else
                SetVehicleEngineOn(veh, false, true, true)
				SetVehicleJetEngineOn(veh, false)
				ESX.ShowNotification("Motor ~r~apagado")
			end
		end 
    end 
end)


RegisterCommand("motor", function(Source, Arguments, RawCommand)
	if #Arguments == 0 then
		TriggerEvent('EngineToggle:Engine', Source)
	end
end, false)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        if IsControlJustPressed(0, 244) then
            if IsPedInAnyVehicle(ped, false) then
                OpenVehiclesMenu()
            end
        end
    end
end)

function OpenVehiclesMenu()
    local elements = {
        {label = "Encender/Apagar Motor", value = 'motor'},
        {label = "Puerta Delantera Izquierda", value = 'puerta1'},
        {label = "Puerta Delantera Derecha", value = 'puerta2'},
        {label = "Puerta Trasera Izquierda", value = 'puerta3'},
        {label = "Puerta Trasera Derecha", value = 'puerta4'},
        {label = "Maletero", value = 'maletero'},
        {label = "Capo", value = 'capo'},
        {label = "Activar/Desactivar Drift", value = 'drift'},
        {label = "Opciones de Carrera", value = 'race'},
    }

    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehiclesmenu', {
        title    = "Control del Vehículo",
        align    = 'right',
        elements = elements
    }, function(data, menu)

        if data.current.value == 'motor' then
            ExecuteCommand('motor')
        elseif data.current.value == 'puerta1' then
            ExecuteCommand('puerta 1')
        elseif data.current.value == 'puerta2' then
            ExecuteCommand('puerta 2')
        elseif data.current.value == 'puerta3' then
            ExecuteCommand('puerta 3')
        elseif data.current.value == 'puerta4' then
            ExecuteCommand('puerta 4')
        elseif data.current.value == 'maletero' then
            ExecuteCommand('maletero')
        elseif data.current.value == 'capo' then
            ExecuteCommand('capo')
        elseif data.current.value == 'drift' then
            ExecuteCommand('toggledrift')
        elseif data.current.value == 'race' then
            OpenRaceOptions()
        end
    end, function(data, menu)
        menu.close()
    end)
end

OpenRaceOptions = function()
    local elements = {
        {label = "Crear Carrera", value = 'createRace'},
        {label = "Empezar Carrera", value = 'startRace'},
        {label = "Limpiar Puntos Carrera", value = 'clearRacePoints'},
        {label = "Abandonar Carrera", value = 'leaveRace'},
    }

    ESX.UI.Menu.CloseAll()
    
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehiclesmenu', {
        title    = "Opciones de Carrera",
        align    = 'right',
        elements = elements
    }, function(data, menu)
        local ApuestaCarrera = 100
        if data.current.value == 'createRace' then
            ExecuteCommand('carrera crear')
            ESX.ShowNotification("Abre el mapa y selecciona los puntos de ruta, una vez acabes vuelve a este menú.")
            menu.close()
        elseif data.current.value == 'startRace' then
            ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), "race_menu", {
                ["title"] = "Introduce la apuesta."
            }, function(menuData, menuHandle)
                local apuesta = menuData["value"]
                ApuestaCarrera = tonumber(apuesta)
                ExecuteCommand('carrera empezar '..ApuestaCarrera..' 30')
                ESX.UI.Menu.CloseAll()
            end, function(menuData, menuHandle)
                menuHandle.close()
            end)
            
        elseif data.current.value == 'clearRacePoints' then
            ExecuteCommand('carrera limpiar')
        elseif data.current.value == 'leaveRace' then
            ExecuteCommand('carrera abandonar')
        end
    end, function(data, menu)
        menu.close()
    end)
end