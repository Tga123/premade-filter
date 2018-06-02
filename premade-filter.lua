local _, L = ...;

function T(str)
	return L[str];
end

-- key binding interface constants
BINDING_HEADER_PREMADEFILTER = "Premade Filter"
BINDING_NAME_PREMADEFILTER_SEARCH = "Trigger background search"

MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES = 1000;
LFG_LIST_FRESH_FONT_COLOR = { r=0.3, g=0.9, b=0.3 };

local COLOR_RESET	= "|r"
local COLOR_WHITE	= "|cffffffff"
local COLOR_GRAY	= "|cffbbbbbb"
local COLOR_BLUE	= "|cff88ccff"
local COLOR_GREEN	= "|cff88ff88"
local COLOR_YELLOW	= "|cffffff66"
local COLOR_ORANGE	= "|cffffaa66"
local COLOR_RED		= "|cffff6666"

table.insert(UIChildWindows, "PremadeFilter_Frame");

local PremadeFilter_DefaultSettings = {
	Version				= GetAddOnMetadata("premade-filter", "Version"),
	MaxRecentWords		= 10,
	UpdateInterval		= 15,
	ChatNotifications	= nil,
	NewGroupChatNotifications	= true,
	NewPlayerChatNotifications	= true,
	SoundNotifications	= true,
}

local PremadeFilter_ActivityInfo = {
	
	
	--Classic
	["3-0-9"]		= { tier = 1, instance = 1, raid = true }, --Molten Core
	["3-0-293"]		= { tier = 1, instance = 2, raid = true }, --Blackwing Lair
	["3-0-294"]		= { tier = 1, instance = 3, raid = true }, --Ruins of Ahn'Qiraj
	["3-0-295"]		= { tier = 1, instance = 4, raid = true }, --Temple of Ahn'Qiraj
	
	
	--BC
	["3-0-45"]		= { tier = 2, instance = 1, raid = true }, --Karazhan
	["3-0-296"]		= { tier = 2, instance = 2, raid = true }, --Gruul's Lair 
	["3-0-297"]		= { tier = 2, instance = 3, raid = true }, --Magtheridon's Lair
	["3-0-298"]		= { tier = 2, instance = 4, raid = true }, --Serpentshrine Cavern
	["3-0-299"]		= { tier = 2, instance = 5, raid = true }, --Tempest Keep
	["3-0-300"]		= { tier = 2, instance = 7, raid = true }, --Black Temple
	["3-0-301"]		= { tier = 2, instance = 8, raid = true }, --Sunwell Plateau
	
	
	--WotLK
	["3-16-43"]		= { tier = 3, instance = 2, raid = true, difficulty = 3 }, --Naxxramas 10
	["3-16-44"]		= { tier = 3, instance = 2, raid = true, difficulty = 4 }, --Naxxramas 25
	
	["3-72-302"]	= { tier = 3, instance = 5, raid = true, difficulty = 3 }, --Ulduar 10
	["3-72-303"]	= { tier = 3, instance = 5, raid = true, difficulty = 4 }, --Ulduar 25
	
	["3-73-304"]	= { tier = 3, instance = 6, raid = true, difficulty = 3 }, --Trial of the Crusader Normal 10
	["3-73-305"]	= { tier = 3, instance = 6, raid = true, difficulty = 5 }, --Trial of the Crusader Heroic 10
	["3-73-306"]	= { tier = 3, instance = 6, raid = true, difficulty = 4 }, --Trial of the Crusader Normal 25
	["3-73-307"]	= { tier = 3, instance = 6, raid = true, difficulty = 6 }, --Trial of the Crusader Heroic 25
	
	["3-17-46"]		= { tier = 3, instance = 8, raid = true, difficulty = 3 }, --Icecrown Citadel Normal 10
	["3-17-47"]		= { tier = 3, instance = 8, raid = true, difficulty = 5 }, --Icecrown Citadel Heroic 10
	["3-17-48"]		= { tier = 3, instance = 8, raid = true, difficulty = 4 }, --Icecrown Citadel Normal 25
	["3-17-49"]		= { tier = 3, instance = 8, raid = true, difficulty = 6 }, --Icecrown Citadel Heroic 25
	
	["3-74-308"]	= { tier = 3, instance = 9, raid = true, difficulty = 3 }, --The Ruby Sanctum Normal 10
	["3-74-309"]	= { tier = 3, instance = 9, raid = true, difficulty = 5 }, --The Ruby Sanctum Heroic 10
	["3-74-310"]	= { tier = 3, instance = 9, raid = true, difficulty = 4 }, --The Ruby Sanctum Normal 25
	["3-74-311"]	= { tier = 3, instance = 9, raid = true, difficulty = 6 }, --The Ruby Sanctum Heroic 25
	
	
	--Cataclysm
	["3-76-319"]	= { tier = 4, instance = 2, raid = true, difficulty = 3 }, --The Bastion of Twilight Normal 10
	["3-76-322"]	= { tier = 4, instance = 2, raid = true, difficulty = 4 }, --The Bastion of Twilight Normal 25
	["3-76-320"]	= { tier = 4, instance = 2, raid = true, difficulty = 5 }, --The Bastion of Twilight Heroic 10
	["3-76-321"]	= { tier = 4, instance = 2, raid = true, difficulty = 6 }, --The Bastion of Twilight Heroic 25
	
	["3-75-313"]	= { tier = 4, instance = 3, raid = true, difficulty = 3 }, --Blackwing Descent Normal 10
	["3-75-316"]	= { tier = 4, instance = 3, raid = true, difficulty = 4 }, --Blackwing Descent Normal 25
	["3-75-317"]	= { tier = 4, instance = 3, raid = true, difficulty = 5 }, --Blackwing Descent Heroic 10
	["3-75-318"]	= { tier = 4, instance = 3, raid = true, difficulty = 6 }, --Blackwing Descent Heroic 25
	
	["3-77-323"]	= { tier = 4, instance = 4, raid = true, difficulty = 3 }, --Throne of the Four Winds Normal 10
	["3-77-326"]	= { tier = 4, instance = 4, raid = true, difficulty = 4 }, --Throne of the Four Winds Normal 25
	["3-77-324"]	= { tier = 4, instance = 4, raid = true, difficulty = 5 }, --Throne of the Four Winds Heroic 10
	["3-77-325"]	= { tier = 4, instance = 4, raid = true, difficulty = 6 }, --Throne of the Four Winds Heroic 25
	
	["3-78-327"]	= { tier = 4, instance = 5, raid = true, difficulty = 3 }, --Firelands Normal 10
	["3-78-329"]	= { tier = 4, instance = 5, raid = true, difficulty = 4 }, --Firelands Normal 25
	["3-78-328"]	= { tier = 4, instance = 5, raid = true, difficulty = 5 }, --Firelands Heroic 10
	["3-78-330"]	= { tier = 4, instance = 5, raid = true, difficulty = 6 }, --Firelands Heroic 25
	
	["3-79-331"]	= { tier = 4, instance = 6, raid = true, difficulty = 3 }, --Dragon Soul Normal 10
	["3-79-332"]	= { tier = 4, instance = 6, raid = true, difficulty = 5 }, --Dragon Soul Heroic 10
	["3-79-333"]	= { tier = 4, instance = 6, raid = true, difficulty = 6 }, --Dragon Soul Heroic 25
	["3-79-334"]	= { tier = 4, instance = 6, raid = true, difficulty = 4 }, --Dragon Soul Normal 25
	
	
	--MoP
	["3-0-397"]		= { tier = 5, instance = 1, raid = true }, --Outdoor MoP
	
	["3-80-335"]	= { tier = 5, instance = 2, raid = true, difficulty = 3 }, --Mogu'shan Vaults Normal 10
	["3-80-336"]	= { tier = 5, instance = 2, raid = true, difficulty = 5 }, --Mogu'shan Vaults Heroic 10
	["3-80-337"]	= { tier = 5, instance = 2, raid = true, difficulty = 4 }, --Mogu'shan Vaults Normal 25
	["3-80-338"]	= { tier = 5, instance = 2, raid = true, difficulty = 6 }, --Mogu'shan Vaults Heroic 25
	
	["3-81-339"]	= { tier = 5, instance = 3, raid = true, difficulty = 3 }, --Heart of Fear Normal 10
	["3-81-340"]	= { tier = 5, instance = 3, raid = true, difficulty = 5 }, --Heart of Fear Heroic 10
	["3-81-341"]	= { tier = 5, instance = 3, raid = true, difficulty = 4 }, --Heart of Fear Normal 25
	["3-81-342"]	= { tier = 5, instance = 3, raid = true, difficulty = 6 }, --Heart of Fear Heroic 25
	
	["3-82-343"]	= { tier = 5, instance = 4, raid = true, difficulty = 3 }, --Terrace of Endless Spring Normal 10
	["3-82-344"]	= { tier = 5, instance = 4, raid = true, difficulty = 5 }, --Terrace of Endless Spring Heroic 10
	["3-82-345"]	= { tier = 5, instance = 4, raid = true, difficulty = 4 }, --Terrace of Endless Spring Normal 25
	["3-82-346"]	= { tier = 5, instance = 4, raid = true, difficulty = 6 }, --Terrace of Endless Spring Heroic 25
	
	["3-83-347"]	= { tier = 5, instance = 5, raid = true, difficulty = 3 }, --Throne of Thunder Normal 10
	["3-83-348"]	= { tier = 5, instance = 5, raid = true, difficulty = 5 }, --Throne of Thunder Heroic 10
	["3-83-349"]	= { tier = 5, instance = 5, raid = true, difficulty = 6 }, --Throne of Thunder Heroic 25
	["3-83-350"]	= { tier = 5, instance = 5, raid = true, difficulty = 4 }, --Throne of Thunder Normal 25
	
	["3-1-4"]		= { tier = 5, instance = 6, raid = true, difficulty = 14 }, --Siege of Orgrimmar Normal
	["3-1-41"]		= { tier = 5, instance = 6, raid = true, difficulty = 15 }, --Siege of Orgrimmar Heroic
	["3-1-42"]		= { tier = 5, instance = 6, raid = true, difficulty = 16 }, --Siege of Orgrimmar Mythic
	
	
	--WoD
	["3-0-398"]		= { tier = 6, instance = 1, raid = true }, --Outdoor WoD
	
	["3-14-37"]		= { tier = 6, instance = 2, raid = true, difficulty = 14 }, --Highmaul Normal
	["3-14-38"]		= { tier = 6, instance = 2, raid = true, difficulty = 15 }, --Highmaul Heroic
	["3-14-399"]	= { tier = 6, instance = 2, raid = true, difficulty = 16 }, --Highmaul Mythic
	
	["3-15-39"]		= { tier = 6, instance = 3, raid = true, difficulty = 14 }, --Blackrock Foundry Normal
	["3-15-40"]		= { tier = 6, instance = 3, raid = true, difficulty = 15 }, --Blackrock Foundry Heroic
	["3-15-400"]	= { tier = 6, instance = 3, raid = true, difficulty = 16 }, --Blackrock Foundry Mythic
	
	["3-110-409"]	= { tier = 6, instance = 4, raid = true, difficulty = 14 },  --Hellfire Citadel Normal
	["3-110-410"]	= { tier = 6, instance = 4, raid = true, difficulty = 15 },  --Hellfire Citadel Heroic
	["3-110-412"]	= { tier = 6, instance = 4, raid = true, difficulty = 16 },  --Hellfire Citadel Mythic
	
	
	--Legion
	["3-0-458"]		= { tier = 7, instance = 1, raid = true }, -- Outdoor Legion
	
	["3-122-413"]	= { tier = 7, instance = 2, raid = true, difficulty = 14 }, -- Emerald Nightmare Normal
	["3-122-414"]	= { tier = 7, instance = 2, raid = true, difficulty = 15 }, -- Emerald Nightmare Heroic
	["3-122-468"]	= { tier = 7, instance = 2, raid = true, difficulty = 16 }, -- Emerald Nightmare Mythic
	
	["3-126-456"]	= { tier = 7, instance = 3, raid = true, difficulty = 14 }, -- TOV Normal
	["3-126-457"]	= { tier = 7, instance = 3, raid = true, difficulty = 15 }, -- TOV Heroic
	["3-126-480"]	= { tier = 7, instance = 3, raid = true, difficulty = 16 }, -- TOV Mythic
	
	["3-123-415"]	= { tier = 7, instance = 4, raid = true, difficulty = 14 }, -- Nighthold Normal
	["3-123-416"]	= { tier = 7, instance = 4, raid = true, difficulty = 15 }, -- Nighthold Heroic
	["3-123-481"]	= { tier = 7, instance = 4, raid = true, difficulty = 16 }, -- Nighthold Mythic
	
	["3-131-479"]	= { tier = 7, instance = 5, raid = true, difficulty = 14 }, -- ToS Normal
	["3-131-478"]	= { tier = 7, instance = 5, raid = true, difficulty = 15 }, -- ToS Heroic
	["3-131-492"]	= { tier = 7, instance = 5, raid = true, difficulty = 16 }, -- ToS Mythic
	
	["3-132-482"]	= { tier = 7, instance = 6, raid = true, difficulty = 14 }, -- AtBT Normal
	["3-132-483"]	= { tier = 7, instance = 6, raid = true, difficulty = 15 }, -- AtBT Heroic
	["3-132-493"]	= { tier = 7, instance = 6, raid = true, difficulty = 16 }, -- AtBT Mythic
}

local PremadeFilter_RealmChapters = {
	-- US
	{ "Oceania", "Pacific", "Mountain", "Central", "Eastern", "Latin America", "Brazil" },
	
	-- Korea
	{ "격노의 전장", "징벌의 전장" },
	
	-- EU
	{ "English", "French", "German", "Russian", "Spanish", "Portuguese", "Italian" },
	  
	-- Taiwan
	{ "殺戮", "嗜血", "暴怒" },
	
	-- China
	{ "Battle Group 1",  "Battle Group 2",  "Battle Group 3",  "Battle Group 4",  "Battle Group 5",  "Battle Group 6",  "Battle Group 7",  "Battle Group 8",  "Battle Group 9",  "Battle Group 10",
	  "Battle Group 11", "Battle Group 12", "Battle Group 13", "Battle Group 14", "Battle Group 15", "Battle Group 16", "Battle Group 17", "Battle Group 18", "Battle Group 19", "Battle Group 20",
	  "Battle Group 21" },
};

local PremadeFilter_Relams = {
	-- US
		-- Oceania
		{ name = "Aman'Thul", region = 1, chapter = 1 },
		{ name = "Barthilas", region = 1, chapter = 1 },
		{ name = "Caelestrasz", region = 1, chapter = 1 },
		{ name = "Dath'Remar", region = 1, chapter = 1 },
		{ name = "Dreadmaul", region = 1, chapter = 1 },
		{ name = "Frostmourne", region = 1, chapter = 1 },
		{ name = "Gundrak", region = 1, chapter = 1 },
		{ name = "Jubei'Thos", region = 1, chapter = 1 },
		{ name = "Khaz'goroth", region = 1, chapter = 1 },
		{ name = "Nagrand", region = 1, chapter = 1 },
		{ name = "Saurfang", region = 1, chapter = 1 },
		{ name = "Thaurissan", region = 1, chapter = 1 },
		
		-- Pacific
		{ name = "Aerie Peak", region = 1, chapter = 2 },
		{ name = "Antonidas", region = 1, chapter = 2 },
		{ name = "Anvilmar", region = 1, chapter = 2 },
		{ name = "Arathor", region = 1, chapter = 2 },
		{ name = "Azuremyst", region = 1, chapter = 2 },
		{ name = "Baelgun", region = 1, chapter = 2 },
		{ name = "Blackrock", region = 1, chapter = 2 },
		{ name = "Blackwing Lair", region = 1, chapter = 2 },
		{ name = "Blade's Edge", region = 1, chapter = 2 },
		{ name = "Bladefist", region = 1, chapter = 2 },
		{ name = "Blackwater Raiders", region = 1, chapter = 2 },
		{ name = "Bonechewer", region = 1, chapter = 2 },
		{ name = "Boulderfist", region = 1, chapter = 2 },
		{ name = "Bronzebeard", region = 1, chapter = 2 },
		{ name = "Cenarius", region = 1, chapter = 2 },
		{ name = "Cenarion Circle", region = 1, chapter = 2 },
		{ name = "Coilfang", region = 1, chapter = 2 },
		{ name = "Crushridge", region = 1, chapter = 2 },
		{ name = "Daggerspine", region = 1, chapter = 2 },
		{ name = "Dark Iron", region = 1, chapter = 2 },
		{ name = "Darrowmere", region = 1, chapter = 2 },
		{ name = "Destromath", region = 1, chapter = 2 },
		{ name = "Dethecus", region = 1, chapter = 2 },
		{ name = "Draenor", region = 1, chapter = 2 },
		{ name = "Dragonblight", region = 1, chapter = 2 },
		{ name = "Dragonmaw", region = 1, chapter = 2 },
		{ name = "Dunemaul", region = 1, chapter = 2 },
		{ name = "Echo Isles", region = 1, chapter = 2 },
		{ name = "Feathermoon", region = 1, chapter = 2 },
		{ name = "Frostwolf", region = 1, chapter = 2 },
		{ name = "Galakrond", region = 1, chapter = 2 },
		{ name = "Gnomeregan", region = 1, chapter = 2 },
		{ name = "Gorgonnash", region = 1, chapter = 2 },
		{ name = "Gurubashi", region = 1, chapter = 2 },
		{ name = "Hyjal", region = 1, chapter = 2 },
		{ name = "Kalecgos", region = 1, chapter = 2 },
		{ name = "Kil'Jaeden", region = 1, chapter = 2 },
		{ name = "Kilrogg", region = 1, chapter = 2 },
		{ name = "Korialstrasz", region = 1, chapter = 2 },
		{ name = "Lethon", region = 1, chapter = 2 },
		{ name = "Lightbringer", region = 1, chapter = 2 },
		{ name = "Maiev", region = 1, chapter = 2 },
		{ name = "Misha", region = 1, chapter = 2 },
		{ name = "Mok'Nathal", region = 1, chapter = 2 },
		{ name = "Moonrunner", region = 1, chapter = 2 },
		{ name = "Nazjatar", region = 1, chapter = 2 },
		{ name = "Ner'zhul", region = 1, chapter = 2 },
		{ name = "Nordrassil", region = 1, chapter = 2 },
		{ name = "Onyxia", region = 1, chapter = 2 },
		{ name = "Proudmoore", region = 1, chapter = 2 },
		{ name = "Rivendare", region = 1, chapter = 2 },
		{ name = "Sentinels", region = 1, chapter = 2 },
		{ name = "Shadowsong", region = 1, chapter = 2 },
		{ name = "Shattered Halls", region = 1, chapter = 2 },
		{ name = "Shu'Halo", region = 1, chapter = 2 },
		{ name = "Silver Hand", region = 1, chapter = 2 },
		{ name = "Silvermoon", region = 1, chapter = 2 },
		{ name = "Skywall", region = 1, chapter = 2 },
		{ name = "Spinebreaker", region = 1, chapter = 2 },
		{ name = "Spirestone", region = 1, chapter = 2 },
		{ name = "Stonemaul", region = 1, chapter = 2 },
		{ name = "Stormscale", region = 1, chapter = 2 },
		{ name = "Suramar", region = 1, chapter = 2 },
		{ name = "The Scryers", region = 1, chapter = 2 },
		{ name = "The Venture Co US", region = 1, chapter = 2 },
		{ name = "Tichondrius", region = 1, chapter = 2 },
		{ name = "Uldum", region = 1, chapter = 2 },
		{ name = "Ursin", region = 1, chapter = 2 },
		{ name = "Uther", region = 1, chapter = 2 },
		{ name = "Vashj", region = 1, chapter = 2 },
		{ name = "Velen", region = 1, chapter = 2 },
		{ name = "Windrunner", region = 1, chapter = 2 },
		{ name = "Wyrmrest Accord", region = 1, chapter = 2 },
		
		-- Mountain
		{ name = "Azjol-Nerub", region = 1, chapter = 3 },
		{ name = "Bloodscalp", region = 1, chapter = 3 },
		{ name = "Darkspear", region = 1, chapter = 3 },
		{ name = "Deathwing", region = 1, chapter = 3 },
		{ name = "Doomhammer", region = 1, chapter = 3 },
		{ name = "Icecrown", region = 1, chapter = 3 },
		{ name = "Kel'Thuzad", region = 1, chapter = 3 },
		{ name = "Nathrezim", region = 1, chapter = 3 },
		{ name = "Perenolde", region = 1, chapter = 3 },
		{ name = "Shadow Council", region = 1, chapter = 3 },
		{ name = "Terenas", region = 1, chapter = 3 },
		{ name = "Zangarmarsh", region = 1, chapter = 3 },
		
		-- Central
		{ name = "Aegwynn", region = 1, chapter = 4 },
		{ name = "Agamaggan", region = 1, chapter = 4 },
		{ name = "Aggramar", region = 1, chapter = 4 },
		{ name = "Akama", region = 1, chapter = 4 },
		{ name = "Alexstrasza", region = 1, chapter = 4 },
		{ name = "Alleria", region = 1, chapter = 4 },
		{ name = "Archimonde", region = 1, chapter = 4 },
		{ name = "Azgalor", region = 1, chapter = 4 },
		{ name = "Azshara", region = 1, chapter = 4 },
		{ name = "Balnazzar", region = 1, chapter = 4 },
		{ name = "Blackhand", region = 1, chapter = 4 },
		{ name = "Blood Furnace", region = 1, chapter = 4 },
		{ name = "Borean Tundra", region = 1, chapter = 4 },
		{ name = "Burning Legion", region = 1, chapter = 4 },
		{ name = "Cairne", region = 1, chapter = 4 },
		{ name = "Cho'gall", region = 1, chapter = 4 },
		{ name = "Chromaggus", region = 1, chapter = 4 },
		{ name = "Dawnbringer", region = 1, chapter = 4 },
		{ name = "Detheroc", region = 1, chapter = 4 },
		{ name = "Drak'tharon", region = 1, chapter = 4 },
		{ name = "Drak'thul", region = 1, chapter = 4 },
		{ name = "Draka", region = 1, chapter = 4 },
		{ name = "Eitrigg", region = 1, chapter = 4 },
		{ name = "Emerald Dream", region = 1, chapter = 4 },
		{ name = "Farstriders", region = 1, chapter = 4 },
		{ name = "Fizzcrank", region = 1, chapter = 4 },
		{ name = "Frostmane", region = 1, chapter = 4 },
		{ name = "Garithos", region = 1, chapter = 4 },
		{ name = "Garona", region = 1, chapter = 4 },
		{ name = "Ghostlands", region = 1, chapter = 4 },
		{ name = "Greymane", region = 1, chapter = 4 },
		{ name = "Grizzly Hills", region = 1, chapter = 4 },
		{ name = "Gul'dan", region = 1, chapter = 4 },
		{ name = "Hakkar", region = 1, chapter = 4 },
		{ name = "Hellscream", region = 1, chapter = 4 },
		{ name = "Hydraxis", region = 1, chapter = 4 },
		{ name = "Illidan", region = 1, chapter = 4 },
		{ name = "Kael'thas", region = 1, chapter = 4 },
		{ name = "Khaz Modan", region = 1, chapter = 4 },
		{ name = "Kirin Tor", region = 1, chapter = 4 },
		{ name = "Korgath", region = 1, chapter = 4 },
		{ name = "Kul Tiras", region = 1, chapter = 4 },
		{ name = "Laughing Skull", region = 1, chapter = 4 },
		{ name = "Lightninghoof", region = 1, chapter = 4 },
		{ name = "Madoran", region = 1, chapter = 4 },
		{ name = "Maelstrom", region = 1, chapter = 4 },
		{ name = "Mal'Ganis", region = 1, chapter = 4 },
		{ name = "Malfurion", region = 1, chapter = 4 },
		{ name = "Malorne", region = 1, chapter = 4 },
		{ name = "Malygos", region = 1, chapter = 4 },
		{ name = "Mok’Nathal", region = 1, chapter = 4 },
		{ name = "Moon Guard", region = 1, chapter = 4 },
		{ name = "Mug'thol", region = 1, chapter = 4 },
		{ name = "Muradin", region = 1, chapter = 4 },
		{ name = "Nesingwary", region = 1, chapter = 4 },
		{ name = "Quel'Dorei", region = 1, chapter = 4 },
		{ name = "Ravencrest", region = 1, chapter = 4 },
		{ name = "Rexxar", region = 1, chapter = 4 },
		{ name = "Runetotem", region = 1, chapter = 4 },
		{ name = "Sargeras", region = 1, chapter = 4 },
		{ name = "Scarlet Crusade", region = 1, chapter = 4 },
		{ name = "Sen'Jin", region = 1, chapter = 4 },
		{ name = "Sisters of Elune", region = 1, chapter = 4 },
		{ name = "Staghelm", region = 1, chapter = 4 },
		{ name = "Stormreaver", region = 1, chapter = 4 },
		{ name = "Terokkar", region = 1, chapter = 4 },
		{ name = "The Underbog", region = 1, chapter = 4 },
		{ name = "Thorium Brotherhood", region = 1, chapter = 4 },
		{ name = "Thunderhorn", region = 1, chapter = 4 },
		{ name = "Thunderlord", region = 1, chapter = 4 },
		{ name = "Twisting Nether", region = 1, chapter = 4 },
		{ name = "Vek'nilash", region = 1, chapter = 4 },
		{ name = "Whisperwind", region = 1, chapter = 4 },
		{ name = "Wildhammer", region = 1, chapter = 4 },
		{ name = "Winterhoof", region = 1, chapter = 4 },
		
		-- Eastern
		{ name = "Altar of Storms", region = 1, chapter = 5 },
		{ name = "Alterac Mountains", region = 1, chapter = 5 },
		{ name = "Andorhal", region = 1, chapter = 5 },
		{ name = "Anetheron", region = 1, chapter = 5 },
		{ name = "Anub'arak", region = 1, chapter = 5 },
		{ name = "Area 52", region = 1, chapter = 5 },
		{ name = "Argent Dawn", region = 1, chapter = 5 },
		{ name = "Arthas", region = 1, chapter = 5 },
		{ name = "Arygos", region = 1, chapter = 5 },
		{ name = "Auchindoun", region = 1, chapter = 5 },
		{ name = "Black Dragonflight", region = 1, chapter = 5 },
		{ name = "Bleeding Hollow", region = 1, chapter = 5 },
		{ name = "Bloodhoof", region = 1, chapter = 5 },
		{ name = "Burning Blade", region = 1, chapter = 5 },
		{ name = "Dalaran", region = 1, chapter = 5 },
		{ name = "Dalvengyr", region = 1, chapter = 5 },
		{ name = "Demon Soul", region = 1, chapter = 5 },
		{ name = "Dentarg", region = 1, chapter = 5 },
		{ name = "Drenden", region = 1, chapter = 5 },
		{ name = "Durotan", region = 1, chapter = 5 },
		{ name = "Duskwood", region = 1, chapter = 5 },
		{ name = "Earthen Ring", region = 1, chapter = 5 },
		{ name = "Eldre'Thalas", region = 1, chapter = 5 },
		{ name = "Elune", region = 1, chapter = 5 },
		{ name = "Eonar", region = 1, chapter = 5 },
		{ name = "Eredar", region = 1, chapter = 5 },
		{ name = "Executus", region = 1, chapter = 5 },
		{ name = "Exodar", region = 1, chapter = 5 },
		{ name = "Fenris", region = 1, chapter = 5 },
		{ name = "Firetree", region = 1, chapter = 5 },
		{ name = "Garrosh", region = 1, chapter = 5 },
		{ name = "Gilneas", region = 1, chapter = 5 },
		{ name = "Gorefiend", region = 1, chapter = 5 },
		{ name = "Grizzly Hills", region = 1, chapter = 5 },
		{ name = "Haomarush", region = 1, chapter = 5 },
		{ name = "Jaedenar", region = 1, chapter = 5 },
		{ name = "Kargath", region = 1, chapter = 5 },
		{ name = "Khadgar", region = 1, chapter = 5 },
		{ name = "Lightning's Blade", region = 1, chapter = 5 },
		{ name = "Llane", region = 1, chapter = 5 },
		{ name = "Lothar", region = 1, chapter = 5 },
		{ name = "Magtheridon", region = 1, chapter = 5 },
		{ name = "Mannoroth", region = 1, chapter = 5 },
		{ name = "Medivh", region = 1, chapter = 5 },
		{ name = "Nazgrel", region = 1, chapter = 5 },
		{ name = "Norgannon", region = 1, chapter = 5 },
		{ name = "Ravenholdt", region = 1, chapter = 5 },
		{ name = "Scilla", region = 1, chapter = 5 },
		{ name = "Shadowmoon", region = 1, chapter = 5 },
		{ name = "Shandris", region = 1, chapter = 5 },
		{ name = "Shattered Hand", region = 1, chapter = 5 },
		{ name = "Skullcrusher", region = 1, chapter = 5 },
		{ name = "Smolderthorn", region = 1, chapter = 5 },
		{ name = "Steamwheedle Cartel", region = 1, chapter = 5 },
		{ name = "Stormrage", region = 1, chapter = 5 },
		{ name = "Tanaris", region = 1, chapter = 5 },
		{ name = "The Forgotten Coast", region = 1, chapter = 5 },
		{ name = "Thrall", region = 1, chapter = 5 },
		{ name = "Tortheldrin", region = 1, chapter = 5 },
		{ name = "Trollbane", region = 1, chapter = 5 },
		{ name = "Turalyon", region = 1, chapter = 5 },
		{ name = "Uldaman", region = 1, chapter = 5 },
		{ name = "Undermine", region = 1, chapter = 5 },
		{ name = "Warsong", region = 1, chapter = 5 },
		{ name = "Ysera", region = 1, chapter = 5 },
		{ name = "Ysondre", region = 1, chapter = 5 },
		{ name = "Zul'jin", region = 1, chapter = 5 },
		{ name = "Zuluhed", region = 1, chapter = 5 },
		
		-- Latin America
		{ name = "Drakkari", region = 1, chapter = 6 },
		{ name = "Quel'Thalas", region = 1, chapter = 6 },
		{ name = "Ragnaros", region = 1, chapter = 6 },
		
		-- Brazil
		{ name = "Azralon", region = 1, chapter = 7 },
		{ name = "Goldrinn", region = 1, chapter = 7 },
		{ name = "Gallywix", region = 1, chapter = 7 },
		{ name = "Nemesis", region = 1, chapter = 7 },
		{ name = "Tol Barad", region = 1, chapter = 7 },
	
	-- Korea
		-- 격노의 전장
		{ name = "렉사르", region = 2, chapter = 1 },
		{ name = "불타는 군단", region = 2, chapter = 1 },
		{ name = "와일드해머", region = 2, chapter = 1 },
		{ name = "가로나", region = 2, chapter = 1 },
		{ name = "달라란", region = 2, chapter = 1 },
		{ name = "데스윙", region = 2, chapter = 1 },
		{ name = "라그나로스", region = 2, chapter = 1 },
		{ name = "말퓨리온", region = 2, chapter = 1 },
		{ name = "세나리우스", region = 2, chapter = 1 },
		{ name = "알렉스트라자", region = 2, chapter = 1 },
		{ name = "카르가스", region = 2, chapter = 1 },
		{ name = "하이잘", region = 2, chapter = 1 },
		{ name = "헬스크림", region = 2, chapter = 1 },		
		
		-- 징벌의 전장
		{ name = "스톰레이지", region = 2, chapter = 2 },
		{ name = "윈드러너", region = 2, chapter = 2 },
		{ name = "굴단 (Gul'dan)", region = 2, chapter = 2 },
		{ name = "노르간논", region = 2, chapter = 2 },
		{ name = "듀로탄", region = 2, chapter = 2 },
		{ name = "아즈샤라", region = 2, chapter = 2 },
		{ name = "에이그윈", region = 2, chapter = 2 },
		{ name = "엘룬", region = 2, chapter = 2 },
		{ name = "이오나", region = 2, chapter = 2 },
		{ name = "줄진 (Zul'jin)", region = 2, chapter = 2 },
		
	-- EU
		-- English
		{ name = "Aerie Peak", region = 3, chapter = 1 },
		{ name = "Agamaggan", region = 3, chapter = 1 },
		{ name = "Aggra(Português)", region = 3, chapter = 1 },
		{ name = "Aggramar", region = 3, chapter = 1 },
		{ name = "Ahn'Qiraj", region = 3, chapter = 1 },
		{ name = "Al'Akir", region = 3, chapter = 1 },
		{ name = "Alonsus", region = 3, chapter = 1 },
		{ name = "Anachronos", region = 3, chapter = 1 },
		{ name = "Arathor", region = 3, chapter = 1 },
		{ name = "Argent Dawn", region = 3, chapter = 1 },
		{ name = "Aszune", region = 3, chapter = 1 },
		{ name = "Auchindoun", region = 3, chapter = 1 },
		{ name = "Azjol-Nerub", region = 3, chapter = 1 },
		{ name = "Azuremyst", region = 3, chapter = 1 },
		{ name = "Balnazzar", region = 3, chapter = 1 },
		{ name = "Blade's Edge", region = 3, chapter = 1 },
		{ name = "Bladefist", region = 3, chapter = 1 },
		{ name = "Bloodfeather", region = 3, chapter = 1 },
		{ name = "Bloodhoof", region = 3, chapter = 1 },
		{ name = "Bloodscalp", region = 3, chapter = 1 },
		{ name = "Boulderfist", region = 3, chapter = 1 },
		{ name = "Bronze Dragonflight", region = 3, chapter = 1 },
		{ name = "Bronzebeard", region = 3, chapter = 1 },
		{ name = "Burning Blade", region = 3, chapter = 1 },
		{ name = "Burning Legion", region = 3, chapter = 1 },
		{ name = "Burning Steppes", region = 3, chapter = 1 },
		{ name = "Chamber of Aspects", region = 3, chapter = 1 },
		{ name = "Chromaggus", region = 3, chapter = 1 },
		{ name = "Crushridge", region = 3, chapter = 1 },
		{ name = "Daggerspine", region = 3, chapter = 1 },
		{ name = "Darkmoon Faire", region = 3, chapter = 1 },
		{ name = "Darksorrow", region = 3, chapter = 1 },
		{ name = "Darkspear", region = 3, chapter = 1 },
		{ name = "Deathwing", region = 3, chapter = 1 },
		{ name = "Defias Brotherhood", region = 3, chapter = 1 },
		{ name = "Dentarg", region = 3, chapter = 1 },
		{ name = "Doomhammer", region = 3, chapter = 1 },
		{ name = "Draenor", region = 3, chapter = 1 },
		{ name = "Dragonblight", region = 3, chapter = 1 },
		{ name = "Dragonmaw", region = 3, chapter = 1 },
		{ name = "Drak'thul", region = 3, chapter = 1 },
		{ name = "Dunemaul", region = 3, chapter = 1 },
		{ name = "Earthen Ring", region = 3, chapter = 1 },
		{ name = "Emerald Dream", region = 3, chapter = 1 },
		{ name = "Emeriss", region = 3, chapter = 1 },
		{ name = "Eonar", region = 3, chapter = 1 },
		{ name = "Executus", region = 3, chapter = 1 },
		{ name = "Frostmane", region = 3, chapter = 1 },
		{ name = "Frostwhisper", region = 3, chapter = 1 },
		{ name = "Genjuros", region = 3, chapter = 1 },
		{ name = "Ghostlands", region = 3, chapter = 1 },
		{ name = "Grim Batol", region = 3, chapter = 1 },
		{ name = "Hakkar", region = 3, chapter = 1 },
		{ name = "Haomarush", region = 3, chapter = 1 },
		{ name = "Hellfire", region = 3, chapter = 1 },
		{ name = "Hellscream", region = 3, chapter = 1 },
		{ name = "Jaedenar", region = 3, chapter = 1 },
		{ name = "Karazhan", region = 3, chapter = 1 },
		{ name = "Kazzak", region = 3, chapter = 1 },
		{ name = "Khadgar", region = 3, chapter = 1 },
		{ name = "Kilrogg", region = 3, chapter = 1 },
		{ name = "Kor'gall", region = 3, chapter = 1 },
		{ name = "Kul Tiras", region = 3, chapter = 1 },
		{ name = "Laughing Skull", region = 3, chapter = 1 },
		{ name = "Lightbringer", region = 3, chapter = 1 },
		{ name = "Lightning's Blade", region = 3, chapter = 1 },
		{ name = "Magtheridon", region = 3, chapter = 1 },
		{ name = "Mazrigos", region = 3, chapter = 1 },
		{ name = "Molten Core", region = 3, chapter = 1 },
		{ name = "Moonglade", region = 3, chapter = 1 },
		{ name = "Nagrand", region = 3, chapter = 1 },
		{ name = "Neptulon", region = 3, chapter = 1 },
		{ name = "Nordrassil", region = 3, chapter = 1 },
		{ name = "Outland", region = 3, chapter = 1 },
		{ name = "Quel'Thalas", region = 3, chapter = 1 },
		{ name = "Ragnaros", region = 3, chapter = 1 },
		{ name = "Ravencrest", region = 3, chapter = 1 },
		{ name = "Ravenholdt", region = 3, chapter = 1 },
		{ name = "Runetotem", region = 3, chapter = 1 },
		{ name = "Saurfang", region = 3, chapter = 1 },
		{ name = "Scarshield Legion", region = 3, chapter = 1 },
		{ name = "Shadowmoon", region = 3, chapter = 1 },
		{ name = "Shadowsong", region = 3, chapter = 1 },
		{ name = "Shattered Halls", region = 3, chapter = 1 },
		{ name = "Shattered Hand", region = 3, chapter = 1 },
		{ name = "Silvermoon", region = 3, chapter = 1 },
		{ name = "Skullcrusher", region = 3, chapter = 1 },
		{ name = "Spinebreaker", region = 3, chapter = 1 },
		{ name = "Sporeggar", region = 3, chapter = 1 },
		{ name = "Steamwheedle Cartel", region = 3, chapter = 1 },
		{ name = "Stonemaul", region = 3, chapter = 1 },
		{ name = "Stormrage", region = 3, chapter = 1 },
		{ name = "Stormreaver", region = 3, chapter = 1 },
		{ name = "Stormscale", region = 3, chapter = 1 },
		{ name = "Sunstrider", region = 3, chapter = 1 },
		{ name = "Sylvanas", region = 3, chapter = 1 },
		{ name = "Talnivarr", region = 3, chapter = 1 },
		{ name = "Tarren Mill", region = 3, chapter = 1 },
		{ name = "Terenas", region = 3, chapter = 1 },
		{ name = "Terokkar", region = 3, chapter = 1 },
		{ name = "The Maelstrom", region = 3, chapter = 1 },
		{ name = "The Sha'tar", region = 3, chapter = 1 },
		{ name = "The Venture Co EU", region = 3, chapter = 1 },
		{ name = "Thunderhorn", region = 3, chapter = 1 },
		{ name = "Trollbane", region = 3, chapter = 1 },
		{ name = "Turalyon", region = 3, chapter = 1 },
		{ name = "Twilight's Hammer", region = 3, chapter = 1 },
		{ name = "Twisting Nether", region = 3, chapter = 1 },
		{ name = "Vashj", region = 3, chapter = 1 },
		{ name = "Vek'nilash", region = 3, chapter = 1 },
		{ name = "Warsong", region = 3, chapter = 1 },
		{ name = "Wildhammer", region = 3, chapter = 1 },
		{ name = "Xavius", region = 3, chapter = 1 },
		{ name = "Zenedar", region = 3, chapter = 1 },
		
		-- French
		{ name = "Arak-arahm", region = 3, chapter = 2 },
		{ name = "Arathi", region = 3, chapter = 2 },
		{ name = "Archimonde", region = 3, chapter = 2 },
		{ name = "Chants éternels", region = 3, chapter = 2 },
		{ name = "Cho'gall", region = 3, chapter = 2 },
		{ name = "Confrérie du Thorium", region = 3, chapter = 2 },
		{ name = "Conseil des Ombres", region = 3, chapter = 2 },
		{ name = "Culte de la Rive Noire", region = 3, chapter = 2 },
		{ name = "Dalaran", region = 3, chapter = 2 },
		{ name = "Drek'Thar", region = 3, chapter = 2 },
		{ name = "Eitrigg", region = 3, chapter = 2 },
		{ name = "Eldre'Thalas", region = 3, chapter = 2 },
		{ name = "Elune", region = 3, chapter = 2 },
		{ name = "Garona", region = 3, chapter = 2 },
		{ name = "Hyjal", region = 3, chapter = 2 },
		{ name = "Illidan", region = 3, chapter = 2 },
		{ name = "Kael'Thas", region = 3, chapter = 2 },
		{ name = "Khaz Modan", region = 3, chapter = 2 },
		{ name = "Kirin Tor", region = 3, chapter = 2 },
		{ name = "Krasus", region = 3, chapter = 2 },
		{ name = "La Croisade écarlate", region = 3, chapter = 2 },
		{ name = "Les Clairvoyants", region = 3, chapter = 2 },
		{ name = "Les Sentinelles", region = 3, chapter = 2 },
		{ name = "Marécage de Zangar", region = 3, chapter = 2 },
		{ name = "Medivh", region = 3, chapter = 2 },
		{ name = "Naxxramas", region = 3, chapter = 2 },
		{ name = "Ner'zhul", region = 3, chapter = 2 },
		{ name = "Rashgarroth", region = 3, chapter = 2 },
		{ name = "Sargeras", region = 3, chapter = 2 },
		{ name = "Sinstralis", region = 3, chapter = 2 },
		{ name = "Suramar", region = 3, chapter = 2 },
		{ name = "Temple noir", region = 3, chapter = 2 },
		{ name = "Throk'Feroth", region = 3, chapter = 2 },
		{ name = "Uldaman", region = 3, chapter = 2 },
		{ name = "Varimathras", region = 3, chapter = 2 },
		{ name = "Vol'jin", region = 3, chapter = 2 },
		{ name = "Ysondre", region = 3, chapter = 2 },
		
		-- German
		{ name = "Aegwynn", region = 3, chapter = 3 },
		{ name = "Alexstrasza", region = 3, chapter = 3 },
		{ name = "Alleria", region = 3, chapter = 3 },
		{ name = "Aman'Thul", region = 3, chapter = 3 },
		{ name = "Ambossar", region = 3, chapter = 3 },
		{ name = "Anetheron", region = 3, chapter = 3 },
		{ name = "Antonidas", region = 3, chapter = 3 },
		{ name = "Anub'arak", region = 3, chapter = 3 },
		{ name = "Area 52", region = 3, chapter = 3 },
		{ name = "Arthas", region = 3, chapter = 3 },
		{ name = "Arygos", region = 3, chapter = 3 },
		{ name = "Azshara", region = 3, chapter = 3 },
		{ name = "Baelgun", region = 3, chapter = 3 },
		{ name = "Blackhand", region = 3, chapter = 3 },
		{ name = "Blackmoore", region = 3, chapter = 3 },
		{ name = "Blackrock", region = 3, chapter = 3 },
		{ name = "Blutkessel", region = 3, chapter = 3 },
		{ name = "Dalvengyr", region = 3, chapter = 3 },
		{ name = "Das Konsortium", region = 3, chapter = 3 },
		{ name = "Das Syndikat", region = 3, chapter = 3 },
		{ name = "Der Mithrilorden", region = 3, chapter = 3 },
		{ name = "Der Rat von Dalaran", region = 3, chapter = 3 },
		{ name = "Der abyssische Rat", region = 3, chapter = 3 },
		{ name = "Destromath", region = 3, chapter = 3 },
		{ name = "Dethecus", region = 3, chapter = 3 },
		{ name = "Die Aldor", region = 3, chapter = 3 },
		{ name = "Die Arguswacht", region = 3, chapter = 3 },
		{ name = "Die Nachtwache", region = 3, chapter = 3 },
		{ name = "Die Silberne Hand", region = 3, chapter = 3 },
		{ name = "Die Todeskrallen", region = 3, chapter = 3 },
		{ name = "Die ewige Wacht", region = 3, chapter = 3 },
		{ name = "Dun Morogh", region = 3, chapter = 3 },
		{ name = "Durotan", region = 3, chapter = 3 },
		{ name = "Echsenkessel", region = 3, chapter = 3 },
		{ name = "Eredar", region = 3, chapter = 3 },
		{ name = "Festung der Stürme", region = 3, chapter = 3 },
		{ name = "Forscherliga", region = 3, chapter = 3 },
		{ name = "Frostmourne", region = 3, chapter = 3 },
		{ name = "Frostwolf", region = 3, chapter = 3 },
		{ name = "Garrosh", region = 3, chapter = 3 },
		{ name = "Gilneas", region = 3, chapter = 3 },
		{ name = "Gorgonnash", region = 3, chapter = 3 },
		{ name = "Gul'dan", region = 3, chapter = 3 },
		{ name = "Kargath", region = 3, chapter = 3 },
		{ name = "Kel'Thuzad", region = 3, chapter = 3 },
		{ name = "Khaz'goroth", region = 3, chapter = 3 },
		{ name = "Kil'Jaeden", region = 3, chapter = 3 },
		{ name = "Krag'jin", region = 3, chapter = 3 },
		{ name = "Kult der Verdammten", region = 3, chapter = 3 },
		{ name = "Lordaeron", region = 3, chapter = 3 },
		{ name = "Lothar", region = 3, chapter = 3 },
		{ name = "Madmortem", region = 3, chapter = 3 },
		{ name = "Mal'Ganis", region = 3, chapter = 3 },
		{ name = "Malfurion", region = 3, chapter = 3 },
		{ name = "Malorne", region = 3, chapter = 3 },
		{ name = "Malygos", region = 3, chapter = 3 },
		{ name = "Mannoroth", region = 3, chapter = 3 },
		{ name = "Mug'thol", region = 3, chapter = 3 },
		{ name = "Nathrezim", region = 3, chapter = 3 },
		{ name = "Nazjatar", region = 3, chapter = 3 },
		{ name = "Nefarian", region = 3, chapter = 3 },
		{ name = "Nera'thor", region = 3, chapter = 3 },
		{ name = "Nethersturm", region = 3, chapter = 3 },
		{ name = "Norgannon", region = 3, chapter = 3 },
		{ name = "Nozdormu", region = 3, chapter = 3 },
		{ name = "Onyxia", region = 3, chapter = 3 },
		{ name = "Perenolde", region = 3, chapter = 3 },
		{ name = "Proudmoore", region = 3, chapter = 3 },
		{ name = "Rajaxx", region = 3, chapter = 3 },
		{ name = "Rexxar", region = 3, chapter = 3 },
		{ name = "Sen'jin", region = 3, chapter = 3 },
		{ name = "Shattrath", region = 3, chapter = 3 },
		{ name = "Taerar", region = 3, chapter = 3 },
		{ name = "Teldrassil", region = 3, chapter = 3 },
		{ name = "Terrordar", region = 3, chapter = 3 },
		{ name = "Theradras", region = 3, chapter = 3 },
		{ name = "Thrall", region = 3, chapter = 3 },
		{ name = "Tichondrius", region = 3, chapter = 3 },
		{ name = "Tirion", region = 3, chapter = 3 },
		{ name = "Todeswache", region = 3, chapter = 3 },
		{ name = "Ulduar", region = 3, chapter = 3 },
		{ name = "Un'Goro", region = 3, chapter = 3 },
		{ name = "Vek'lor", region = 3, chapter = 3 },
		{ name = "Wrathbringer", region = 3, chapter = 3 },
		{ name = "Ysera", region = 3, chapter = 3 },
		{ name = "Zirkel des Cenarius", region = 3, chapter = 3 },
		{ name = "Zuluhed", region = 3, chapter = 3 },
		
		-- Russian
		{ name = "Азурегос", region = 3, chapter = 4 },
		{ name = "Борейская тундра", region = 3, chapter = 4 },
		{ name = "Вечная Песня", region = 3, chapter = 4 },
		{ name = "Галакронд", region = 3, chapter = 4 },
		{ name = "Голдринн", region = 3, chapter = 4 },
		{ name = "Гордунни", region = 3, chapter = 4 },
		{ name = "Гром", region = 3, chapter = 4 },
		{ name = "Дракономор", region = 3, chapter = 4 },
		{ name = "Король-лич", region = 3, chapter = 4 },
		{ name = "Пиратская бухта", region = 3, chapter = 4 },
		{ name = "Подземье", region = 3, chapter = 4 },
		{ name = "Разувий", region = 3, chapter = 4 },
		{ name = "Ревущий фьорд", region = 3, chapter = 4 },
		{ name = "Свежеватель Душ", region = 3, chapter = 4 },
		{ name = "Седогрив", region = 3, chapter = 4 },
		{ name = "Страж Смерти", region = 3, chapter = 4 },
		{ name = "Термоштепсель", region = 3, chapter = 4 },
		{ name = "Ткач Смерти", region = 3, chapter = 4 },
		{ name = "Черный Шрам", region = 3, chapter = 4 },
		{ name = "Ясеневый лес", region = 3, chapter = 4 },
		
		-- Spanish
		{ name = "C'Thun", region = 3, chapter = 5 },
		{ name = "Colinas Pardas", region = 3, chapter = 5 },
		{ name = "Dun Modr", region = 3, chapter = 5 },
		{ name = "Exodar", region = 3, chapter = 5 },
		{ name = "Los Errantes", region = 3, chapter = 5 },
		{ name = "Minahonda", region = 3, chapter = 5 },
		{ name = "Sanguino", region = 3, chapter = 5 },
		{ name = "Shen'dralar", region = 3, chapter = 5 },
		{ name = "Tyrande", region = 3, chapter = 5 },
		{ name = "Uldum", region = 3, chapter = 5 },
		{ name = "Zul'jin", region = 3, chapter = 5 },
		
		-- Portuguese
		{ name = "Aggra", region = 3, chapter = 6 },
		
		-- Italian
		{ name = "Nemesis", region = 3, chapter = 7 },
		{ name = "Pozzo dell'Eternità", region = 3, chapter = 7 },
		
	-- Taiwan
		-- 殺戮
		{ name = "狼狂索斯", region = 4, chapter = 1 },
		
		-- 嗜血
		{ name = "世界之樹", region = 4, chapter = 2 },
		{ name = "暗影之月", region = 4, chapter = 2 },
		{ name = "天空之牆", region = 4, chapter = 2 },
		{ name = "巴納札爾", region = 4, chapter = 2 },
		{ name = "巨龍之喉", region = 4, chapter = 2 },
		{ name = "狂熱之刃", region = 4, chapter = 2 },
		{ name = "冬握湖", region = 4, chapter = 2 },
		{ name = "雷鱗", region = 4, chapter = 2 },
		{ name = "凜風峽灣", region = 4, chapter = 2 },
		{ name = "米奈希爾", region = 4, chapter = 2 },
		{ name = "死亡之翼", region = 4, chapter = 2 },
		{ name = "水晶之刺", region = 4, chapter = 2 },
		{ name = "艾奧那斯", region = 4, chapter = 2 },
		{ name = "遠祖灘頭", region = 4, chapter = 2 },
		{ name = "日落沼澤", region = 4, chapter = 2 },
		{ name = "戰歌", region = 4, chapter = 2 },
		{ name = "提克迪奧斯", region = 4, chapter = 2 },
		{ name = "地獄吼", region = 4, chapter = 2 },
		{ name = "尖石", region = 4, chapter = 2 },
		{ name = "風暴群山", region = 4, chapter = 2 },
		{ name = "火焰之樹", region = 4, chapter = 2 },
		{ name = "冰霜之刺", region = 4, chapter = 2 },
		{ name = "冰風崗哨", region = 4, chapter = 2 },
		
		-- 暴怒
		{ name = "聖光之願 (Light's Hope)", region = 4, chapter = 3 },
		{ name = "亞雷戈斯", region = 4, chapter = 3 },
		{ name = "語風", region = 4, chapter = 3 },
		{ name = "奧妮克希亞", region = 4, chapter = 3 },
		{ name = "暴風祭壇", region = 4, chapter = 3 },
		{ name = "眾星之子 (Quel'dorei)", region = 4, chapter = 3 },
		{ name = "科爾蘇加德 (Kel’Thuzad)", region = 4, chapter = 3 },
		{ name = "狂心", region = 4, chapter = 3 },
		{ name = "鬼霧峰", region = 4, chapter = 3 },
		{ name = "奎爾達納斯 (Quel'Danas)", region = 4, chapter = 3 },
		{ name = "奈辛瓦里", region = 4, chapter = 3 },
		{ name = "屠魔山谷", region = 4, chapter = 3 },
		{ name = "諾姆瑞根", region = 4, chapter = 3 },
		{ name = "憤怒使者", region = 4, chapter = 3 },
		{ name = "撒爾薩里安", region = 4, chapter = 3 },
		{ name = "阿薩斯", region = 4, chapter = 3 },
		{ name = "夜空之歌", region = 4, chapter = 3 },
		{ name = "惡魔之魂", region = 4, chapter = 3 },
		{ name = "銀翼要塞", region = 4, chapter = 3 },
		{ name = "寒冰皇冠", region = 4, chapter = 3 },
		{ name = "血之谷", region = 4, chapter = 3 },
		{ name = "黑龍軍團", region = 4, chapter = 3 },
		
	-- China
		-- Battle Group 1
		{ name = "奥蕾莉亚", region = 5, chapter = 1 },
		{ name = "白银之手", region = 5, chapter = 1 },
		{ name = "回音山", region = 5, chapter = 1 },
		{ name = "阿格拉玛", region = 5, chapter = 1 },
		{ name = "艾苏恩", region = 5, chapter = 1 },
		{ name = "安威玛尔", region = 5, chapter = 1 },
		{ name = "奥达曼", region = 5, chapter = 1 },
		{ name = "暴风祭坛", region = 5, chapter = 1 },
		{ name = "藏宝海湾", region = 5, chapter = 1 },
		{ name = "尘风峡谷", region = 5, chapter = 1 },
		{ name = "达纳斯", region = 5, chapter = 1 },
		{ name = "迪托马斯", region = 5, chapter = 1 },
		{ name = "国王之谷", region = 5, chapter = 1 },
		{ name = "黑龙军团", region = 5, chapter = 1 },
		{ name = "黑石尖塔", region = 5, chapter = 1 },
		{ name = "红龙军团", region = 5, chapter = 1 },
		{ name = "基尔罗格", region = 5, chapter = 1 },
		{ name = "卡德罗斯", region = 5, chapter = 1 },

		{ name = "卡扎克", region = 5, chapter = 1 },
		{ name = "库德兰", region = 5, chapter = 1 },
		
		-- Battle Group 2
		{ name = "玛多兰", region = 5, chapter = 2 },
		{ name = "普瑞斯托", region = 5, chapter = 2 },
		{ name = "图拉扬", region = 5, chapter = 2 },
		{ name = "伊瑟拉", region = 5, chapter = 2 },
		{ name = "蓝龙军团", region = 5, chapter = 2 },
		{ name = "雷霆之王", region = 5, chapter = 2 },
		{ name = "烈焰峰", region = 5, chapter = 2 },
		{ name = "罗宁", region = 5, chapter = 2 },
		{ name = "洛萨", region = 5, chapter = 2 },
		{ name = "玛瑟里顿", region = 5, chapter = 2 },
		{ name = "耐萨里奥", region = 5, chapter = 2 },
		{ name = "诺莫瑞根", region = 5, chapter = 2 },
		{ name = "燃烧平原", region = 5, chapter = 2 },
		{ name = "萨格拉斯", region = 5, chapter = 2 },
		{ name = "山丘之王", region = 5, chapter = 2 },
		{ name = "死亡之翼", region = 5, chapter = 2 },
		{ name = "索拉丁", region = 5, chapter = 2 },
		{ name = "索瑞森", region = 5, chapter = 2 },
		{ name = "铜龙军团", region = 5, chapter = 2 },
		
		-- Battle Group 3
		{ name = "艾森娜", region = 5, chapter = 3 },
		{ name = "阿克蒙德", region = 5, chapter = 3 },
		{ name = "阿迦玛甘", region = 5, chapter = 3 },
		{ name = "埃加洛尔", region = 5, chapter = 3 },
		{ name = "埃苏雷格", region = 5, chapter = 3 },
		{ name = "艾萨拉", region = 5, chapter = 3 },
		{ name = "爱斯特纳", region = 5, chapter = 3 },
		{ name = "暗影之月", region = 5, chapter = 3 },
		{ name = "奥拉基尔", region = 5, chapter = 3 },
		{ name = "冰霜之刃", region = 5, chapter = 3 },
		{ name = "达斯雷玛", region = 5, chapter = 3 },
		{ name = "地狱咆哮", region = 5, chapter = 3 },
		{ name = "地狱之石", region = 5, chapter = 3 },
		{ name = "风暴之怒", region = 5, chapter = 3 },
		{ name = "风行者", region = 5, chapter = 3 },
		{ name = "弗塞雷迦", region = 5, chapter = 3 },
		{ name = "戈古纳斯", region = 5, chapter = 3 },
		{ name = "毁灭之锤", region = 5, chapter = 3 },
		{ name = "火焰之树", region = 5, chapter = 3 },
		{ name = "卡德加", region = 5, chapter = 3 },
		
		-- Battle Group 4
		{ name = "梦境之树", region = 5, chapter = 4 },
		{ name = "轻风之语", region = 5, chapter = 4 },
		{ name = "塞纳里奥", region = 5, chapter = 4 },
		{ name = "泰兰德", region = 5, chapter = 4 },
		{ name = "月光林地", region = 5, chapter = 4 },
		{ name = "月神殿", region = 5, chapter = 4 },
		{ name = "海加尔", region = 5, chapter = 4 },
		{ name = "拉文凯斯", region = 5, chapter = 4 },
		{ name = "玛法里奥", region = 5, chapter = 4 },
		{ name = "麦维影歌", region = 5, chapter = 4 },
		{ name = "梅尔加尼", region = 5, chapter = 4 },
		{ name = "耐普图隆", region = 5, chapter = 4 },
		{ name = "闪电之刃", region = 5, chapter = 4 },
		{ name = "石爪峰", region = 5, chapter = 4 },
		{ name = "屠魔山谷", region = 5, chapter = 4 },
		{ name = "夏维安", region = 5, chapter = 4 },
		{ name = "伊利丹", region = 5, chapter = 4 },
		{ name = "战歌", region = 5, chapter = 4 },
		{ name = "主宰之剑", region = 5, chapter = 4 },
		
		-- Battle Group 5
		{ name = "黄金之路", region = 5, chapter = 5 },
		{ name = "埃德萨拉", region = 5, chapter = 5 },
		{ name = "布莱克摩", region = 5, chapter = 5 },
		{ name = "杜隆坦", region = 5, chapter = 5 },
		{ name = "符文图腾", region = 5, chapter = 5 },
		{ name = "鬼雾峰", region = 5, chapter = 5 },
		{ name = "黑暗之矛", region = 5, chapter = 5 },
		{ name = "红龙女王", region = 5, chapter = 5 },
		{ name = "红云台地", region = 5, chapter = 5 },
		{ name = "火羽山", region = 5, chapter = 5 },
		{ name = "凯恩血蹄", region = 5, chapter = 5 },
		{ name = "狂风峭壁", region = 5, chapter = 5 },
		{ name = "雷斧堡垒", region = 5, chapter = 5 },
		{ name = "雷霆号角", region = 5, chapter = 5 },
		{ name = "血环", region = 5, chapter = 5 },
		{ name = "迦罗娜", region = 5, chapter = 5 },
		
		-- Battle Group 6
		{ name = "诺兹多姆", region = 5, chapter = 6 },
		{ name = "羽月", region = 5, chapter = 6 },
		{ name = "灰烬使者", region = 5, chapter = 6 },
		{ name = "禁魔监狱", region = 5, chapter = 6 },
		{ name = "雷克萨", region = 5, chapter = 6 },
		{ name = "玛里苟斯", region = 5, chapter = 6 },
		{ name = "纳沙塔尔", region = 5, chapter = 6 },
		{ name = "普罗德摩", region = 5, chapter = 6 },
		{ name = "千针石林", region = 5, chapter = 6 },
		{ name = "燃烧之刃", region = 5, chapter = 6 },
		{ name = "萨尔", region = 5, chapter = 6 },
		{ name = "圣火神殿", region = 5, chapter = 6 },
		{ name = "死亡之门", region = 5, chapter = 6 },
		{ name = "甜水绿洲", region = 5, chapter = 6 },
		{ name = "熊猫酒仙", region = 5, chapter = 6 },
		{ name = "血牙魔王", region = 5, chapter = 6 },
		{ name = "勇士岛", region = 5, chapter = 6 },
		{ name = "蜘蛛王国", region = 5, chapter = 6 },
		{ name = "自由之风", region = 5, chapter = 6 },
		
		-- Battle Group 7
		{ name = "耳语海岸", region = 5, chapter = 7 },
		{ name = "阿尔萨斯", region = 5, chapter = 7 },
		{ name = "阿拉索", region = 5, chapter = 7 },
		{ name = "埃霍恩", region = 5, chapter = 7 },
		{ name = "埃雷达尔", region = 5, chapter = 7 },
		{ name = "艾欧纳尔", region = 5, chapter = 7 },
		{ name = "暗影议会", region = 5, chapter = 7 },
		{ name = "奥特兰克", region = 5, chapter = 7 },
		{ name = "巴尔古恩", region = 5, chapter = 7 },
		{ name = "冰风岗", region = 5, chapter = 7 },
		{ name = "达隆米尔", region = 5, chapter = 7 },
		{ name = "古尔丹", region = 5, chapter = 7 },
		{ name = "寒冰皇冠", region = 5, chapter = 7 },
		{ name = "基尔加丹", region = 5, chapter = 7 },
		{ name = "激流堡", region = 5, chapter = 7 },
		{ name = "巨龙之吼", region = 5, chapter = 7 },
		{ name = "拉格纳洛斯", region = 5, chapter = 7 },
		{ name = "利刃之拳", region = 5, chapter = 7 },
		
		-- Battle Group 8
		{ name = "麦迪文", region = 5, chapter = 8 },
		{ name = "霜之哀伤", region = 5, chapter = 8 },
		{ name = "遗忘海岸", region = 5, chapter = 8 },
		{ name = "银松森林", region = 5, chapter = 8 },
		{ name = "银月", region = 5, chapter = 8 },
		{ name = "凯尔萨斯", region = 5, chapter = 8 },
		{ name = "克尔苏加德", region = 5, chapter = 8 },
		{ name = "玛诺洛斯", region = 5, chapter = 8 },
		{ name = "耐奥祖", region = 5, chapter = 8 },
		{ name = "瑞文戴尔", region = 5, chapter = 8 },
		{ name = "霜狼", region = 5, chapter = 8 },
		{ name = "斯坦索姆", region = 5, chapter = 8 },
		{ name = "塔伦米尔", region = 5, chapter = 8 },
		{ name = "提瑞斯法", region = 5, chapter = 8 },
		{ name = "通灵学院", region = 5, chapter = 8 },
		{ name = "希尔瓦娜斯", region = 5, chapter = 8 },
		{ name = "血色十字军", region = 5, chapter = 8 },
		{ name = "鹰巢山", region = 5, chapter = 8 },
		{ name = "影牙要塞", region = 5, chapter = 8 },
		
		-- Battle Group 9
		{ name = "世界之树", region = 5, chapter = 9 },
		{ name = "万色星辰", region = 5, chapter = 9 },
		{ name = "布兰卡德", region = 5, chapter = 9 },
		{ name = "雏龙之翼", region = 5, chapter = 9 },
		{ name = "恶魔之翼", region = 5, chapter = 9 },
		{ name = "黑暗魅影", region = 5, chapter = 9 },
		{ name = "激流之傲", region = 5, chapter = 9 },
		{ name = "加兹鲁维", region = 5, chapter = 9 },
		{ name = "浸毒之骨", region = 5, chapter = 9 },
		{ name = "卡珊德拉", region = 5, chapter = 9 },
		{ name = "狂热之刃", region = 5, chapter = 9 },
		{ name = "玛格索尔", region = 5, chapter = 9 },
		{ name = "守护之剑", region = 5, chapter = 9 },
		{ name = "水晶之刺", region = 5, chapter = 9 },
		{ name = "苏塔恩", region = 5, chapter = 9 },
		{ name = "迅捷微风", region = 5, chapter = 9 },
		{ name = "斩魔者", region = 5, chapter = 9 },
		
		-- Battle Group 10
		{ name = "神圣之歌", region = 5, chapter = 10 },
		{ name = "永夜港", region = 5, chapter = 10 },
		{ name = "安多哈尔", region = 5, chapter = 10 },
		{ name = "大地之怒", region = 5, chapter = 10 },
		{ name = "朵丹尼尔", region = 5, chapter = 10 },
		{ name = "法拉希姆", region = 5, chapter = 10 },
		{ name = "芬里斯", region = 5, chapter = 10 },
		{ name = "风暴之眼", region = 5, chapter = 10 },
		{ name = "加德纳尔", region = 5, chapter = 10 },
		{ name = "密林游侠", region = 5, chapter = 10 },
		{ name = "暮色森林", region = 5, chapter = 10 },
		{ name = "日落沼泽", region = 5, chapter = 10 },
		{ name = "踏梦者", region = 5, chapter = 10 },
		{ name = "提尔之手", region = 5, chapter = 10 },
		{ name = "午夜之镰", region = 5, chapter = 10 },
		{ name = "伊萨里奥斯", region = 5, chapter = 10 },
		{ name = "伊森利恩", region = 5, chapter = 10 },
		{ name = "元素之力", region = 5, chapter = 10 },
		{ name = "金色平原", region = 5, chapter = 10 },
		
		-- Battle Group 11
		{ name = "瓦里玛萨斯", region = 5, chapter = 11 },
		{ name = "阿拉希", region = 5, chapter = 11 },
		{ name = "阿纳克洛斯", region = 5, chapter = 11 },
		{ name = "阿努巴拉克", region = 5, chapter = 11 },
		{ name = "安纳塞隆", region = 5, chapter = 11 },
		{ name = "安其拉", region = 5, chapter = 11 },
		{ name = "巴纳扎尔", region = 5, chapter = 11 },
		{ name = "德拉诺", region = 5, chapter = 11 },
		{ name = "黑手军团", region = 5, chapter = 11 },
		{ name = "黑翼之巢", region = 5, chapter = 11 },
		{ name = "卡拉赞", region = 5, chapter = 11 },
		{ name = "克洛玛古斯", region = 5, chapter = 11 },
		{ name = "克苏恩", region = 5, chapter = 11 },
		{ name = "雷霆之怒", region = 5, chapter = 11 },
		{ name = "龙骨平原", region = 5, chapter = 11 },
		{ name = "破碎岭", region = 5, chapter = 11 },
		{ name = "燃烧军团", region = 5, chapter = 11 },
		{ name = "熔火之心", region = 5, chapter = 11 },
		{ name = "桑德兰", region = 5, chapter = 11 },
		{ name = "血羽", region = 5, chapter = 11 },
		
		-- Battle Group 12
		{ name = "海达希亚", region = 5, chapter = 12 },
		{ name = "范达尔鹿盔", region = 5, chapter = 12 },
		{ name = "格瑞姆巴托", region = 5, chapter = 12 },
		{ name = "古拉巴什", region = 5, chapter = 12 },
		{ name = "哈卡", region = 5, chapter = 12 },
		{ name = "海克泰尔", region = 5, chapter = 12 },
		{ name = "库尔提拉斯", region = 5, chapter = 12 },
		{ name = "奎尔萨拉斯", region = 5, chapter = 12 },
		{ name = "拉贾克斯", region = 5, chapter = 12 },
		{ name = "拉文霍德", region = 5, chapter = 12 },
		{ name = "莱索恩", region = 5, chapter = 12 },
		{ name = "洛丹伦", region = 5, chapter = 12 },
		{ name = "纳克萨玛斯", region = 5, chapter = 12 },
		{ name = "奈法利安", region = 5, chapter = 12 },
		{ name = "萨菲隆", region = 5, chapter = 12 },
		{ name = "森金", region = 5, chapter = 12 },
		{ name = "泰拉尔", region = 5, chapter = 12 },
		{ name = "瓦拉斯塔兹", region = 5, chapter = 12 },
		{ name = "无尽之海", region = 5, chapter = 12 },
		{ name = "永恒之井", region = 5, chapter = 12 },
		
		-- Battle Group 13
		{ name = "艾维娜", region = 5, chapter = 13 },
		{ name = "布莱恩", region = 5, chapter = 13 },
		{ name = "阿卡玛", region = 5, chapter = 13 },
		{ name = "阿扎达斯", region = 5, chapter = 13 },
		{ name = "埃克索图", region = 5, chapter = 13 },
		{ name = "艾莫莉丝", region = 5, chapter = 13 },
		{ name = "巴瑟拉斯", region = 5, chapter = 13 },
		{ name = "达文格尔", region = 5, chapter = 13 },
		{ name = "丹莫德", region = 5, chapter = 13 },
		{ name = "迪瑟洛克", region = 5, chapter = 13 },
		{ name = "恶魔之魂", region = 5, chapter = 13 },
		{ name = "菲拉斯", region = 5, chapter = 13 },
		{ name = "格雷迈恩", region = 5, chapter = 13 },
		{ name = "古加尔", region = 5, chapter = 13 },
		{ name = "黑铁", region = 5, chapter = 13 },
		{ name = "灰谷", region = 5, chapter = 13 },
		{ name = "加基森", region = 5, chapter = 13 },
		{ name = "加里索斯", region = 5, chapter = 13 },
		{ name = "恐怖图腾", region = 5, chapter = 13 },
		{ name = "血顶", region = 5, chapter = 13 },
		
		-- Battle Group 14
		{ name = "逐日者", region = 5, chapter = 14 },
		{ name = "安戈洛", region = 5, chapter = 14 },
		{ name = "奥妮克希亚", region = 5, chapter = 14 },
		{ name = "奥斯里安", region = 5, chapter = 14 },
		{ name = "大漩涡", region = 5, chapter = 14 },
		{ name = "风暴之鳞", region = 5, chapter = 14 },
		{ name = "黑暗虚空", region = 5, chapter = 14 },
		{ name = "荆棘谷", region = 5, chapter = 14 },
		{ name = "诺森德", region = 5, chapter = 14 },
		{ name = "塞拉赞恩", region = 5, chapter = 14 },
		{ name = "瑟莱德丝", region = 5, chapter = 14 },
		{ name = "双子峰", region = 5, chapter = 14 },
		{ name = "塔纳利斯", region = 5, chapter = 14 },
		{ name = "天空之墙", region = 5, chapter = 14 },
		{ name = "托塞德林", region = 5, chapter = 14 },
		{ name = "外域", region = 5, chapter = 14 },
		{ name = "维克尼拉斯", region = 5, chapter = 14 },
		{ name = "伊莫塔尔", region = 5, chapter = 14 },
		{ name = "祖尔金", region = 5, chapter = 14 },
		
		-- Battle Group 15
		{ name = "冰川之拳", region = 5, chapter = 15 },
		{ name = "刺骨利刃", region = 5, chapter = 15 },
		{ name = "冬寒", region = 5, chapter = 15 },
		{ name = "戈杜尼", region = 5, chapter = 15 },
		{ name = "火喉", region = 5, chapter = 15 },
		{ name = "火烟之谷", region = 5, chapter = 15 },
		{ name = "金度", region = 5, chapter = 15 },
		{ name = "米奈希尔", region = 5, chapter = 15 },
		{ name = "莫格莱尼", region = 5, chapter = 15 },
		{ name = "深渊之巢", region = 5, chapter = 15 },
		{ name = "噬灵沼泽", region = 5, chapter = 15 },
		{ name = "巫妖之王", region = 5, chapter = 15 },
		{ name = "伊兰尼库斯", region = 5, chapter = 15 },
		{ name = "幽暗沼泽", region = 5, chapter = 15 },
		{ name = "迦玛兰", region = 5, chapter = 15 },
		
		-- Battle Group 16
		{ name = "亚雷戈斯", region = 5, chapter = 16 },
		{ name = "冬泉谷", region = 5, chapter = 16 },
		{ name = "夺灵者", region = 5, chapter = 16 },
		{ name = "厄祖玛特", region = 5, chapter = 16 },
		{ name = "风暴裂隙", region = 5, chapter = 16 },
		{ name = "烈焰荆棘", region = 5, chapter = 16 },
		{ name = "耐克鲁斯", region = 5, chapter = 16 },
		{ name = "塞拉摩", region = 5, chapter = 16 },
		{ name = "瑟玛普拉格", region = 5, chapter = 16 },
		{ name = "石锤", region = 5, chapter = 16 },
		{ name = "岩石巨塔", region = 5, chapter = 16 },
		{ name = "伊森德雷", region = 5, chapter = 16 },
		{ name = "扎拉赞恩", region = 5, chapter = 16 },
		
		-- Battle Group 17
		{ name = "艾露恩", region = 5, chapter = 17 },
		{ name = "阿古斯", region = 5, chapter = 17 },
		{ name = "奥金顿", region = 5, chapter = 17 },
		{ name = "刀塔", region = 5, chapter = 17 },
		{ name = "迪门修斯", region = 5, chapter = 17 },
		{ name = "凤凰之神", region = 5, chapter = 17 },
		{ name = "格鲁尔", region = 5, chapter = 17 },
		{ name = "哈兰", region = 5, chapter = 17 },
		{ name = "黑暗之门", region = 5, chapter = 17 },
		{ name = "军团要塞", region = 5, chapter = 17 },
		{ name = "玛克扎尔", region = 5, chapter = 17 },
		{ name = "麦姆", region = 5, chapter = 17 },
		{ name = "深渊之喉", region = 5, chapter = 17 },
		{ name = "死亡熔炉", region = 5, chapter = 17 },
		{ name = "无底海渊", region = 5, chapter = 17 },
		{ name = "鲜血熔炉", region = 5, chapter = 17 },
		{ name = "血槌", region = 5, chapter = 17 },
		
		-- Battle Group 18
		{ name = "翡翠梦境", region = 5, chapter = 18 },
		{ name = "暗影迷宫", region = 5, chapter = 18 },
		{ name = "范克里夫", region = 5, chapter = 18 },
		{ name = "雷德", region = 5, chapter = 18 },
		{ name = "罗曼斯", region = 5, chapter = 18 },
		{ name = "摩摩尔", region = 5, chapter = 18 },
		{ name = "末日祷告祭坛", region = 5, chapter = 18 },
		{ name = "穆戈尔", region = 5, chapter = 18 },
		{ name = "破碎大厅", region = 5, chapter = 18 },
		{ name = "塞泰克", region = 5, chapter = 18 },
		{ name = "试炼之环", region = 5, chapter = 18 },
		{ name = "太阳之井", region = 5, chapter = 18 },
		{ name = "托尔巴拉德", region = 5, chapter = 18 },
		{ name = "瓦丝琪", region = 5, chapter = 18 },
		{ name = "希雷诺斯", region = 5, chapter = 18 },
		{ name = "蒸汽地窟", region = 5, chapter = 18 },
		{ name = "祖阿曼", region = 5, chapter = 18 },
		{ name = "祖达克", region = 5, chapter = 18 },
		
		-- Battle Group 19
		{ name = "贫瘠之地", region = 5, chapter = 19 },
		{ name = "阿比迪斯", region = 5, chapter = 19 },
		{ name = "阿曼尼", region = 5, chapter = 19 },
		{ name = "阿斯塔洛", region = 5, chapter = 19 },
		{ name = "安苏", region = 5, chapter = 19 },
		{ name = "白骨荒野", region = 5, chapter = 19 },
		{ name = "壁炉谷", region = 5, chapter = 19 },
		{ name = "布鲁塔卢斯", region = 5, chapter = 19 },
		{ name = "达尔坎", region = 5, chapter = 19 },
		{ name = "达基萨斯", region = 5, chapter = 19 },
		{ name = "菲米丝", region = 5, chapter = 19 },
		{ name = "盖斯", region = 5, chapter = 19 },
		{ name = "戈提克", region = 5, chapter = 19 },
		{ name = "加尔", region = 5, chapter = 19 },
		{ name = "末日行者", region = 5, chapter = 19 },
		{ name = "能源舰", region = 5, chapter = 19 },
		{ name = "生态船", region = 5, chapter = 19 },
		{ name = "血吼", region = 5, chapter = 19 },
		{ name = "迦顿", region = 5, chapter = 19 },
		{ name = "熵魔", region = 5, chapter = 19 },
		
		-- Battle Group 20
		{ name = "嚎风峡湾", region = 5, chapter = 20 },
		{ name = "霍格", region = 5, chapter = 20 },
		{ name = "奎尔丹纳斯", region = 5, chapter = 20 },
		{ name = "莉亚德琳", region = 5, chapter = 20 },
		{ name = "玛格曼达", region = 5, chapter = 20 },
		{ name = "莫加尔", region = 5, chapter = 20 },
		{ name = "沙怒", region = 5, chapter = 20 },
		{ name = "斯克提斯", region = 5, chapter = 20 },
		
		-- Battle Group 21
		{ name = "迦拉克隆", region = 5, chapter = 21 },
		{ name = "安格博达", region = 5, chapter = 21 },
		{ name = "安加萨", region = 5, chapter = 21 },
		{ name = "奥尔加隆", region = 5, chapter = 21 },
		{ name = "达克萨隆", region = 5, chapter = 21 },
		{ name = "冬拥湖", region = 5, chapter = 21 },
		{ name = "风暴峭壁", region = 5, chapter = 21 },
		{ name = "古达克", region = 5, chapter = 21 },
		{ name = "黑锋哨站", region = 5, chapter = 21 },
		{ name = "兰娜瑟尔", region = 5, chapter = 21 },
		{ name = "洛肯", region = 5, chapter = 21 },
		{ name = "玛洛加尔", region = 5, chapter = 21 },
		{ name = "莫德雷萨", region = 5, chapter = 21 },
		{ name = "萨塔里奥", region = 5, chapter = 21 },
		{ name = "亡语者", region = 5, chapter = 21 },
		{ name = "影之哀伤", region = 5, chapter = 21 },
		{ name = "远古海滩", region = 5, chapter = 21 },
		{ name = "织亡者", region = 5, chapter = 21 },
		
};

StaticPopupDialogs["PREMADEFILTER_CONFIRM_CLOSE"] = {
	text = T("Automatic monitoring of new groups in background is broken since patch 7.2. It was forbidden by Blizzard and is no longer possible. See https://us.battle.net/forums/en/wow/topic/20754326419 for more details.\n\nYou can manually trigger background search by assigning key binding."),
	button1 = OKAY,
	button2 = NO,
	OnShow = function(self)
		PremadeFilter_Frame.closeConfirmation = true;
	end,
	OnHide = function(self)
		PremadeFilter_Frame.closeConfirmation = false;
	end,
	OnAccept = function(self, arg1, reason)
		if PremadeFilter_Frame:IsVisible() then
			PremadeFilter_Frame.ShowNextTime = true;
			
			HideUIPanel(PVEFrame);
			
			PremadeFilter_MinimapButton:Show();
			PremadeFilter_MinimapButton.Eye:Show();
			EyeTemplate_StartAnimating(PremadeFilter_MinimapButton.Eye);
			
			PremadeFilter_StartMonitoring();
		end
	end,
	OnCancel = function(self, arg1, reason)
		PremadeFilter_Frame.ShowNextTime = false;
		PremadeFilter_Frame:Hide();
		PremadeFilter_Frame.AdvancedButton:Enable();
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

StaticPopupDialogs["PREMADEFILTER_SAVE_FILTERSET"] = {
	text = T("Enter filter set name"),
	hasEditBox = true,
	maxLetters = 100,
	editBoxWidth = 350,
	button1 = SAVE,
	button2 = CANCEL,
	OnShow = function(self)
		local defaultText = T("New filter set");
		local index = PremadeFilter_Frame.selectedFilterSet;
		local text;
		if index <= #PremadeFilter_Data.FilterSetsOrder then
			text = PremadeFilter_Data.FilterSetsOrder[index];
		else
			text = defaultText;
		end
		self.editBox:SetText(text);
		self.editBox:SetFocus();
	end,
	OnAccept = function(self, arg1, reason)
		local defaultText = T("New filter set");
		local text = self.editBox:GetText():gsub("^%s*(.-)%s*$", "%1");
		
		if text == defaultText or text == "" then
			local index = 2;
			repeat
				text = string.format("%s %d", defaultText, index);
				index = index + 1;
			until not PremadeFilter_Data.FilterSets[text];
		end
		
		if type(PremadeFilter_Data.FilterSets[text]) ~= "table" then
			table.insert(PremadeFilter_Data.FilterSetsOrder, text);
			PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder;
		end

		PremadeFilter_Data.FilterSets[text] = PremadeFilter_GetFilters();
		
		PremadeFilter_FixFilterSets();
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

StaticPopupDialogs["PREMADEFILTER_CONFIRM_DELETE"] = {
	text = T("Are you sure you want to delete filter set?"),
	button1 = YES,
	button2 = NO,
	OnAccept = function(self, arg1, reason)
		local index = PremadeFilter_Frame.selectedFilterSet;
	
		if index <= #PremadeFilter_Data.FilterSetsOrder then
			local text = table.remove(PremadeFilter_Data.FilterSetsOrder, index);
			PremadeFilter_Data.FilterSets[text] = nil;
			
			PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder + 1;
			PremadeFilter_SetFilters({
				category	= PremadeFilter_Frame.selectedCategory,
				group		= PremadeFilter_Frame.selectedGroup,
				activity	= PremadeFilter_Frame.selectedActivity,
			});
		end
	end,
	timeout = 0,
	whileDead = true,
	hideOnEscape = true,
	preferredIndex = 3
}

PremadeFilter_HelpPlate = {
	FramePos = { x = 0,  y = -22 },
	FrameSize = { width = 817, height = 409 },
	
	[1]  = { ButtonPos = { x = 280, y = -25  }, HighLightBox = { x = 23, y = -33,  width = 296, height = 84  },  ToolTipDir = "UP",    ToolTipText = 
		T("Select group activity: quest, dungeon, raid, difficulty") },
	[2]  = { ButtonPos = { x = 280, y = -119 }, HighLightBox = { x = 23, y = -127, width = 296, height = 119 },  ToolTipDir = "RIGHT", ToolTipText = 
		T("Enter the words you want to be present or absent in group title and comment.").."\n\n"..
		T("Click [+] to open window within extended features.") },
	[3]  = { ButtonPos = { x = 148, y = -241 }, HighLightBox = { x = 23, y = -250, width = 296, height = 27  },  ToolTipDir = "UP",    ToolTipText = 
		T("Select the roles you can fulfill.").."\n\n"..
		T("If a group is not created by the addon this option is ignored.") },
	[4]  = { ButtonPos = { x = 280, y = -302 }, HighLightBox = { x = 23, y = -281, width = 296, height = 60  },  ToolTipDir = "DOWN",  ToolTipText = 
		T("If you want to join a group of highly equipped characters you can setup minimum item level defined for its members.").."\n\n"..
		T("You can find a group that uses specific voice chat software or a group tha doesn't use voice chat at all.") },
	[5]  = { ButtonPos = { x = 516, y = -25  }, HighLightBox = { x = 322, y = -33,  width = 233, height = 213 },  ToolTipDir = "UP",   ToolTipText = 
		T("You can mark the bosses you want to be still alive with [v] and the bosses you want to be already defeated by [-].") },
	[6]  = { ButtonPos = { x = 516, y = -302 }, HighLightBox = { x = 322, y = -250, width = 233, height = 91  },  ToolTipDir = "DOWN", ToolTipText = 
		T("Define minimum and/or maximum number of players of any role.").."\n\n"..
		T("For example if you are a tank you can set maximum number of tanks to 1 and you get the groups you are guaranteed to have a spot.") },
	[7]  = { ButtonPos = { x = 655, y = -302 }, HighLightBox = { x = 558, y = -33,  width = 239, height = 308 },  ToolTipDir = "UP",   ToolTipText = 
		T("Want to find a mythic raid? Choose your realm only.") },
	[8]  = { ButtonPos = { x = 793, y = 22   }, HighLightBox = { x = 558, y = 21,   width = 258, height = 43  },  ToolTipDir = "UP",   ToolTipText = 
		T("You can save the filters to use them in future.") },
	[9]  = { ButtonPos = { x = 122, y = -350 }, HighLightBox = { x = 0,   y = -355, width = 145, height = 36  }, ToolTipDir = "DOWN",  ToolTipText = 
		T("By hiding the window you can activate background search so you can do anything else in the game.").."\n\n"..
		T("The addon notifies you if it finds a group that matches your requirements.") },
	[10] = { ButtonPos = { x = 791, y = -350 }, HighLightBox = { x = 669, y = -355, width = 145, height = 36  }, ToolTipDir = "DOWN",  ToolTipText = 
		T("The filters take effect when you click this button. The changes don't take effect until you do that.") },
}

PremadeFilter_HelpFilters = {
	["ilvl"] = 123,
	["maxHealers"] = 3,
	["group"] = 14,
	["minHealers"] = 2,
	["bosses"] = {},
	["maxTanks"] = 1,
	["realms"] = "-aeriepeak-agamaggan-aggra(português)-aggramar-ahn'qiraj-al'akir-alonsus-anachronos-arathor-argentdawn-aszune-auchindoun-azjol-nerub-azuremyst-balnazzar-blade'sedge-bladefist-bloodfeather-bloodhoof-bloodscalp-boulderfist-bronzedragonflight-bronzebeard-burningblade-burninglegion-burningsteppes-chamberofaspects-chromaggus-crushridge-daggerspine-darkmoonfaire-darksorrow-darkspear-deathwing-defiasbrotherhood-dentarg-doomhammer-draenor-dragonblight-dragonmaw-drak'thul-dunemaul-earthenring-emeralddream-emeriss-eonar-executus-frostmane-frostwhisper-genjuros-ghostlands-grimbatol-hakkar-haomarush-hellfire-hellscream-jaedenar-karazhan-kazzak-khadgar-kilrogg-kor'gall-kultiras-laughingskull-lightbringer-lightning'sblade-magtheridon-mazrigos-moltencore-moonglade-nagrand-neptulon-nordrassil-outland-quel'thalas-ragnaros-ravencrest-ravenholdt-runetotem-saurfang-scarshieldlegion-shadowmoon-shadowsong-shatteredhalls-shatteredhand-silvermoon-skullcrusher-spinebreaker-sporeggar-steamwheedlecartel-stonemaul-stormrage-stormreaver-stormscale-sunstrider-sylvanas-talnivarr-tarrenmill-terenas-terokkar-themaelstrom-thesha'tar-theventurecoeu-thunderhorn-trollbane-turalyon-twilight'shammer-twistingnether-vashj-vek'nilash-warsong-wildhammer-xavius-zenedar-c'thun-colinaspardas-dunmodr-exodar-loserrantes-minahonda-sanguino-shen'dralar-tyrande-uldum-zul'jin-aggra-nemesis",
	["name"] = {
		["include"] = {
			"norm", -- [1]
		},
		["possible"] = {
			"tank", -- [1]
			"dps", -- [2]
		},
		["exclude"] = {
			"farm", -- [1]
		},
	},
	["category"] = 3,
	["roles"] = 5,
	["activity"] = 38,
	["vc"] = {
		["none"] = true,
		["text"] = "",
	},
}
local savedInstances = {}

local function UpdateSavedInstances ()
	local instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName;
	local savedInstanceCount = GetNumSavedInstances();
	
	for index=1, savedInstanceCount do		
		instanceName, instanceID, instanceReset, instanceDifficulty, locked, extended, instanceIDMostSig, isRaid, maxPlayers, difficultyName = GetSavedInstanceInfo(index);
		if(isRaid == false and locked == true) then
			savedInstances[instanceID.."-"..instanceDifficulty] = true
		end
	end

end

function PremadeFilter_ToggleTutorial()
	local helpPlate = PremadeFilter_HelpPlate;
	if ( helpPlate and not HelpPlate_IsShowing(helpPlate) ) then
		helpPlate.oldFilters = PremadeFilter_GetFilters();
		
		PremadeFilter_SetFilters(PremadeFilter_HelpFilters);
		local bossAlive = PremadeFilter_Frame_BossListButton3BossName:GetText();
		local bossDefeated = PremadeFilter_Frame_BossListButton4BossName:GetText();
		PremadeFilter_HelpFilters.bosses[bossAlive] = true;
		PremadeFilter_HelpFilters.bosses[bossDefeated] = false;
		PremadeFilter_SetFilters(PremadeFilter_HelpFilters);
		
		HelpPlate_Show( helpPlate, PremadeFilter_Frame, PremadeFilter_Frame.MainHelpButton, true );
		PremadeFilter_Data.HideTutorial = true;
	else
		HelpPlate_Hide(true);
		PremadeFilter_SetFilters(helpPlate.oldFilters);
	end
end

function PremadeFilter_Frame_OnLoad(self)
	self:RegisterEvent("LFG_LIST_APPLICANT_LIST_UPDATED");
	self:RegisterEvent("ADDON_LOADED");
	self:RegisterEvent("CHAT_MSG_ADDON");
	self:RegisterEvent("UPDATE_INSTANCE_INFO")
	
	LFGListFrame.SearchPanel.SearchBox:SetSize(205, 18);
	LFGListFrame.SearchPanel.SearchBox:SetMaxLetters(1023);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnEditFocusGained", nop);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.SearchPanel.SearchBox:SetScript("OnTextChanged", LFGListFrameSearchBox_OnTextChanged);
	LFGListFrame.SearchPanel.AutoCompleteFrame:Hide();
	
	LFGListFrame.EntryCreation.Description:SetSize(283, 22);
	LFGListFrame.EntryCreation.Description.EditBox:SetMaxLetters(LFGListFrame.EntryCreation.Description.EditBox:GetMaxLetters()-2);
	
	LFGListFrame.EntryCreation.Name:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.Description.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SetScript("OnTabPressed", LFGListEditBox_OnTabPressed);
	
	LFGListFrame.EntryCreation.ItemLevel.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_OnClick);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.ItemLevel.EditBox:Hide();
	
	LFGListFrame.EntryCreation.VoiceChat.CheckButton:SetScript("OnClick", PremadeFilter_CheckButton_OnClick);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:SetScript("OnEditFocusLost", nop);
	LFGListFrame.EntryCreation.VoiceChat.EditBox:Hide();
	
	PremadeFilter_Roles:SetParent(LFGListFrame.EntryCreation);
	PremadeFilter_Roles:SetPoint("TOPLEFT", LFGListFrame.EntryCreation, "TOPLEFT", -10, -20);
	
	self.AdvancedButton:SetParent(LFGListFrame.SearchPanel);
	self.AdvancedButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.RefreshButton, "TOPLEFT", 0, 0);
	
	self:SetParent(LFGListFrame.SearchPanel);
	self:SetPoint("TOPLEFT", LFGListFrame.SearchPanel, "TOPRIGHT", 10, -20);
	
	self.Name.Instructions:SetText(LFG_LIST_ENTER_NAME);
	self.Description.EditBox:SetScript("OnEnterPressed", nop);
	
	LFGListUtil_SetUpDropDown(self, self.CategoryDropDown, LFGListEntryCreation_PopulateCategories, PremadeFilter_OnCategorySelected);
	LFGListUtil_SetUpDropDown(self, self.GroupDropDown, LFGListEntryCreation_PopulateGroups, PremadeFilter_OnGroupSelected);
	LFGListUtil_SetUpDropDown(self, self.ActivityDropDown, LFGListEntryCreation_PopulateActivities, PremadeFilter_OnActivitySelected);
	LFGListEntryCreation_SetBaseFilters(self, 0);
	
	PremadeFilter_OnHide(self);
	
	self.baseFilters = LE_LFG_LIST_FILTER_PVE;
	self.selectedFilters = LE_LFG_LIST_FILTER_PVE;
	self.results = {};
	self.minAge = {};
	self.availableBosses = nil;
	self.realmName = GetRealmName();
	self.realmInfo = PremadeFilter_GetRealmInfo(GetCurrentRegion(), self.realmName);
	self.realmList = PremadeFilter_GetRegionRealms(self.realmInfo);
	self.visibleRealms = PremadeFilter_GetVisibleRealms();
	self.query = "";
	self.updated = {};
	self.freshResults = {};
	self.resultInfo = {};
	self.chatNotifications = {};
	self.selectedFilterSet = 0;
	
	PremadeFilter_RealmList_Update();
	
	QueueStatusMinimapButton:HookScript("OnShow", 
		function() 
			--self.MinimizeButton:Disable();
			PremadeFilter_StopMonitoring(); 
		end
	);
	QueueStatusMinimapButton:HookScript("OnHide", 
		function() 
			--self.MinimizeButton:Enable(); 
		end
	);
	
	self.oldHyperlinkClick = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkClick");
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkClick", PremadeFilter_Hyperlink_OnClick);
	
	self.oldHyperlinkEnter = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkEnter");
	self.oldHyperlinkLeave = DEFAULT_CHAT_FRAME:GetScript("OnHyperlinkLeave");
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkEnter", PremadeFilter_Hyperlink_OnEnter);
	DEFAULT_CHAT_FRAME:SetScript("OnHyperlinkLeave", PremadeFilter_Hyperlink_OnLeave);
	
	RegisterAddonMessagePrefix("PREMADE_FILTER");
	
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", PremadeFilter_ChatFilter);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", PremadeFilter_ChatFilter);
	ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", PremadeFilter_ChatFilter);
	
	LeaveChannelByName("PremadeFilter");
end

function PremadeFilter_OnEvent(self, event, ...)
	if event == "ADDON_LOADED" then
		local addonName = ...;
		if addonName == "premade-filter" then
			if not PremadeFilter_Data then
				PremadeFilter_Data = {};
			end
		end
	elseif event == "LFG_LIST_APPLICANT_LIST_UPDATED" then
		PremadeFilter_OnApplicantListUpdated(self, event, ...);
	elseif event == "UPDATE_INSTANCE_INFO" then
		UpdateSavedInstances()
	
	elseif event == "CHAT_MSG_ADDON" then
		local prefix, msg, channel, sender = ...;
		
		if prefix == "PREMADE_FILTER" then
			if msg == "VER?" then
				local player = UnitName("player");
				local version = GetAddOnMetadata("premade-filter", "Version");
				
				SendAddonMessage("PREMADE_FILTER", "VER!"..player..":"..version, "WHISPER", sender);
				
				if SLASH_PFD1 then
					PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, sender.." requested addon version");
				end
			elseif msg:sub(1,4) == "VER!" then
				local version = GetAddOnMetadata("premade-filter", "Version");
				local recievedVersion = msg:gsub("^VER%!(.+):(.+)$", "%2");
				
				if recievedVersion > version then
					if not self.VersionLabel:IsShown() then
						self.VersionLabel:Show();
						self.VersionLabel:SetText(T("New version available"));
						PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, T("New version available"));
					end
				end
				
				if SLASH_PFD1 then
					PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, msg:sub(5));
				end
			end
		end
	end
end

function PremadeFilter_ChatFilter(self, event, msg, author, arg5, arg6, arg7, arg8, arg9, arg10, channelName, ...)
	if channelName == "PremadeFilter" then
		return true;
	else
		return false, msg, author, arg5, arg6, arg7, arg8, arg9, arg10, channelName, ...
	end
end

function PremadeFilter_FixSettings()
	if type(PremadeFilter_Data.Settings) ~= "table" then
		PremadeFilter_Data.Settings = PremadeFilter_DefaultSettings;
	end
	
	if not PremadeFilter_Data.Settings.Version then
		PremadeFilter_Data.Settings = PremadeFilter_DefaultSettings;
		PremadeFilter_Data.Settings.Version = GetAddOnMetadata("premade-filter", "Version");
	elseif PremadeFilter_Data.Settings.Version == "0.8.4" then
		PremadeFilter_Data.Settings.NewGroupChatNotifications = PremadeFilter_DefaultSettings.NewGroupChatNotifications;
		PremadeFilter_Data.Settings.NewPlayerChatNotifications = PremadeFilter_Data.Settings.ChatNotifications;
		PremadeFilter_Data.Settings.ChatNotifications = nil;
		PremadeFilter_Data.Settings.Version = "0.9.94";
	end
	
	if type(PremadeFilter_Data.Settings.UpdateInterval) ~= "number"
		  or PremadeFilter_Data.Settings.UpdateInterval < 2
		  or PremadeFilter_Data.Settings.UpdateInterval > 60
	then
		PremadeFilter_Data.Settings.UpdateInterval = PremadeFilter_DefaultSettings.UpdateInterval;
	end
	
	if type(PremadeFilter_Data.Settings.MaxRecentWords) ~= "number"
		  or PremadeFilter_Data.Settings.MaxRecentWords < 5
		  or PremadeFilter_Data.Settings.MaxRecentWords > 20
	then
		PremadeFilter_Data.Settings.MaxRecentWords = PremadeFilter_DefaultSettings.MaxRecentWords;
	end
end

function PremadeFilter_SetSettings(name, value)
	PremadeFilter_FixSettings();
	
	if name then
		PremadeFilter_Data.Settings[name] = value;
	else
		PremadeFilter_Data.Settings = value;
	end
	
	PremadeFilter_FixSettings();
end

function PremadeFilter_GetSettings(name)
	PremadeFilter_FixSettings();
	
	if name then
		if PremadeFilter_Data.Settings[name] == nil then
			PremadeFilter_Data.Settings[name] = PremadeFilter_DefaultSettings[name];
		end
		return PremadeFilter_Data.Settings[name];
	else
		return PremadeFilter_Data.Settings;
	end
end

function PremadeFilter_OnShow(self)
	if not PremadeFilter_Data.HideTutorial then
		PremadeFilter_ToggleTutorial();
	end
	
	local categoryID = LFGListFrame.categoryID
	local baseFilters = LFGListFrame.baseFilters;
	
	self.categoryID = categoryID;
	self.baseFilters = baseFilters;

	local selectedCategory;
	local selectedFilters;
	local selectedGroup;
	local selectedActivity;
	
	if self.selectedCategory ~= LFGListFrame.CategorySelection.selectedCategory or self.selectedFilters ~= LFGListFrame.CategorySelection.selectedFilters then
		selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
		selectedFilters = LFGListFrame.CategorySelection.selectedFilters;
		selectedGroup = nil;
		selectedActivity = nil;
	else
		selectedCategory = self.selectedCategory;
		selectedFilters = self.selectedFilters;
		selectedGroup = self.selectedGroup;
		selectedActivity = self.selectedActivity;
	end
	
	LFGListEntryCreation_Select(self, selectedFilters, selectedCategory, selectedGroup, selectedActivity);
	
	if type(self.availableBosses) ~= "table" or #(self.availableBosses) <= 0 then
		self.availableBosses = PremadeFilter_GetAvailableBosses();
		PremadeFilter_BossList_Update();
	end
	
	self.QueryBuilder:SetParent(self);
	self.QueryBuilder:SetPoint("TOPLEFT", self, "TOPLEFT", 5, -5);
	self.QueryBuilder:SetPoint("BOTTOMRIGHT", self, "BOTTOMRIGHT", -5, 5);
	self.QueryBuilder:SetFrameStrata("DIALOG");
	self.Name.BuildButton:SetParent(self.Name);
	self.Name.BuildButton:SetPoint("TOPRIGHT", self.Name, "TOPRIGHT", 0, -1);
	
	self.AdvancedButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up");
	self.AdvancedButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down");
	self.AdvancedButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled");
	
	LFGListFrameSearchBox_OnTextChanged(LFGListFrame.SearchPanel.SearchBox);
	
	if PremadeFilter_Frame.ShowNextTime then
		PremadeFilter_MinimapButton:Hide();
		PremadeFilter_MinimapButton.Eye:Hide();
		EyeTemplate_StopAnimating(PremadeFilter_MinimapButton.Eye);
	else
		LFGListSearchPanel_DoSearch(PremadeFilter_Frame:GetParent());
	end
	
	PremadeFilter_StopNotification();
	
	if not self.VersionLabel:IsShown() then
		local guildName = GetGuildInfo("player")
		if guildName then
			SendAddonMessage("PREMADE_FILTER", "VER?", "GUILD");
		end
	end
	
	LeaveChannelByName("PremadeFilter");
	
	PlaySound(SOUNDKIT.IG_MAINMENU_OPEN);
end

function PremadeFilter_OnHide(self)
	self.QueryBuilder:SetParent(LFGListFrame);
	self.QueryBuilder:SetPoint("TOPLEFT", LFGListFrame, "TOPLEFT", -5, -21);
	self.QueryBuilder:SetPoint("BOTTOMRIGHT", LFGListFrame, "BOTTOMRIGHT", -2, 2);
	self.QueryBuilder:SetFrameStrata("DIALOG");
	self.QueryBuilder:Hide();
	
	self.Name.BuildButton:SetParent(LFGListFrame.SearchPanel.SearchBox);
	self.Name.BuildButton:SetPoint("TOPRIGHT", LFGListFrame.SearchPanel.SearchBox, "TOPRIGHT", -1, 1);
	
	self.AdvancedButton:SetNormalTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up");
	self.AdvancedButton:SetPushedTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down");
	self.AdvancedButton:SetDisabledTexture("Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled");

	StaticPopup_Hide("PREMADEFILTER_CONFIRM_CLOSE");
	StaticPopup_Hide("PREMADEFILTER_SAVE_FILTERSET");
	
	local helpPlate = PremadeFilter_HelpPlate;
	if HelpPlate_IsShowing(helpPlate) then
		HelpPlate_Hide();
		PremadeFilter_SetFilters(helpPlate.oldFilters);
	end
end

function PremadeFilter_Toggle()
	if PremadeFilter_Frame:IsVisible() then
		if QueueStatusMinimapButton:IsVisible() or PremadeFilter_Frame.closeConfirmation then
			PremadeFilter_Frame:Hide();
		else
			StaticPopup_Show("PREMADEFILTER_CONFIRM_CLOSE");
		end
	else
		PremadeFilter_Frame:Show();
	end
end

function LFGListSearchPanel_Clear(self)
	C_LFGList.ClearSearchResults();
	self.SearchBox:SetText(PremadeFilter_Frame.query);
	self.selectedResult = nil;
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
end

function LFGListFrameSearchBox_OnTextChanged(self)
	local text = self:GetText();
	
	PremadeFilter_Frame.query = text;
	PremadeFilter_Frame.Name:SetText(text);
	
	InputBoxInstructions_OnTextChanged(self);
end

function LFGListEditBox_OnTabPressed(self)
	if ( self.tabCategory ) then
		local step = IsShiftKeyDown() and -1 or 1;
		local offset = step;
		local cat = LFG_LIST_EDIT_BOX_TAB_CATEGORIES[self.tabCategory];
		if ( cat ) then
			--It's times like this when I wish Lua was 0-based...
			repeat
				local index = ((self.tabCategoryIndex - 1 + offset + #cat) % #cat) + 1;
				local input = cat[index];
				if input:IsVisible() then
					input:SetFocus();
				else
					offset = offset + step;
				end
			until input:IsVisible();
		end
	end
end

function PremadeFilter_FilterButton_OnClick(self)
	LFGListSearchPanel_SetCategory(LFGListFrame.SearchPanel, PremadeFilter_Frame.selectedCategory, PremadeFilter_Frame.selectedFilters, PremadeFilter_Frame.baseFilters);
	LFGListSearchPanel_DoSearch(self:GetParent():GetParent());
end

function PremadeFilter_GetAvailableBosses()
	local bossList = {};
	local activityIndex = string.format("%d-%d-%d", PremadeFilter_Frame.selectedCategory, PremadeFilter_Frame.selectedGroup, PremadeFilter_Frame.selectedActivity);
	local activity = PremadeFilter_ActivityInfo[activityIndex];	
	if ( not EncounterJournal ) then
		EncounterJournal_LoadUI();
	end
	
	if type(activity) == "table" then		
		EncounterJournal_TierDropDown_Select(nil, activity.tier);
		
		local instanceID = EJ_GetInstanceByIndex(activity.instance, activity.raid);
		
		if GetLocale() == "zhCN" then --Fix zhCN UI API bug (https://twitter.com/liruqi/status/946870306873909248)
			if activity.tier == 7 and activity.instance == 6 and instanceID == 959 then
				instanceID = 946
			end
		end
		
		EncounterJournal_DisplayInstance(instanceID);
		
		if activity.difficulty then
			EncounterJournal_SelectDifficulty(nil, activity.difficulty);
		end
		
		local encounter = 1;
		local boss
		repeat
			boss = EJ_GetEncounterInfoByIndex(encounter, instanceID);
			if boss then
				table.insert(bossList, { name = boss });
			end
			encounter = encounter + 1;
		until not boss;
	end
	
	--output(PremadeFilter_Frame.selectedCategory.."-"..PremadeFilter_Frame.selectedGroup.."-"..PremadeFilter_Frame.selectedActivity);
	
	return bossList;
end

function PremadeFilter_GetRealmInfo(region, realmName)
	for index, info in pairs(PremadeFilter_Relams) do
		if info.region == region and info.name == realmName then
			return info;
		end
	end
	
	return nil;
end

function PremadeFilter_GetRegionRealms(realmInfo)
	if not realmInfo then
		return nil;
	end
	
	local realmList = {};
	local chapter = nil;
	local currentChapterIndex = nil;
	
	for index, info in pairs(PremadeFilter_Relams) do
		if info.region == realmInfo.region then
			if info.chapter ~= chapter then
				chapter = info.chapter;
				currentChapterIndex = #realmList + 1;
				
				-- add chapter
				table.insert(realmList, {
					isChapter = true,
					isCollapsed = true,
					name = PremadeFilter_RealmChapters[info.region][info.chapter],
					region = info.region,
					chapter = info.chapter,
					index = currentChapterIndex,
					isChecked = true
				});
			end
			
			-- add realm
			info.index = #realmList + 1;
			info.chapterIndex = currentChapterIndex;
			info.isChecked = true;
			table.insert(realmList, info);
		end
	end
	
	return realmList;
end

function PremadeFilter_GetVisibleRealms()
	local visibleRealms = {};
	
	if PremadeFilter_Frame.realmList then
		for i=1, #PremadeFilter_Frame.realmList do
			local info = PremadeFilter_Frame.realmList[i];
			if info.isChapter or not PremadeFilter_Frame.realmList[info.chapterIndex].isCollapsed then
				table.insert(visibleRealms, info);
			end
		end
	end
	
	return visibleRealms;
end

function PremadeFilter_GetSelectedRealms()
	if not PremadeFilter_Frame.realmList then
		return nil;
	end
	
	local selectedRealms = {""};
	local totalRealms = 1;
	
	for i=1, #PremadeFilter_Frame.realmList do
		local info = PremadeFilter_Frame.realmList[i];
		if not info.isChapter then
			totalRealms = totalRealms + 1;
			if info.isChecked then
				local name = info.name:gsub("[%s%']+", "");
				table.insert(selectedRealms, name:lower());
			end
		end
	end
	
	if #selectedRealms == totalRealms then
		-- all realms selected
		return nil;
	else
		return selectedRealms;
	end
end

function PremadeFilter_ExpandOrCollapseButton_OnClick(self, button)
	local info = self:GetParent().info;
	
	PremadeFilter_Frame.realmList[info.index].isCollapsed = not info.isCollapsed;
	PremadeFilter_Frame.visibleRealms = PremadeFilter_GetVisibleRealms();
	
	PremadeFilter_RealmList_Update();
end

function PremadeFilter_RealmListCheckButton_OnClick(button, category, dungeonList, hiddenByCollapseList)
	local info = button:GetParent().info;
	local update = info.isChapter and not info.isCollapsed;
	local isChecked = button:GetChecked();
	
	if info.isChapter then
		local chapter = info.chapter;
		local index = info.index;
		repeat
			PremadeFilter_Frame.realmList[info.index].isChecked = isChecked;
			info = PremadeFilter_Frame.realmList[info.index+1];
		until not info or info.isChapter;
	else
		PremadeFilter_Frame.realmList[info.index].isChecked = isChecked;
		
		local chapterInfo = PremadeFilter_Frame.realmList[info.chapterIndex];
		local chapterChecked = true;
		info = PremadeFilter_Frame.realmList[chapterInfo.index + 1];
		repeat
			chapterChecked = chapterChecked and info.isChecked;
			info = PremadeFilter_Frame.realmList[info.index+1];
		until not chapterChecked or not info or info.isChapter;
		
		if chapterChecked ~= chapterInfo.isChecked then
			PremadeFilter_Frame.realmList[chapterInfo.index].isChecked = chapterChecked;
			update = true;
		end
	end
	
	if update then
		PremadeFilter_RealmList_Update();
	end
	
	PlaySound(isChecked and SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON or SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
end

function PremadeFilter_BossList_Update()
	FauxScrollFrame_Update(PremadeFilter_Frame_BossListScrollFrame, #PremadeFilter_Frame.availableBosses, 10, 16);
	
	local offset = FauxScrollFrame_GetOffset(PremadeFilter_Frame_BossListScrollFrame);
	
	for i = 1, 10 do
		local button = _G["PremadeFilter_Frame_BossListButton"..i];
		local bossIndex = i+offset;
		local info = PremadeFilter_Frame.availableBosses[bossIndex];
		if info then
			if type(info.isChecked) == "nil" then
				button.statusButton.CheckedNone = false;
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
				button.statusButton:SetChecked(false);
				button.bossName:SetTextColor(0.7, 0.7, 0.7);
			elseif info.isChecked then
				button.statusButton.CheckedNone = false;
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
				button.statusButton:SetChecked(true);
				button.bossName:SetTextColor(0, 1, 0);
			else
				button.statusButton.CheckedNone = true;
				button.statusButton:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up");
				button.statusButton:SetChecked(true);
				button.bossName:SetTextColor(1, 0, 0);
			end
			
			button.bossName:SetText(info.name);
			button.bossName:SetFontObject(QuestDifficulty_Header);
			button:SetWidth(195);
			button:Show();
		else
			button:Hide();
		end
		button.bossIndex = bossIndex;
	end
end

function PremadeFilter_RealmList_Update()
	FauxScrollFrame_Update(PremadeFilter_Frame_RealmListScrollFrame, #PremadeFilter_Frame.visibleRealms, 16, 16);
	
	local offset = FauxScrollFrame_GetOffset(PremadeFilter_Frame_RealmListScrollFrame);
	
	for i = 1, 16 do
		local button = _G["PremadeFilter_Frame_RealmListButton"..i];
		local info = PremadeFilter_Frame.visibleRealms[i+offset];
		if info then
			button.info = info;
			button.instanceName:SetText(info.name);
			button.instanceName:SetFontObject(QuestDifficulty_Header);
			button.instanceName:SetPoint("RIGHT", button, "RIGHT", 0, 0);
			
			if info.isChapter then
				if info.isCollapsed then
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-PlusButton-UP");
				else
					button.expandOrCollapseButton:SetNormalTexture("Interface\\Buttons\\UI-MinusButton-UP");
				end
				button.expandOrCollapseButton:Show();
			else
				button.expandOrCollapseButton:Hide();
			end
			
			button.enableButton:SetChecked(info.isChecked);
			
			button:SetWidth(195);
			button:Show();
		else
			button:Hide();
		end
	end
end

function PremadeFilter_OnCategorySelected(self, id, filters)
	self.selectedCategory = id;
	self.selectedFilters = filters;
	
	LFGListCategorySelection_SelectCategory(LFGListFrame.CategorySelection, id, filters);
	LFGListEntryCreation_OnCategorySelected(self, id, filters);
	
	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses();
	PremadeFilter_BossList_Update();
end

function PremadeFilter_OnGroupSelected(self, id, buttonType)
	self.selectedGroup = id;
	
	if ( buttonType == "activity" ) then
        LFGListEntryCreation_OnGroupSelected(self, id, buttonType);
    elseif ( buttonType == "group" ) then
        LFGListEntryCreation_OnGroupSelected(self, id, buttonType);
    elseif ( buttonType == "more" ) then
        PremadeFilterActivityFinder_Show(self.ActivityFinder, self.selectedCategory, nil);
		return true;
    end
	
	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses();
	PremadeFilter_BossList_Update();
end

function PremadeFilter_OnActivitySelected(self, id, buttonType)
	self.selectedActivity = id;
	
	if ( buttonType == "activity" ) then
        LFGListEntryCreation_OnActivitySelected(self, id, buttonType);
    elseif ( buttonType == "more" ) then
        PremadeFilterActivityFinder_Show(self.ActivityFinder, self.selectedCategory, self.selectedGroup);
		return true;
    end
	
	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses();
	PremadeFilter_BossList_Update();
end

function PremadeFilterActivityFinder_OnLoad(self)
    self.Dialog.ScrollFrame.update = function() PremadeFilterActivityFinder_Update(self); end;
    self.Dialog.ScrollFrame.scrollBar.doNotHide = true;
    HybridScrollFrame_CreateButtons(self.Dialog.ScrollFrame, "PremadeFilterActivityListTemplate");
 
    self.matchingActivities = {};
end

function PremadeFilterActivityFinder_Show(self, categoryID, groupID, filters)
    self.Dialog.EntryBox:SetText("");
    self.categoryID = categoryID;
    self.groupID = groupID;
    self.filters = filters;
    self.selectedActivity = nil;
    PremadeFilterActivityFinder_UpdateMatching(self);
    self:Show();
    self.Dialog.EntryBox:SetFocus();
end

function PremadeFilterActivityFinder_UpdateMatching(self)
    self.matchingActivities = C_LFGList.GetAvailableActivities(self.categoryID, self.groupID, self.filters, self.Dialog.EntryBox:GetText());
    LFGListUtil_SortActivitiesByRelevancy(self.matchingActivities);
    if ( not self.selectedActivity or not tContains(self.matchingActivities, self.selectedActivity) ) then
        self.selectedActivity = self.matchingActivities[1];
    end
    PremadeFilterActivityFinder_Update(self);
end
 
function PremadeFilterActivityFinder_Update(self)
    local actitivities = self.matchingActivities;
 
    local offset = HybridScrollFrame_GetOffset(self.Dialog.ScrollFrame);
 
    for i=1, #self.Dialog.ScrollFrame.buttons do
        local button = self.Dialog.ScrollFrame.buttons[i];
        local idx = i + offset;
        local id = actitivities[idx];
        if ( id ) then
            button:SetText( (C_LFGList.GetActivityInfo(id)) );
            button.activityID = id;
            button.Selected:SetShown(self.selectedActivity == id);
            if ( self.selectedActivity == id ) then
                button:LockHighlight();
            else
                button:UnlockHighlight();
            end
            button:Show();
        else
            button:Hide();
        end
    end
	
    HybridScrollFrame_Update(self.Dialog.ScrollFrame, self.Dialog.ScrollFrame.buttons[1]:GetHeight() * #actitivities, self.Dialog.ScrollFrame:GetHeight());
end
 
function PremadeFilterActivityFinder_Accept(self)
    if ( self.selectedActivity ) then
		LFGListEntryCreation_OnActivitySelected(self:GetParent(), self.selectedActivity, "activity");
		PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses();
		PremadeFilter_BossList_Update();
    end
    self:Hide();
end
 
function PremadeFilterActivityFinder_Cancel(self)
    self:Hide();
end
 
function PremadeFilterActivityFinder_Select(self, activityID)
    self.selectedActivity = activityID;
    PremadeFilterActivityFinder_Update(self);
end

--[[function LFGListEntryCreation_PopulateGroups(self, dropDown, info)
	if ( not self.selectedCategory ) then
		--We don't have a category, so we can't fill out groups.
		return;
	end
	
	--Start out displaying everything
	local groups = C_LFGList.GetAvailableActivityGroups(self.selectedCategory, bit.bor(self.baseFilters, self.selectedFilters));
	local activities = C_LFGList.GetAvailableActivities(self.selectedCategory, 0, bit.bor(self.baseFilters, self.selectedFilters));
	
	local groupOrder = groups[1] and select(2, C_LFGList.GetActivityGroupInfo(groups[1]));
	local activityOrder = activities[1] and select(10, C_LFGList.GetActivityInfo(activities[1]));

	local groupIndex, activityIndex = 1, 1;

	--Start merging
	for i=1, MAX_LFG_LIST_GROUP_DROPDOWN_ENTRIES do
		if ( not groupOrder and not activityOrder ) then
			break;
		end

		if ( activityOrder and (not groupOrder or activityOrder < groupOrder) ) then
			local activityID = activities[activityIndex];
			local name = select(ACTIVITY_RETURN_VALUES.shortName, C_LFGList.GetActivityInfo(activityID));

			info.text = name;
			info.value = activityID;
			info.arg1 = "activity";
			info.checked = (self.selectedActivity == activityID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			activityIndex = activityIndex + 1;
			activityOrder = activities[activityIndex] and select(10, C_LFGList.GetActivityInfo(activities[activityIndex]));
		else
			local groupID = groups[groupIndex];
			local name = C_LFGList.GetActivityGroupInfo(groupID);

			info.text = name;
			info.value = groupID;
			info.arg1 = "group";
			info.checked = (self.selectedGroup == groupID);
			info.isRadio = true;
			UIDropDownMenu_AddButton(info);

			groupIndex = groupIndex + 1;
			groupOrder = groups[groupIndex] and select(2, C_LFGList.GetActivityGroupInfo(groups[groupIndex]));
		end
	end
end]]--

function LFGListSearchPanel_DoSearch(self)
	local visible = PremadeFilter_Frame:IsVisible();
	local category = PremadeFilter_Frame.selectedCategory;
	local languages = C_LFGList.GetLanguageSearchFilter();
	
	if visible and category then
		C_LFGList.Search(category, LFGListSearchPanel_ParseSearchTerms(""), self.filters, self.preferredFilters, languages);
	else
		C_LFGList.Search(self.categoryID, LFGListSearchPanel_ParseSearchTerms(""), self.filters, self.preferredFilters, languages);
		category = self.categoryID;
	end
	
	self.searching = true;
	self.searchFailed = false;
	self.selectedResult = nil;
	
	PremadeFilter_Frame.addonSearch = true;
	PremadeFilter_Frame.selectedCategory = category;
	PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] = nil;
	PremadeFilter_Frame.extraFilters = PremadeFilter_GetFilters();
	
	LFGListSearchPanel_UpdateResultList(self);
	LFGListSearchPanel_UpdateResults(self);
	
	if not PremadeFilter_MinimapButton:IsVisible() then
		PremadeFilter_MinimapButton.LastUpdate = 0;
	end
end

function PremadeFilter_GetFilters()
	if not PremadeFilter_Frame:IsVisible() and not PremadeFilter_MinimapButton:IsVisible() then
		return nil;
	end
	
	local filters = {};
	
	-- category
	filters.category = PremadeFilter_Frame.selectedCategory;
	
	-- group
	filters.group = PremadeFilter_Frame.selectedGroup;
	
	-- activity
	filters.activity = PremadeFilter_Frame.selectedActivity;
	
	-- name
	local nameText = PremadeFilter_Frame.Name:GetText();
	if nameText ~= "" then
		local nameInclude, nameExclude, namePossible = PremadeFilter_ParseQuery(nameText);
		filters.name = {
			include = nameInclude,
			exclude = nameExclude,
			possible = namePossible,
		}
	end
	
	-- description
	local descrText = PremadeFilter_Frame.Description.EditBox:GetText();
	if descrText ~= "" then
		local descrInclude, descrExclude, descrPossible = PremadeFilter_ParseQuery(descrText);
		filters.description = {
			include = descrInclude,
			exclude = descrExclude,
			possible = descrPossible,
		}
	end
	
	-- item level
	if PremadeFilter_Frame.ItemLevel.CheckButton:GetChecked() then
		local ilvlText = tonumber(PremadeFilter_Frame.ItemLevel.EditBox:GetText());
		filters.ilvl = ilvlText;
	end
	
	-- voice chat
	if PremadeFilter_Frame.VoiceChat.CheckButton:GetChecked() then
		local vcText = PremadeFilter_Frame.VoiceChat.EditBox:GetText();
		local vcNone = PremadeFilter_Frame.VoiceChat.CheckButton.CheckedNone;
		filters.vc = {
			text = vcText,
			none = vcNone
		}
	end
	
	-- roles
	local tank = PremadeFilter_Frame.TankCheckButton:GetChecked();
	local heal = PremadeFilter_Frame.HealerCheckButton:GetChecked();
	local dps  = PremadeFilter_Frame.DamagerCheckButton:GetChecked();
	if tank or heal or dps then
		filters.roles = 0;
		if tank then filters.roles = filters.roles+4 end
		if heal then filters.roles = filters.roles+2 end
		if dps  then filters.roles = filters.roles+1 end
	end
	
	-- realm
	local selectedRealms = PremadeFilter_GetSelectedRealms();
	if selectedRealms then
		filters.realms = table.concat(selectedRealms, "-");
	end
	
	-- members
	if PremadeFilter_Frame.PlayersTankCheckButton:GetChecked() then
		filters.minTanks = tonumber(PremadeFilter_Frame.MinTanks:GetText());
		filters.maxTanks = tonumber(PremadeFilter_Frame.MaxTanks:GetText());
	end
	if PremadeFilter_Frame.PlayersHealerCheckButton:GetChecked() then
		filters.minHealers = tonumber(PremadeFilter_Frame.MinHealers:GetText());
		filters.maxHealers = tonumber(PremadeFilter_Frame.MaxHealers:GetText());
	end
	if PremadeFilter_Frame.PlayersDamagerCheckButton:GetChecked() then
		filters.minDamagers = tonumber(PremadeFilter_Frame.MinDamagers:GetText());
		filters.maxDamagers = tonumber(PremadeFilter_Frame.MaxDamagers:GetText());
	end
	
	-- bosses
	if type(PremadeFilter_Frame.availableBosses) == "table" and #PremadeFilter_Frame.availableBosses > 0 then
		filters.bosses = {};
		for index, info in pairs(PremadeFilter_Frame.availableBosses) do
			if type(info.isChecked) ~= "nil" then
				filters.bosses[info.name] = info.isChecked;
			end
		end
	end
	
	return filters;
end

function PremadeFilter_SetFilters(filters)
	PremadeFilter_Frame.selectedCategory = filters.category;
	LFGListEntryCreation_Select(PremadeFilter_Frame, PremadeFilter_Frame.selectedFilters, filters.category, filters.group, filters.activity);
	
	PremadeFilter_Frame.availableBosses = PremadeFilter_GetAvailableBosses();
	
	-- name
	if type(filters.name) == "table" then
		local include  = PremadeFilter_BuildQueryPrefix(table.concat(filters.name.include, " "),  "");
		local exclude  = PremadeFilter_BuildQueryPrefix(table.concat(filters.name.exclude, " "),  "-");
		local possible = PremadeFilter_BuildQueryPrefix(table.concat(filters.name.possible, " "), "?");
		local query = include.." "..exclude.." "..possible;
		
		LFGListFrame.SearchPanel.SearchBox:SetText(query:gsub("^%s*(.-)%s*$", "%1").." ");
	else
		LFGListFrame.SearchPanel.SearchBox:SetText("");
	end
	
	-- description
	if type(filters.description) == "table" then
		local include  = PremadeFilter_BuildQueryPrefix(table.concat(filters.description.include, " "),  "");
		local exclude  = PremadeFilter_BuildQueryPrefix(table.concat(filters.description.exclude, " "),  "-");
		local possible = PremadeFilter_BuildQueryPrefix(table.concat(filters.description.possible, " "), "?");
		local query = include.." "..exclude.." "..possible;
		
		PremadeFilter_Frame.Description.EditBox:SetText(query:gsub("^%s*(.-)%s*$", "%1"));
	else
		PremadeFilter_Frame.Description.EditBox:SetText("");
	end
	
	-- item level
	if type(filters.ilvl) == "number" and filters.ilvl > 0 then
		PremadeFilter_Frame.ItemLevel.CheckButton:SetChecked(true);
		PremadeFilter_Frame.ItemLevel.EditBox:SetText(filters.ilvl);
		PremadeFilter_Frame.ItemLevel.EditBox:Show();
	else
		PremadeFilter_Frame.ItemLevel.CheckButton:SetChecked(false);
		PremadeFilter_Frame.ItemLevel.EditBox:SetText("");
		PremadeFilter_Frame.ItemLevel.EditBox:Hide();
	end
	
	-- voice chat
	PremadeFilter_Frame.VoiceChat.CheckButton:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
	PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(false);
	PremadeFilter_Frame.VoiceChat.EditBox:Hide();
	
	if type(filters.vc) == "table" then
		PremadeFilter_Frame.VoiceChat.CheckButton.CheckedNone = filters.vc.none;
		PremadeFilter_Frame.VoiceChat.EditBox:SetText(filters.vc.text);
		
		if filters.vc.none then
			PremadeFilter_Frame.VoiceChat.CheckButton:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up");
			PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(true);
		elseif filters.vc.text ~= "" then
			PremadeFilter_Frame.VoiceChat.CheckButton:SetChecked(true);
			PremadeFilter_Frame.VoiceChat.EditBox:Show();
		end
	end
	
	-- roles
	if type(filters.roles) == "number" then
		local tank = (bit.band(filters.roles, 4) ~= 0);
		local heal = (bit.band(filters.roles, 2) ~= 0);
		local dps  = (bit.band(filters.roles, 1) ~= 0);
		
		PremadeFilter_Frame.TankCheckButton:SetChecked(tank);
		PremadeFilter_Frame.HealerCheckButton:SetChecked(heal);
		PremadeFilter_Frame.DamagerCheckButton:SetChecked(dps);
	else
		PremadeFilter_Frame.TankCheckButton:SetChecked(false);
		PremadeFilter_Frame.HealerCheckButton:SetChecked(false);
		PremadeFilter_Frame.DamagerCheckButton:SetChecked(false);
	end
	
	-- realm
	if filters.realms and PremadeFilter_Frame.realmList then
		local noneChecked;
		for i=1, #PremadeFilter_Frame.realmList do
			if PremadeFilter_Frame.realmList[i].isChapter then
				if i > 1 then
					local chapter = PremadeFilter_Frame.realmList[i-1].chapterIndex;
					if noneChecked then
						PremadeFilter_Frame.realmList[chapter].isCollapsed = true;
					end
				end
				PremadeFilter_Frame.realmList[i].isChecked = true;
				PremadeFilter_Frame.realmList[i].isCollapsed = true;
				noneChecked = true;
			else
				local chapter	= PremadeFilter_Frame.realmList[i].chapterIndex;
				local name		= PremadeFilter_Frame.realmList[i].name:gsub("[%s%']+", "");
				local checked	= (filters.realms:find("-"..name:lower(), 1, true) ~= nil);
				
				PremadeFilter_Frame.realmList[i].isChecked = checked;
				
				if not checked then
					PremadeFilter_Frame.realmList[chapter].isChecked = false;
					PremadeFilter_Frame.realmList[chapter].isCollapsed = false;
				else
					noneChecked = false;
				end
			end
		end
		
		if noneChecked then
			local lastRealm = #PremadeFilter_Frame.realmList;
			local lastChapter = PremadeFilter_Frame.realmList[lastRealm].chapterIndex;
			PremadeFilter_Frame.realmList[lastChapter].isCollapsed = true;
		end
	elseif PremadeFilter_Frame.realmList then
		for i=1, #PremadeFilter_Frame.realmList do
			PremadeFilter_Frame.realmList[i].isChecked = true;
			PremadeFilter_Frame.realmList[i].isCollapsed = true;
		end
	end
	PremadeFilter_Frame.visibleRealms = PremadeFilter_GetVisibleRealms();
	PremadeFilter_RealmList_Update();
	
	-- members
	PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(false);
	PremadeFilter_Frame.MinTanks:SetText("");
	PremadeFilter_Frame.MaxTanks:SetText("");
	PremadeFilter_Frame.PlayersNoTankMinLabel:Show();
	PremadeFilter_Frame.PlayersNoTankMaxLabel:Show();
	PremadeFilter_Frame.MinTanks:Hide();
	PremadeFilter_Frame.MaxTanks:Hide();
	if type(filters.minTanks) == "number" then
		PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(true);
		PremadeFilter_Frame.MinTanks:SetText(filters.minTanks);
		PremadeFilter_Frame.PlayersNoTankMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoTankMaxLabel:Hide();
		PremadeFilter_Frame.MinTanks:Show();
		PremadeFilter_Frame.MaxTanks:Show();
	end
	if type(filters.maxTanks) == "number" then
		PremadeFilter_Frame.PlayersTankCheckButton:SetChecked(true);
		PremadeFilter_Frame.MaxTanks:SetText(filters.maxTanks);
		PremadeFilter_Frame.PlayersNoTankMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoTankMaxLabel:Hide();
		PremadeFilter_Frame.MinTanks:Show();
		PremadeFilter_Frame.MaxTanks:Show();
	end
	
	PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(false);
	PremadeFilter_Frame.MinHealers:SetText("");
	PremadeFilter_Frame.MaxHealers:SetText("");
	PremadeFilter_Frame.PlayersNoHealerMinLabel:Show();
	PremadeFilter_Frame.PlayersNoHealerMaxLabel:Show();
	PremadeFilter_Frame.MinHealers:Hide();
	PremadeFilter_Frame.MaxHealers:Hide();
	if type(filters.minHealers) == "number" then
		PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(true);
		PremadeFilter_Frame.MinHealers:SetText(filters.minHealers);
		PremadeFilter_Frame.PlayersNoHealerMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoHealerMaxLabel:Hide();
		PremadeFilter_Frame.MinHealers:Show();
		PremadeFilter_Frame.MaxHealers:Show();
	end
	if type(filters.maxHealers) == "number" then
		PremadeFilter_Frame.PlayersHealerCheckButton:SetChecked(true);
		PremadeFilter_Frame.MaxHealers:SetText(filters.maxHealers);
		PremadeFilter_Frame.PlayersNoHealerMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoHealerMaxLabel:Hide();
		PremadeFilter_Frame.MinHealers:Show();
		PremadeFilter_Frame.MaxHealers:Show();
	end
	
	PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(false);
	PremadeFilter_Frame.MinDamagers:SetText("");
	PremadeFilter_Frame.MaxDamagers:SetText("");
	PremadeFilter_Frame.PlayersNoDamagerMinLabel:Show();
	PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Show();
	PremadeFilter_Frame.MinDamagers:Hide();
	PremadeFilter_Frame.MaxDamagers:Hide();
	if type(filters.minDamagers) == "number" then
		PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(true);
		PremadeFilter_Frame.MinDamagers:SetText(filters.minDamagers);
		PremadeFilter_Frame.PlayersNoDamagerMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Hide();
		PremadeFilter_Frame.MinDamagers:Show();
		PremadeFilter_Frame.MaxDamagers:Show();
	end
	if type(filters.maxDamagers) == "number" then
		PremadeFilter_Frame.PlayersDamagerCheckButton:SetChecked(true);
		PremadeFilter_Frame.MaxDamagers:SetText(filters.maxDamagers);
		PremadeFilter_Frame.PlayersNoDamagerMinLabel:Hide();
		PremadeFilter_Frame.PlayersNoDamagerMaxLabel:Hide();
		PremadeFilter_Frame.MinDamagers:Show();
		PremadeFilter_Frame.MaxDamagers:Show();
	end
	
	-- bosses
	for index, info in pairs(PremadeFilter_Frame.availableBosses) do
		if type(filters.bosses) == "table" and type(filters.bosses[info.name]) ~= "nil" then
			PremadeFilter_Frame.availableBosses[index].isChecked = filters.bosses[info.name];
		else
			PremadeFilter_Frame.availableBosses[index].isChecked = nil;
		end
	end
	
	PremadeFilter_BossList_Update();
end

function PremadeFilter_GetInfoName(activityID, name, leaderName)
	return activityID.."-"..name.."-"..(leaderName or "");
end

function LFGListSearchPanel_UpdateResultList(self)
	if not self.searching then
		self.totalResults, self.results = C_LFGList.GetSearchResults();
		self.applications = C_LFGList.GetApplications();
		
		local searchText = self.SearchBox:GetText():lower();
		local include, exclude, possible = PremadeFilter_ParseQuery(searchText);
		
		if #include + #exclude + #possible > 1 then
			PremadeFilter_AddRecentQuery(searchText:gsub("^%s*(.-)%s*$", "%1"));
		end
		
		PremadeFilter_AddRecentWords(include);
		PremadeFilter_AddRecentWords(exclude);
		PremadeFilter_AddRecentWords(possible);
		
		local numResults = 0;
		local extraFilters = PremadeFilter_Frame.extraFilters;
		
		local newResults = {};
		
		local minAge = nil;
		
		PremadeFilter_Frame.freshResults = {};
		
		if not PremadeFilter_Frame.selectedCategory then
			PremadeFilter_Frame.selectedCategory = LFGListFrame.CategorySelection.selectedCategory;
		end
		
		for i=1, #self.results do
			local resultID = self.results[i];
			local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers = C_LFGList.GetSearchResultInfo(resultID);
			local activityName, shortName, categoryID, groupID, itemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
			local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
			
			if (not minAge) or (age < minAge) then
				minAge = age;
			end
			
			local infoName = PremadeFilter_GetInfoName(activityID, name);
			local matches = PremadeFilter_IsStringMatched(name:lower(), include, exclude, possible);
			
			-- check additional filters
			if matches and extraFilters then
				-- category
				if matches and extraFilters.category then
					matches = (categoryID == extraFilters.category);
				end
				
				-- group
				if matches and extraFilters.group then
					matches = (groupID == extraFilters.group);
				end
				
				-- activity
				if matches and extraFilters.activity then
					matches = (activityID == extraFilters.activity);
				end
				
				-- description
				if matches and extraFilters.description then
					matches = PremadeFilter_IsStringMatched(comment:lower(), extraFilters.description.include, extraFilters.description.exclude, extraFilters.description.possible);
				end
				
				-- item level
				if matches and extraFilters.ilvl then
					matches = (iLvl >= extraFilters.ilvl);
				end
				
				-- voice chat
				if matches and extraFilters.vc then
					if extraFilters.vc.none then
						matches = (voiceChat == "");
					else
						if extraFilters.vc.text ~= "" then
							matches = (voiceChat:lower() == extraFilters.vc.text:lower());
						else
							matches = (voiceChat ~= "");
						end
					end;
				end
				
				-- roles
				if matches and extraFilters.roles then
					-- check if premade has role bit mask
					local lastWord = string.sub(comment, comment:len()-1);
					local byte1 = string.byte(lastWord, 1, 1);
					local byte2 = string.byte(lastWord, 2, 2);
					
					if byte1 == 194 and byte2 > 128 and byte2 <= 135 then
						matches = (bit.band(extraFilters.roles, byte2-128) ~= 0);
					end
				end
				
				-- realm
				if matches and leaderName and extraFilters.realms then
					local leaderRealm = leaderName:gmatch("-.+$")();
					if not leaderRealm then
						leaderRealm = "-"..PremadeFilter_Frame.realmName:gsub("[%s%']+", "");
					end
					matches = extraFilters.realms:find(leaderRealm:lower(), 1, true);
				end
				
				-- members
				if matches and extraFilters.minTanks then
					matches = (memberCounts.TANK >= extraFilters.minTanks);
				end
				if matches and extraFilters.maxTanks then
					matches = (memberCounts.TANK <= extraFilters.maxTanks);
				end
				
				if matches and extraFilters.minHealers then
					matches = (memberCounts.HEALER >= extraFilters.minHealers);
				end
				if matches and extraFilters.maxHealers then
					matches = (memberCounts.HEALER <= extraFilters.maxHealers);
				end
				
				if matches and extraFilters.minDamagers then
					matches = (memberCounts.DAMAGER >= extraFilters.minDamagers);
				end
				if matches and extraFilters.maxDamagers then
					matches = (memberCounts.DAMAGER <= extraFilters.maxDamagers);
				end
				
				-- bosses
				if matches and extraFilters.bosses then
					local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID);
					local bossesDefeated = {};
					
					if type(completedEncounters) == "table" then
						for i=1, #completedEncounters do
							local boss = completedEncounters[i];
							local shortName = boss:match("^([^%,%-%s]+)");
							bossesDefeated[shortName] = true;
						end
					end
					
					for boss, filterStatus in pairs(extraFilters.bosses) do
						local shortName = boss:match("^([^%,%-%s]+)");
						local bossStatus = (type(bossesDefeated[shortName]) == "nil");
						if bossStatus ~= filterStatus then
							matches = false;
							break;
						end
					end
				end
			end
			
			-- RESULT
			if matches then
				numResults = numResults + 1
				newResults[numResults] = resultID;
				
				if PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] and time() - age > PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] then
					PremadeFilter_Frame.freshResults[resultID] = true;
					
					if PremadeFilter_MinimapButton:IsVisible() then
						PremadeFilter_StartNotification();
						
						if PremadeFilter_GetSettings("NewGroupChatNotifications") and not PremadeFilter_Frame.chatNotifications[infoName] then
							PremadeFilter_Frame.chatNotifications[infoName] = true;
							PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, T("found new group").." "..PremadeFilter_GetHyperlink(name, { infoName = infoName }));
						end
					end
				end
			end
		end
		
		if PremadeFilter_Frame.addonSearch and not PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] and not PremadeFilter_MinimapButton:IsVisible() then
			PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] = minAge or 0;
			
			PremadeFilter_MinimapButton.LastUpdate = 0;
			PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] = time() - PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] + 1;
			
			PremadeFilter_Frame.addonSearch = false;
		end
		
		self.totalResults = numResults;
		self.results = newResults;
		
		LFGListUtil_SortSearchResults(self.results);
	end
end

function LFGListSearchPanel_UpdateResults(self)
	local offset = HybridScrollFrame_GetOffset(self.ScrollFrame);
	local buttons = self.ScrollFrame.buttons;
	
	--If we have an application selected, deselect it.
	LFGListSearchPanel_ValidateSelected(self);

	if ( self.searching ) then
		self.SearchingSpinner:Show();
		self.ScrollFrame.NoResultsFound:Hide();
		self.ScrollFrame.StartGroupButton:Hide();
		for i=1, #buttons do
			buttons[i]:Hide();
		end
	else
		self.SearchingSpinner:Hide();
		local results = self.results;
		local apps = self.applications;

		for i=1, #buttons do
			local button = buttons[i];
			local idx = i + offset;
			local result = (idx <= #apps) and apps[idx] or results[idx - #apps];

			if ( result ) then
				local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers = C_LFGList.GetSearchResultInfo(result);
				local infoName = PremadeFilter_GetInfoName(activityID, name);
				button.resultID = result;
				button.infoName = infoName;
				button.fresh = PremadeFilter_Frame.freshResults[result];
				LFGListSearchEntry_Update(button);
				button:Show();
			else
				button.created = 0;
				button.resultID = nil;
				button.infoName = nil;
				button:Hide();
			end
			button:SetScript("OnEnter", PremadeFilter_SearchEntry_OnEnter);
		end

		local totalHeight = buttons[1]:GetHeight() * (#results + #apps);

		--Reanchor the errors to not overlap applications
		if ( totalHeight < self.ScrollFrame:GetHeight() ) then
			self.ScrollFrame.NoResultsFound:SetPoint("TOP", self.ScrollFrame, "TOP", 0, -totalHeight - 27);
		end
		self.ScrollFrame.NoResultsFound:SetShown(self.totalResults == 0);
		self.ScrollFrame.StartGroupButton:SetShown(self.totalResults == 0 and not self.searchFailed);
		self.ScrollFrame.NoResultsFound:SetText(self.searchFailed and LFG_LIST_SEARCH_FAILED or LFG_LIST_NO_RESULTS_FOUND);

		HybridScrollFrame_Update(self.ScrollFrame, totalHeight, self.ScrollFrame:GetHeight());
	end
	LFGListSearchPanel_UpdateButtonStatus(self);
end

function LFGListSearchEntry_Update(self)
	local resultID = self.resultID;
	local _, appStatus, pendingStatus, appDuration = C_LFGList.GetApplicationInfo(resultID);
	local isApplication = (appStatus ~= "none" or pendingStatus);
	local isAppFinished = LFGListUtil_IsStatusInactive(appStatus) or LFGListUtil_IsStatusInactive(pendingStatus);

	--Update visibility based on whether we're an application or not
	self.isApplication = isApplication;
	self.ApplicationBG:SetShown(isApplication and not isAppFinished);
	self.ResultBG:SetShown(not isApplication or isAppFinished);
	self.DataDisplay:SetShown(not isApplication);
	self.CancelButton:SetShown(isApplication and pendingStatus ~= "applied");
	self.CancelButton:SetEnabled(LFGListUtil_IsAppEmpowered());
	self.CancelButton.Icon:SetDesaturated(not LFGListUtil_IsAppEmpowered());
	self.CancelButton.tooltip = (not LFGListUtil_IsAppEmpowered()) and LFG_LIST_APP_UNEMPOWERED;
	self.Spinner:SetShown(pendingStatus == "applied");
	
	if ( pendingStatus == "applied" and C_LFGList.GetRoleCheckInfo() ) then
		self.PendingLabel:SetText(LFG_LIST_ROLE_CHECK);
		self.PendingLabel:SetTextColor(NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( pendingStatus == "cancelled" or appStatus == "cancelled" or appStatus == "failed" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_CANCELLED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "declined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "timedout" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_TIMED_OUT);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invited" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "inviteaccepted" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_ACCEPTED);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( appStatus == "invitedeclined" ) then
		self.PendingLabel:SetText(LFG_LIST_APP_INVITE_DECLINED);
		self.PendingLabel:SetTextColor(RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	elseif ( isApplication and pendingStatus ~= "applied" ) then
		self.PendingLabel:SetText(LFG_LIST_PENDING);
		self.PendingLabel:SetTextColor(GREEN_FONT_COLOR.r, GREEN_FONT_COLOR.g, GREEN_FONT_COLOR.b);
		self.PendingLabel:Show();
		self.ExpirationTime:Show();
		self.CancelButton:Show();
	else
		self.PendingLabel:Hide();
		self.ExpirationTime:Hide();
		self.CancelButton:Hide();
	end

	--Center justify if we're on more than one line
	if ( self.PendingLabel:GetHeight() > 15 ) then
		self.PendingLabel:SetJustifyH("CENTER");
	else
		self.PendingLabel:SetJustifyH("RIGHT");
	end

	--Change the anchor of the label depending on whether we have the expiration time
	if ( self.ExpirationTime:IsShown() ) then
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "LEFT", -3, 0);
	else
		self.PendingLabel:SetPoint("RIGHT", self.ExpirationTime, "RIGHT", -3, 0);
	end

	self.expiration = GetTime() + appDuration;

	local panel = self:GetParent():GetParent():GetParent();

	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName, numMembers = C_LFGList.GetSearchResultInfo(resultID);
	local activityName = C_LFGList.GetActivityInfo(activityID);
	local infoName = PremadeFilter_GetInfoName(activityID, name);
	
	self.resultID = resultID;
	self.infoName = infoName;
	
	self.Selected:SetShown(panel.selectedResult == resultID and not isApplication and not isDelisted);
	self.Highlight:SetShown(panel.selectedResult ~= resultID and not isApplication and not isDelisted);
	local nameColor = NORMAL_FONT_COLOR;
	local activityColor = GRAY_FONT_COLOR;
	if ( isDelisted or isAppFinished ) then
		nameColor = LFG_LIST_DELISTED_FONT_COLOR;
		activityColor = LFG_LIST_DELISTED_FONT_COLOR;
	elseif ( numBNetFriends > 0 or numCharFriends > 0 or numGuildMates > 0 ) then
		nameColor = BATTLENET_FONT_COLOR;
	elseif self.fresh then
		nameColor = LFG_LIST_FRESH_FONT_COLOR;
	end
	
	self.Name:SetWidth(0);
	self.Name:SetText(name);
	self.Name:SetTextColor(nameColor.r, nameColor.g, nameColor.b);
	self.ActivityName:SetText(activityName);
	self.ActivityName:SetTextColor(activityColor.r, activityColor.g, activityColor.b);
	self.VoiceChat:SetShown(voiceChat ~= "");
	self.VoiceChat.tooltip = voiceChat;

	local displayData = C_LFGList.GetSearchResultMemberCounts(resultID);
	LFGListGroupDataDisplay_Update(self.DataDisplay, activityID, displayData, isDelisted);

	local nameWidth = isApplication and 165 or 176;
	if ( voiceChat ~= "" ) then
		nameWidth = nameWidth - 22;
	end
	if ( self.Name:GetWidth() > nameWidth ) then
		self.Name:SetWidth(nameWidth);
	end
	self.ActivityName:SetWidth(nameWidth);

	local mouseFocus = GetMouseFocus();
	if ( mouseFocus == self ) then
		LFGListSearchEntry_OnEnter(self);
	end
	if ( mouseFocus == self.VoiceChat ) then
		mouseFocus:GetScript("OnEnter")(mouseFocus);
	end

	if ( isApplication ) then
		self:SetScript("OnUpdate", LFGListSearchEntry_UpdateExpiration);
		LFGListSearchEntry_UpdateExpiration(self);
	else
		self:SetScript("OnUpdate", nil);
	end
end

function LFGListSearchEntry_OnEnter(self)
	PremadeFilter_SearchEntry_OnEnter(self);
end


function PremadeFilter_GetTooltipInfo(resultID)
 	local id, activityID, name, comment, voiceChat, iLvl, honorLevel, age, numBNetFriends, numCharFriends, numGuildMates, isDelisted, leaderName,numMembers = C_LFGList.GetSearchResultInfo(resultID);
	
	if not activityID then
		return nil;
	end
	
	local activityName, shortName, categoryID, groupID, minItemLevel, filters, minLevel, maxPlayers, displayType = C_LFGList.GetActivityInfo(activityID);
	local memberCounts = C_LFGList.GetSearchResultMemberCounts(resultID);
	
	local classCounts = {};
	local memberList = {};
	
	for i=1, numMembers do
		local role, class, classLocalized = C_LFGList.GetSearchResultMemberInfo(resultID, i);
		local info = {
			role	= _G[role],
			title	= classLocalized,
			color	= RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR,
		};
		
		table.insert(memberList, info);
		
		if not classCounts[class] then
			classCounts[class] = {
				title = info.title,
				color = info.color,
				counts = {},
			};
		end
		
		if not classCounts[class].counts[info.role] then
			classCounts[class].counts[info.role] = 0;
		end
		
		classCounts[class].counts[info.role] = classCounts[class].counts[info.role] + 1;
	end
	
	local friendList = {};
	if ( numBNetFriends + numCharFriends + numGuildMates > 0 ) then
		friendList = LFGListSearchEntryUtil_GetFriendList(resultID);
	end
	
	local completedEncounters = C_LFGList.GetSearchResultEncounterInfo(resultID);
	
	return {
		displayType			= displayType,
		isDelisted			= isDelisted,
		name				= name,
		activityID			= activityID,
		activityName		= activityName,
		comment				= comment,
		iLvl				= iLvl,
		HonorLevel			= honorLevel,
		voiceChat			= voiceChat,
		leaderName			= leaderName,
		age					= age,
		numMembers			= numMembers,
		memberCounts		= memberCounts,
		classCounts			= classCounts,
		friendList			= friendList,
		completedEncounters	= completedEncounters,
	};
end

function PremadeFilter_SearchEntry_OnEnter(self)
	local info = PremadeFilter_GetTooltipInfo(self.resultID);
	
	-- setup tooltip
	GameTooltip:SetOwner(self, "ANCHOR_RIGHT", 25, 0);
	GameTooltip:SetText(info.name, 1, 1, 1, true);
	GameTooltip:AddLine(info.activityName);
	if ( info.comment ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_COMMENT_FORMAT, info.comment), GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b, true);
	end
	GameTooltip:AddLine(" ");
	if ( info.iLvl > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_ILVL, info.iLvl));
	end
	if ( info.voiceChat ~= "" ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_VOICE_CHAT, info.voiceChat), nil, nil, nil, true);
	end
	if ( info.iLvl > 0 or info.voiceChat ~= "" ) then
		GameTooltip:AddLine(" ");
	end

	if ( info.leaderName ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_LEADER, info.leaderName));
	end
	if ( info.age > 0 ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_AGE, SecondsToTime(info.age, false, false, 1, false)));
	end

	if ( info.leaderName or info.age > 0 ) then
		GameTooltip:AddLine(" ");
	end
	
	if ( info.displayType == LE_LFG_LIST_DISPLAY_TYPE_CLASS_ENUMERATE ) then
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS_SIMPLE, info.numMembers));
		
		if info.memberList then
			for i, memberInfo in pairs(info.memberList) do
				GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_CLASS_ROLE, memberInfo.title, memberInfo.role), memberInfo.color.r, memberInfo.color.g, memberInfo.color.b);
			end
		end
	else
		GameTooltip:AddLine(string.format(LFG_LIST_TOOLTIP_MEMBERS, info.numMembers, info.memberCounts.TANK, info.memberCounts.HEALER, info.memberCounts.DAMAGER));
		
		local classHint = "";
		for i, classInfo in pairs(info.classCounts) do
			local counts = {};
			for role, count in pairs(classInfo.counts) do
				table.insert(counts, COLOR_GRAY..role..": "..COLOR_ORANGE..count..COLOR_RESET);
			end
			GameTooltip:AddLine(string.format("%s (%s)", classInfo.title, table.concat(counts, ", ")), classInfo.color.r, classInfo.color.g, classInfo.color.b);
		end
	end
	

	if ( #info.friendList > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_TOOLTIP_FRIENDS_IN_GROUP);
		GameTooltip:AddLine(info.friendList, 1, 1, 1, true);
	end

	if ( info.completedEncounters and #info.completedEncounters > 0 ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_BOSSES_DEFEATED);
		for i=1, #info.completedEncounters do
			GameTooltip:AddLine(info.completedEncounters[i], RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b);
		end
	end

	if ( info.isDelisted ) then
		GameTooltip:AddLine(" ");
		GameTooltip:AddLine(LFG_LIST_ENTRY_DELISTED, RED_FONT_COLOR.r, RED_FONT_COLOR.g, RED_FONT_COLOR.b, true);
	end
	
	GameTooltip:Show();
end

function LFGListUtil_SortSearchResultsCB(id1, id2)
	local id1, activityID1, name1, comment1, voiceChat1, iLvl1, honorLevel1, age1, numBNetFriends1, numCharFriends1, numGuildMates1, isDelisted1, leaderName1, numMembers1 = C_LFGList.GetSearchResultInfo(id1);
	local id2, activityID2, name2, comment2, voiceChat2, iLvl2, honorLevel2, age2, numBNetFriends2, numCharFriends2, numGuildMates2, isDelisted2, leaderName2, numMembers2 = C_LFGList.GetSearchResultInfo(id2);
	
	--If one has more friends, do that one first
	if ( numBNetFriends1 ~= numBNetFriends2 ) then
		return numBNetFriends1 > numBNetFriends2;
	end

	if ( numCharFriends1 ~= numCharFriends2 ) then
		return numCharFriends1 > numCharFriends2;
	end

	if ( numGuildMates1 ~= numGuildMates2 ) then
		return numGuildMates1 > numGuildMates2;
	end
	
	return age1 < age2;
end

function PremadeFilter_BuildQuery()
	local include  = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Include:GetText(),  "");
	local exclude  = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Exclude:GetText(),  "-");
	local possible = PremadeFilter_BuildQueryPrefix(PremadeFilter_Frame.QueryBuilder.Dialog.Possible:GetText(), "?");
	local query = include.." "..exclude.." "..possible;
	
	LFGListFrame.SearchPanel.SearchBox:SetText(query:gsub("^%s*(.-)%s*$", "%1"));
end

function PremadeFilter_BuildQueryPrefix(text, prefix)
	local words = {};
	local len = 0;
	
	text = text:gsub("[%+%-%?]+", "");
	for w in text:gmatch("%S+") do table.insert(words, w); len = len + 1; end
	if len > 0 then
		return prefix..table.concat(words, " "..prefix);
	end
	
	return "";
end

function PremadeFilter_ParseQuery(searchText)
	local include = {};
	local exclude = {};
	local possible = {};
	
	if searchText ~= "" then
		local words = {}
		for w in searchText:gmatch("%S+") do table.insert(words, w) end
		
		for i,w in pairs(words) do
			local firstChar = w:sub(1,1);
			if firstChar == "+" then
				w = w:sub(2);
				if w ~= "" then
					table.insert(include, w);
				end
			elseif firstChar == "-" then
				w = w:sub(2);
				if w ~= "" then
					table.insert(exclude, w);
				end
			elseif firstChar == "?" then
				w = w:sub(2);
				if w ~= "" then
					table.insert(possible, w);
				end
			else
				table.insert(include, w);
			end
		end
	end
	
	return include, exclude, possible;
end

function PremadeFilter_IsStringMatched(str, include, exclude, possible)
	local matches = true;
	
	if next(include) ~= nil then
		for i,w in pairs(include) do
			local strMatch = str:find(w);
			if strMatch == nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(exclude) ~= nil then
		for i,w in pairs(exclude) do
			local strMatch = str:find(w);
			if strMatch ~= nil then
				matches = false;
				break
			end
		end
	end
	
	if matches and next(possible) ~= nil then
		local strMatch = false;
		for i,w in pairs(possible) do
			local possibleMatch = str:find(w);
			if possibleMatch ~= nil then
				strMatch = true;
				break
			end
		end
		matches = matches and strMatch;
	end
	
	return matches;
end

function LFGListEntryCreation_ListGroup(self)
	local honorLevel = 0;
	local name = LFGListEntryCreation_GetSanitizedName(self);
	if ( LFGListEntryCreation_IsEditMode(self) ) then
		C_LFGList.UpdateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, honorLevel, self.VoiceChat.EditBox:GetText(), self.Description.EditBox:GetText());
		LFGListFrame_SetActivePanel(self:GetParent(), self:GetParent().ApplicationViewer);
	else
		PremadeFilter_Frame.chatNotifications = {};
		
		local description = self.Description.EditBox:GetText();
		
		local tank = PremadeFilter_Roles.TankCheckButton:GetChecked();
		local heal = PremadeFilter_Roles.HealerCheckButton:GetChecked();
		local dps  = PremadeFilter_Roles.DamagerCheckButton:GetChecked();
		local roles = 0;
		
		if tank then roles = roles+4 end
		if heal then roles = roles+2 end
		if dps  then roles = roles+1 end
		
		description = description..string.char(194, 128+roles);
		
		if(C_LFGList.CreateListing(self.selectedActivity, name, tonumber(self.ItemLevel.EditBox:GetText()) or 0, honorLevel, self.VoiceChat.EditBox:GetText(), description)) then
			self.WorkingCover:Show();
			LFGListEntryCreation_ClearFocus(self);
		end
	end
end

function PremadeFilter_CheckButtonSound(self)
	if ( self:GetChecked() ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
	end
end

function PremadeFilter_CheckButton_OnClick(self)
	if ( self:GetChecked() ) then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		self:GetParent().EditBox:Show();
		self:GetParent().EditBox:SetFocus();
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		self:GetParent().EditBox:Hide();
		self:GetParent().EditBox:ClearFocus();
		self:GetParent().EditBox:SetText("");
	end
end

function PremadeFilter_CheckButton_Boss_OnClick(self)
	local bossIndex = self:GetParent().bossIndex;
	if not self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		
		if not self.CheckedNone then
			self.CheckedNone = true;
			self:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up");
			self:SetChecked(true);
			
			PremadeFilter_Frame.availableBosses[bossIndex].isChecked = false;
			
			self:GetParent().bossName:SetTextColor(1, 0, 0);
		else
			self.CheckedNone = false;
			
			PremadeFilter_Frame.availableBosses[bossIndex].isChecked = nil;
			
			self:GetParent().bossName:SetTextColor(0.7, 0.7, 0.7);
		end
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
		self:SetChecked(true);
		self.CheckedNone = false;
		
		PremadeFilter_Frame.availableBosses[bossIndex].isChecked = true;
		
		self:GetParent().bossName:SetTextColor(0, 1, 0);
	end
end

function PremadeFilter_CheckButton_VoiceChat_OnClick(self)
	if not self:GetChecked() then
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_OFF);
		
		if not self.CheckedNone then
			self.CheckedNone = true;
			self:SetCheckedTexture("Interface\\Buttons\\UI-MultiCheck-Up");
			self:SetChecked(true);
		else
			self.CheckedNone = false;
		end
		
		self:GetParent().EditBox:Hide();
		self:GetParent().EditBox:ClearFocus();
		self:GetParent().EditBox:SetText("");
	else
		PlaySound(SOUNDKIT.IG_MAINMENU_OPTION_CHECKBOX_ON);
		self:SetCheckedTexture("Interface\\Buttons\\UI-CheckBox-Check");
			self:SetChecked(true);
		self.CheckedNone = false;
		
		self:GetParent().EditBox:Show();
		self:GetParent().EditBox:SetFocus();
	end
end

function PremadeFilter_Experimental(self)
	GameTooltip:SetOwner(self, "ANCHOR_BOTTOMRIGHT");
	GameTooltip:SetText(T("EXPERIMENTAL")..":\n"..T("Works only on premades created with Premade Filter addon"), nil, nil, nil, nil, true);
	GameTooltip:Show();
end

function PremadeFilter_StartMonitoring()
	PremadeFilter_Frame.chatNotifications = {};
end

function PremadeFilter_StopMonitoring()
	PremadeFilter_Frame.chatNotifications = {};
	
	if PremadeFilter_Frame.selectedCategory then
		PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] = time() - (PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] or 0) + 1;
	end
end

function PremadeFilter_MinimapButton_OnLoad(self)
	QueueStatusMinimapButton_OnLoad(self);
	self.LastUpdate = 0;
end

function PremadeFilter_MinimapButton_OnShow(self)

	QueueStatusMinimapButton_OnShow(self);
	
	local point, anchor, relativePoint, x, y = QueueStatusMinimapButton:GetPoint();
	
	self:ClearAllPoints();
	self:SetParent(QueueStatusMinimapButton:GetParent());
	self:SetPoint(point, anchor, relativePoint, x, y);
end

function PremadeFilter_MinimapButton_OnClick()
	PVEFrame_ShowFrame("GroupFinderFrame");
	
	PremadeFilter_MinimapButton:Hide();
	PremadeFilter_MinimapButton.Eye:Hide();
	EyeTemplate_StopAnimating(PremadeFilter_MinimapButton.Eye);
	
	PremadeFilter_StopMonitoring();
end

function PremadeFilter_OnUpdate(self, elapsed)
	PremadeFilter_MinimapButton_OnUpdate(PremadeFilter_MinimapButton, elapsed);
end

function PremadeFilter_MinimapButton_OnUpdate(self, elapsed)
	self.LastUpdate = self.LastUpdate + elapsed;
	
	if (self.LastUpdate > PremadeFilter_GetSettings("UpdateInterval")) then
		self.LastUpdate = 0;
--		LFGListSearchPanel_DoSearch(PremadeFilter_Frame:GetParent());
	end
end

function PremadeFilter_StartNotification()
	QueueStatusMinimapButton_SetGlowLock(PremadeFilter_MinimapButton, "lfglist-applicant", true);
end;

function PremadeFilter_StopNotification()
	QueueStatusMinimapButton_SetGlowLock(PremadeFilter_MinimapButton, "lfglist-applicant", false);
end;

function PremadeFilter_PrintMessage(frame, str)
	frame:AddMessage(COLOR_GREEN.."PremadeFilter "..COLOR_RESET..str..COLOR_RESET);
end

function PremadeFilter_GetHyperlink(str, data)
	local linkType = "premade";
	local linkData = {};
	
	for k,v in pairs(data) do
		table.insert(linkData, k..":"..v);
	end
	linkData = table.concat(linkData, ":");
	
	if linkData ~= "" then
		linkData = ":"..linkData;
	end
	
	return COLOR_BLUE.."|H"..linkType..linkData.."|h["..str.."]|h";
end

function PremadeFilter_Hyperlink_OnLeave(self, ...)
	if PremadeFilter_Frame.oldHyperlinkLeave then
		PremadeFilter_Frame.oldHyperlinkLeave(self, ...);
	end
end

function PremadeFilter_Hyperlink_OnEnter(self, link, text, ...)
	local prefix = link:sub(1, 7);
	
	if prefix == "premade" then
		local data = {};
		local dataStr = link:sub(8);
		
		local i = 1;
		local k, v;
		for v in dataStr:gmatch("([^:]+)") do 
			if i % 2 == 0 then data[k] = v; else k = v; end
			i = i + 1;
		end
		
		self.infoName = data.infoName;
		
		PremadeFilter_SearchEntry_OnEnter(self)
	elseif PremadeFilter_Frame.oldHyperlinkEnter then
		PremadeFilter_Frame.oldHyperlinkEnter(self, link, text, ...);
	end
end

function PremadeFilter_Hyperlink_OnClick(self, link, text, button)
	local prefix = link:sub(1, 7);
	if prefix == "premade" then
		local name = text:match("%[([^%]]+)%]");
		if name and PremadeFilter_MinimapButton:IsVisible() then
			if button == "LeftButton" then
				PremadeFilter_MinimapButton_OnClick();
			else
				PremadeFilter_Frame.updated[PremadeFilter_Frame.selectedCategory] = time() - (PremadeFilter_Frame.minAge[PremadeFilter_Frame.selectedCategory] or 0) + 1;
				PremadeFilter_StopNotification();
			end
		end
	elseif PremadeFilter_Frame.oldHyperlinkClick then
		PremadeFilter_Frame.oldHyperlinkClick(self, link, text, button);
	end
end

function PremadeFilter_OnApplicantListUpdated(self, event, ...)
		local hasNewPending, hasNewPendingWithData = ...;
		
		if ( hasNewPending and hasNewPendingWithData ) then
			local applicants = C_LFGList.GetApplicants();
			
			for i=1, #applicants do
				local id, status, pendingStatus, numMembers, isNew = C_LFGList.GetApplicantInfo(applicants[i]);
				local grayedOut = not pendingStatus and (status == "failed" or status == "cancelled" or status == "declined" or status == "invitedeclined" or status == "timedout");
				local noTouchy = (status == "invited" or status == "inviteaccepted" or status == "invitedeclined");
				
				if isNew and not grayedOut and not noTouchy then
					for i=1, numMembers do
						local name, class, classLocalized, level, itemLevel, tank, healer, damage, assignedRole, relationship = C_LFGList.GetApplicantMemberInfo(id, i);
						local classColor = RAID_CLASS_COLORS[class] or NORMAL_FONT_COLOR;
						local hexColor = string.format("|cff%02x%02x%02x", classColor.r*255, classColor.g*255, classColor.b*255);
						local displayName = Ambiguate(name, "short");
						
						local role1 = tank and "TANK" or (healer and "HEALER" or (damage and "DAMAGER"));
						local role2 = (tank and healer and "HEALER") or ((tank or healer) and damage and "DAMAGER");
						local roles = _G[role1];
						if ( role2 ) then
							roles = roles..", ".._G[role2];
						end
						
						if PremadeFilter_GetSettings("NewPlayerChatNotifications") and not PremadeFilter_Frame.chatNotifications[name] then
							PremadeFilter_Frame.chatNotifications[name] = true;
							PremadeFilter_PrintMessage(DEFAULT_CHAT_FRAME, T("found new player").." "..hexColor..displayName..COLOR_RESET.." ("..roles.." - "..math.floor(itemLevel)..")");
						end
					end
				end
			end
		end
end

function PremadeFilter_FixRecentQueries()
	if type(PremadeFilter_Data.RecentQueries) ~= "table" then
		PremadeFilter_Data.RecentQueries = {};
	end
	
	if type(PremadeFilter_Data.RecentQueriesOrder) ~= "table" then
		PremadeFilter_Data.RecentQueriesOrder = {};
		for k,v in pairs(PremadeFilter_Data.RecentQueries) do
			table.insert(PremadeFilter_Data.RecentQueriesOrder, k);
		end
	end
	
	while #PremadeFilter_Data.RecentQueriesOrder > 30 do
		local q = table.remove(PremadeFilter_Data.RecentQueriesOrder, 1);
		PremadeFilter_Data.RecentQueries[q] = nil;
	end
end

function PremadeFilter_GetRecentQueries()
	PremadeFilter_FixRecentQueries();
	
	local strRecentQueries = "";
	for k,v in pairs(PremadeFilter_Data.RecentQueries) do
		strRecentQueries = strRecentQueries.."\n"..k.."\n";
	end
	
	return strRecentQueries;
end

function PremadeFilter_FixRecentWords()
	if type(PremadeFilter_Data.RecentWords) ~= "table" then
		PremadeFilter_Data.RecentWords = {};
	end
	
	if type(PremadeFilter_Data.RecentWordsOrder) ~= "table" then
		PremadeFilter_Data.RecentWordsOrder = {};
		for k,v in pairs(PremadeFilter_Data.RecentWords) do
			table.insert(PremadeFilter_Data.RecentWordsOrder, k);
		end
	end
	
	while #PremadeFilter_Data.RecentWordsOrder > 30 do
		local word = table.remove(PremadeFilter_Data.RecentWordsOrder, 1);
		PremadeFilter_Data.RecentWords[word] = nil;
	end
end

function PremadeFilter_GetRecentWords()
	PremadeFilter_FixRecentWords();
	
	local strRecentWords = "";
	for k,v in pairs(PremadeFilter_Data.RecentWords) do
		strRecentWords = strRecentWords.." "..k.." ";
	end
	
	return strRecentWords;
end

function PremadeFilter_AddRecentQuery(query)
	PremadeFilter_FixRecentQueries();
	
	if query == "" then
		return
	end
	
	if not PremadeFilter_Data.RecentQueries[query] then
		PremadeFilter_Data.RecentQueries[query] = true;
		table.insert(PremadeFilter_Data.RecentQueriesOrder, query);
	end
	
	PremadeFilter_FixRecentQueries();
end

function PremadeFilter_AddRecentWords(words)
	PremadeFilter_FixRecentWords();
	
	for k,v in pairs(words) do
		if not PremadeFilter_Data.RecentWords[v] then
			PremadeFilter_Data.RecentWords[v] = true;
			table.insert(PremadeFilter_Data.RecentWordsOrder, v);
		end
	end
	
	PremadeFilter_FixRecentWords();
end

function PremadeFilter_Name_OnTextChanged(self)
	InputBoxInstructions_OnTextChanged(self);
	
	if not self:HasFocus() then
		return
	end
	
	local text = self:GetText();
	LFGListFrame.SearchPanel.SearchBox:SetText(text);
	
	if text == "" then
		PremadeFilter_Frame.AutoCompleteFrame:Hide();
		return
	end
	
	local position = self:GetCursorPosition();
	local word = text:sub(1, position):gmatch("%s*[^%s]+$")();
	
	if not word then
		PremadeFilter_Frame.AutoCompleteFrame:Hide();
		return
	end
	
	-- remove prefix
	word = word:gsub("^%s*(.-)%s*$", "%1");
	local firstChar = word:sub(1,1);
	if firstChar == "+" or firstChar == "-" or firstChar == "?" then
		word = word:sub(2);
	end
	
	if word == "" then
		PremadeFilter_Frame.AutoCompleteFrame:Hide();
		return
	end

	local results = {};
	
	-- literalize
	word = word:gsub("[%(%)%.%%%+%-%*%?%[%]%^%$]", function(c) return "%" .. c end);
	
	-- words
	local strWordList = PremadeFilter_GetRecentWords();
	for w in strWordList:gmatch("%s"..word.."[^%s]*%s") do
		table.insert(results, { index = 1, text = w:gsub("^%s*(.-)%s*$", "%1") });
	end
	
	-- queries
	local strQueryList = PremadeFilter_GetRecentQueries();
	for q in strQueryList:gmatch("\n[^\n]*"..word.."[^\n]*\n") do
		table.insert(results, { index = 2, text = q:gsub("^%s*(.-)%s*$", "%1") });
	end
	
	--Sort results
	table.sort(results, 
		function(v1, v2)
			if v2.index > v1.index then
				return true;
			elseif v2.index == v1.index then
				return v2.text > v1.text;
			else
				return false;
			end
		end
	);
	
	-- check if there is only 1 result
	local numResults = #results;
	if numResults == 1 and results[1].text == word then
		PremadeFilter_Frame.AutoCompleteFrame:Hide();
		return
	end
	
	-- check max results
	local maxResults = PremadeFilter_GetSettings("MaxRecentWords");
	if numResults > maxResults then
		numResults = maxResults;
	end
	
	--Update the buttons
	for i=1, numResults do
	local r = results[i];
		local t = r.text:gsub("^%s*(.-)%s*$", "%1");
		local button = PremadeFilter_Frame.AutoCompleteFrame.Results[i];
		
		if ( not button ) then
			button = CreateFrame("BUTTON", nil, PremadeFilter_Frame.AutoCompleteFrame, "PremadeFilter_AutoCompleteButtonTemplate");
			button:SetPoint("TOPLEFT", PremadeFilter_Frame.AutoCompleteFrame.Results[i-1], "BOTTOMLEFT", 0, 0);
			button:SetPoint("TOPRIGHT", PremadeFilter_Frame.AutoCompleteFrame.Results[i-1], "BOTTOMRIGHT", 0, 0);
			PremadeFilter_Frame.AutoCompleteFrame.Results[i] = button;
		end
		
		button.result = r;
		
		if ( t == PremadeFilter_Frame.AutoCompleteFrame.selected ) then
			button.Selected:Show();
		else
			button.Selected:Hide();
		end
		
		button:SetText(t);
		button:Show();
	end
	
	--Hide unused buttons
	for i=numResults + 1, #PremadeFilter_Frame.AutoCompleteFrame.Results do
		PremadeFilter_Frame.AutoCompleteFrame.Results[i]:Hide();
	end
	
	PremadeFilter_Frame.AutoCompleteFrame:SetHeight(numResults * PremadeFilter_Frame.AutoCompleteFrame.Results[1]:GetHeight() + 8);
	PremadeFilter_Frame.AutoCompleteFrame:SetShown(numResults > 0);
end

function PremadeFilter_AutoCompleteButton_OnClick(self)
	local text = PremadeFilter_Frame.Name:GetText();
	local position = PremadeFilter_Frame.Name:GetCursorPosition();
	local word = text:sub(1, position):gmatch("%s*[^%s]+$")();
	
	word = word:gsub("^%s*(.-)%s*$", "%1");
	
	if word == "" then
		return
	end
	
	local textNew;
	
	-- query or word?
	if self.result.index == 2 then
		textNew = self.result.text.." ";
		position = textNew:len();
	else
		-- remove prefix
		local firstChar = word:sub(1,1);
		if firstChar ~= "+" and firstChar ~= "-" and firstChar ~= "?" then
			firstChar = "";
		end
		
		local wordNew = self.result.text;
		local textStart = text:sub(1, position);
		local textEnd = text:sub(position+1);
		
		textNew = textStart:gsub("%s*"..word.."$", " "..firstChar..wordNew.." ");
		position = textNew:len();
		textNew = textNew..textEnd;
	end
	
	PremadeFilter_Frame.Name:SetText(textNew:gsub("^%s*(.-)$", "%1"));
	PremadeFilter_Frame.Name:SetCursorPosition(position);
	PremadeFilter_Frame.AutoCompleteFrame:Hide();
end

function PremadeFilter_AutoCompleteAdvance(offset)
	local selected = PremadeFilter_Frame.AutoCompleteFrame.selected;

	--Find the index of the current selection and how many results we have displayed
	local idx = nil;
	local numDisplayed = 0;
	local button;
	for i=1, #PremadeFilter_Frame.AutoCompleteFrame.Results do
		button = PremadeFilter_Frame.AutoCompleteFrame.Results[i];
		if button:IsShown() then
			numDisplayed = i;
			if ( button:GetText() == selected ) then
				idx = i;
			end
		else
			break;
		end
	end

	local newIndex = nil;
	if ( not idx ) then
		--We had nothing selected, advance from the front or back
		if ( offset > 0 ) then
			newIndex = offset;
		else
			newIndex = numDisplayed + 1 + offset;
		end
	else
		--Advance from our old location
		button = PremadeFilter_Frame.AutoCompleteFrame.Results[idx];
		button.Selected:Hide();
		newIndex = ((idx - 1 + offset + numDisplayed) % numDisplayed) + 1;
	end
	
	button = PremadeFilter_Frame.AutoCompleteFrame.Results[newIndex];
	button.Selected:Show();
	
	PremadeFilter_Frame.AutoCompleteFrame.selectedIndex = newIndex;
	PremadeFilter_Frame.AutoCompleteFrame.selected = button:GetText();
end

function PremadeFilter_Options_OnLoad(self)
	self.name = "Premade Filter ";
	
	-- setup localization
	self.NotificationsHeader:SetText(T(self.NotificationsHeader:GetText()));
	self.NewGroupChatNotificationsHeader:SetText(T(self.NewGroupChatNotificationsHeader:GetText()));
	self.NewPlayerChatNotificationsHeader:SetText(T(self.NewPlayerChatNotificationsHeader:GetText()));
	self.SoundNotificationsHeader:SetText(T(self.SoundNotificationsHeader:GetText()));
	self.MonitoringHeader:SetText(T(self.MonitoringHeader:GetText()));
	self.UpdateIntervalHeader:SetText(T(self.UpdateIntervalHeader:GetText()));
	
	-- temp
	self.SoundNotifications:Disable();
	self.SoundNotificationsHeader:SetTextColor(GRAY_FONT_COLOR.r, GRAY_FONT_COLOR.g, GRAY_FONT_COLOR.b);
	
	-- save options
	self.okay = function (self)
		PremadeFilter_SetSettings("NewGroupChatNotifications", self.NewGroupChatNotifications:GetChecked());
		PremadeFilter_SetSettings("NewPlayerChatNotifications", self.NewPlayerChatNotifications:GetChecked());
		PremadeFilter_SetSettings("SoundNotifications", self.SoundNotifications:GetChecked());
		PremadeFilter_SetSettings("UpdateInterval", self.UpdateInterval:GetValue());
	end;
	
	-- add panel
	InterfaceOptions_AddCategory(self);
end

function PremadeFilter_MenuTitleItem(text)
	return {
		isTitle			= true,
		notCheckable	= true,
		text			= T(text),
	};
end

function PremadeFilter_MenuSpacerItem()
	return {
		isTitle			= true,
		notCheckable	= true,
		text			= "",
	};
end

function PremadeFilter_MenuActionItem(text, func, disabled)
	return {
		notCheckable	= true,
		disabled		= disabled,
		text			= T(text),
		func			= func,
	};
end

function PremadeFilter_MenuRadioItem(text, checked, func, disabled)
	return {
		checked			= checked,
		disabled		= disabled,
		text			= T(text),
		func			= func,
	};
end

function PremadeFilter_MenuCheckboxItem(text, checked, func, disabled)
	return {
		isNotRadio		= true,
		checked			= checked,
		disabled		= disabled,
		text			= T(text),
		func			= func,
	};
end

function PremadeFilter_SubMenuItem(text, menuList)
	return {
		notCheckable	= true,
		hasArrow		= true,
		text			= T(text),
		menuList		= menuList,
	};
end

function PremadeFilter_OptionsMenu(self)
	local dropDownList = _G["DropDownList"..UIDROPDOWNMENU_MENU_LEVEL];
	if dropDownList:IsShown() then
		CloseDropDownMenus();
		return;
	end
	
	local saveDialog = StaticPopup_FindVisible("PREMADEFILTER_SAVE_FILTERSET");
	if saveDialog then
		return;
	end
	
	local menuList = {
		PremadeFilter_MenuTitleItem("Filter set"),
		PremadeFilter_MenuSpacerItem(),
		PremadeFilter_MenuTitleItem("Actions"),
		PremadeFilter_MenuActionItem(SAVE, PremadeFilter_SaveFilterSet),
		PremadeFilter_MenuActionItem(DELETE, PremadeFilter_DeleteFilterSet),
		PremadeFilter_MenuSpacerItem(),
		PremadeFilter_MenuTitleItem(SETTINGS),
		PremadeFilter_MenuCheckboxItem("Notify in chat on new group", PremadeFilter_GetSettings("NewGroupChatNotifications"),
			function(self, arg1, arg2, checked)
				self.checked = not checked;
				PremadeFilter_SetSettings("NewGroupChatNotifications", self.checked);
			end
		),
		PremadeFilter_MenuCheckboxItem("Notify in chat on new player", PremadeFilter_GetSettings("NewPlayerChatNotifications"),
			function(self, arg1, arg2, checked)
				self.checked = not checked;
				PremadeFilter_SetSettings("NewPlayerChatNotifications", self.checked);
			end
		),
		PremadeFilter_MenuCheckboxItem("Enable sound notifications", PremadeFilter_GetSettings("SoundNotifications"), nil, true),
		PremadeFilter_MenuActionItem(ADVANCED_OPTIONS,
			function()
				InterfaceOptionsFrame_Show();
				InterfaceOptionsFrame_OpenToCategory(PremadeFilter_Options);
			end
		),
		PremadeFilter_MenuActionItem(CANCEL,
			function()
				CloseDropDownMenus();
			end
		),
	};
	
	local recentSets = PremadeFilter_GetRecentFilterSets();
	for index,text in pairs(recentSets) do
		local selectedIndex = #PremadeFilter_Data.FilterSetsOrder - PremadeFilter_Frame.selectedFilterSet + 2;
		local checked = (index == selectedIndex);
		table.insert(menuList, index+1, PremadeFilter_MenuRadioItem(text, checked, PremadeFilter_OnFilterSetSelected));
	end
	
	local restSets = PremadeFilter_GetRestFilterSets();
	if #restSets > 0 then
		local moreItems = {};
		for index,text in pairs(restSets) do
			table.insert(moreItems, PremadeFilter_MenuRadioItem(text, false, PremadeFilter_OnFilterSetSelected));
		end
		table.insert(menuList, #recentSets+2, PremadeFilter_SubMenuItem("More", moreItems));
	end
	
	EasyMenu(menuList, self.Menu, self, 117 , 0, "MENU");
end

function PremadeFilter_FixFilterSets()
	if type(PremadeFilter_Data.FilterSets) ~= "table" then
		PremadeFilter_Data.FilterSets = {};
	end
	
	if type(PremadeFilter_Data.FilterSetsOrder) ~= "table" then
		PremadeFilter_Data.FilterSetsOrder = {};
		for k,v in pairs(PremadeFilter_Data.FilterSets) do
			table.insert(PremadeFilter_Data.FilterSetsOrder, k);
		end
	end
	
	while #PremadeFilter_Data.FilterSetsOrder > 30 do
		local word = table.remove(PremadeFilter_Data.FilterSetsOrder, 1);
		PremadeFilter_Data.FilterSets[word] = nil;
	end
	
	if type(PremadeFilter_Frame.selectedFilterSet) ~= "number" or PremadeFilter_Frame.selectedFilterSet < 1 or PremadeFilter_Frame.selectedFilterSet > #PremadeFilter_Data.FilterSetsOrder then
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder + 1;
	end
end

function PremadeFilter_GetRecentFilterSets()
	PremadeFilter_FixFilterSets();
	
	local recentSets = { T("New filter set") };
	local index = #PremadeFilter_Data.FilterSetsOrder;
	
	while index > 0 and index > #PremadeFilter_Data.FilterSetsOrder-5 do
		table.insert(recentSets, PremadeFilter_Data.FilterSetsOrder[index]);
		index = index - 1;
	end
	
	return recentSets;
end

function PremadeFilter_GetRestFilterSets()
	PremadeFilter_FixFilterSets();
	
	local restSets = {};
	local index = #PremadeFilter_Data.FilterSetsOrder - 5;
	
	while index > 0 do
		table.insert(restSets, PremadeFilter_Data.FilterSetsOrder[index]);
		index = index - 1;
	end
	
	return restSets;
end

function PremadeFilter_SaveFilterSet()
	StaticPopup_Show("PREMADEFILTER_SAVE_FILTERSET");
end

function PremadeFilter_DeleteFilterSet()
	local index = PremadeFilter_Frame.selectedFilterSet;
	
	if index <= #PremadeFilter_Data.FilterSetsOrder then
		StaticPopup_Show("PREMADEFILTER_CONFIRM_DELETE");
	end
end

function PremadeFilter_OnFilterSetSelected(self, arg1, arg2, checked)
	local index = self:GetID();
	
	if UIDROPDOWNMENU_MENU_LEVEL == 1 then
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder - index + 3;
	elseif UIDROPDOWNMENU_MENU_LEVEL == 2 then
		local order = #PremadeFilter_Data.FilterSetsOrder - 5 + index - 1;
		local text = table.remove(PremadeFilter_Data.FilterSetsOrder, order);
		table.insert(PremadeFilter_Data.FilterSetsOrder, text);
		PremadeFilter_Frame.selectedFilterSet = #PremadeFilter_Data.FilterSetsOrder;
	end
	
	CloseDropDownMenus();
	
	local setIndex = PremadeFilter_Frame.selectedFilterSet;
	local filters;
	
	if setIndex <= #PremadeFilter_Data.FilterSetsOrder then
		local setName = PremadeFilter_Data.FilterSetsOrder[setIndex];
		filters = PremadeFilter_Data.FilterSets[setName];
	else
		filters = {
			category	= PremadeFilter_Frame.selectedCategory,
			group		= PremadeFilter_Frame.selectedGroup,
			activity	= PremadeFilter_Frame.selectedActivity,
		};
	end
	
	PremadeFilter_SetFilters(filters);
	
	PremadeFilter_FilterButton_OnClick(PremadeFilter_Frame.FilterButton);
end

function PremadeFilter_UpdateIntervalSlider_OnValueChanged(self)
	PremadeFilter_UpdateIntervalEditBox:SetText(self:GetValue());
	PremadeFilter_UpdateIntervalShortAlert_UpdateVisibility(PremadeFilter_UpdateIntervalShortAlert);

	if not self._onsetting then   -- is single threaded 
		self._onsetting = true
		self:SetValue(self:GetValue())
		self._onsetting = false
	else 
		return
	end               -- ignore recursion for actual event handler
end

function PremadeFilter_UpdateIntervalEditBox_OnLoad(self)
	self:SetText(PremadeFilter_UpdateIntervalSlider:GetValue());
end

function PremadeFilter_UpdateIntervalEditBox_OnEnterPressed(self)
	self:ClearFocus();

	local v = tonumber(self:GetText());
	if v == nil then return	end

	PremadeFilter_UpdateIntervalSlider:SetValue(v);
	self:SetText(PremadeFilter_UpdateIntervalSlider:GetValue());
end

function PremadeFilter_UpdateIntervalShortAlert_UpdateVisibility(self)
	if PremadeFilter_UpdateIntervalSlider:GetValue() < 15 then
		self:Show();
	else
		self:Hide();
	end	
end
