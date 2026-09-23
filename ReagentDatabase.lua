local _, ns = ...

-- Database of reagent-consuming spells per class.
-- Each entry: spells = {spellID, ...} (any spell in the list can trigger this reagent), reagent = itemID.
ns.spells = {
	WARLOCK = {
		{	-- Spell: shared by every Soul Shard consuming ability below
			spells = {
				697,	-- Spell: Summon Voidwalker
				698,	-- Spell: Ritual of Summoning
				712,	-- Spell: Summon Succubus
				691,	-- Spell: Summon Felhunter
				6353,	-- Spell: Soul Fire
				17924,	-- Spell: Soul Fire (Rank 2)
				27211,	-- Spell: Soul Fire (Rank 3)
				30545,	-- Spell: Soul Fire (Rank 4)
				29858,	-- Spell: Soulshatter
				29893,	-- Spell: Ritual of Souls
				693,	-- Spell: Create Soulstone (Minor)
				20752,	-- Spell: Create Soulstone (Lesser)
				20755,	-- Spell: Create Soulstone
				20756,	-- Spell: Create Soulstone (Greater)
				20757,	-- Spell: Create Soulstone (Major)
				27238,	-- Spell: Create Soulstone (Rank 6)
				6201,	-- Spell: Create Healthstone (Minor)
				6202,	-- Spell: Create Healthstone (Lesser)
				5699,	-- Spell: Create Healthstone
				11729,	-- Spell: Create Healthstone (Greater)
				11730,	-- Spell: Create Healthstone (Major)
				27230,	-- Spell: Create Healthstone (Rank 6)
				6366,	-- Spell: Create Firestone (Lesser)
				17951,	-- Spell: Create Firestone
				17952,	-- Spell: Create Firestone (Greater)
				17953,	-- Spell: Create Firestone (Major)
				27250,	-- Spell: Create Firestone (Rank 5)
				2362,	-- Spell: Create Spellstone
				17727,	-- Spell: Create Spellstone (Greater)
				17728,	-- Spell: Create Spellstone (Major)
				28172,	-- Spell: Create Spellstone (Rank 4)
				1098,	-- Spell: Enslave Demon
				11725,	-- Spell: Enslave Demon (Rank 2)
				11726,	-- Spell: Enslave Demon (Rank 3)
			},
			reagent = 6265,	-- Item: Soul Shard
		},
		{
			spells = {1122},	-- Spell: Inferno
			reagent = 5565,		-- Item: Infernal Stone
		},
		{
			spells = {18540},	-- Spell: Ritual of Doom
			reagent = 16583,	-- Item: Demonic Figurine
		},
	},
	PRIEST = {
		{
			spells = {1706},	-- Spell: Levitate
			reagent = 17056,	-- Item: Light Feather
		},
		{
			spells = {21562},	-- Spell: Prayer of Fortitude (Rank 1)
			reagent = 17028,	-- Item: Holy Candle
		},
		{
			spells = {
				27683,	-- Spell: Prayer of Shadow Protection
				39374,	-- Spell: Prayer of Shadow Protection (Rank 2)
				27681,	-- Spell: Prayer of Spirit
				32999,	-- Spell: Prayer of Spirit (Rank 2)
				21564,	-- Spell: Prayer of Fortitude (Rank 2)
				25392,	-- Spell: Prayer of Fortitude (Rank 3)
			},
			reagent = 17029,	-- Item: Sacred Candle
		},
		{
			spells = {
				48162,	-- Spell: Prayer of Fortitude (Rank 4)
				48170,	-- Spell: Prayer of Shadow Protection (Rank 3)
				48074,	-- Spell: Prayer of Spirit (Rank 3)
			},
			reagent = 44615,	-- Item: Devout Candle
		},
	},
	SHAMAN = {
		{
			spells = {20608},	-- Spell: Reincarnation
			reagent = 17030,	-- Item: Ankh
		},
		{
			spells = {131},		-- Spell: Water Breathing
			reagent = 17057,	-- Item: Shiny Fish Scales
		},
		{
			spells = {546},		-- Spell: Water Walking
			reagent = 17058,	-- Item: Fish Oil
		},
	},
	MAGE = {
		{	-- Self-only teleports
			spells = {
				3567,	-- Spell: Teleport: Orgrimmar
				3563,	-- Spell: Teleport: Undercity
				3566,	-- Spell: Teleport: Thunder Bluff
				32272,	-- Spell: Teleport: Silvermoon
				49358,	-- Spell: Teleport: Stonard
				35715,	-- Spell: Teleport: Shattrath (Horde)
				3561,	-- Spell: Teleport: Stormwind
				3562,	-- Spell: Teleport: Ironforge
				3565,	-- Spell: Teleport: Darnassus
				32271,	-- Spell: Teleport: Exodar
				49359,	-- Spell: Teleport: Theramore
				33690,	-- Spell: Teleport: Shattrath (Alliance)
			},
			reagent = 17031,	-- Item: Rune of Teleportation
		},
		{	-- Group portals
			spells = {
				11417,	-- Spell: Portal: Orgrimmar
				11418,	-- Spell: Portal: Undercity
				11420,	-- Spell: Portal: Thunder Bluff
				32267,	-- Spell: Portal: Silvermoon
				49361,	-- Spell: Portal: Stonard
				35717,	-- Spell: Portal: Shattrath (Horde)
				10059,	-- Spell: Portal: Stormwind
				11416,	-- Spell: Portal: Ironforge
				11419,	-- Spell: Portal: Darnassus
				32266,	-- Spell: Portal: Exodar
				49360,	-- Spell: Portal: Theramore
				33691,	-- Spell: Portal: Shattrath (Alliance)
			},
			reagent = 17032,	-- Item: Rune of Portals
		},
		{
			spells = {130},		-- Spell: Slow Fall
			reagent = 17056,	-- Item: Light Feather
		},
		{	-- Food/drink ritual spells
			spells = {
				23028,	-- Spell: Arcane Brilliance (Rank 1)
				27127,	-- Spell: Arcane Brilliance (Rank 2)
				43002,	-- Spell: Arcane Brilliance (Rank 3)
				43987,	-- Spell: Ritual of Refreshment (Rank 1)
				58659,	-- Spell: Ritual of Refreshment (Rank 2)
			},
			reagent = 17020,	-- Item: Arcane Powder
		},
	},
	ROGUE = {
		-- Spell: all entries below share the "Poisons" skill (spell 2842) - the actual
		-- poison used comes from whichever item is applied, not from the spell itself.
		{
			spells = {2842},
			reagent = 21835,	-- Item: Anesthetic Poison
		},
		{
			spells = {2842},
			reagent = 6947,		-- Item: Instant Poison
		},
		{
			spells = {2842},
			reagent = 6949,		-- Item: Instant Poison II
		},
		{
			spells = {2842},
			reagent = 6950,		-- Item: Instant Poison III
		},
		{
			spells = {2842},
			reagent = 8926,		-- Item: Instant Poison IV
		},
		{
			spells = {2842},
			reagent = 8927,		-- Item: Instant Poison V
		},
		{
			spells = {2842},
			reagent = 8928,		-- Item: Instant Poison VI
		},
		{
			spells = {2842},
			reagent = 21927,	-- Item: Instant Poison VII
		},
		{
			spells = {2842},
			reagent = 3775,		-- Item: Crippling Poison
		},
		{
			spells = {2842},
			reagent = 3776,		-- Item: Crippling Poison II
		},
		{
			spells = {2842},
			reagent = 5237,		-- Item: Mind-numbing Poison
		},
		{
			spells = {2842},
			reagent = 6951,		-- Item: Mind-numbing Poison II
		},
		{
			spells = {2842},
			reagent = 9186,		-- Item: Mind-numbing Poison III
		},
		{
			spells = {2842},
			reagent = 2892,		-- Item: Deadly Poison
		},
		{
			spells = {2842},
			reagent = 2893,		-- Item: Deadly Poison II
		},
		{
			spells = {2842},
			reagent = 8984,		-- Item: Deadly Poison III
		},
		{
			spells = {2842},
			reagent = 8985,		-- Item: Deadly Poison IV
		},
		{
			spells = {2842},
			reagent = 20844,	-- Item: Deadly Poison V
		},
		{
			spells = {2842},
			reagent = 22053,	-- Item: Deadly Poison VI
		},
		{
			spells = {2842},
			reagent = 22054,	-- Item: Deadly Poison VII
		},
		{
			spells = {2842},
			reagent = 10918,	-- Item: Wound Poison
		},
		{
			spells = {2842},
			reagent = 10920,	-- Item: Wound Poison II
		},
		{
			spells = {2842},
			reagent = 10921,	-- Item: Wound Poison III
		},
		{
			spells = {2842},
			reagent = 10922,	-- Item: Wound Poison IV
		},
		{
			spells = {2842},
			reagent = 22055,	-- Item: Wound Poison V
		},
		{
			spells = {
				1856,	-- Spell: Vanish
				1857,	-- Spell: Vanish (Rank 2)
				26889,	-- Spell: Vanish (Rank 3)
			},
			reagent = 5140,		-- Item: Flash Powder
		},
		{
			spells = {2094},	-- Spell: Blind
			reagent = 5530,		-- Item: Blinding Powder
		},
	},
	DRUID = {
		{
			spells = {20484},	-- Spell: Rebirth (Rank 1)
			reagent = 17034,	-- Item: Maple Seed
		},
		{
			spells = {20739},	-- Spell: Rebirth (Rank 2)
			reagent = 17035,	-- Item: Stranglethorn Seed
		},
		{
			spells = {20742},	-- Spell: Rebirth (Rank 3)
			reagent = 17036,	-- Item: Ashwood Seed
		},
		{
			spells = {20747},	-- Spell: Rebirth (Rank 4)
			reagent = 17037,	-- Item: Hornbeam Seed
		},
		{
			spells = {20748},	-- Spell: Rebirth (Rank 5)
			reagent = 17038,	-- Item: Maple Seed
		},
		{
			spells = {26994},	-- Spell: Rebirth (Rank 6)
			reagent = 22147,	-- Item: Flintweed Seed
		},
		{
			spells = {48477},	-- Spell: Rebirth (Rank 7)
			reagent = 44614,	-- Item: Starleaf Seed
		},
		{
			spells = {21849},	-- Spell: Gift of the Wild (Rank 1)
			reagent = 17021,	-- Item: Wild Berries
		},
		{
			spells = {21850},	-- Spell: Gift of the Wild (Rank 2)
			reagent = 17026,	-- Item: Wild Thornroot
		},
		{
			spells = {26991},	-- Spell: Gift of the Wild (Rank 3)
			reagent = 22148,	-- Item: Wild Quillvine
		},
		{
			spells = {48470},	-- Spell: Gift of the Wild (Rank 4)
			reagent = 44605,	-- Item: Wild Spineleaf
		},
	},
	PALADIN = {
		{
			spells = {19752},	-- Spell: Divine Intervention
			reagent = 17033,	-- Item: Symbol of Divinity
		},
		{	-- All Greater Blessings share the same reagent
			spells = {
				25782,	-- Spell: Greater Blessing of Might (Rank 1)
				25916,	-- Spell: Greater Blessing of Might (Rank 2)
				27141,	-- Spell: Greater Blessing of Might (Rank 3)
				25894,	-- Spell: Greater Blessing of Wisdom (Rank 1)
				25918,	-- Spell: Greater Blessing of Wisdom (Rank 2)
				27143,	-- Spell: Greater Blessing of Wisdom (Rank 3)
				25898,	-- Spell: Greater Blessing of Kings
				25895,	-- Spell: Greater Blessing of Salvation
				25899,	-- Spell: Greater Blessing of Sanctuary
				27169,	-- Spell: Greater Blessing of Sanctuary (Rank 2)
				25890,	-- Spell: Greater Blessing of Light
				27145,	-- Spell: Greater Blessing of Light (Rank 2)
			},
			reagent = 21177,	-- Item: Symbol of Kings
		},
	},
}
