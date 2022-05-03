_menuPool = NativeUI.CreatePool()
mainMenu = NativeUI.CreateMenu("Car spawn", "~b~Vehicle Spawner")
_menuPool:Add(mainMenu)

function FirstItem(menu)  
    local submenu = _menuPool:AddSubMenu(menu, "~b~Department of Transportation") 
    local carItem101 = NativeUI.CreateItem("Ford F-150 DOT", "Spawn A DOT Vehicle")
    carItem101.Activated = function(sender, item)
         if item == carItem101 then
             spawnCar("st150")
         end
    end
    submenu:AddItem(carItem101)
end

FirstItem(mainMenu)
_menuPool:RefreshIndex()

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        _menuPool:ProcessMenus()
        --[[ The "F5" button will activate the menu ]]
        if IsControlJustPressed(1, 166) then
            mainMenu:Visible(not mainMenu:Visible())
        end
    end
end)






function notify(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(true, true)
end


function spawnCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(50)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, x + 2, y + 2, z + 1, GetEntityHeading(PlayerPedId()), true, false)
    SetPedIntoVehicle(PlayerPedId(), vehicle, -1)
    
    SetEntityAsNoLongerNeeded(vehicle)
    SetModelAsNoLongerNeeded(vehicleName)
    
end
