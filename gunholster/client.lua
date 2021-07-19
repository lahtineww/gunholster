print 'Fegge#7703'
print 'https://github.com/lahtineww'


local holsterissa = true
local blokattu = false
local playerData = {}


Citizen.CreateThread(function()
    while true do
        local idleeee = 100
        if not IsPedInAnyVehicle(PlayerPedId(), false) then
            if GetPedDrawableVariation(PlayerPedId(),8) == 130 then
                if checkWeapon(PlayerPedId()) then
                    loadAnim()
                    if holsterissa then
                        idleeee = 1
                        blokattu = true
                        blocking()
                        SetPedCurrentWeaponVisible(PlayerPedId(), false, true, true, true)
                        TaskPlayAnim(PlayerPedId(), "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                        Citizen.Wait(1700)
                        SetPedCurrentWeaponVisible(PlayerPedId(), true, true, true, true)
                        TaskPlayAnim(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
                        Citizen.Wait(400)
                        ClearPedTasks(PlayerPedId())
                        holsterissa = false
                        removeAnim()
                    else
                        blokattu = false
                    end
                else
                    if not holsterissa then
                        TaskPlayAnim(PlayerPedId(), "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0)
                        Citizen.Wait(500)
                        TaskPlayAnim(PlayerPedId(), "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0)
                        Citizen.Wait(60)
                        ClearPedTasks(PlayerPedId())
                        holsterissa = true
                        removeAnim()
                    end
                end
            else
                if checkWeapon(PlayerPedId()) then
                    RequestAnimDict("reaction@intimidation@1h")
                    while not HasAnimDictLoaded("reaction@intimidation@1h") do
                        Wait(1)
                    end
                    if holsterissa then
                        blokattu = true
                        SetPedCurrentWeaponVisible(PlayerPedId(), false, true, true , true)
                        TaskPlayAnim(PlayerPedId(), "reaction@intimidation@1h", "intro", 5.0, 1.0, -1, 50, 0, 0, 0, 0)
                        Citizen.Wait(1250)
                        SetPedCurrentWeaponVisible(PlayerPedId(), true, true, true, true)
                        Citizen.Wait(1700)
                        ClearPedTasks(PlayerPedId())
                        holsterissa = false
                        RemoveAnimDict("reaction@intimidation@1h")
                    else
                        blokattu = false
                    end
                else
                    if not holsterissa then
                        TaskPlayAnim(PlayerPedId(), "reaction@intimidation@1h", "outro", 8.0, 3.0, -1, 50, 0, 0, 0.125, 0 )
                        Citizen.Wait(1700)
                        ClearPedTasks(PlayerPedId())
                        holsterissa = true
                        RemoveAnimDict("reaction@intimidation@1h")
                    end
                end
            end
        else
            holsterissa = true
        end
        Citizen.Wait(idleeee)
    end
end)





function blocking()
    Citizen.CreateThread(function()
        local tapa_treadi = GetIdOfThisThread()
        while blokattu do
            DisableControlAction(1, 25, true )
            DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
            DisableControlAction(1, 23, true)
            DisableControlAction(1, 37, true)
            DisablePlayerFiring(PlayerPedId(), true)
            Citizen.Wait(1)
        end
        TerminateThread(tapa_treadi)
    end)
end

function loadAnim()
    RequestAnimDict('rcmjosh4')
    RequestAnimDict('reaction@intimidation@cop@unarmed')
    RequestAnimSet('intro')
    RequestAnimSet('josh_leadout_cop2')
    RequestAnimSet('outro')
    while not HasAnimDictLoaded('rcmjosh4') and not HasAnimDictLoaded('reaction@intimidation@cop@unarmed') do
        Wait(1)
    end
end

function removeAnim()
    RemoveAnimDict('rcmjosh4')
    RemoveAnimDict('reaction@intimidation@cop@unarmed')
    RemoveAnimSet('intro')
    RemoveAnimSet('josh_leadout_cop2')
    RemoveAnimSet('outro')
end

function checkWeapon(ped)
	if not IsEntityDead(ped) then
		for i = 1, #Config.Aseet do
			if GetHashKey(Config.Aseet[i]) == GetSelectedPedWeapon(ped) then
				return true
			end
		end
    end
    return false
end