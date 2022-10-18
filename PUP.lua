-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------
 
-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
 
    -- Load and initialize the include file.
    include('Mote-Include.lua')
end
 
 
-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    -- List of pet weaponskills to check for
    petWeaponskills = S{"Slapstick", "Knockout", "Magic Mortar",
        "Chimera Ripper", "String Clipper", "Cannibal Blade", "Bone Crusher", "String Shredder",
        "Arcuballista", "Daze", "Armor Piercer", "Armor Shatterer"}
     
    -- Map automaton heads to combat roles
    petModes = {
        ['Harlequin Head'] = 'Melee',
        ['Sharpshot Head'] = 'Ranged',
        ['Valoredge Head'] = 'Tank',
        ['Stormwaker Head'] = 'Magic',
        ['Soulsoother Head'] = 'Heal',
        ['Spiritreaver Head'] = 'Nuke'
        }
 
    -- Subset of modes that use magic
    magicPetModes = S{'Nuke','Heal','Magic'}
     
    -- Var to track the current pet mode.
    state.PetMode = M{['description']='Pet Mode', 'None', 'Melee', 'Ranged', 'Tank', 'Magic', 'Heal', 'Nuke'}
end
 
-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------
 
-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'TP', 'Acc', 'Martial_Arts')
    state.HybridMode:options('Normal', 'DT')
    state.WeaponskillMode:options('Normal', 'Acc', 'Fodder')
    state.PhysicalDefenseMode:options('PDT', 'Evasion', 'PetDT')
    state.IdleMode:options('Normal', 'PetDT')
     
    -- Default maneuvers 1, 2, 3 and 4 for each pet mode.
    defaultManeuvers = {
        ['Melee'] = {'Fire Maneuver', 'Thunder Maneuver', 'Wind Maneuver', 'Light Maneuver'},
        ['Ranged'] = {'Wind Maneuver', 'Fire Maneuver', 'Thunder Maneuver', 'Light Maneuver'},
        ['Tank'] = {'Earth Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Wind Maneuver'},
        ['Magic'] = {'Ice Maneuver', 'Light Maneuver', 'Dark Maneuver', 'Earth Maneuver'},
        ['Heal'] = {'Light Maneuver', 'Dark Maneuver', 'Water Maneuver', 'Earth Maneuver'},
        ['Nuke'] = {'Ice Maneuver', 'Dark Maneuver', 'Light Maneuver', 'Earth Maneuver'}
    }
 
----------------------------------------------------------------------------
-- Augmented Gear and Abbreviations
----------------------------------------------------------------------------
	----------------------------------------------------------------
	--Weapons--
		gear.Midnights 					= {name="Midnights", augments={'Pet: Attack+25','Pet: Accuracy+25','Pet: Damage taken -3%',}}
	
		gear.Ohtas 						= {name="Ohtas", augments={'Accuracy+70','Pet: Accuracy+70','Pet: Haste+10%',}}
	
	-- Capes --
		gear.Visucius = {}
		gear.Visucius.PetHaste 			= {name="Visucius's Mantle", augments={'Pet: Acc.+20 Pet: R.Acc.+20 Pet: Atk.+20 Pet: R.Atk.+20','Accuracy+20 Attack+20','Pet: Haste+10',}}
		gear.Visucius.PetRegen 			= {name="Visucius's Mantle", augments={'Accuracy+14 Attack+14','Pet: "Regen"+10',}}
		
		gear.PUPJSECape 				= {name="Dispersal Mantle", augments={'STR+2','DEX+1','Pet: TP Bonus+480','"Martial Arts"+17',}}
		
		-- Artifact --
		gear.PUPAF = {}
		gear.PUPAF.Head 				= {name="Foire Taj +2"}
		gear.PUPAF.Body 				= {name="Foire Tobe +2"}
		gear.PUPAF.Hands 				= {name="Foire Dastanas +2"}
		gear.PUPAF.Legs 				= {name="Foire Churidars +2"}
		gear.PUPAF.Feet 				= {name="Foire Bab. +2"}
		
		-- Relic --
		gear.PUPRelic = {}
		gear.PUPRelic.Head 				= {name="Pitre Taj +1", augments={'Enhances "Optimization" effect',}}
		gear.PUPRelic.Body 				= {name="Pitre Tobe +1", augments={'Enhances "Overdrive" effect',}}
		gear.PUPRelic.Hands 			= {name="Pitre Dastanas +1", augments={'Enhances "Fine-Tuning" effect',}}
		gear.PUPRelic.Legs 				= {name="Pitre Churidars +1", augments={'Enhances "Ventriloquy" effect',}}
		gear.PUPRelic.Feet 				= {name="Pitre Babouches +1", augments={'Enhances "Role Reversal" effect',}}
		
		
		-- Empyrean --
		gear.PUPEmpy = {}
		gear.PUPEmpy.Head 				= {name="Karagoz Capello +1"}
		gear.PUPEmpy.Body 				= {name="Kara. Farsetto +1"}
		gear.PUPEmpy.Hands				= {name="Karagoz Guanti +1"}
		gear.PUPEmpy.Legs 				= {name="Kara. Pantaloni +1"}
		gear.PUPEmpy.Feet 				= {name="Karagoz Scarpe +1"}

		
		-- Herculean --
		gear.Herc = {}
		gear.Herc.Head 					= {name="Herculean Helm", augments={'Accuracy+12 Attack+12','"Triple Atk."+2','STR+10','Accuracy+14','Attack+4',}}
		gear.Herc.Body 					= {name="Herculean Vest", augments={'"Triple Atk."+1','STR+9','Accuracy+9','Attack+11',}}
		gear.Herc.Hands 				= {name="Herculean Gloves", augments={'Accuracy+23','"Triple Atk."+3','DEX+8','Attack+12',}}
		gear.Herc.Legs 					= {name="Herculean Trousers", augments={'Attack+13','Crit. hit damage +2%','STR+10','Accuracy+11',}}
		gear.Herc.Feet 					= {name="Herculean Boots", augments={'Attack+29','"Triple Atk."+3','Accuracy+5',}}
		
					
		-- Naga --
		gear.Naga = {}
		gear.Naga.Head 					= {name="Naga Somen", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Body 					= {name="Naga Samue", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Hands 				= {name="Naga Tekko", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Legs 					= {name="Naga Hakama", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Feet 					= {name="Naga Kyahan", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}

		gear.Naga.Body.WS 				= {name="Naga Samue", augments={'HP+80','DEX+10','Attack+20',}}
		gear.Naga.Hands.PetMacc	 		= {name="Naga Tekko", augments={'Pet: MP+80','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+20',}}
		gear.Naga.Legs.A				= {name="Naga Hakama", augments={'STR+10','Accuracy+15','"Subtle Blow"+7',}}
		gear.Naga.Feet.PetMelee 		= {name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}}

		
		-- Rao --
		gear.RaoPetDT = {}
		gear.RaoPetDT.Head 				= {name="Rao Kabuto +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
		gear.RaoPetDT.Body 				= {name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Hands 			= {name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Legs 				= {name="Rao Haidate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}
		gear.RaoPetDT.Feet 				= {name="Rao Sune-Ate +1", augments={'Pet: HP+125','Pet: Accuracy+20','Pet: Damage taken -4%',}}

		gear.RaoMaster = {}
		gear.RaoMaster.Head 			= {name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Body 			= {name="Rao Togi", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Hands 			= {name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Legs 			= {name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Feet 			= {name="Rao Sune-Ate", augments={'STR+10','DEX+10','Attack+15',}}
				
		-- Rawhide --
		gear.Rawhide = {}
		gear.Rawhide.Head				= {name="Rawhide Mask", augments={'HP+50','Accuracy+15','Evasion+20',}}	
		gear.Rawhide.Body 				= {name="Rawhide Vest", augments={'HP+43','Accuracy+12','Evasion+17',}}
		gear.Rawhide.Legs 				= {name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}}

		-- Ryuo --
		gear.Ryuo = {}
		gear.Ryuo.Head 					= {name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Body 					= {name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Hands 				= {name="Ryuo Tekko +1", augments={'STR+12','DEX+12','Accuracy+20',}}
		gear.Ryuo.Legs 					= {name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}}
		gear.Ryuo.Feet 					= {name="Ryuo Sune-Ate +1", augments={'STR+12','DEX+12','Accuracy+20',}}
		
		-- Taeon --
		gear.Taeon = {}
		gear.Taeon.Hands 				= {name="Taeon Gloves", augments={'Accuracy+20 Attack+20','Pet: "Dbl. Atk."+3','Pet: Damage taken -4%',}}
		gear.Taeon.Body					= {name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: Crit.hit rate +4','Pet: Damage taken -4%',}}
		gear.Taeon.Head					= {name="Taeon Chapeau", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}}
		gear.Taeon.Legs					= {name="Taeon Tights", augments={'Pet: Attack+18 Pet: Rng.Atk.+18','"Repair" potency +5%','Pet: Damage taken -4%',}}
		gear.Taeon.Feet					= {name="Taeon Boots", augments={'Pet: Accuracy+19 Pet: Rng. Acc.+19','Pet: Crit.hit rate +4','Pet: Damage taken -4%',}}
		
		
	-- Miscellaneous --
		-- Hizamaru --
		gear.Hiza = {}
		gear.Hiza.Head 					= {name="Hizamaru Somen +2"}
		gear.Hiza.Body 					= {name="Hiza. Haramaki +2"}
		gear.Hiza.Hands 				= {name="Hizamaru Kote +2"}
		gear.Hiza.Legs 					= {name="Hiza. Hizayoroi +2"}
		gear.Hiza.Feet 					= {name="Hiza. Sune-Ate +2"}
		
		-- Tali'ah --
		gear.Tali = {}
		gear.Tali.Head					= {name="Tali'ah Turban +2"}
		gear.Tali.Body					= {name="Tali'ah Manteel +2"}
		gear.Tali.Hands					= {name="Tali'ah Gages +1"}
		gear.Tali.Legs					= {name="Tali'ah Sera. +2"}
		gear.Tali.Feet					= {name="Tali'ah Crackows +1"}
    
		gear.Samnuha = {}
		gear.Samnuha.Legs 				= {name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}
		
		gear.Anwig = {}
		gear.Anwig 						= {name="Anwig Salade", augments={'Attack+3','Pet: Damage taken -10%','Attack+3','Pet: "Regen"+1',}}
		
		gear.Desultor = {}
		gear.Desultor 					= {name="Desultor Tassets", augments={'"Repair" potency +10%','Movement speed +8%+2',}}
 
    update_pet_mode()
    select_default_macro_book()
end
 
 
-- Define sets used by this job file.
function init_gear_sets()
     
    -- Precast Sets
 
    sets.precast.Step = 											{head="Hiza. Somen +2",
																	body=gear.Herc.Body.Acc,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Subtlety Spec.",
																	waist="Klouskap Sash",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Visucius.PetHaste,}    
     
    sets.precast.Flourish = 										{head=gear.Herc.Head,
																	body=gear.Herc.Body.Acc,
																	hands=gear.Ryuo.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Empath Necklace",
																	waist="Klouskap Sash",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Visucius.PetHaste,}
     
    -- Fast cast sets for spells
    sets.precast.FC = 												{head=gear.Herc.Head,
																	body="Zendik Robe",
																	hands=gear.Taeon.Hands,
																	legs=gear.Rawhide.Legs,
																	feet=gear.Herc.Feet,
																	neck="Voltsurge Torque",
																	waist="Klouskap Sash",
																	left_ring="Prolix Ring",
																	left_ear="Etiolation Earring",
																	right_ear="Loquac. Earring",
																	back="Swith Cape",}

    sets.precast.FC.Utsusemi = 										sets.precast.FC

    -- Precast sets to enhance JAs
	sets.precast.JA['Overdrive'] =									{body=gear.PUPRelic.Body}
	sets.precast.JA['Ventriloquy'] =								{legs=gear.PUPRelic.Legs}
	sets.precast.JA['Role Reversal'] =								{feet=gear.PUPRelic.Feet}
    sets.precast.JA['Tactical Switch'] = 							{feet=gear.PUPEmpy.Feet}
    
    sets.precast.JA['Repair'] = 									{feet=gear.PUPAF.Feet,
																	--Guignol Earring,
																	legs=gear.Desultor,}
	
	sets.precast.JA['Activate'] =									{main=gear.Midnights,
																	body=gear.PUPEmpy.Body,
																	hands=gear.PUPAF.Hands,
																	--ear2="Burana Earring",
																	back=gear.Visucius.PetHaste}
	
	sets.precast.JA['Deus Ex Automata'] =							sets.precast.JA['Activate']
	
    sets.precast.JA.Maneuver = 										{body=gear.PUPEmpy.Body,
																	hands=gear.PUPAF.Hands,
																	--ear2="Burana Earring",
																	back=gear.Visucius.PetHaste}  
    -- Waltz set (chr and vit)
    sets.precast.Waltz = 											{ammo="Automat. Oil +3",
																	head=gear.PUPAF.Head,
																	body=gear.Hiza.Body,
																	hands=gear.Hiza.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Unmoving Collar",
																	waist="Caudata Belt",
																	left_ear="Handler's Earring +1",
																	right_ear="Handler's Earring",
																	left_ring="Niqmaddu Ring",
																	right_ring="Regal Ring",
																	back="Refraction Cape",}
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = 							{}
 
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    
	-- sets.precast.WS = {}
 
    -- Specific weaponskill sets.  Uses the base set if an appropriate WSMod version isn't found.
    
	-- Combo - STR/VIT
	sets.precast.WS['Combo'] = 										{ammo="Knobkierrie",
																	head=gear.RaoMaster.Head,
																	body=gear.RaoMaster.Body,
																	hands=gear.RaoMaster.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Genmei Earring",
																	right_ear="Odnowa Earring +1",
																	left_ring="Niqmaddu Ring",
																	right_ring="Regal Ring",
																	back=gear.Visucius.PetHaste,}
	-- Shoulder Tackle - VIT 
	sets.precast.WS['Shoulder Tackle'] =							{ammo="Knobkierrie",
																	head=gear.RaoMaster.Head,
																	body=gear.Hiza.Body,
																	hands=gear.Hiza.Hands,
																	legs=gear.Hiza.Legs,
																	feet=gear.Hiza.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Genmei Earring",
																	right_ear="Odnowa Earring +1",
																	left_ring="Niqmaddu Ring",
																	right_ring="Regal Ring",
																	back=gear.Visucius.PetHaste}
	-- 1" Punch - VIT
	sets.precast.WS['One Inch Punch'] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Hiza.Body,
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste}
	-- Backhand Blow - STR/DEX
	sets.precast.WS['Backhand Blow'] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.PUPJSECape}
	
	-- Raging Fists - STR/DEX
	sets.precast.WS['Raging Fists'] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.PUPJSECape}
																		
	
	-- Spinning Attack - STR
	sets.precast.WS['Spinning Attack'] =								{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Ryuo.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Zennaroi Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste} 
	
	-- Howling Fist - DEX/STR
	sets.precast.WS['Howling Fist'] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.PUPJSECape}
	
	-- Dragon Kick - STR/DEX
	sets.precast.WS['Dragon Kick'] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.PUPJSECape}
	
	-- Asuran Fists - STR/VIT
	sets.precast.WS['Asuran Fists'] = 									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.RaoMaster.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste,}
	
	-- Tornado Kick - STR/VIT
	sets.precast.WS['Tornado Kick'] = 									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.RaoMaster.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste,}
	
	-- Shijin Spiral - DEX
    sets.precast.WS['Shijin Spiral'] = 									{ammo="Knobkierrie",
																		head=gear.Herc.Head,
																		body=gear.Naga.Body.WS,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Pixie Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste}
	
	-- Victory Smite - STR
    sets.precast.WS['Victory Smite'] = 									{ammo="Knobkierrie",
																		head="Blistering sallet +1",
																		body="Heyoka Harness",
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Moonbow belt +1",
																		left_ear="Ishvara Earring",
																		right_ear="Moonshade Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Epona's Ring",
																		back=gear.Visucius.PetHaste} 
	
	-- Stringing Pummel - STR/VIT
	sets.precast.WS['Stringing Pummel'] = 								{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.RaoMaster.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Visucius.PetHaste,}
     
    -- Midcast Sets
 
    sets.midcast.FastRecast = 											sets.precast.FC
         
	sets.midcast['Blue Magic'] =										{range="Animator P",
																		ammo="Automat. Oil +3",
																		head=gear.Herc.Head.PetMacc,
																		body="Vrikodara Jupon",
																		hands="Kurys Gloves",
																		legs="Obatala Subligar",
																		feet="Hermes' Sandals",
																		neck="Unmoving Collar",
																		waist="Klouskap Sash",
																		left_ear="Trux Earring",
																		right_ear="Cryptic Earring",
																		left_ring="Pernicious Ring",
																		right_ring="Begrudging Ring",
																		back="Swith Cape",}
 
    -- Midcast sets for pet actions
        sets.midcast.Pet.Cure = 										{head=gear.Naga.Head,
																		body=gear.Naga.Body,
																		hands=gear.Naga.Hands,
																		legs=gear.PUPAF.Legs,
																		feet=gear.Naga.Feet,
																		waist="Klouskap Sash",
																		back="Refraction Cape",}
 		
		sets.midcast.Pet['Elemental Magic'] = 							{head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Argocham. Mantle",}
 
        sets.midcast.Pet['Enfeebling Magic'] = 							{head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Refraction Cape",}
     
        sets.midcast.Pet['Dark Magic'] = 								{head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Refraction Cape",}
     
        sets.midcast.Pet['Divine Magic'] = 								{head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Refraction Cape",}
     
        sets.midcast.Pet['Enhancing Magic'] = 							{head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPEmpy.Legs,
																		feet=gear.Naga.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Refraction Cape",}
     
    --Set for Pet Weapon Skill DMG MAX - TP Bonus 550+480=1030tp
     sets.midcast.Pet.Weaponskill = 									{ammo="Automat. Oil +3",
																		head=gear.PUPEmpy.Head,
																		body=gear.Herc.Body,
																		hands=gear.PUPEmpy.Hands,
																		legs=gear.PUPEmpy.Legs,
																		feet=gear.Naga.Feet.PetMelee,
																		neck="Shulmanu Collar",
																		waist="Klouskap Sash",
																		left_ear="Handler's Earring +1",
																		right_ear="Odnowa Earring +1",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back=gear.PUPJSECape}
 
    -- Sets to return to when not performing an action.
		--Burana Earring (PUP) Maneuver effects +1 Automaton: Attack+15 Ranged Attack+15 "Magic Atk. Bonus"+10 "Regen"+2
		--Cirque Earring (PUP) Automaton: Attack+2 Ranged Attack+2 "Magic Atk. Bonus"+2
     
    -- Resting sets
    sets.resting = 														{head=gear.PUPRelic.Head,
																		body=gear.Hiza.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.RaoMaster.Legs,
																		feet=gear.RaoMaster.Feet,
																		neck="Sanctity Necklace",
																		waist="Klouskap Sash",
																		left_ear="Infused Earring",	
																		right_ear="Odnowa Earring +1",
																		left_ring="Patricius Ring",	
																		right_ring="Defending Ring",
																		back=gear.Visucius.PetRegen,}
     
    -- Idle sets
    sets.idle = 														sets.resting
 
    --sets.idle.Town = set_combine(sets.idle, {range="Divinator",main="Denouements"})
 
    -- Set for idle while pet is out (eg: pet regen gear)
    sets.idle.Pet =														{ammo="Automat. Oil +3",
																		head=gear.PUPRelic.Head,
																		body=gear.PUPAF.Body,
																		hands=gear.RaoPetDT.Hands,
																		legs=gear.RaoPetDT.Legs,
																		feet=gear.RaoPetDT.Feet,
																		neck="Empath Necklace",
																		waist="Isa Belt",
																		left_ear="Handler's Earring +1",
																		right_ear="Enmerker Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back=gear.Visucius.PetRegen,}
 
    -- Idle sets to wear while pet is engaged
    sets.idle.Pet.Engaged = 											{range="Animator P",
																		ammo="Automat. Oil +3",
																		head=gear.PUPRelic.Head,
																		neck="Empath Necklace",
																		left_ear="Domesticator's Earring",
																		right_ear="Enmerker Earring",
																		body=gear.PUPAF.Body,
																		--hands="Regimen Mittens",
																		ring1="Thurandaut Ring",
																		ring2="Varar Ring +1",
																		back=gear.Visucius.PetHaste,
																		waist="Klouskap Sash",
																		legs=gear.PUPEmpy.Legs,
																		feet="Punchinellos",}--Handler's Earring/Burana Earring
 
    sets.idle.Pet.PetDT = 												{range="Animator P +1",
																		ammo="Automat. Oil +3",
																		head={ name="Taeon Chapeau", augments={'Pet: Accuracy+24 Pet: Rng. Acc.+24','Pet: "Dbl. Atk."+4','Pet: Damage taken -4%',}},
																		body={ name="Taeon Tabard", augments={'Pet: Accuracy+25 Pet: Rng. Acc.+25','Pet: Crit.hit rate +4','Pet: Damage taken -4%',}},
																		hands={ name="Taeon Gloves", augments={'Accuracy+20 Attack+20','Pet: "Dbl. Atk."+3','Pet: Damage taken -4%',}},
																		legs={ name="Taeon Tights", augments={'Pet: Attack+18 Pet: Rng.Atk.+18','"Repair" potency +5%','Pet: Damage taken -4%',}},
																		feet={ name="Taeon Boots", augments={'Pet: Accuracy+19 Pet: Rng. Acc.+19','Pet: Crit.hit rate +4','Pet: Damage taken -4%',}},
																		neck="Pup. Collar",
																		waist="Incarnation Sash",
																		left_ear="Domes. Earring",
																		right_ear="Rimeice Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back="Penetrating Cape",}
         
    sets.idle.Pet.Engaged.Ranged = 										{range="Animator P II",
																		ammo ="Automat. Oil +3",
																		head=gear.Tali.Head,
																		body=gear.Tali.Body,
																		hands=gear.Tali.Hands,
																		legs=gear.Tali.Legs,
																		feet="Punchinellos",
																		neck="Empath Necklace",
																		waist="Klouskap Sash",
																		left_ear="Charivari Earring",
																		right_ear="Rimeice Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back=gear.Visucius.PetHaste}
 
    sets.idle.Pet.Engaged.Nuke = 										{range="Animator P II",
																		ammo="Automat. Oil +3",
																		head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPEmpy.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back="Argocham. Mantle"}
 
    sets.idle.Pet.Engaged.Heal = 										{range="Animator P II",
																		ammo="Automat. Oil +3",
																		head=gear.Naga.Head,
																		body=gear.Naga.Body,
																		hands=gear.Naga.Hands,
																		legs=gear.PUPAF.Legs,
																		feet=gear.Naga.Feet,
																		waist="Klouskap Sash",
																		back="Refraction Cape",}
     
    sets.idle.Pet.Engaged.Magic = 										{range="Animator P II",
																		ammo="Automat. Oil +3",
																		head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		back="Refraction Cape"}
 
    -- Defense sets
    sets.defense.Evasion = 												{ammo="Automat. Oil +3",
																		head=gear.Hiza.Head,
																		body=gear.Hiza.Body,
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Infused Earring",
																		right_ear="Eabani Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back=gear.PUPJSECape}
 
    sets.defense.PDT = 	-- 	20 PDT / 23 DT											
																		{ammo="Automat. Oil +3",
																		head="Blistering Sallet +1",
																		body=gear.Ryuo.Body,
																		hands="Kurys Gloves",
																		legs=gear.Herc.Legs,
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Infused Earring",
																		right_ear="Genmei Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back="Solemnity Cape",}
 
    sets.defense.PetDT = 												{ammo ="Automat. Oil +3",
																		head=gear.RaoPetDT.Feet,
																		body=gear.RaoPetDT.Feet,
																		hands=gear.RaoPetDT.Hands,
																		legs=gear.RaoPetDT.Legs,
																		feet=gear.RaoPetDT.Feet,
																		neck="Empath Necklace",
																		waist="Isa Belt",
																		left_ear="Handler's Earring +1",
																		right_ear="Enmerker Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back=gear.Visucius.PetRegen,}
         
    sets.defense.MDT = 													{ammo ="Automat. Oil +3",
																		head=gear.Naga.Head,
																		body=gear.Hiza.Body,
																		hands="Kurys Gloves",
																		legs="Gyve Trousers",
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Etiolation Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Yacuruna Ring",
																		right_ring="Defending Ring",
																		back="Solemnity Cape",}
 
    sets.Kiting = 														{feet="Hermes' Sandals"}
 
    -- Engaged sets
 
    -- Variations for TP weapon	and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
     
    -- Normal melee group
    sets.engaged = 														{ammo="Automat. Oil +3",
																		head=gear.Hiza.Head,
																		body=gear.Rawhide.Body,
																		hands=gear.Herc.Hands,
																		legs=gear.Samnuha.Legs,
																		feet=gear.Herc.Feet,
																		neck="Shulmanu Collar",
																		waist="Moonbow Belt",
																		left_ear="Mache Earring",
																		right_ear="Mache Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Visucius.PetHaste}
    
	sets.engaged.TP =													{ammo="Automat. Oil +3",
																		head="Blistering Sallet +1",
																		body=gear.Rawhide.Body,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Ryuo.Legs,
																		feet=gear.Herc.Feet,
																		neck="Shulmanu Collar",
																		waist="Moonbow Belt",
																		left_ear="Steelflash Earring",
																		right_ear="Bladeborn Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.PUPJSECape}
	
	sets.engaged.Acc = 													{ammo="Automat. Oil +3",
																		head=gear.Herc.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Shulmanu Collar",
																		waist="Klouskap Sash",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Visucius.PetHaste}
    
	sets.engaged.Martial_Arts = --480-80-20-20 (traits) = 360 Base Delay - 68 MA this set = 292 base delay 
																		{ammo="Automat. Oil +3",
																		head=gear.Hiza.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.Herc.Hands,
																		legs=gear.PUPEmpy.Legs,
																		feet=gear.Herc.Feet,
																		neck="Shulmanu Collar",
																		waist="Shaolin Belt",
																		left_ear="Mache Earring",
																		right_ear="Mache Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.PUPJSECape}
																		   
    sets.engaged.DT = 													{ammo="Automat. Oil +3",
																		head=gear.Ryuo.Head,
																		body=gear.Ryuo.Body,
																		hands="Kurys Gloves",
																		legs=gear.Herc.Legs,
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Infused Earring",
																		right_ear="Genmei Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back="Solemnity Cape"}
    
	--[[sets.engaged.Acc.DT = {ammo="Automat. Oil +3",
        head="Dampening Tam",neck="Loricate Torque +1",ear1="Steelflash Earring",ear2="Cessance Earring",
        body={ name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}},hands="Herculean Gloves",ring1="Dark Ring",ring2="Defending Ring",
        back="Umbra Cape",waist="Klouskap Sash",legs={ name="Taeon Tights", augments={'Accuracy+17','"Triple Atk."+2','Crit. hit damage +3%',}},feet="Herculean Boots"}]]--
    
	------------------------------------------------------------------------------
    -- When Pet is Engaged this what will be Equiped for armor while your weapons are Drawn.
    ------------------------------------------------------------------------------
    
	sets.engaged.PetEngaged = 											{ammo="Automat. Oil +3",
																		head=gear.PUPRelic.Head,
																		body=gear.PUPAF.Body,
																		hands=gear.PUPRelic.Hands,			
																		legs=gear.PUPEmpy.Legs,
																		feet="Punchinellos",
																		neck="Shulmanu Collar",
																		waist="Klouskap Sash",	
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",	
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",								
																		back=gear.Visucius.PetHaste,}
         
    sets.engaged.PetEngaged.PetDT =										{ammo ="Automat. Oil +3",
																		head=gear.RaoPetDT.Feet,
																		body=gear.RaoPetDT.Feet,
																		hands=gear.RaoPetDT.Hands,
																		legs=gear.RaoPetDT.Legs,
																		feet=gear.RaoPetDT.Feet,
																		neck="Empath Necklace",
																		waist="Isa Belt",
																		left_ear="Handler's Earring +1",
																		right_ear="Enmerker Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back=gear.Visucius.PetRegen,}
         
    sets.engaged.PetEngaged.Ranged =									{ammo ="Automat. Oil +3",
																		head=gear.PUPEmpy.Head,
																		body=gear.PUPRelic.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.Naga.Legs,
																		feet="Punchinellos",
																		neck="Empath Necklace",
																		waist="Klouskap Sash",
																		left_ear="Charivari Earring",
																		right_ear="Rimeice Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back=gear.Visucius.PetHaste,}
 
    sets.engaged.PetEngaged.Nuke = 										{ammo="Automat. Oil +3",
																		head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",	
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back="Argocham. Mantle",}	
 
    sets.engaged.PetEngaged.Heal = 										{ammo="Automat. Oil +3",
																		head=gear.Naga.Head,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.Naga.Feet,
																		neck="Adad Amulet",	
																		waist="Incarnation Sash",
																		left_ear="Handler's Earring +1",
																		right_ear="Odnowa Earring +1",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back="Refraction Cape",}
     
    sets.engaged.PetEngaged.Magic = 									{ammo="Automat. Oil +3",
																		head=gear.Herc.Head.PetMacc,
																		body=gear.PUPAF.Body,
																		hands=gear.Naga.Hands.PetMacc,
																		legs=gear.PUPRelic.Legs,
																		feet=gear.PUPRelic.Feet,
																		neck="Adad Amulet",	
																		waist="Incarnation Sash",
																		left_ear="Charivari Earring",
																		right_ear="Enmerker Earring",
																		left_ring="Varar Ring +1",
																		right_ring="Thurandaut Ring",
																		back="Refraction Cape",}
end
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when pet is about to perform an action
function job_pet_midcast(spell, action, spellMap, eventArgs)
    if petWeaponskills:contains(spell.english) then
        classes.CustomClass = "Weaponskill"
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------
 
-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    if buff == 'Wind Maneuver' then
        handle_equipping_gear(player.status)
    end
end
 
-- Called when a player gains or loses a pet.
-- pet == pet gained or lost
-- gain == true if the pet was gained, false if it was lost.
function job_pet_change(pet, gain)
    update_pet_mode()
end
 
-- Called when the pet's status changes.
function job_pet_status_change(newStatus, oldStatus)
    if newStatus == 'Engaged' then
        display_pet_status()
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------
 
-- Called by the 'update' self-command, for common needs.
-- Set eventArgs.handled to true if we don't want automatic equipping of gear.
function job_update(cmdParams, eventArgs)
    update_pet_mode()
end
 
 
-- Set eventArgs.handled to true if we don't want the automatic display to be run.
function display_current_job_state(eventArgs)
    display_pet_status()
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- User self-commands.
-------------------------------------------------------------------------------------------------------------------
 
-- Called for custom player commands.
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1] == 'maneuver' then
        if pet.isvalid then
            local man = defaultManeuvers[state.PetMode.value]
            if man and tonumber(cmdParams[2]) then
                man = man[tonumber(cmdParams[2])]
            end
 
            if man then
                send_command('input /pet "'..man..'" <me>')
            end
        else
            add_to_chat(123,'No valid pet.')
        end
    end
end
 
 
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
 
-- Get the pet mode value based on the equipped head of the automaton.
-- Returns nil if pet is not valid.
function get_pet_mode()
    if pet.isvalid then
        return petModes[pet.head] or 'None'
    else
        return 'None'
    end
end
 
-- Update state.PetMode, as well as functions that use it for set determination.
function update_pet_mode()
    state.PetMode:set(get_pet_mode())
    update_custom_groups()
end
 
-- Change PetDT to use Pet:Enmity+ gear for tanking
-- function 
 
-- Update custom groups based on the current pet.
function update_custom_groups()
    classes.CustomIdleGroups:clear()
    if pet.isvalid then
        classes.CustomIdleGroups:append(state.PetMode.value)
    end
end
 
-- Engage updates
 
function job_handle_equipping_gear(playerStatus, eventArgs)
    classes.CustomMeleeGroups:clear()
    if pet.status=="Engaged" then
        classes.CustomMeleeGroups:append('PetEngaged')
        classes.CustomMeleeGroups:append(state.PetMode.value)
    end
end
 
-- Display current pet status.
function display_pet_status()
    if pet.isvalid then
        local petInfoString = pet.name..' ['..pet.head..']: '..tostring(pet.status)..'  TP='..tostring(pet.tp)..'  HP%='..tostring(pet.hpp)
         
        if magicPetModes:contains(state.PetMode.value) then
            petInfoString = petInfoString..'  MP%='..tostring(pet.mpp)
        end
         
        add_to_chat(122,petInfoString)
    end
end
 
-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 18)
    elseif player.sub_job == 'THF' then
        set_macro_page(1, 18)
    else
        set_macro_page(1, 18)
    end
end
