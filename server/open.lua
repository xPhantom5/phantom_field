Framework = ''

if GetResourceState('vorp_core') == 'started' then
    Framework = 'vorp'
    Core = exports.vorp_core:GetCore()
    
elseif GetResourceState('rsg-core') == 'started' then
    Framework = 'rsg'
    Core = exports['rsg-core']:GetCoreObject()
end

function GetPlayer(source)
    if Framework == 'vorp' then
        return Core.getUser(source)
    elseif Framework == 'rsg' then
        return Core.Functions.GetPlayer(source)
    else
        return nil
    end
end

function AddItem(source, rewardItem, rewardCount)
    if Framework == 'vorp' then
        exports.vorp_inventory:addItem(source, rewardItem, rewardCount)
        Core.NotifyObjective(source, "You receive x" .. rewardCount .. ' ' .. rewardItem, 4000)

    elseif Framework == 'rsg' then
        exports["rsg-inventory"]:AddItem(source, rewardItem, rewardCount)

        TriggerClientEvent('rsg-inventory:client:ItemBox', source, Core.Shared.Items[rewardItem], 'add', rewardCount)
    end
end
