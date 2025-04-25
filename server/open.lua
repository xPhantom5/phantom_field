Framework = ''

if GetResourceState('vorp_core') == 'started' then
    Framework = 'vorp'
    Vorp = exports.vorp_core:GetCore()
    
elseif GetResourceState('rsg-core') == 'started' then
    Framework = 'rsg'
    core = exports['rsg-core']:GetCoreObject()
end

function GetPlayer(source)
    if Framework == 'vorp' then
        return Vorp.getUser(source)
    elseif Framework == 'rsg' then
        return core.Functions.GetPlayer(source)
    else
        return nil
    end
end

function AddItem(source, rewardItem, rewardCount)
    if Framework == 'vorp' then
        exports.vorp_inventory:addItem(source, rewardItem, rewardCount)
    elseif Framework == 'rsg' then
        exports["rsg-inventory"]:AddItem(source, rewardItem, rewardCount)

        TriggerClientEvent('rsg-inventory:client:ItemBox', source, core.Shared.Items[rewardItem], 'add', rewardCount)
    end
end
