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
end
----------------------------------------------------------------------------
-- Setup vars that are user-independent.
----------------------------------------------------------------------------
function job_setup()
	state.Buff.Migawari = 											buffactive.migawari or false
    state.Buff.Doom = 												buffactive.Doom or false
	state.Buff.Mikage = 											buffactive.Mikage or false
    state.Buff.Futae = 												buffactive.Futae or false
	state.Buff.Sange = 												buffactive.Sange or false
	state.Buff.Minuet =												buffactive[198] or false
	state.Buff.Madrigal =											buffactive[199] or false
	state.warned = 													M(true)
end
--------------------------------------------------------------------------------------------------------------------
-- USER SETUP FUNCTIONS FOR THIS JOB FILE.  
--------------------------------------------------------------------------------------------------------------------
function user_setup()
    state.OffenseMode:options('Normal', 'Acc', 'MaxACC', 'CritHit', 'PDT', 'MDT', 'Tank')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal')
	state.BurstMode = 												M{['description']='Burst Mode', 'Burst Off', 'Burst On'}
	--Haste mode
	state.HasteMode = 												M(false, 'Haste 2')
	----------------------------------------------------------------
	-- Bow
	----------------------------------------------------------------
    gear.Ranged = 													"Togakushi shuriken"
	gear.Ammo = 													"Togakushi shuriken"
	options.ammo_warning_limit = 15
	----------------------------------------------------------------
	-- Dusk to Dawn gear
	----------------------------------------------------------------
    gear.MovementFeet = 											{}
    gear.DayFeet = 													"Danzo Sune-ate"
    gear.NightFeet = 												"Danzo Sune-ate"
    gear.left_Earring =												{}
	gear.DayEarleft =												"Odnowa Earring +1"
	gear.NightEarleft =												"Lugra Earring"
	gear.right_Earring =											{}
	gear.DayEarright =												"Dominance Earring"
	gear.NightEarright =											"Lugra Earring +1"
	----------------------------------------------------------------
	-- Additional local binds
	----------------------------------------------------------------
    send_command('bind ^q gs c cycle BurstMode')
	send_command('bind ^` gs c toggle HasteMode')
	----------------------------------------------------------------
	-- Select dusk to dawn gear
	----------------------------------------------------------------    
	nightgear()
	----------------------------------------------------------------
	-- Determine haste for maximum dual wield effeciency
	---------------------------------------------------------------- 	
	determine_haste_group()
	----------------------------------------------------------------
	-- Select macro book
	---------------------------------------------------------------- 
    select_default_macro_book()
----------------------------------------------------------------------------
-- Augmented Gear and Abbreviations
----------------------------------------------------------------------------
	----------------------------------------------------------------
		--Weapons--

	
		-- Capes --
		gear.Smertrios = {}
		
		-- Artifact --
		gear.SAMAF = {}
		gear.SAMAF.Head 				= {name="Hachi. Hatsu. +3",}
		gear.SAMAF.Body 				= {name="Hachi. Chain. +3",}
		gear.SAMAF.Hands				= {name="Hachiya Tekko +2",}
		gear.SAMAF.Legs 				= {name="Hachi. Hakama +2",}
		gear.SAMAF.Feet 				= {name="Hachi. Kyahan +3",}
		
		-- Relic --
		gear.SAMRelic = {}
		gear.SAMRelic.Head 				= {name="Mochi. Hatsuburi +1", augments={'Increases elem. ninjutsu III damage',}}
		gear.SAMRelic.Body 				= {name="Mochi. Chainmail +1", augments={'Enhances "Sange" effect',}}
		gear.SAMRelic.Hands				= {name="Mochizuki Tekko +1", augments={'Enh. "Ninja Tool Expertise" effect',}}
		gear.SAMRelic.Legs 				= {name="Mochi. Hakama +1", augments={'Enhances "Mijin Gakure" effect',}}
		gear.SAMRelic.Feet 				= {name="Mochi. Kyahan +1", augments={'Reduces elem. ninjutsu III cast time',}}
		
		-- Empyrean --
		gear.SAMEmpy = {}
		gear.SAMEmpy.Head 				= {name="Hattori Zukin +1",}
		gear.SAMEmpy.Body 				= {name="Hattori Ningi +1",}
		gear.SAMEmpy.Hands				= {name="Hattori Tekko +1",}
		gear.SAMEmpy.Legs 				= {name="Hattori Hakama +1",}
		gear.SAMEmpy.Feet 				= {name="Hattori Kyahan +1",}

		-- Despair --
		gear.Despair = {}
		gear.Despair.Head				= {}
		gear.Despair.Body 				= {name="Despair Mail", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Hands	 			= {name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Legs 				= {name="Despair Cuisses", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Feet 				= {name="Despair Greaves", augments={'DEX+10','STR+7','Phys. dmg. taken -3',}}
		
		-- Flamma --
		gear.Flamma = {}
		gear.Flamma.Head				= {name="Flamma Zucchetto +1"}
		gear.Flamma.Body				= {name="Flamma Korazin +1"}
		gear.Flamma.Hands				= {name="Flamma Manopolas +1"}
		gear.Flamma.Legs				= {name="Flamma Dirs +1"}
		gear.Flamma.Feet				= {name="Flamma Gambieras +1"}
		
		-- Hizamaru --
		gear.Hiza = {}
		gear.Hiza.Head 					= {name="Hizamaru Somen +2"}
		gear.Hiza.Body 					= {name="Hiza. Haramaki +2"}
		gear.Hiza.Hands					= {name="Hizamaru Kote +1"}
		gear.Hiza.Legs 					= {name="Hiza. Hizayoroi +2"}
		gear.Hiza.Feet 					= {name="Hiza. Sune-Ate +2"}
		
		-- Naga --
		gear.Naga = {}
		gear.Naga.Head 					= {name="Naga Somen", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Body 					= {name="Naga Samue", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Hands					= {name="Naga Tekko", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Legs 					= {name="Naga Hakama", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Feet 					= {name="Naga Kyahan", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}

		gear.Naga.Body.WS 				= {name="Naga Samue", augments={'HP+80','DEX+10','Attack+20',}}
		gear.Naga.Hands.PetMacc 		= {name="Naga Tekko", augments={'Pet: MP+80','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+20',}}
		gear.Naga.Legs.A 				= {name="Naga Hakama", augments={'STR+10','Accuracy+15','"Subtle Blow"+7',}}
		gear.Naga.Feet.PetMelee 		= {name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}}

		-- Rao --
		gear.RaoMaster = {}
		gear.RaoMaster.Head 			= {name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Body 			= {name="Rao Togi", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Hands 			= {name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Legs 			= {name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Feet 			= {name="Rao Sune-Ate", augments={'STR+10','DEX+10','Attack+15',}}

		-- Ryuo --
		gear.Ryuo = {}
		gear.Ryuo.Head 					= {name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Body 					= {name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Hands					= {name="Ryuo Tekko", augments={'DEX+10','Accuracy+20','"Dbl.Atk."+3',}}
		gear.Ryuo.Legs 					= {name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}}
		gear.Ryuo.Feet 					= {name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}}
		
		-- Valorous --
		gear.Val = {}
		gear.Val.Head 					= {name="Valorous Mask", augments={'Accuracy+18 Attack+18','"Dbl.Atk."+3','Accuracy+8','Attack+13',}}
		gear.Val.Body					= {}
		gear.Val.Hands					= {}
		gear.Val.Legs					= {}
		gear.Val.Feet					= {name="Valorous Greaves", augments={'Accuracy+15 Attack+15','"Dbl.Atk."+4','STR+1','Attack+7',}}
		
		-- Miscellaneous --
		gear.Samnuha = {}
		gear.Samnuha.Legs 				= {name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}	
		gear.Samnuha.Body 				= {name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}}
		
		gear.Tam = {}
		gear.Tam 						= {name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}}
		
		gear.Loyalist = {}
		gear.Loyalist 					= {name="Loyalist Sabatons", augments={'STR+10','Attack+15','Phys. dmg. taken -3%','Haste+3',}}
		
		gear.Floral = {}
		gear.Floral 					= {name="Floral Gauntlets", augments={'Rng.Acc.+15','Accuracy+15','"Triple Atk."+3','Magic dmg. taken -4%',}}
		
		gear.Amm = {}
		gear.Amm 						= {name="Amm Greaves", augments={'HP+45','VIT+10','Accuracy+14','Damage taken-1%',}}
		
		gear.Leyline = {}
		gear.Leyline 					= {name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}
end
----------------------------------------------------------------------------
-- Called when this job file is unloaded (eg: job change)
----------------------------------------------------------------------------
function file_unload()
    send_command('unbind ^z')
    send_command('unbind ^x')
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
	-- Resting set(s)
	----------------------------------------------------------------
    sets.resting = 													{ammo="Knobkierrie",
																	head=gear.Val.Head,
																	body=gear.Hiza.Body,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.RaoMaster.Legs,
																	feet=gear.RaoMaster.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Infused Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Niqmaddu Ring",
																	right_ring="Ilabrat Ring",
																	back="Moonbeam Cape",}
    ----------------------------------------------------------------
	-- Idle set(s)
	----------------------------------------------------------------
    sets.idle = 													sets.resting
    ----------------------------------------------------------------
	-- Physical Defense set(s)
	----------------------------------------------------------------
    sets.defense.PDT = 												{head="Genmei Kabuto",
																	body="Emet Harness +1",
																	hands="Umuthi Gloves",
																	legs=gear.Ryuo.Legs,
																	feet=gear.Amm,
																	neck="Loricate Torque +1",
																	waist="Grunfeld Rope",
																	left_ear="Infused Earring",
																	right_ear="Genmei Earring",
																	left_ring="Patricius Ring",
																	right_ring="Defending Ring",
																	back="Moonbeam Cape",}
    ----------------------------------------------------------------
	-- Magical Defense set(s)
	----------------------------------------------------------------    
	sets.defense.MDT = 												{ammo="Sihirik",
																	head=gear.Tam,
																	body=gear.NINEmpy.Body,
																	hands=gear.Floral,
																	legs="Gyve Trousers",
																	feet=gear.Amm,
																	neck="Loricate Torque +1",
																	waist="Grunfeld Rope",
																	left_ear="Infused Earring",
																	right_ear="Genmei Earring",
																	left_ring="Yacuruna Ring",
																	right_ring="Defending Ring",
																	back="Reiki Cloak",}
    ----------------------------------------------------------------
	-- Kiting set
	----------------------------------------------------------------    
	sets.Kiting = 													{feet=gear.MovementFeet}
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
	sets.precast.JA = {}
    sets.precast.JA['Futae'] = 										gear.NINEmpy.Hands
    sets.precast.JA['Sange'] =										gear.NINRelic.Body
	sets.precast.JA['Mikage'] =										{}
	sets.precast.JA['Mijin Gakure'] = 								gear.NINRelic.Legs
	
	sets.precast.JA.Provoke = 										{ammo="Iron Gobbet",
																	head="Genmei Kabuto",
																	body="Emet Harness +1",
																	hands="Kurys Gloves",
																	legs="Obatala Subligar",
																	feet=gear.NINRelic.Feet,
																	neck="Unmoving Collar",
																	waist="Sinew Belt",
																	left_ear="Cryptic Earring",
																	right_ear="Trux Earring",
																	left_ring="Pernicious Ring",
																	right_ring="Supershear Ring",
																	back="Reiki Cloak",}
    ----------------------------------------------------------------
	-- Weaponskill Precast set(s)
	----------------------------------------------------------------
    sets.precast.WS = 												{ammo="Knobkierrie",
																	head="Sukeroku Hachi.",
																	legs=gear.Hiza.Legs,
																	left_ear="Trux Earring",
																	left_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	------------------
	 --Great Katana--
	------------------
	-- 60% STR
    sets.precast.WS['Tachi: Enpi'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 60% STR
	sets.precast.WS['Tachi: Hobaku'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 60% STR
    sets.precast.WS['Tachi: Goten'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 75% STR
    sets.precast.WS['Tachi: Kagero'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 30% STR
    sets.precast.WS['Tachi: Jinpu'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 50% MND / 30% STR
    sets.precast.WS['Tachi: Koki'] =     							{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body="Reiki Osode",
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Infused Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 75% STR / 1.5 ATT Mod
    sets.precast.WS['Tachi: Yukikaze'] =							{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 75% STR / 2.0 ATT Mod
    sets.precast.WS['Tachi: Gekko'] =								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 75% STR / 1.65 ATT Mod
    sets.precast.WS['Tachi: Kasha'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 40% STR / 60% CHR
    sets.precast.WS['Tachi: Ageha'] =     							{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body="Reiki Osode",
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Loyalist,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Infused Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- STR - 73% / 76% / 79% / 82% / 85% / 1.35 - 1.45 ATT Mod
    sets.precast.WS['Tachi: Shoha'] =  								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 80% STR
    sets.precast.WS['Tachi: Fudo'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 50% STR
    sets.precast.WS['Tachi: Rana'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	-- 75% STR
    sets.precast.WS['Tachi: Kaiten'] = 								{ammo="Knobkierrie",
																	head="Ynglinga Sallet",
																	body=gear.Despair.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Niqmaddu Ring",
																	right_ring="Rufescent Ring",
																	back="Vespid Mantle",}
	------------------
		--Dagger--
	------------------	
	-- 100% DEX
--[[	sets.precast.WS['Wasp Sting'] = 								{ammo="Yamarang",
																	head=gear.NINAF.Head,
																	body=gear.Mummu.Body,
																	hands=gear.Mummu.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Mummu.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Apate Ring",
																	back=gear.Andartia.WSD}
	-- 40% DEX / 40% INT
	sets.precast.WS['Gust Slash'] = 								{ammo="Seeth. Bomblet +1",
																	head=gear.Tam,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Herc.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Shiva Ring",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.Nuke}
	-- 40% DEX / 40% INT
	sets.precast.WS['Gust Slash'] = 								{ammo="Seeth. Bomblet +1",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands=gear.Leyline,
																	legs="Gyve Trousers",
																	feet=gear.Herc.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Crematio Earring",
																	right_ear="Friomisi Earring",
																	left_ring="Dingir Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Andartia.Nuke,}
	-- 100% CHR
	sets.precast.WS['Shadowstitch'] = 								{ammo="Yamarang",
																	head="Sukeroku Hachi.",
																	body="Reiki Osode",
																	hands=gear.Mummu.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Mummu.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Handler's Earring +1",
																	right_ear="Handler's Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.WSD,}	
	-- 100% DEX
	sets.precast.WS['Viper Bite'] = 								{ammo="Yamarang",
																	head=gear.NINAF.Head,
																	body=gear.Mummu.Body,
																	hands=gear.Mummu.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Mummu.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Apate Ring",
																	back=gear.Andartia.WSD}
	-- 40% DEX / 40% INT
	sets.precast.WS['Cyclone'] = 									{ammo="Seeth. Bomblet +1",
																	head=gear.Tam,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Herc.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Shiva Ring",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.Nuke}
	-- 100% MND
	sets.precast.WS['Energy Steal'] = 								{ammo="Yamarang",
																	head=gear.Tam,
																	body="Reiki Osode",
																	hands=gear.RaoMaster.Hands,
																	legs=gear.RaoMaster.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Subtlety Spec.",
																	waist="Caudata Belt",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Rufescent Ring",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.WSD}
	-- 100% MND
	sets.precast.WS['Energy Drain'] = 								{ammo="Yamarang",
																	head=gear.Tam,
																	body="Reiki Osode",
																	hands=gear.RaoMaster.Hands,
																	legs=gear.RaoMaster.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Subtlety Spec.",
																	waist="Caudata Belt",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Rufescent Ring",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.WSD}
	-- 50% DEX
	sets.precast.WS['Evisceration'] = 								{ammo="Yamarang",
																	head=gear.NINAF.Head,
																	body=gear.Mummu.Body,
																	hands=gear.Mummu.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Mummu.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Apate Ring",
																	back=gear.Andartia.WSD}
	-- 40% DEX / 40% INT		
	sets.precast.WS['Aeolian Edge'] = 								{ammo="Seeth. Bomblet +1",
																	head=gear.Tam,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs="Jokushu Haidate",
																	feet=gear.Herc.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Pixie Earring",
																	right_ear=gear.right_Earring,
																	left_ring="Shiva Ring",
																	right_ring="Metamor. Ring +1",
																	back=gear.Andartia.Nuke}
	-- AGI - 73% / 76% / 79% / 82% / 85%													
	sets.precast.WS['Exenterator'] = 								{ammo="Yamarang",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands="Kobo Kote",
																	legs=gear.Hiza.Legs,
																	feet=gear.Mummu.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Infused Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Regal Ring",
																	right_ring="Dingir Ring",
																	back=gear.Andartia.WSD,}
	------------------
		 --Club--
	------------------	
	-- 40% STR / 40% MND
	sets.precast.WS['Shining Strike'] =								{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- 40% STR / 40% MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Seraph Strike'] =								{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- 100% STR
	sets.precast.WS['Brainshaker'] =								{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Ryuo.Body,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- Skill
	sets.precast.WS['Starlight'] =									{}
	
	-- Skill (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Moonlight'] =									{}

	-- 100% STR
	sets.precast.WS['Skullbreaker'] =								{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Ryuo.Body,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- 100% STR
	sets.precast.WS['True Strike'] =								{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Ryuo.Body,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Ryuo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- 50% STR / 50% MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Judgement'] =									{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- 50% STR / 50% MND
	sets.precast.WS['Flash Nova'] =									{ammo="Amar Cluster",
																	head=gear.NINAF.Head,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear=gear.left_Earring,
																	right_ear=gear.right_Earring,
																	left_ring="Regal Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
	-- MND - 73% / 76% / 79% / 82% / 85%
	sets.precast.WS['Realmrazer'] =									{ammo="Yamarang",
																	head=gear.Tam,
																	body=gear.Herc.Body.WSD,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet="Shukuyu Sune-Ate",
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Andartia.WSD,}
																	
	------------------
	    --Polearm--
	------------------
	-- 30% STR / 30% DEX
	sets.precast.WS['Double Thrust'] =								{}
	
	-- 40% STR / 40% INT
	sets.precast.WS['Thunder Thrust'] =								{}

	-- 40% STR / 40% INT
	sets.precast.WS['Raiden Thrust'] =								{}
	
	-- 100% STR
	sets.precast.WS['Leg Sweep'] =									{}
	
	-- 20% STR / 20% DEX / 0.875 ATT Mod
	sets.precast.WS['Penta Thrust'] =								{}
	
	-- 50% STR / 50% AGI
	sets.precast.WS['Vorpal Thrust'] =								{}
	
	-- 100% STR
	sets.precast.WS['Impulse Drive'] =								{}
	
	-- 40% STR / 40% DEX
	sets.precast.WS['Sonic Thrust'] =								{}
	
	-- STR - 73% / 76% / 79% / 82% / 85%
	sets.precast.WS['Stardiver'] =									{}
]]--	
    ----------------------------------------------------------------
	-- Waltz Precast set
	----------------------------------------------------------------
    sets.precast.Waltz = 											{head="Ynglinga Sallet",
																	body="Reiki Osode",
																	hands="Umuthi Gloves",
																	legs=gear.Hiza.Legs,
																	feet=gear.Amm,
																	neck="Unmoving Collar",
																	waist="Caudata Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Regal Ring",
																	right_ring="Defending Ring",}
																	--back=gear.Andartia.FC,}	
	----------------------------------------------------------------
    -- Spell Catch All Precast set
	----------------------------------------------------------------
    sets.precast.FC = 												{ammo="Sapience Orb",
																	head="Blistering Sallet +1",
																	body=gear.Despair.Body,
																	hands=gear.Leyline,
																	legs={ name="Founder's Hose", augments={'MND+10','Mag. Acc.+15','Attack+15','Breath dmg. taken -5%',}},
																	feet=gear.Loyalist,
																	neck="Voltsurge Torque",
																	waist="Dynamic Belt",
																	left_ear="Etiolation Earring",
																	right_ear="Telos Earring",
																	left_ring="Prolix Ring",
																	right_ring="Cacoethic Ring",
																	back="Moonbeam Cape",}
--[[	----------------------------------------------------------------
    -- Ranged Attack Precast Set
	----------------------------------------------------------------
    sets.precast.RA = 												{ammo=gear.RAShuriken,
																	head=gear.Ryuo.Head,
																	body=gear.Pursuers.Body,
																	hands=gear.Floral,
																	legs=gear.Adhemar.Legs,
																	feet=gear.Pursuers.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Enervating Earring",
																	right_ear="Digni. Earring",
																	left_ring="Adoulin Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.RA}
]]--
----------------------------------------------------------------------------
-- MIDCAST SETS
----------------------------------------------------------------------------
	----------------------------------------------------------------
	-- Catch All Midcast set
	----------------------------------------------------------------
	sets.midcast =													sets.precast.FC
	----------------------------------------------------------------
	-- Fast Recast Midcast set
	----------------------------------------------------------------
    sets.midcast.FastRecast = 										sets.precast.FC
    ----------------------------------------------------------------
    -- Utsusemi Precast set
	----------------------------------------------------------------        
    sets.midcast.Utsusemi = 										sets.precast.FC
    ----------------------------------------------------------------
	-- Waltz Midcast set
	----------------------------------------------------------------																			
    sets.midcast.Waltz = 											{ammo="Yamarang",
																	head=gear.NINRelic.Head,
																	body="Reiki Osode",
																	hands="Umuthi Gloves",
																	legs=gear.Hiza.Legs,
																	feet=gear.Amm,
																	neck="Unmoving Collar",
																	waist="Caudata Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Odnowa Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Defending Ring",
																	back="Grounded Mantle",}																				
--[[
	----------------------------------------------------------------
    -- Ranged Attack Midcast Set
	----------------------------------------------------------------
    sets.midcast.RA = 												{ammo=gear.RAShuriken,
																	head=gear.Ryuo.Head,
																	body=gear.Pursuers.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Adhemar.Legs,
																	feet=gear.Pursuers.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Infused Earring",
																	right_ear="Enervating Earring",
																	left_ring="Adoulin Ring",
																	right_ring="Dingir Ring",
																	back=gear.Andartia.RA}
	----------------------------------------------------------------
	-- Day Weather Bonus
	----------------------------------------------------------------
	sets.midcast.Bonus = 											{waist="Hachirin-no-Obi"}
	----------------------------------------------------------------
	-- Ninjutsu Midcast Set(s)
	----------------------------------------------------------------																		
    sets.midcast.NinjutsuBuff = 									sets.midcast.FastRecast
]]--
----------------------------------------------------------------------------
-- ENGAGED SETS
----------------------------------------------------------------------------
    ----------------------------------------------------------------
	-- 39 DW To Cap Delay (38 DW is 79.75% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged =     												{ammo="Knobkierrie",
																	head=gear.Val.Head,
																	body={ name="Found. Breastplate", augments={'Accuracy+15','Mag. Acc.+15','Attack+15','"Mag.Atk.Bns."+15',}},
																	hands=gear.Ryuo.Hands,
																	legs=gear.Ryuo.Legs,
																	feet=gear.Val.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Brutal Earring",
																	left_ring="Ilabrat Ring",
																	right_ring="Niqmaddu Ring",
																	back="Takaha Mantle",}
																	--[[{ammo="Knobkierrie",
																	head=gear.Val.Head,
																	body="Vatic Byrnie",
																	hands=gear.Ryuo.Hands,
																	legs=gear.Ryuo.Legs,
																	feet=gear.Val.Feet,
																	neck="Clotharius Torque",
																	waist="Cetl Belt",
																	left_ear="Brutal Earring",
																	right_ear="Telos Earring",
																	left_ring="Niqmaddu Ring",
																	right_ring="Ilabrat Ring",
																	back="Atheling Mantle",}]]--
--[[    ----------------------------------------------------------------
	-- 39 DW To Cap Delay
	---------------------------------------------------------------- 
	sets.engaged.Acc = 												set_combine(sets.engaged,
																	{ammo="Yamarang",
																	neck="Subtlety Spec.",	
																	left_ear="Zennaroi Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
	----------------------------------------------------------------
	-- SLOW / ELEGY -- FULL DW Gear mixed with Accuracy
	----------------------------------------------------------------
	sets.engaged.SE =												{ammo="Yamarang",
																	head=gear.Ryuo.Head,
																	body=gear.NINAF.body,
																	hands=gear.Floral,
																	legs=gear.NINAF.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Subtlety Spec.",
																	waist="Reiki Yotai",
																	left_ear="Zennaroi Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,}
    ----------------------------------------------------------------
	-- 37 DW To Cap Delay (36 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.Haste_5 =											{ammo="Seeth. Bomblet +1",
																	head=gear.Ryuo.Head,
																	body=gear.NINAF.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Clotharius Torque",
																	waist="Reiki Yotai",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Apate Ring",
																	back=gear.Andartia.TP}
    ----------------------------------------------------------------
	-- 37 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_5 =										set_combine(sets.engaged.Haste_5,
																	{ammo="Yamarang",
																	neck="Subtlety Spec.",	
																	left_ear="Zennaroi Earring",
																	right_ear="Digni. Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
    ----------------------------------------------------------------
	-- 35 DW To Cap Delay (34 DW is 79.84% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.Haste_10 =											{ammo="Seeth. Bomblet +1",
																	head=gear.Ryuo.Head,
																	body=gear.NINAF.Body,
																	hands=gear.Floral,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP}
    ----------------------------------------------------------------
	-- 35 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_10 =										set_combine(sets.engaged.Haste_10,
																	{ammo="Yamarang",
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Zennaroi Earring",
																	right_ear="Digni. Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
	----------------------------------------------------------------
	-- 32 DW To Cap Delay (31 DW is 79.58% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.Haste_15 = 										{ammo="Seeth. Bomblet +1",
																	head=gear.Ryuo.Head,
																	body="Ken. Samue",
																	hands=gear.Floral,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Clotharius Torque",
																	waist="Reiki Yotai",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 32 DW To Cap Delay
	----------------------------------------------------------------     
	sets.engaged.Acc.Haste_15 = 									set_combine(sets.engaged.Haste_15,
																	{ammo="Yamarang",
																	body=gear.Herc.Body.Acc,
																	neck="Subtlety Spec.",	
																	left_ear="Zennaroi Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
    ----------------------------------------------------------------
	-- 29 DW To Cap Delay (28 DW is 79.62% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.Haste_20 =											{ammo="Seeth. Bomblet +1",
																	head=gear.Ryuo.Head,
																	body=gear.NINAF.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Herc.Feet,
																	neck="Clotharius Torque",
																	waist="Reiki Yotai",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 29 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_20 =										set_combine(sets.engaged.Haste_20,
																	{ammo="Yamarang",
																	body=gear.Herc.Body.Acc,
																	neck="Subtlety Spec.",	
																	left_ear="Zennaroi Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
    ----------------------------------------------------------------
	-- 25 DW To Cap Delay (24 DW is 79.50% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.Haste_25 =											{ammo="Seeth. Bomblet +1",
																	head=gear.NINEmpy.Head,
																	body="Ken. Samue",
																	hands=gear.Floral,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 25 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_25 =										set_combine(sets.engaged.Haste_25,
																	{ammo="Yamarang",
																	body=gear.Herc.Body.Acc,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Zennaroi Earring",
																	right_ear="Digni. Earring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
	----------------------------------------------------------------
	-- 21 DW To Cap Delay (20 DW is 79.74% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.Haste_30 = 										{ammo="Seeth. Bomblet +1",
																	head=gear.Herc.Head,
																	body=gear.NINAF.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Herc.Feet,
																	neck="Clotharius Torque",
																	waist="Reiki Yotai",
																	left_ear="Trux Earring",
																	right_ear="Eabani Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 21 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_30 = 									set_combine(sets.engaged.Haste_30,
																	{ammo="Yamarang",
																	feet=gear.Mummu.Feet,
																	neck="Subtlety Spec.",
																	left_ear="Zennaroi Earring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
	----------------------------------------------------------------	
	-- 16 DW To Cap Delay (15 DW is 79.98% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.Haste_35 = 										{ammo="Seeth. Bomblet +1",
																	head=gear.Herc.Head,
																	body=gear.NINAF.Body,
																	hands=gear.Floral,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Herc.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Brutal Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 16 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_35 = 									set_combine(sets.engaged.Haste_35,
																	{ammo="Yamarang",
																	feet=gear.Mummu.Feet,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Zennaroi Earring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})
    ----------------------------------------------------------------
	-- 8 DW To Cap Delay (7 DW is 79.67% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.Haste_40 =											{ammo="Seeth. Bomblet +1",
																	head=gear.Ryuo.Head,
																	body="Ken. Samue",
																	hands=gear.Ryuo.Hands,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Herc.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Brutal Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 8 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_40 =										set_combine(sets.engaged.Haste_40,
																	{ammo="Yamarang",
																	body=gear.Herc.Body.Acc,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Mummu.Legs,
																	feet=gear.Herc.Feet,																			
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Zennaroi Earring",
																	right_ear="Digni. Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,})																																					
	----------------------------------------------------------------
	-- 1 DW To Cap Delay (0 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.MagicHasteCapped = 								{ammo="Seeth. Bomblet +1",
																	head=gear.Herc.Head,
																	body="Ken. Samue",
																	hands=gear.Herc.Hands,
																	legs=gear.Samnuha.Legs,
																	feet=gear.Herc.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Trux Earring",
																	right_ear="Brutal Earring",
																	left_ring="Regal Ring",
																	right_ring="Ilabrat Ring",
																	back=gear.Andartia.TP,}
    ----------------------------------------------------------------
	-- 1 DW To Cap Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.MagicHasteCapped = 							{ammo="Yamarang",
																	head=gear.Hiza.Head,
																	body=gear.Herc.Body.Acc,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Herc.Feet,				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Zennaroi Earring",
																	right_ear="Digni. Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,}
    ----------------------------------------------------------------
	-- Capped Delay (here for consistancy with other jobs)
	----------------------------------------------------------------
	sets.engaged.Haste_40Samba =									sets.engaged.MagicHasteCapped
    ----------------------------------------------------------------
	-- Capped Delay
	----------------------------------------------------------------
	sets.engaged.Acc.Haste_40Samba =								sets.engaged.Acc.MagicHasteCapped																																					
	----------------------------------------------------------------
	-- Capped Delay (here for consistancy with other jobs)
	----------------------------------------------------------------
    sets.engaged.MagicHasteCappedSamba = 							sets.engaged.MagicHasteCapped
    ----------------------------------------------------------------
	-- Capped Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.MagicHasteCappedSamba = 						sets.engaged.Acc.MagicHasteCapped
]]
    ----------------------------------------------------------------
	-- Max Accuracy
	----------------------------------------------------------------    
	sets.engaged.MaxACC = 											{ammo="Amar Cluster",
																	head="Ynglinga Sallet",
																	body=gear.Hiza.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Telos Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back="Grounded Mantle",}
--[[																	
    ----------------------------------------------------------------
	-- Critical Hit Rate Maxed - 36% on gear,+5% Merits (+164DEX)
	---------------------------------------------------------------- 																			
	sets.engaged.CritHit =											{ammo="Seething Bomblet +1",
																	head=gear.Mummu.Head,
																	body=gear.Mummu.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Mummu.Legs,
																	feet=gear.Mummu.Feet,
																	neck="Subtlety Spec.",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Regal Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Andartia.ACC,}
    ----------------------------------------------------------------
	-- Physical Damage Taken
	----------------------------------------------------------------
	sets.engaged.PDT = 												{head="Genmei Kabuto",
																	body="Emet Harness +1",
																	hands="Umuthi Gloves",
																	legs=gear.Ryuo.Legs,
																	feet=gear.Loyalist,
																	neck="Loricate Torque +1",
																	waist="Grunfeld Rope",
																	left_ear="Infused Earring",
																	right_ear="Genmei Earring",
																	left_ring="Patricius Ring",
																	right_ring="Defending Ring",
																	back="Solemnity Cape",}
    ----------------------------------------------------------------
	-- Magic Damage Taken
	----------------------------------------------------------------
	sets.engaged.MDT = 												{ammo="Sihirik",
																	head=gear.Tam,
																	body=gear.NINEmpy.Body,
																	hands=gear.Floral,
																	legs="Gyve Trousers",
																	feet=gear.Amm,
																	neck="Loricate Torque +1",
																	waist="Grunfeld Rope",
																	left_ear="Infused Earring",
																	right_ear="Genmei Earring",
																	left_ring="Yacuruna Ring",
																	right_ring="Defending Ring",
																	back="Reiki Cloak",}
    ----------------------------------------------------------------
	-- Maximum Emity for Tanking
	----------------------------------------------------------------
	sets.engaged.Tank = 											{ammo="Iron Gobbet",
																	head="Genmei Kabuto",
																	body="Emet Harness +1",
																	hands="Kurys Gloves",
																	legs="Obatala Subligar",
																	feet=gear.NINRelic.Feet,
																	neck="Unmoving Collar",
																	waist="Sinew Belt",
																	left_ear="Cryptic Earring",
																	right_ear="Trux Earring",
																	left_ring="Pernicious Ring",
																	right_ring="Begrudging Ring",
																	back="Reiki Cloak",}
]]
----------------------------------------------------------------------------
-- CUSTOM SETS NOT COVERED ANYWHERE ELSE
----------------------------------------------------------------------------
--[[    sets.buff.Migawari =											{body=gear.NINEmpy.Body,back=gear.Andartia.WSD}
    sets.buff.Yonin = 												{legs=gear.NINEmpy.Legs}
    sets.buff.Innin = 												{head=gear.NINEmpy.Head}
	sets.buff.Futae = 												{hands=gear.NINEmpy.Hands}
	
	sets.buff.Sange = 												{ammo=gear.RAShuriken,
																	head=gear.Ryuo.Head,
																	body=gear.NINRelic.Body,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Adhemar.Legs,
																	feet=gear.Pursuers.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Infused Earring",
																	right_ear="Enervating Earring",
																	left_ring="Adoulin Ring",
																	right_ring="Dingir Ring",
																	back=gear.Yokaze,}
	sets.buff.Madrigal =											{hands="Composer's Mitts"}
	sets.buff.Minuet =												{feet="Composer's Sabots"}
    ----------------------------------------------------------------
    -- Magic Burst Set
	----------------------------------------------------------------
	sets.magic_burst = 												{ammo="Pemphredo Tathlum",
																	head=gear.NINRelic.Head,
																	body=gear.Samnuha.Body,
																	hands=gear.NINEmpy.Hands,
																	legs=gear.Herc.Legs.Nuke,
																	feet=gear.NINAF.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Crematio Earring",
																	ring1="Locus ring",
																	ring2="Mujin Band",
																	back=gear.Andartia.Nuke}															
]]end
--------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
--------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- PRECAST FUNCTIONS
----------------------------------------------------------------------------
function job_precast(spell, action, spellMap, eventArgs)
	if spell.type == "WeaponSkill" then
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
		end
	elseif spell.action_type == 'Ranged Attack' then
		equip(sets.precast.RA)
		do_shuriken_checks(spell, spellMap, eventArgs)
	elseif spell.type == 'JobAbility' then
		if sets.precast.JA[spell.name] then
			equip(sets.precast.JA[spell.name])
		end
	end
end
----------------------------------------------------------------------------
-- POST MIDCAST FUNCTIONS
----------------------------------------------------------------------------	
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.Buff.Doom then
		equip(sets.buff.Doom)
	end
	if state.Buff.Futae then
		equip(sets.buff.Futae)
	end
	if state.Buff.Mikage then
		equip(sets.buff.Mikage)
	end
	if state.Buff.Sange then
		equip(sets.buff.Sange)
	end
	if buffactive[199] and (state.OffenseMode.value=='Acc' or state.OffenseMode.value=='MaxACC') then
	equip(sets.buff.Madrigal)
	end
	if buffactive[198] then
	equip(sets.buff.Minuet)
	end
	if spell.skill == 'ElementalNinjutsu' and state.BurstMode.value == 'Burst On' then
        equip(sets.magic_burst)
    end
end
----------------------------------------------------------------------------
-- AFTERCAST FUNCTIONS
----------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
		if spell.english == 'Kurayami: Ichi' or spell.english == 'Kurayami: Ni' then
			send_command('@wait 55;input /echo ------- '..spell.english..'(Blind) is wearing off in 5 seconds -------')
		elseif spell.english == 'Hojo: Ichi' or spell.english == 'Hojo: Ni' then
			send_command('@wait 55;input /echo ------- '..spell.english..'(Slow) is wearing off in 5 seconds -------')
		elseif spell.english == 'Dokumori: Ichi' then
			send_command('@wait 55;input /echo ------- '..spell.english..'(Poison) is wearing off in 5 seconds -------')
		elseif spell.english == 'Jubaku: Ichi' then
			send_command('@wait 55;input /echo ------- '..spell.english..'(Paralyze) is wearing off in 5 seconds -------')
		elseif spell.english == 'Aisha: Ichi' then
			send_command('@wait 125;input /echo ------- '..spell.english..'(Attack Down) is wearing off in 5 seconds -------')
		elseif spell.english == 'Yurin: Ichi' then
			send_command('@wait 125;input /echo ------- '..spell.english..'(Inhibit TP) is wearing off in 5 seconds -------')
		elseif spell.english == "Migawari: Ichi" then
			state.Buff.Migawari = true
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
	if S{'haste', 'march', 'mighty guard', 'embrava', 'haste samba', 'geo-haste', 'indi-haste'}:contains(buff:lower()) then
		determine_haste_group()
		if not midaction() then
			handle_equipping_gear(player.status)
		end
	end
end
----------------------------------------------------------------------------
-- Select Dusk to Dawn gear for idle status
----------------------------------------------------------------------------
function job_status_change(new_status, old_status)
	if new_status == 'Idle' then
		nightgear()
	end
end
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Get custom spell maps
----------------------------------------------------------------------------
function job_get_spell_map(spell, default_spell_map)
	if spell.skill == "Ninjutsu" then
		if not default_spell_map then
			if spell.target.type == 'SELF' then
				return 'NinjutsuBuff'
			else
				return 'NinjutsuDebuff'
			end
		end
	end
end
----------------------------------------------------------------------------
-- Modify the default idle set after it was constructed.
----------------------------------------------------------------------------
function customize_idle_set(idleSet)
	if state.Buff.Migawari then
		idleSet = set_combine(idleSet, sets.buff.Migawari)
	end
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
	if state.Buff.Futae then
		idleSet = set_combine(idleSet, sets.buff.Futae)
	end	
	if state.Buff.Mikage then
		idleSet = set_combine(idleSet, sets.buff.Mikage)
	end	
	if state.Buff.Sange then
		idleSet = set_combine(idleSet, sets.buff.Sange)
	end	
	return idleSet
end
----------------------------------------------------------------------------
-- Modify the default melee set after it was constructed.
----------------------------------------------------------------------------
function customize_melee_set(meleeSet)
	if state.Buff.Migawari then
		meleeSet = set_combine(meleeSet, sets.buff.Migawari)
	end
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end	
	if state.Buff.Futae then
		meleeSet = set_combine(meleeSet, sets.buff.Futae)
	end	
	if state.Buff.Mikage then
		meleeSet = set_combine(meleeSet, sets.buff.Mikage)
	end
	if state.Buff.Sange then
		meleeSet = set_combine(meleeSet, sets.buff.Sange)
	end	
	if buffactive[199] and (state.OffenseMode.value=='Acc' or state.OffenseMode.value=='MaxACC') then
		meleeSet = set_combine(meleeSet, sets.buff.Madrigal)
	end
	if buffactive[198] then
		meleeSet = set_combine(meleeSet, sets.buff.Minuet)
	end
	return meleeSet
end
----------------------------------------------------------------------------
-- Called by the default 'update' self-command.
----------------------------------------------------------------------------
function job_update(cmdParams, eventArgs)
	nightgear()
	determine_haste_group()
end
--------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
--------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- HASTE GROUP FOR DUAL WIELD
----------------------------------------------------------------------------
function determine_haste_group()
	classes.CustomMeleeGroups:clear()
	-- Haste 						= 15%
	-- Haste II						= 30%
	-- GeoHaste						= 29.9%	(30% Used below)
	-- Haste Samba (Sub) 			=  5%
	-- Haste Samba (Merited DNC) 	= 10% 	(Only the subjob value is used below)
	-- Victory March +0/+3/+4/+5    = 10.4%	**NEW baseline (10% Used below)
	-- Advancing March +0/+3/+4/+5  = 15.9%	**NEW baseline (15% Used below)
	-- Embrava 						= 26.9% with 500 enhancing skill (25% Used below)
	-- Mighty Guard 				= 15%
	
	-- buffactive[580] 				= geo haste
	-- buffactive[33] 				= haste (1 & 2, shared icon)
	-- buffactive[604] 				= mighty guard
	-- buffactive[228] 				= embrava
	-- buffactive[370] 				= Haste Samba
	-- buffactive[214]				= March (Advancing and Victory use same icons/Id's .... Honor March unknown)
	
	-- state.HasteMode = toggle for when you know Haste II is being cast on you
	-- Hi = Haste II is being cast. This is clunky to use when both haste II and haste I are being cast
	
	-- I did my best to account for all combos of buffs, but if I missed something, 
	-- (After you check both sections) please let me know so it can be added or if any mistakes were made.

	-- Other Notes :
	--	This is not setup for DNC main, adjustments need to be made to account for Haste Samba differences between a Meritted DNC Main and what /dnc gets
	--	Riki's original that I worked from made some assupmtions about +song gear, I left those out.  
	--	This is WORST CASE SCENARIO assumed for all buffs.
	
	-- Credit where it's due, this is mainly Rikimarueye's work, I just made it prettier (with some formatting and full comments),
	-- and updated it with the new baseline March Values, and small changes like moving Embrava from 30% to 25%.
	-- Tib

if state.HasteMode.value == true then
		if		(buffactive[13] or buffactive[194]) then																			-- SLOW AND ELEGY
				equip(sets.engaged.SE)
																																	-- ***This Section is for Haste II*** --
		elseif 	(buffactive[33] and (buffactive[580] or (buffactive.march == 2) or buffactive[604]) and buffactive[370]) or			-- HasteII + (GeoHaste or 2x march or MG) + Samba
				(buffactive[228] and (buffactive[33] or buffactive[580] or (buffactive.march == 2) and buffactive[370])) then		-- Embrava + (HasteII or GeoHaste or 2x march) + Samba
			--add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCappedSamba')
        elseif 	((buffactive[33] or buffactive[580]) and (buffactive.march == 1 and buffactive [370]) or							-- (HasteII or GeoHaste) + (1x march +Samba)
				(buffactive[604] and buffactive.march == 2 and buffactive[370]) or													-- MG + 2x march + Samba
				((buffactive[228] and buffactive[604]) and buffactive[370])) then													-- Embrava + MG + Samba
            --add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('Haste_40Samba')
		elseif 	(buffactive[580] and (buffactive[33] or (buffactive.march == 2) or buffactive[604])) or   							-- GeoHaste + (HasteII or 2x march or MG)
				(buffactive[604] and ((buffactive.march == 2) and buffactive[370])) or												-- MG + 2x March + Samba
				(buffactive[33] and ((buffactive.march == 2) or buffactive[604])) or												-- HasteII + (2x march or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        --add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCapped')
        elseif 	((buffactive[33] or buffactive[580]) and buffactive.march == 1) or													-- (HasteII or GeoHaste) + 1x march
				(buffactive[604] and buffactive.march == 2) or																		-- MG + 2x march
				(buffactive[228] and buffactive[604]) then																			-- Embrava + MG
            --add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('Haste_40')	
        elseif 	((buffactive[33] or buffactive[580]) and buffactive[370]) or 														-- (HasteII or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then																	-- Embrava + 1x march
		    --add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif 	(buffactive[604] and buffactive.march == 1 and buffactive[370]) or													-- MG + 1x march + Samba
				((buffactive.march == 2) and buffactive[370]) or																	-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or																			-- Embrava + Samba
				(buffactive[33] or buffactive[580]) then																			-- HasteII or GeoHaste  
            --add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif 	(buffactive[604] and (buffactive.march == 1)) or																	-- MG + 1x march 
				(buffactive.march == 2) or																							-- 2x march
				(buffactive[228]) then																								-- Embrava
		    --add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('Haste_25')
		elseif 	(buffactive[604] and buffactive[370]) then																			-- MG + Samba
		    --add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('Haste_20')
	    elseif 	(buffactive.march == 1 and buffactive[370]) or 																		-- 1x march + Samba
				(buffactive[604]) then																								-- MG
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            --add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('Haste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            --add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('Haste_5')
		end
    else																													-- ***This section is for Haste I*** --										
		if		(buffactive[13] or buffactive[194]) then																			-- SLOW AND ELEGY
				equip(sets.engaged.SE)
	
		elseif 	(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) and buffactive[370] or  		-- GeoHaste + (2x march or Haste or MG) + Samba
				(buffactive[228] and buffactive[580] and buffactive[370]) then														-- Embrava + GeoHaste + Samba
	        --add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCappedSamba')
        elseif 	(buffactive[228] and (buffactive[33] or buffactive[604]) and buffactive[370]) or									-- Embrava + (Haste or MG) + Samba
				((buffactive[33] or buffactive[604]) and ((buffactive.march == 2) and buffactive[370])) then						-- (Haste or MG) + (2x march + Samba)
            --add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('Haste_40Samba')
		elseif 	(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) or   							-- GeoHaste + (2x march or Haste or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        --add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCapped')
		elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive.march == 1) or							-- ((Haste + MG) or GeoHaste) + 1x march
				((buffactive[33] or buffactive[604]) and buffactive.march == 2) or													-- (Haste or MG) + 2x march
				(buffactive[228] and buffactive.march == 1 and buffactive[370]) or													-- Embrava + 1x march + Samba
				((buffactive[33] or buffactive[604]) and buffactive[228]) then														-- (Haste or MG) + Embrava
            --add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('Haste_40')        
		elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive[370]) or 									-- ((Haste + MG) or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then 																	-- Embrava + 1x march
            --add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
		elseif 	((buffactive[33] or buffactive[604]) and buffactive.march == 1 and buffactive[370]) or 								-- (Haste or MG) + 1x march + Samba		
				(buffactive.march == 2 and buffactive[370]) or																		-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or  																			-- Embrava + Samba
				(buffactive[33] and buffactive[604]) or																				-- Haste + MG
				(buffactive[580]) then 																								-- GeoHaste
            --add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
		elseif  ((buffactive[33] or buffactive[604]) and buffactive.march == 1) or 													-- (Haste or MG) + 1x march	
				(buffactive.march == 2) or 																							-- 2x march
				(buffactive[228]) then																								-- Embrava
			--add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('Haste_25')
		elseif 	((buffactive[33] or buffactive[604]) and buffactive[370]) then														-- (Haste or MG) + Samba
		    --add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('Haste_20')
		elseif	((buffactive.march == 1) and buffactive[370]) or																	-- 1x march + Samba
				(buffactive[33] or buffactive[604]) then																			-- Haste or MG
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            --add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('Haste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            --add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('Haste_5')
        end
    end
end
----------------------------------------------------------------------------
-- DUSK TO DAWN GEAR
----------------------------------------------------------------------------
function nightgear()
	if world.time >= 17*60 or world.time < 7*60 then
		gear.MovementFeet.name = gear.NightFeet
		gear.left_Earring.name = gear.NightEarleft
		gear.right_Earring.name = gear.NightEarright
	else
		gear.MovementFeet.name = gear.DayFeet
		gear.left_Earring.name = gear.DayEarleft
		gear.right_Earring.name = gear.DayEarright
	end
end
----------------------------------------------------------------------------
-- SHURIKEN AMMO CHECK
----------------------------------------------------------------------------
function do_shuriken_checks(spell, spellMap, eventArgs)
	local shuriken_name
	local shuriken_min_count = 1
	if spell.action_type == 'Ranged Attack' then
		shuriken_name = gear.RAShuriken
	end
	local available_shurikens = player.inventory[shuriken_name] or player.wardrobe[shuriken_name]
	-- If no ammo is available, give appropriate warning and end.
	if not available_shurikens then
		if spell.action_type == 'Ranged Attack' and player.equipment.ammo == gear.RAShuriken then
			add_to_chat(104, 'No Shuriken ammo left.')
			return
		else
			add_to_chat(104, 'No ammo ('..tostring(shuriken_name)..') available for that action.')
			eventArgs.cancel = true
			return
		end
	end
	-- Low ammo warning.
	if spell.action_type == 'Ranged Attack' and state.warned.value == false
		and available_shurikens.count > 1 and available_shurikens.count <= options.ammo_warning_limit then
		local msg = '*****  LOW AMMO WARNING: '..shuriken_name..' *****'
		--local border = string.repeat("*", #msg)
		local border = ""
		for i = 1, #msg do
			border = border .. "*"
		end
		add_to_chat(104, border)
		add_to_chat(104, msg)
		add_to_chat(104, border)
		state.warned:set()
	elseif available_shurikens.count > options.ammo_warning_limit and state.warned then
		state.warned:reset()
	end
end
----------------------------------------------------------------------------
-- SUBJOB AND MACRO BOOK SELECTION
----------------------------------------------------------------------------
function select_default_macro_book()
	set_macro_page(2, 16)
end