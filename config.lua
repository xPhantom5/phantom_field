Config = {}

Config.Target = {
	enabled = false,
	target = 'rsg'
}

Config.Text = {
	drawTextLabel = 'Press ~e~[G]~q~ to Harvest!',
	targetLabel = 'Harvest',
	progressbarLabel = 'Collecting',
}

Config.Progressbar = 'vorp' -- default (ox_lib) | circle (ox_lib) | vorp (default vorp progressbar)


Config.Notify = {
    no_item = {title = 'Field', description = "You missing the requirement item: ", typeMessage = "error", duration = 4000},
}

Config.Field = {

	['Cotton'] = {
		nameField = 'Cotton',

		Location = vector3(2593.12, -862.24, 42.09),
		
		propFarm = "s_cottonginned01x", farmRadius = 40.0, maxProps = 7,
		
		itemReward = "desert_sage", countReward = 1,

		whitelistJob = {
			enabled = false,
			jobName = 'medic'
		},

		itemRequired = {
			enabled = false,
			itemName = 'bread'
		},

		durationPickup = 5, -- seconds

		targetIcon = 'fa-solid fa-tractor', -- This would work only if you have target eye and want specific icon for the Eye for different fields!

        blip = {
            enabled = true,
            textureHash = -1739686743,
            color = "BLIP_MODIFIER_DEBUG_YELLOW",
            scale = 1.0,
            name = "Cotton Field",
        },
		radiusBlip = {
			enabled = true,
			colourBlip = "BLIP_MODIFIER_DEBUG_RED",
			radius = 50,
		},
		
		disablePvP = true, -- enable pvp mode in the field
	}

}