resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

author 'xPhantom Field System'

description 'Field System script for RedM ♾️'

fx_version "adamant"

games {"rdr3"}

rdr3_warning 'I acknowledge that this is a prerelease build of RedM, and I am aware my resources *will* become incompatible once RedM ships.'

server_scripts {
	'config.lua',
	'server/*.lua'
}

shared_scripts {
    '@ox_lib/init.lua',
}

client_scripts {
	'config.lua',
	'client/*.lua'
}

lua54 'yes'
