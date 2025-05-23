-- This work only if you need vorp framework for notify
if Framework == 'vorp' then
    Core = exports.vorp_core:GetCore()
end

function Notify(typeMessage, item)
    -- lib.notify({
    --     title = Config.Notify[typeMessage].title,
    --     description = Config.Notify[typeMessage].description .. item,
    --     type = Config.Notify[typeMessage].typeMessage,
    --     duration = Config.Notify[typeMessage].duration
    -- })
    Core.NotifyObjective(Config.Notify[typeMessage].description .. item, Config.Notify[typeMessage].duration)
end