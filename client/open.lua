Framework = ''

if GetResourceState('vorp_core') == 'started' then
    Framework = 'vorp'
    Core = exports.vorp_core:GetCore()
    
elseif GetResourceState('rsg-core') == 'started' then
    Framework = 'rsg'
    Core = exports['rsg-core']:GetCoreObject()
end
