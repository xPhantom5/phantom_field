CreateThread(function()
    local resource = GetCurrentResourceName()
    if resource ~= 'phantom_field' then
        print("^1[ERROR] Unable to start: The script name must be 'phantom_field'.^0")
        print("^2[phantom_field] Stopping resource...^0")

        StopResource(resource)
        return
    end

    while not Core do
        Wait(100)
    end

end)


RegisterServerEvent('phantom_field:getReward')
AddEventHandler('phantom_field:getReward',function(keyItem)
	local currentItem = Config.Field[keyItem]
	
	if currentItem then
		AddItem(source, Config.Field[keyItem].itemReward, Config.Field[keyItem].countReward)
	end
end)

lib.callback.register("phantom_field:GetJob", function(source)
    local Character = Core.getUser(source).getUsedCharacter
    local job = Character.job
    return job
end)

lib.callback.register("phantom_field:hasItem", function(source)
    local result = exports.vorp_inventory:getItem(source, 'Agarita')
    return result
end)