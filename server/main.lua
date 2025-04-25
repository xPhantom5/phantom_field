RegisterServerEvent('ip_field:getReward')
AddEventHandler('ip_field:getReward',function(keyItem)
	
    local Player = GetPlayer(source)
	
	local currentItem = Config.Field[keyItem]
	
	local rewardItem  = currentItem.itemReward
	
	local rewardCount = currentItem.countReward
	
	if currentItem then
		AddItem(source,rewardItem,rewardCount)
	end
end)
