Config = {}

Config.Target = {
	enabled = true,
	target = 'rsg'
}

Config.Text = {
	drawTextLabel = 'Press ~e~[G]~q~ to Harvest!',
	targetLabel = 'Harvest',
	progressbarLabel = 'Collecting',
}

Config.Field = {

	['Cotton'] = {
		nameField = 'Cotton',

		Location = vector3(2593.12, -862.24, 42.09),
		
		propFarm = "s_cottonginned01x", farmRadius = 40.0, maxProps = 7,
		
		itemReward = "desert_sage", countReward = 1,

		whitelistJob = {
			enabled = true,
			jobName = 'medic'
		},

		itemRequired = {
			enabled = true,
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