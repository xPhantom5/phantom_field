local farmProps, currentPlant, isPvPDisabled, inPvPZone = {}, nil, false, false

local jobWhitelisted, props

function setupBlip()
	for _, data in pairs(Config.Field) do

		Core.Functions.GetPlayerData(function(PlayerData)
			jobWhitelisted = PlayerData.job.name
		end)
	
		if data.blip.enabled then
			if data.whitelistJob.enabled then
				if jobWhitelisted == data.whitelistJob.jobName then
					local blip_modifier_hash = GetHashKey(data.blip.color)
		
					blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, data.Location)
		
					SetBlipSprite(blip, data.blip.textureHash, 1)
		
					Citizen.InvokeNative(0x9CB1A1623062F402, blip, "" ..data.blip.name.."" )
		
					Citizen.InvokeNative(0x662D364ABF16DE2F, blip, blip_modifier_hash)
				else
					RemoveBlip(blip)
					resetField()
				end
			else
				local blip_modifier_hash = GetHashKey(data.blip.color)
		
				blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, data.Location)
	
				SetBlipSprite(blip, data.blip.textureHash, 1)
	
				Citizen.InvokeNative(0x9CB1A1623062F402, blip, "" ..data.blip.name.."" )
	
				Citizen.InvokeNative(0x662D364ABF16DE2F, blip, blip_modifier_hash)
			end
		end
	
		if data.radiusBlip.enabled then
			if data.whitelistJob.enabled then
				if jobWhitelisted == data.whitelistJob.jobName then

					blipCircle = Citizen.InvokeNative(0x45f13b7e0a15c880, GetHashKey(data.radiusBlip.colourBlip), data.Location, data.radiusBlip.radius + 0.0)
		
					SetBlipSprite(blipCircle, 1)
				end
			else
				blipCircle = Citizen.InvokeNative(0x45f13b7e0a15c880, GetHashKey(data.radiusBlip.colourBlip), data.Location, data.radiusBlip.radius + 0.0)
		
				SetBlipSprite(blipCircle, 1)
			end
		else
			RemoveBlip(blipCircle)
			resetField()
		end
	end
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		local playerPed = PlayerPedId()
		
		local coords = GetEntityCoords(playerPed)
		
		local letSleep = true

		for k, v in pairs(Config.Field) do
			local LocationV = v.Location
			local distance = Vdist(coords, LocationV.x, LocationV.y, LocationV.z, true)

			if distance < 20.0 then
				currentPlant = k
				break
			end
		end		

		if currentPlant then
			local propFarm = Config.Field[currentPlant].propFarm

			local Location = Config.Field[currentPlant].Location

			local whitelistedJob = Config.Field[currentPlant].whitelistJob.jobName

			Core.Functions.GetPlayerData(function(PlayerData)
				jobWhitelisted = PlayerData.job.name
			end)
			
			posX, posY, Z, heading = Location.x+math.random(-10,10), Location.y+math.random(-10,10), Location.z+999.0, math.random(0,359)+.0

			ground,posZ = GetGroundZAndNormalFor_3dCoord(posX+.0,posY+.0,Z,1)

			if Vdist(coords, Location.x, Location.y,Location.z, false) < 20 then
				letSleep = false

				if Config.Field[currentPlant].disablePvP ~= isPvPDisabled then
					DisablePvP(Config.Field[currentPlant].disablePvP)
				end
				
				if Config.Field[currentPlant]. whitelistJob.enabled then
					if jobWhitelisted == whitelistedJob then
						if ground then
							if #farmProps < Config.Field[currentPlant].maxProps then
								props = CreateObject(propFarm, posX, posY, posZ, false, true, false)

								NetworkRegisterEntityAsNetworked(props)

								coordsProps = GetEntityCoords(props, true)
								
								PlaceObjectOnGroundProperly(props)
							
								FreezeEntityPosition(props, true)
							
								table.insert(farmProps, props)
							end
						end
					end
				else
					if ground then
						if #farmProps < Config.Field[currentPlant].maxProps then
							props = CreateObject(propFarm, posX, posY, posZ, false, true, false)

							NetworkRegisterEntityAsNetworked(props)

							coordsProps = GetEntityCoords(props, true)
							
							PlaceObjectOnGroundProperly(props)
						
							FreezeEntityPosition(props, true)
						
							table.insert(farmProps, props)
						end
					end
				end
			else
				for _,v in pairs(farmProps) do
					Citizen.Wait(100)
					DeleteObject(v)
				end
				
				farmProps ={}
			end
		end	

		if letSleep then
			Citizen.Wait(400)
		end
	end
end)

function DisablePvP(state)
    if state == isPvPDisabled and inPvPZone == state then return end
    
    isPvPDisabled = state
    inPvPZone = state
    
    if state then
        Citizen.InvokeNative(0xF808475FA571D823, false)
        SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
        NetworkSetFriendlyFireOption(false)
        
        CreateThread(function()
            while inPvPZone do
                DisableControlAction(0, `INPUT_MELEE_ATTACK`, true)
                DisableControlAction(0, `INPUT_MELEE_GRAPPLE`, true)
                DisableControlAction(0, `INPUT_MELEE_GRAPPLE_CHOKE`, true)
                DisableControlAction(0, `INPUT_ATTACK`, true)
                DisableControlAction(0, `INPUT_AIM`, true)
                Wait(0)
            end
        end)
    else
        Citizen.InvokeNative(0xF808475FA571D823, true)
        SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
        NetworkSetFriendlyFireOption(true)
    end
end



function progressBar(duration,v, k)
	RequestAnimDict("mech_pickup@treasure@rock_pile")

	while not HasAnimDictLoaded("mech_pickup@treasure@rock_pile") do
		Wait(100)
	end	

	TaskPlayAnim(PlayerPedId(), 'mech_pickup@treasure@rock_pile', "pickup", 3.0, -8, duration, 1, 0, 0, 0, 0 )

	if lib.progressCircle({
		duration = duration,
		position = 'bottom',
		label = Config.Text.progressbarLabel .. " " .. Config.Field[currentPlant].nameField,
		useWhileDead = false,
		canCancel = false,
		disable = {
			car = true,
			move = true,
			combat = true,
			sprint = true,
			mouse = true,
		},
	})
	then
		DeleteObject(v)
	
		table.remove(farmProps, k)
		
		for k,field in pairs(Config.Field) do
			TriggerServerEvent("ip_field:getReward",k)
		end
	else
		print('Do stuff when cancelled')
	end		

end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		local letSleep = true
		
		local playerPed = PlayerPedId()
		
		local coords = GetEntityCoords(playerPed)
	
		for k,v in pairs(farmProps) do
			local currentCoords = GetEntityCoords(v)
			
			if #(coords - currentCoords) < 2.5 then
				letSleep = false
				duration = Config.Field[currentPlant].durationPickup * 1000
				if not Config.Target.enabled then
				-- if IsPedOnFoot(playerPed) then
					DrawText3D(currentCoords.x, currentCoords.y, currentCoords.z, Config.Text.drawTextLabel)
					if IsControlJustReleased(0, 0x760A9C6F) then
						if Config.Field[currentPlant].itemRequired.enabled then
							if Core.Functions.HasItem(Config.Field[currentPlant].itemRequired.itemName, 1) then
								progressBar(duration,v,k)
							end
						else
							progressBar(duration,v,k)
						end
					end
				else
					exports["rsg-target"]:AddTargetEntity(v, {
						options = {
							{
								type = "client",
								label = Config.Text.targetLabel .. " " .. Config.Field[currentPlant].nameField,
								icon = Config.Field[currentPlant].targetIcon,
								action = function()
									if Config.Field[currentPlant].itemRequired.enabled then
										if Core.Functions.HasItem(Config.Field[currentPlant].itemRequired.itemName, 1) then
											progressBar(duration,v,k)
										end
									else
										progressBar(duration,v,k)
									end
								end
							}
						},
						distance = 2.5
					})
				end
			end
		end
		
		if letSleep then
			Citizen.Wait(1000)
		end
	end
end)

function resetField()
	if #farmProps > 0 then
		for _, v in pairs(farmProps) do
			DeleteObject(v)
		end
		farmProps = {}
	end
	RemoveBlip(blip)
	RemoveBlip(blipCircle)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		resetField()
	end
end)
AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		setupBlip()
	end
end)

function DrawText3D(x, y, z, text)
	local onScreen, screenX, screenY = GetScreenCoordFromWorldCoord(x, y, z)
	SetTextScale(0.35, 0.35)
	SetTextFontForCurrentCommand(1)
	SetTextColor(255, 255, 255, 223)
	SetTextCentre(1)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), screenX, screenY)
end

RegisterNetEvent('RSGCore:Client:OnJobUpdate', function()
    setupBlip()
end)