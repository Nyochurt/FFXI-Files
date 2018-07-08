--------------------------------------------------------------------------------------------------------------------	
-- SETUP FUNCTIONS FOR THIS JOB.
--------------------------------------------------------------------------------------------------------------------	
----------------------------------------------------------------------------
-- Initialization function for this job file.
----------------------------------------------------------------------------
function get_sets()
    mote_include_version = 2
    ----------------------------------------------------------------
    -- Load and initialize the include file.
	----------------------------------------------------------------
    include('Mote-Include.lua')
	----------------------------------------------------------------
	-- Load organizer add on to grab all gear associated with lua.
	----------------------------------------------------------------
	include('organizer-lib')
	----------------------------------------------------------------
	-- Load and initialize the AutoStun file.
	----------------------------------------------------------------	
	include('Sel-Stahp.lua')
end
----------------------------------------------------------------------------
-- Setup vars that are user-independent.
----------------------------------------------------------------------------
function job_setup()
    state.Buff.Doom = 														buffactive.Doom or false
	state.Buff['Mana Wall'] = 												buffactive['Mana Wall'] or false
end
--------------------------------------------------------------------------------------------------------------------
-- USER SETUP FUNCTIONS FOR THIS JOB FILE.  
--------------------------------------------------------------------------------------------------------------------
function user_setup()
    state.OffenseMode:options('Normal', 'Melee', 'MeleeACC')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
	----------------------------------------------------------------
	-- Cycle between capacity point bonus gear and normal
	----------------------------------------------------------------
	state.CapacityMode = 											M{['description']='Capacity Bonus', 'Normal', 'Bonus Active'}
	----------------------------------------------------------------
	-- Auto sublimation on or off
	----------------------------------------------------------------	
	state.AutoSubMode = 											M(false, 'Auto Sublimation Mode')
	----------------------------------------------------------------
	-- Spakeona's Coat
	----------------------------------------------------------------
	state.ConsMP =													M(false, 'Conserve MP')
	----------------------------------------------------------------
	-- Cycle between elemental mage and death mage
	----------------------------------------------------------------
	state.MageMode = 												M{['description']='Mage Mode', 'Casting Mage', 'Melee Mage', 'Death Mage'}
	----------------------------------------------------------------
	-- Cycle between elemental mage and death mage magic burst
	----------------------------------------------------------------
	state.BurstMode = 												M{['description']='Burst Mode', 'Burst Off', 'Burst On'}
	----------------------------------------------------------------
	-- Custom magic tiers
	----------------------------------------------------------------	
	lowTierNukes = 													S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder",
																	"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
																	"Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
																	"Stonega", "Waterga", "Aeroga", "Firaga", "Blizzaga", "Thundaga",
																	"Stonega II", "Waterga II", "Aeroga II", "Firaga II", "Blizzaga II", "Thundaga II"}
	
	highTierNukes = 												S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
																	"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V",
																	"Stone VI", "Water VI", "Aero VI", "Fire VI", "Blizzard VI", "Thunder VI",
																	"Stonega III", "Waterga III", "Aeroga III", "Firaga III", "Blizzaga III", "Thundaga III",
																	"Stoneja", "Waterja", "Aeroja", "Firaja", "Blizzaja", "Thundaja",
																	"Quake","Tornado","Freeze","Flare","Flood","Burst","Comet",
																	"Quake II","Tornado II","Freeze II","Flare II","Flood II","Burst II"}
 	
	ancientIINukes = 												S{"Quake II","Tornado II","Freeze II","Flare II","Flood II","Burst II",}
----------------------------------------------------------------------------
-- Augmented Gear
----------------------------------------------------------------------------
	-- Weapons
		gear.Staff.Lathi = {}
		gear.Staff.Lathi.A 				= {name="Lathi", augments={'MP+80','INT+20','"Mag.Atk.Bns."+20'}}
	
		gear.Staff.Grioavolr = {}
		gear.Staff.Grioavolr.Nuke 		= {name="Grioavolr", augments={'"Fast Cast"+3','INT+1','Mag. Acc.+29','"Mag.Atk.Bns."+29','Magic Damage +6',}}
		gear.Staff.Grioavolr.Enf 		= {name="Grioavolr", augments={'Enfb.mag. skill +15','MND+17','Mag. Acc.+22',}}
		gear.Staff.Grioavolr.Enh 		= {name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}
    
	-- Artifact --
		gear.BLMAF = {}
		gear.BLMAF.Head 				= {name="Spae. Petasos +3"}
		gear.BLMAF.Body 				= {name="Spae. Coat +3"}
		gear.BLMAF.Hands 				= {name="Spae. Gloves +3"}
		gear.BLMAF.Legs 				= {name="Spae. Tonban +3"}
		gear.BLMAF.Feet 				= {name="Spae. Sabots +3"}
	
	-- Relic119 - AMII and Manafont Bonuses
		gear.BLMRelic = {}
		gear.BLMRelic.Head 				= {name="Arch. Petasos +2", augments={'Increases Ancient Magic II damage',}}
		gear.BLMRelic.Body 				= {name="Arch. Coat +3", augments={'Enhances "Manafont" effect',}}
		gear.BLMRelic.Hands 			= {name="Arch. Gloves +1", augments={'Reduces Ancient Magic II casting time',}}
		gear.BLMRelic.Legs 				= {name="Arch. Tonban +3", augments={'Increases Ancient Magic II accuracy',}}
		gear.BLMRelic.Feet 				= {name="Arch. Sabots +1", augments={'Reduces Ancient Magic II MP cost',}}
	
	-- Empyrean --
		gear.BLMEmpy = {}
		gear.BLMEmpy.Head 				= {name="Wicce Petasos +1"}
		gear.BLMEmpy.Body 				= {name="Wicce Coat +1"}
		gear.BLMEmpy.Hands 				= {name="Wicce Gloves +1"}
		gear.BLMEmpy.Legs				= {name="Wicce Chausses +1"}
		gear.BLMEmpy.Feet				= {name="Wicce Sabots +1"}
	
    -- JSE Capes
		gear.BLMJSE = {}  				-- Shoud only be used for Max MP or Pure Skill builds, Taranus's MACC beats for resist sets
		gear.BLMJSE.MP 					= {name="Bane Cape", augments={'Elem. magic skill +2','Dark magic skill +10','"Fast Cast"+4',}}
	
		gear.Taranus = {}  					-- Nuke cape for INT Enfeebles, FC for MND Enfeebles
		gear.Taranus.Nuke 				= {name="Taranus's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
		gear.Taranus.FC 				= {name="Taranus's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
		--gear.Taranus.ACC 				= {name="Taranus's Cape", augments={'DEX+20','Accuracy+20 Attack+20','Haste+10',}}
       
    -- Telchine
		gear.Telchine = {}
		gear.Telchine.Head				= {name="Telchine Cap", augments={'"Conserve MP"+5','Enh. Mag. eff. dur. +7',}}
		gear.Telchine.Body 				= {name="Telchine Chas.", augments={'Evasion+14','Spell interruption rate down -9%','Enh. Mag. eff. dur. +7',}}
		gear.Telchine.Hands				= {name="Telchine Gloves", augments={'Mag. Evasion+10','"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
		--gear.Telchine.Legs			= {}
		gear.Telchine.Feet				= {name="Telchine Pigaches", augments={'"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
	
	-- Helios
		gear.Helios = {}
		gear.Helios.Body 				= {name="Helios Jacket", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +10','Mag. crit. hit dmg. +9%',}}
    
    -- Psycloth
		gear.Psycloth = {}
		gear.Psycloth.Body 				= {name="Psycloth Vest", augments={'Elem. magic skill +20','INT+7','Enmity-6',}}
		gear.Psycloth.Hands 			= {name="Psycloth Manillas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}}
		gear.Psycloth.Legs 				= {name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}
		gear.Psycloth.Feet 				= {name="Psycloth Boots", augments={'MP+50','INT+7','"Conserve MP"+6',}}
    
    -- Amalric 
		gear.Amalric = {}
		gear.Amalric.Head = {}
		gear.Amalric.Head.A 			= {name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
		gear.Amalric.Body = {}
		gear.Amalric.Body.D				= {name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3'}}
		gear.Amalric.Hands = {}
		gear.Amalric.Hands.A 			= {name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
		gear.Amalric.Hands.D 			= {name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
		gear.Amalric.Legs = {}
		gear.Amalric.Legs.C 			= {name="Amalric Slops", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
		gear.Amalric.Legs.D 			= {name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}}
		gear.Amalric.Feet = {}
		gear.Amalric.Feet.A 			= {name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}} 

    -- Merlinic
		gear.Merlinic = {}
		gear.Merlinic.Head = {}
		gear.Merlinic.Head.DrAsp 		= {name="Merlinic Hood", augments={'Mag. Acc.+7','"Drain" and "Aspir" potency +10','MND+4',}}
		gear.Merlinic.Head.FC 			= {name="Merlinic Hood", augments={'Mag. Acc.+29','"Fast Cast"+6','CHR+8',}}
		gear.Merlinic.Head.MAB 			= {name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+9%','CHR+5','Mag. Acc.+11','"Mag.Atk.Bns."+13',}}
		gear.Merlinic.Body = {}
		gear.Merlinic.Body.FC 			= {name="Merlinic Jubbah", augments={'"Fast Cast"+7',}}
		gear.Merlinic.Body.MAB 			= {name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Enmity-3','INT+13','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Body.Burst 		= {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+11%','CHR+10','Mag. Acc.+13',}}
		gear.Merlinic.Body.DrAsp		= {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','MND+4','"Mag.Atk.Bns."+13',}}
		gear.Merlinic.Hands = {}
		gear.Merlinic.Hands.DrAsp 		= {name="Merlinic Dastanas", augments={'Accuracy+12','"Drain" and "Aspir" potency +10','INT+2','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Hands.FC			= {name="Merlinic Dastanas", augments={'Mag. Acc.+26','"Fast Cast"+6','INT+1','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Hands.Ref			= {name="Merlinic Dastanas", augments={'Crit. hit damage +1%','Pet: AGI+8','"Refresh"+2','Accuracy+15 Attack+15',}}
		gear.Merlinic.Legs = {}
		gear.Merlinic.Legs.DrAsp 		= {name="Merlinic Shalwar", augments={'Mag. Acc.+22','"Drain" and "Aspir" potency +11','AGI+10','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Legs.MAB 			= {name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+8%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Legs.Ref			= {name="Merlinic Shalwar", augments={'"Store TP"+5','Accuracy+1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
		gear.Merlinic.Feet = {}
		gear.Merlinic.Feet.Burst 		= {name="Merlinic Crackows", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+8%','MND+14','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
		gear.Merlinic.Feet.DrAsp 		= {name="Merlinic Crackows", augments={'Mag. Acc.+24','"Drain" and "Aspir" potency +9','INT+4',}}
		gear.Merlinic.Feet.FC 			= {name="Merlinic Crackows", augments={'"Fast Cast"+7','INT+2',}}
		gear.Merlinic.Feet.MAB 			= {name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+6','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Feet.Ref			= {name="Merlinic Crackows", augments={'"Triple Atk."+1','DEX+7','"Refresh"+2','Accuracy+11 Attack+11','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
	
	-- Hagondes
		gear.Hagondes = {}
		gear.Hagondes.Legs 				= {name="Hagondes Pants +1", augments={'Phys. dmg. taken -3%','Magic dmg. taken -2%','"Mag.Atk.Bns."+28',}}
	
	-- Vanya
		gear.Vanya = {}
		gear.Vanya.Head 				= {name="Vanya Hood", augments={'MP+50','"Fast Cast"+10','Haste+2%',}}
		gear.Vanya.Body 				= {name="Vanya Robe", augments={'MND+10','Spell interruption rate down +15%','"Conserve MP"+6',}}
		gear.Vanya.Hands 				= {name="Vanya Cuffs", augments={'Healing magic skill +20','"Cure" spellcasting time -7%','Magic dmg. taken -3',}}
		gear.Vanya.Feet 				= {name="Vanya Clogs", augments={'"Cure" potency +5%','"Cure" spellcasting time -15%','"Conserve MP"+6',}}
	
	-- Misc Augmented Gear
	
		-- Jhakri
		gear.Jhakri = {}
		gear.Jhakri.Head				= {head="Jhakri Coronal +1"}
		gear.Jhakri.Body				= {name="Jhakri Robe +2"}
		gear.Jhakri.Hands				= {name="Jhakri Cuffs +2"}
		gear.Jhakri.Legs				= {name="Jhakri Slops +1"}
		gear.Jhakri.Feet				= {name="Jhakri Pigaches +1"}
		
		-- Mallquis
		gear.Mallquis = {}
	    gear.Mallquis.Head 				= {name="Mallquis Chapeau +1"}
		gear.Mallquis.Body 				= {name="Mallquis Saio +2"}
		gear.Mallquis.Hands 			= {name="Mallquis Cuffs +1"}
		gear.Mallquis.Legs 				= {name="Mallquis Trews +1"}
		gear.Mallquis.Feet 				= {name="Mallquis Clogs +1"}
		
		gear.Witching = {}
		gear.Witching 					= {name="Witching Robe", augments={'MP+45','Mag. Acc.+14','"Mag.Atk.Bns."+14',}}
	
		gear.Mediums = {}
		gear.Mediums 					= {name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}}
	
		gear.Otomi = {}
		gear.Otomi 						= {name="Otomi Gloves", augments={'Haste+2','"Snapshot"+2','"Fast Cast"+3',}}
	
		gear.Moonshade = {}
		gear.Moonshade 					= {name="Moonshade Earring", augments={'MP+25','Latent effect: "Refresh"+1',}}
	
		gear.Lengo = {}
		gear.Lengo 						= {name="Lengo Pants", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15','"Refresh"+1',}}
	----------------------------------------------------------------
	-- Additional local binds
	----------------------------------------------------------------
    windower.send_command('bind ^` input /ma Stun <t>;input /echo Target <t> Stunned')
    windower.send_command('bind ^q gs c cycle BurstMode')
	windower.send_command('bind ^z gs c toggle AutoSubMode')
	windower.send_command('bind !` gs c toggle ConsMP')
	windower.send_command('bind ^c gs c cycle CapacityMode')
	windower.send_command('bind ^y gs equip sets.hp;wait .5;gs c update')
	windower.send_command('bind ^a gs c cycle MageMode')
	windower.send_command('bind !^a gs c cycle StaffMode')
	----------------------------------------------------------------
	-- Check if sub Scholar
	---------------------------------------------------------------- 	
	auto_sublimation()
	----------------------------------------------------------------
	-- Select Mage Mode for Spells
	----------------------------------------------------------------    
	magemode()
	----------------------------------------------------------------
	-- Specific time gear
	----------------------------------------------------------------	
	--timedgear()
	----------------------------------------------------------------
	-- Select macro book
	----------------------------------------------------------------
    select_default_macro_book()
end
----------------------------------------------------------------------------
-- Called when this job file is unloaded (eg: job change)
----------------------------------------------------------------------------
function user_unload()
    windower.send_command('unbind ^`')
    windower.send_command('unbind ^q')
	windower.send_command('unbind ^z')
	windower.send_command('unbind !`')	
	windower.send_command('unbind ^c')
	windower.send_command('unbind ^y')
	windower.send_command('unbind ^a')
	windower.send_command('unbind !^a')
end
--------------------------------------------------------------------------------------------------------------------
-- DEFINE SETS AND VARS USED BY THIS JOB FILE
--------------------------------------------------------------------------------------------------------------------
function init_gear_sets()
----------------------------------------------------------------------------
-- Organizer Items
----------------------------------------------------------------------------
	organizer_items = 												{}
----------------------------------------------------------------------------
-- RESTING/IDLE/DEFENSE/TOWN/ETC Sets
----------------------------------------------------------------------------
	----------------------------------------------------------------
	-- Idle set(s)
	----------------------------------------------------------------
	sets.idle = 													{ammo="Ghastly Tathlum +1",
																	head="Befouled Crown",
																	body=gear.Jhakri.Body,
																	hands=gear.Merlinic.Hands.Ref,
																	legs=gear.Merlinic.Legs.Ref,
																	feet=gear.Merlinic.Feet.Ref,
																	neck="Sanctity Necklace",
																	waist="Hierarch Belt",																		
																	right_ear="Graiai Earring",
																	left_ear="Etiolation Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back=gear.BLMJSE.MP,}    
	----------------------------------------------------------------
	-- Resting MP recovery gear
	----------------------------------------------------------------
	sets.resting = 													{main="Boonwell Staff",
																	sub="Ariesian Grip",
																	ammo="Clarus Stone",
																	head="Oracle's Cap",
																	body=gear.Jhakri.Body,
																	hands="Nares Cuffs",
																	legs="Menhit Slacks",
																	feet="Oracle's Pigaches",
																	neck="Beak Necklace +1",
																	waist="Hierarch Belt",
																	right_ear="Magnetic Earring",
																	left_ear="Etiolation Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back=gear.BLMJSE.MP,}
    ----------------------------------------------------------------
	-- Physical Defense set(s)
	----------------------------------------------------------------
	sets.defense.PDT =  		   									{ammo="Ghastly Tathlum +1",
																	head="Blistering Sallet +1",
																	body=gear.Mallquis.Body,
																	hands=gear.Merlinic.Hands.Ref,
																	legs=gear.Hagondes.Legs,
																	feet=gear.Mallquis.Feet,
																	neck="Loricate Torque +1",
																	waist="Cetl Belt",
																	left_ear="Infused Earring",
																	right_ear="Genmei Earring",
																	left_ring="Patricius Ring",
																	right_ring="Defending Ring",
																	back="Moonbeam Cape",}
    ----------------------------------------------------------------
	-- Magical Defense set(s)
	----------------------------------------------------------------
    sets.defense.MDT = 	    										{ammo="Sihirik",
																	head=gear.Vanya.Head,
																	body=gear.Mallquis.Body,
																	hands=gear.Vanya.Hands,
																	legs=gear.Vanya.Legs,
																	feet=gear.Mallquis.Feet,
																	neck="Loricate Torque +1",
																	waist="Cetl Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Etiolation Earring",
																	left_ring="Yacuruna Ring",
																	right_ring="Defending Ring",
																	back="Moonbeam Cape",}	
    ----------------------------------------------------------------
	-- Death idle set
	----------------------------------------------------------------	
	sets.Death = 													{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.BLMAF.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.Burst,
																	neck="Sanctity Necklace",
																	waist="Luminary Sash",
																	left_ear="Barkaro. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Mujin Band",
																	back=gear.Taranus.Nuke,}
	----------------------------------------------------------------
    -- Lower HP for sorcerer's ring set
	----------------------------------------------------------------	
	sets.hp =														{ammo="Ghastly Tathlum +1",
																	head="Zenith Crown +1",
																	body="Dalmatica",
																	hands="Zenith Mitts",
																	legs="Zenith Slacks",
																	feet="Zenith Pumps",
																	neck="Incanter's Torque",
																	waist="Luminary Sash",
																	left_ear="Etiolation Earring",
																	right_ear="Graiai Earring",
																	left_ring="Mephitas's Ring +1",				
																	right_ring="Mephitas's Ring",
																	back=gear.BLMJSE.MP}
    ----------------------------------------------------------------
	-- Kiting set(s)
	----------------------------------------------------------------    
	sets.Kiting = 													{feet="Herald's gaiters"}
    ----------------------------------------------------------------
	-- Latent Refresh set(s)
	----------------------------------------------------------------
    sets.latent_refresh =											{waist="Fucho-no-obi",left_ear=gear.Mooonshade}
    ----------------------------------------------------------------
	-- Bonus set(s)
	----------------------------------------------------------------
	sets.Hachirin = 												{waist="Hachirin-no-Obi"}
	sets.CP = 														{back="Mecisto. Mantle"}
	--sets.Protect_Shell = 											{right_ring="Sheltered Ring"}
	--sets.SorcEarring = 											{left_ear="Sorcerer's Earring"}
	sets.SorcRing = 												{left_ring="Sorcerer's Ring"}
	sets.ConsMP = 													{body="Spae. Coat +3"}
----------------------------------------------------------------------------
-- PRECAST SETS
----------------------------------------------------------------------------
    ----------------------------------------------------------------
	-- Catch All Precast set
	----------------------------------------------------------------
	sets.precast = 													{}
    ----------------------------------------------------------------
	-- Job Ability Precast set(s)
	----------------------------------------------------------------
	sets.precast.JA = 												{}
    sets.precast.JA['Mana Wall'] = 									{feet=gear.BLMEmpy.Feet,back=gear.Taranus.Nuke}
	sets.precast.JA['Manafont'] = 									{body=gear.BLMRelic.Body}
    ----------------------------------------------------------------
	-- Weaponskill Precast set(s)
	----------------------------------------------------------------
	sets.precast.WS = 												{}
	---------------
	  -- Clubs --
	---------------	
	-- 40% STR / 40% MND
	sets.precast.WS["Shining Strike"] =								{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Pahtli Cape",}
	-- 40% STR / 40% MND - STR/MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Seraph Strike"] =								sets.precast.WS["Shining Strike"]
	-- 100% STR
	sets.precast.WS["Brainshaker"] =								{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back="Moonbeam Cape",}	
	-- Starlight - Skill
	sets.precast.WS["Starlight"] =									{}
	-- Moonlight - Skill (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Moonlight"] =									{}
	-- 100% STR
	sets.precast.WS["Skullbreaker"] =								sets.precast.WS["Brainshaker"]	
	-- 100% STR
	sets.precast.WS["True Strike"] =								sets.precast.WS["Brainshaker"]	
	-- 50% STR / 50% MND - STR/MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Judgement"] =									sets.precast.WS["Shining Strike"]
	-- 30% STR / 70% MND
	sets.precast.WS["Black Halo"] =									sets.precast.WS["Shining Strike"]
	-- MND 73% / 76% / 79% / 82% / 85%
	sets.precast.WS["Realmrazer"] =									{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Pahtli Cape",}
	---------------
	   --Dagger--
	---------------
	-- 100% DEX
	sets.precast.WS['Wasp Sting'] = 								{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs="Gyve Trousers",
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Dominance Earring",
																	right_ear="Pixie Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back="Moonbeam Cape",}
	-- 40% DEX / 40% INT
	sets.precast.WS['Gust Slash'] = 								{ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkarole earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
	-- 100% CHR
	sets.precast.WS['Shadowstitch'] = 								{ammo="Amar Cluster",
																	head="Sukeroku Hachi.",
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Handler's Earring +1",
																	right_ear="Handler's Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Moonbeam Cape",}	
	-- 100% DEX
	sets.precast.WS['Viper Bite'] = 								sets.precast.WS['Wasp Sting']
	-- 40% DEX / 40% INT
	sets.precast.WS['Cyclone'] = 									sets.precast.WS['Gust Slash']
	-- 100% MND
	sets.precast.WS['Energy Steal'] = 								{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Pahtli Cape",}
	-- 100% MND
	sets.precast.WS['Energy Drain'] = 								sets.precast.WS['Energy Steal']
	-- 40% DEX / 40% INT	
	sets.precast.WS['Aeolian Edge'] = 								{ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkarole earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
	---------------
	   --Scythe--
	---------------
	-- 100% STR
	sets.precast.WS["Slice"] =										{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back="Moonbeam Cape",}
	-- 40% STR / 40% INT
	sets.precast.WS["Dark Harvest"] = 								{ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkarole earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
	-- 60% STR / 60% MND
	sets.precast.WS["Nightmare Scythe"] =							{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Pahtli Cape",}
	-- 100% STR
	sets.precast.WS["Spinning Scythe"] =							sets.precast.WS["Slice"]
	-- 100% STR
	sets.precast.WS["Vorpal Scythe"] =								sets.precast.WS["Slice"]
	---------------
	  -- Staff --
	---------------
	-- 100% STR
	sets.precast.WS["Heavy Swing"] =								{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back="Moonbeam Cape",}
	-- 40% STR / 40% INT
	sets.precast.WS["Rock Crusher"] =								{ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkarole earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
	-- 40% STR / 40% MND
	sets.precast.WS["Starburst"] =									{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Pahtli Cape",}
	-- 40% STR / 40% MND
	sets.precast.WS["Sunburst"] =									sets.precast.WS["Starburst"]
	-- 100% STR
	sets.precast.WS["Earth Crusher"] =								sets.precast.WS["Heavy Swing"]
	-- 50% STR
	sets.precast.WS["Full Swing"] =									sets.precast.WS["Heavy Swing"]
	-- 50% INT / 50% MND
	sets.precast.WS["Spirit Taker"] =								{ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkarole earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
	-- 30% STR / 50% MND
	sets.precast.WS["Retribution"] =								sets.precast.WS["Starburst"]
	-- Max MP
	sets.precast.WS['Myrkr'] = 										{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.Amalric.Head.A,
																	body=gear.Amalric.Body.D,
																	hands=gear.BLMAF.Hands,
																	legs=gear.BLMAF.Legs,
																	feet=gear.Psycloth.Feet,
																	neck="Sanctity Necklace",
																	waist="Hierarch Belt",
																	left_ear="Etiolation Earring",
																	right_ear="Graiai Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back=gear.BLMJSE.MP,}
	----------------------------------------------------------------
    -- Spell Catch All Precast set	(80% in set, 15 over necessary /rdm)
	----------------------------------------------------------------
    sets.precast.FC = 												{ammo="Sapience Orb",				-- 2
																	head=gear.Merlinic.Head.FC,			--14
																	body="Zendik Robe",					--13
																	hands=gear.Merlinic.Hands.FC,		-- 6
																	legs=gear.Psycloth.Legs,			-- 7
																	feet=gear.Merlinic.Feet.FC,			--12
																	neck="Voltsurge Torque",			-- 4
																	waist="Witful Belt",				-- 3
																	left_ring="Kishar Ring",			-- 4
																	right_ring="Prolix Ring",			-- 2
																	right_ear="Etiolation Earring",		-- 1
																	left_ear="Loquac. Earring",			-- 2
																	back=gear.Taranus.FC,}				--10
	----------------------------------------------------------------
    -- Spell Quickcast Magic 10% Cap
	----------------------------------------------------------------
	sets.precast.FC.QC =											{ammo="Sapience Orb",		
																	head=gear.Merlinic.Head.FC,		
																	body="Zendik Robe",					
																	hands=gear.Merlinic.Hands.FC,	
																	legs=gear.Psycloth.Legs,			
																	feet=gear.Merlinic.Feet.FC,		
																	neck="Voltsurge Torque",		
																	waist="Witful Belt",			
																	left_ring="Kishar Ring",		
																	right_ring="Prolix Ring",		
																	right_ear="Etiolation Earring",	
																	left_ear="Loquac. Earring",		
																	back="Perimede Cape",}
	----------------------------------------------------------------
	-- Dark Magic Precast set(s) (Stun Drain Aspir only!!)
	----------------------------------------------------------------
	sets.precast.FC['Dark Magic'] =    								sets.precast.FC.QC
	----------------------------------------------------------------
	-- Elemental Magic Precast set(s) 								( -14 FC, Casting time down -14%, still capped @ 80% FC /rdm )
	----------------------------------------------------------------
    sets.precast.FC['Elemental Magic'] = 							{ammo="Sapience Orb",		
																	head=gear.Merlinic.Head.FC,			
																	body="Zendik Robe",				
																	hands=gear.Mallquis.Hands,		
																	legs=gear.Mallquis.Legs,			
																	feet=gear.Merlinic.Feet.FC,			
																	neck="Voltsurge Torque",			
																	waist="Witful Belt",				
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Barkarole earring",		
																	left_ear="Loquac. Earring",			
																	back=gear.Taranus.FC,}
																	
	sets.precast.FC.Impact = 										{ammo="Sapience Orb",				
																	head=empty,			
																	body="Twilight Cloak",			
																	hands=gear.Merlinic.Hands.FC,		
																	legs=gear.Psycloth.Legs,			
																	feet=gear.Merlinic.Feet.FC,			
																	neck="Voltsurge Torque",			
																	waist="Witful Belt",				
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Etiolation Earring",		
																	left_ear="Loquac. Earring",			
																	back="Perimede Cape",}
	
	sets.precast.FC.AncientIIMagic = 								{ammo="Sapience Orb",				
																	head=gear.BLMRelic.Head,			
																	body="Zendik Robe",					
																	hands=gear.BLMRelic.Hands,			
																	legs=gear.BLMRelic.Legs,			
																	feet=gear.BLMRelic.Feet,			
																	neck="Voltsurge Torque",		
																	waist="Witful Belt",				
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Barkarole earring",		
																	left_ear="Loquac. Earring",			
																	back=gear.Taranus.FC,}
	----------------------------------------------------------------
	-- Enfeebling Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enfeebling Magic'] = 							{ammo="Sapience Orb",			
																	head=gear.Merlinic.Head.FC,			
																	body="Zendik Robe",				
																	hands=gear.Merlinic.Hands.FC,	
																	legs=gear.Psycloth.Legs,			
																	feet=gear.Merlinic.Feet.FC,		
																	neck="Voltsurge Torque",		
																	waist="Witful Belt",			
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Etiolation Earring",		
																	left_ear="Loquac. Earring",			
																	back="Perimede Cape",}
	----------------------------------------------------------------
	-- Enhancing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enhancing Magic'] = 							{ammo="Sapience Orb",			
																	head="Umuthi Hat",			
																	body="Zendik Robe",					
																	hands=gear.Merlinic.Hands.FC,		
																	legs=gear.Psycloth.Legs,			
																	feet=gear.Merlinic.Feet.FC,			
																	neck="Voltsurge Torque",			
																	waist="Siegel Sash",				
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Etiolation Earring",		
																	left_ear="Loquac. Earring",			
																	back="Perimede Cape",}
																
	sets.precast.FC.Stoneskin = 									{ammo="Sapience Orb",			
																	head="Umuthi Hat",			
																	body="Zendik Robe",					
																	hands=gear.Merlinic.Hands.FC,		
																	legs="Doyen Pants",			
																	feet=gear.Merlinic.Feet.FC,		
																	neck="Nodens Gorget",		
																	waist="Siegel Sash",			
																	left_ring="Kishar Ring",		
																	right_ring="Prolix Ring",			
																	right_ear="Etiolation Earring",		
																	left_ear="Loquac. Earring",		
																	back="Perimede Cape",}
	----------------------------------------------------------------
	-- Healing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Healing Magic'] =								{ammo="Sapience Orb",				
																	head=gear.Merlinic.Head.FC,		
																	body="Zendik Robe",				
																	hands=gear.Merlinic.Hands.FC,	
																	legs=gear.Psycloth.Legs,		
																	feet=gear.Merlinic.Feet.FC,		
																	neck="Voltsurge Torque",		
																	waist="Witful Belt",			
																	left_ring="Kishar Ring",		
																	right_ring="Prolix Ring",		
																	right_ear="Etiolation Earring",		
																	left_ear="Loquac. Earring",			
																	back="Perimede Cape",}
	
	sets.precast.FC.Cure =											{ammo="Sapience Orb",		
																	head=gear.Vanya.Head,		
																	body=gear.Vanya.Body,					
																	hands=gear.Vanya.Hands,		
																	legs="Doyen Pants",			
																	feet=gear.Vanya.Feet,			
																	neck="Voltsurge Torque",			
																	waist="Witful Belt",				
																	left_ring="Kishar Ring",			
																	right_ring="Prolix Ring",			
																	right_ear="Mendicant's Earring",		
																	left_ear="Loquac. Earring",			
																	back="Pahtli cape",}
----------------------------------------------------------------------------
-- MIDCAST SETS
----------------------------------------------------------------------------
	----------------------------------------------------------------
	-- Catch All Midcast set
	----------------------------------------------------------------
	sets.midcast = 													{}
	----------------------------------------------------------------
	-- Fast Recast Midcast set
	----------------------------------------------------------------
	sets.midcast.FastRecast = 										{ammo="Sapience Orb",
																	head=gear.Merlinic.Head.FC,
																	body=gear.Merlinic.Body.FC,
																	hands=gear.Merlinic.Hands.FC,
																	legs=gear.Psycloth.Legs,
																	feet=gear.Merlinic.Feet.FC,
																	neck="Voltsurge torque",
																	waist="Cetl Belt",
																	right_ear="Etiolation Earring",
																	left_ear="Loquac. Earring",	
																	back=gear.Taranus.FC,}
	----------------------------------------------------------------
	-- Midcast Dark Magic set(s)
	----------------------------------------------------------------
    sets.midcast['Dark Magic'] = 									{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Striga Crown",
																	body=gear.Psycloth.Body,
																	hands=gear.BLMRelic.Hands,
																	legs=gear.BLMAF.Legs,
																	feet=gear.BLMEmpy.Feet,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",																		
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.BLMJSE.MP,}

	sets.midcast.Drain =											{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Pixie Hairpin +1",
																	body=gear.Merlinic.Body.DrAsp,
																	hands=gear.Merlinic.Hands.DrAsp,
																	legs=gear.BLMAF.Legs,
																	feet=gear.Merlinic.Feet.DrAsp,
																	neck="Erra Pendant",
																	waist="Fucho-no-Obi",
																	left_ear="Dignitary's Earring",
																	left_ring="Evanescence Ring",
																	right_ear="Barkaro. Earring",
																	right_ring="Excelsis Ring",
																	back=gear.Taranus.Nuke,}
																	
	sets.midcast.Aspir =											sets.midcast.Drain
	
	sets.midcast.Stun = 											{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Striga Crown",
																	body=gear.Psycloth.Body,
																	hands=gear.BLMRelic.Hands,
																	legs=gear.BLMAF.Legs,
																	feet=gear.BLMEmpy.Feet,
																	neck="Erra Pendant",																		
																	waist="Eschan Stone",
																	left_ear="Abyssal Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Taranus.FC,}
	----------------------------------------------------------------
	-- Elemental Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Elemental Magic'] = 								{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.BLMEmpy.Head,
																	body=gear.BLMRelic.Body,
																	hands=gear.BLMAF.Hands,
																	legs=gear.Amalric.Legs.C,
																	feet=gear.BLMRelic.Feet,
																	neck="Incanter's Torque",
																	waist="Eschan Stone",
																	left_ear="Dignitary's Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Resonance Ring",
																	right_ring="Stikini Ring",
																	back=gear.Taranus.Nuke,}
																	
	sets.midcast.LowTierNuke =					 					{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.Mallquis.Head,
																	body=gear.Mallquis.Body,
																	hands=gear.Mallquis.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Eddy Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Crematio Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
																			
    sets.midcast.LowTierNuke.Resistant =					 		sets.midcast['Elemental Magic']
	
	sets.midcast.HighTierNuke = 									{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.BLMRelic.Head,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.Amalric.Hands.D,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Saevus Pendant +1",
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}

    sets.midcast.HighTierNuke.Resistant = 							{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.BLMAF.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Luminary Sash",
																	left_ear="Dignitary's Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Taranus.Nuke,}
																	
	sets.midcast.ElementalEnfeeble = 								sets.midcast['Elemental Magic']
	
	sets.midcast['Ancient Magic'] =									sets.midcast.HighTierNuke
	
	sets.midcast.Impact = 											{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=empty,
																	body="Twilight Cloak",
																	hands=gear.BLMAF.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Incanter's Torque",
																	waist="Eschan Stone",
																	left_ear="Dignitary's Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Resonance Ring",
																	right_ring="Stikini Ring",
																	back=gear.Taranus.Nuke,}
	----------------------------------------------------------------
	-- Enfeebling Magic Midcast set(s)
	----------------------------------------------------------------
    sets.midcast['Enfeebling Magic'] = 								{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Befouled Crown",
																	body=gear.BLMAF.Body,
																	hands="Regal Cuffs",
																	legs=gear.Psycloth.Legs,
																	feet="Skaoi boots",
																	neck="Erra Pendant",
																	waist="Rumination Sash",
																	left_ear="Dignitary's Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Taranus.Nuke}
																	
    sets.midcast['Enfeebling Magic'].Mnd = 							{main=gear.Staff.Lathi.A,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Befouled Crown",
																	body=gear.BLMAF.Body,
																	hands="Regal Cuffs",
																	legs=gear.Psycloth.Legs,
																	feet="Skaoi boots",
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Dignitary's Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Taranus.FC}
	----------------------------------------------------------------
	-- Enhancing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Enhancing Magic'] = 								{ammo="Sapience Orb",
																	head=gear.Telchine.Head,
																	body=gear.Telchine.Body,
																	hands=gear.Telchine.Hands,
																	legs=gear.Telchine.Legs,
																	feet=gear.Telchine.Feet,
																	neck="Incanter's Torque",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Fi Follet Cape +1",}
																			
	sets.midcast.Aquaveil = 										{ammo="Sapience Orb",
																	head=gear.Amalric.Head.A,
																	body=gear.Telchine.Body,
																	hands="Regal Cuffs",
																	legs=gear.Telchine.Legs,
																	feet=gear.Telchine.Feet,
																	neck="Incanter's Torque",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Fi Follet Cape +1",}
																			
	sets.midcast.BarSpell = 										sets.midcast['Enhancing Magic']
	
	sets.midcast.Refresh = 											{ammo="Sapience Orb",
																	head=gear.Amalric.Head.A,
																	body=gear.Telchine.Body,
																	hands=gear.Telchine.Hands,
																	legs=gear.Telchine.Legs,
																	feet="Inspirited boots",
																	neck="Nodens gorget",
																	waist="Gishdubar sash",
																	left_ear="Andoaa Earring",
																	right_ear="Earthcry Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Grapevine cape",}
																			
	sets.midcast.Regen = 											sets.midcast['Enhancing Magic']
																			
	sets.midcast.Stoneskin =					 					{ammo="Sapience Orb",
																	head=gear.Telchine.Head,
																	body=gear.Telchine.Body,
																	hands=gear.Telchine.Hands,
																	legs=gear.Telchine.Legs,
																	feet=gear.Telchine.Feet,
																	neck="Nodens gorget",
																	waist="Siegel Sash",
																	left_ear="Andoaa Earring",
																	right_ear="Earthcry Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Perimede Cape",}
	----------------------------------------------------------------
	-- Healing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Healing Magic'] = 								sets.midcast.FastRecast
	
	sets.midcast.Cure =												{sub="Niobid Strap",
																	ammo="Kalboron Stone",
																	head=gear.Vanya.Head,
																	body="Vrikodara Jupon",
																	hands=gear.Vanya.Hands,
																	legs="Doyen Pants",
																	feet=gear.Vanya.Feet,
																	neck="Nodens Gorget",
																	waist="Rumination Sash",
																	left_ear="Loquac. Earring",
																	right_ear="Mendi. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Pahtli Cape",}
----------------------------------------------------------------------------
-- ENGAGED SETS
----------------------------------------------------------------------------
	sets.engaged =													{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Clotharius Torque",
																	waist="Grunfeld Rope",
																	left_ear="Trux Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Cacoethic Ring +1",
																	back="Moonbeam Cape",}
																	
	sets.engaged.Acc =												{ammo="Amar Cluster",
																	head=gear.Jhakri.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back="Moonbeam Cape",}
----------------------------------------------------------------------------
-- CUSTOM SETS NOT COVERED ANYWHERE ELSE
----------------------------------------------------------------------------
    sets.buff['Mana Wall'] = 										{body=gear.Mallquis.Body,feet=gear.BLMEmpy.Feet,back=gear.Taranus.Nuke}
	
	sets.buff.Doom = 												{waist="Gishdubar sash",}
    ----------------------------------------------------------------
        -- Magic burst set (MB = 40% MBD + 19% MBDII, DeathMB = 42% MBD + 13% MBDII)
	----------------------------------------------------------------
	sets.Elemental_MB = 											{head=gear.Merlinic.Head.MAB,    	-- 9%
																	body="Ea Houppelande",				-- 8%	- 8%II
																	hands=gear.Amalric.Hands.D,      	--		- 6%II
																	legs=gear.Merlinic.Legs.MAB,     	-- 8%
																	feet=gear.Merlinic.Feet.MAB,   		
																	neck="Mizu. Kubikazari",        	-- 10% 
																	left_ring="Mujin Band",        		--  	- 5%II
																	back=gear.Taranus.Nuke,}        	-- 5%  	- ???
	
	sets.DeathMB = 													{head="Pixie Hairpin +1",
																	body=gear.Merlinic.Body.Burst,		-- 11%
																	hands=gear.BLMAF.Hands,      		--   	- 8%II
																	legs=gear.Merlinic.Legs.MAB,     	-- 8%
																	feet=gear.Merlinic.Feet.Burst,   	-- 8%
																	neck="Mizu. Kubikazari",        	-- 10%
																	left_ring="Mujin Band",        		-- 		- 5%II
																	back=gear.Taranus.Nuke,}        	-- 5%	
end
--------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
--------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- PRECAST FUNCTIONS
----------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	if spell.action_type == 'Ability' then
		if spell.english == "Accession" and buffactive['Dark Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Manifestation" <me>')
			return
		elseif spell.english == "Alacrity" and buffactive['Light Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Celerity" <me>')
			return
		elseif spell.english == "Celerity" and buffactive['Dark Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Alacrity" <me>')
			return
		elseif spell.english == "Dark Arts" and buffactive['Dark Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Addendum: Black" <me>')
			return
		elseif spell.english == "Light Arts" and buffactive['Light Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Addendum: White" <me>')
			return
		elseif spell.english == "Manifestation" and buffactive['Light Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Accession" <me>')
			return
		elseif spell.english == "Parsimony" and buffactive['Light Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Penury" <me>')
			return
		elseif spell.english == "Penury" and buffactive['Dark Arts'] then
			eventArgs.cancel = true
			windower.send_command('@input /ja "Parsimony" <me>')
			return
		end
	--[[elseif spell.type == "WeaponSkill" then
		if player.status == 'Engaged' then
			if player.tp >= 1000 then
				if spell.target.distance <= 5 then
					if sets.precast.WS[spell.name] then
						equip(sets.precast.WS[spell.name])
					else
						equip(sets.precast.WS)
					end
				else
					cancel_spell()
					windower.add_to_chat(121, 'Canceled '..spell.name..'.'..spell.target.name..' is Too Far')
				end
			else
				cancel_spell()
				windower.add_to_chat(121, ''..player.tp..'TP is not enough to WS')
			end
		else
			cancel_spell()
			windower.add_to_chat(121, 'You must be Engaged to WS')
	end]]--
 	elseif spell.action_type == 'Magic' then
		if spell.skill == 'Dark Magic' then
			if spell.english:startswith('Drain') then
				equip(sets.precast.FC.Drain)
			elseif spell.english:startswith('Aspir') then
				equip(sets.precast.FC.Aspir)
			elseif ancientIINukes:contains(spell.english) then
				equip(sets.precast.FC.AncientIIMagic)
			else
				equip(sets.precast.FC['Dark Magic'])
			end
		elseif spell.skill == 'Elemental Magic' then
			equip(sets.precast.FC['Elemental Magic'])
		elseif spell.skill == 'Enfeebling Magic' then
			equip(sets.precast.FC['Enfeebling Magic'])
		elseif spell.skill == 'Enhancing Magic' then
			if spell.english:startswith('Stoneskin') then
				equip(sets.precast.FC.Stoneskin)
			else
				equip(sets.precast.FC['Enhancing Magic'])
			end
		elseif spell.skill == 'Healing Magic' then
			equip(sets.precast.FC['Healing Magic'])
		end
	end
end
----------------------------------------------------------------------------
-- MIDCAST FUNCTIONS
----------------------------------------------------------------------------
function job_midcast(spell, action, spellMap, eventArgs)
end
----------------------------------------------------------------------------
-- POST MIDCAST FUNCTIONS
----------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.Buff.Doom then
		equip(sets.buff.Doom)
	end
	if state.Buff['Mana Wall'] then
		equip(sets.buff['Mana Wall'])
	end
	if player.hpp < 75 and player.tp < 1000 then
		equip(sets.SorcRing)
	end
	if player.hpp < 25 and player.tp < 1000 then
		equip(sets.SorcEarring)
	end
--	if spell.skill == 'Elemental Magic' and (player.mp-spell.mp_cost) < 436 then
--		equip(sets.ConsMP)
--		end
	if spell.action_type == 'Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element then
				equip(sets.Hachirin)
			if spell.skill == 'Enfeebling Magic' then
				if spell.english:startswith('Paralyze*|Slow*|Silence') then
					equip(sets.midcast['Enfeebling Magic'].Mnd)
				else
					equip(sets.midcast['Enfeebling Magic'])
				end
			elseif spell.skill == 'Enhancing Magic' then
				if string.find(spell.english,'Protect') then
					equip(sets.Protect_Shell)
				end
				if string.find(spell.english,'Shell') then
					equip(sets.Protect_Shell)
				end
			elseif spell.skill == 'Enhancing Magic' then
			if spell.english:startswith('Warp*|Retrace|Escape|Tractor') then
					equip(sets.midcast.FastRecast)
				end
			end
		end
	end
	if spell.english == 'Death' or spell.english == 'Comet' and state.BurstMode.value == 'Burst On' then
		equip(sets.DeathMB)
	elseif spell.skill == 'Elemental Magic' and state.BurstMode.value == 'Burst On' then
		equip(sets.Elemental_MB)
	end
end
----------------------------------------------------------------------------
-- AFTERCAST FUNCTIONS
----------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.tp < 1000 then
        enable('main','sub')
	elseif not spell.interrupted then
        if spell.english == 'Mana Wall' then
            enable('feet','back')
            equip(sets.buff['Mana Wall'])
            disable('feet','back')
		elseif spell.english == 'Sleep' or spell.english == 'Sleepga' then
			send_command('@wait 55;input /echo ------- '..spell.english..' is wearing off in 5 seconds -------')
		elseif spell.english == 'Sleep II' or spell.english == 'Sleepga II' then
			send_command('@wait 85;input /echo ------- '..spell.english..' is wearing off in 5 seconds -------')
		elseif spell.english == 'Break' or spell.english == 'Breakga' then
			send_command('@wait 25;input /echo ------- '..spell.english..' is wearing off in 5 seconds -------')
		end
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Called when a player gains or loses a buff
----------------------------------------------------------------------------
function job_buff_change(buff, gain)
	if buff == "Doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('waist','left_ring','right_ring')
		else
			enable('waist','left_ring','right_ring')
		end
	elseif buff == "Mana Wall" then
		if gain then
			equip(sets.buff['Mana Wall'])
			disable('feet','back')
		else
			enable('feet','back')
		end
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Get custom spell maps
----------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
    if default_spell_map ~= 'ElementalEnfeeble' then
        if lowTierNukes:contains(spell.english) then
            return 'LowTierNuke'
        elseif ancientIINukes:contains(spell.english) then
			return 'AncientIIMagic'
		elseif highTierNukes:contains(spell.english) then
            return 'HighTierNuke'
		end
    end
end
----------------------------------------------------------------------------
-- Modify the default idle set after it was constructed.
----------------------------------------------------------------------------
function customize_idle_set(idleSet)
    if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
    if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	if state.Buff['Mana Wall'] then
		idleSet = set_combine(idleSet, sets.buff['Mana Wall'])
	end
	if player.hpp < 25 and player.tp < 1000 then
		idleSet = set_combine(idleSet, sets.SorcEarring)
	end
    return idleSet
end
----------------------------------------------------------------------------
-- Modify the default melee set after it was constructed.
----------------------------------------------------------------------------
function customize_melee_set(meleeSet)
    if player.mpp < 51 then
		meleeSet = set_combine(meleeSet, sets.latent_refresh)
	end
    if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
	if state.Buff['Mana Wall'] then
		meleeSet = set_combine(meleeSet, sets.buff['Mana Wall'])
	end
	if player.hpp < 25 and player.tp < 1000 then
		meleeSet = set_combine(meleeSet, sets.SorcEarring)
	end	
	return meleeSet
end
----------------------------------------------------------------------------
-- Called by the default 'update' self-command.
----------------------------------------------------------------------------
function display_current_job_state(eventArgs)
    display_current_caster_state()
    eventArgs.handled = true
end
function job_update(cmdParams, eventArgs)
	auto_sublimation()
	capacitymode()
	magemode()
--	timedgear()
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Check for auto sublimation
----------------------------------------------------------------------------
function auto_sublimation()
	if state.AutoSubMode.value then
		local abil_recasts = windower.ffxi.get_ability_recasts()
		if (not (buffactive['Sublimation: Activated'] or buffactive['Sublimation: Complete'])) and abil_recasts[234] == 0 then
			windower.send_command('input /ja Sublimation <me>')
			return true
		elseif buffactive['Sublimation: Complete'] and player.mpp < 25 and abil_recasts[234] == 0 then
			windower.send_command('input /ja Sublimation <me>')
			return true
		else
			return false
		end
	else
		return false
	end
end
----------------------------------------------------------------------------
-- Cycle between capacity point bonus gear and normal
----------------------------------------------------------------------------
function capacitymode()
	if state.CapacityMode.value == 'Bonus Active' then
		enable('back')
		equip(sets.CP)
		disable('back')
        handle_equipping_gear(player.status)
	elseif state.CapacityMode.value == 'Normal' then
		enable('back')
	end
end
----------------------------------------------------------------------------
-- Cycle between Death Mage and Elemental Mage
----------------------------------------------------------------------------
function magemode()
	if state.MageMode.value == 'Death Mage' then
		enable('main','sub','ammo','head','right_ear','body','hands','right_ring','legs','feet')
		sets.MSD = {main=gear.Staff.Lathi.A,sub="Niobid strap"}
		sets.DB = set_combine(sets.Death, sets.MSD)
		equip(sets.DB)
		disable('main','sub','ammo','head','right_ear','body','hands','right_ring','legs','feet')
        handle_equipping_gear(player.status)
	end
	if state.MageMode.value == 'Casting Mage' then
		enable('main','sub','ammo','head','right_ear','body','hands','right_ring','legs','feet')
		sets.MSE = {main=gear.Staff.Lathi.A,sub="Niobid strap"}
		sets.EB = set_combine(sets.idle, sets.MSE)
		equip(sets.EB)
	end
end
----------------------------------------------------------------------------
-- SUBJOB AND MACRO BOOK SELECTION
----------------------------------------------------------------------------
function select_default_macro_book()
    set_macro_page(2, 18)
end