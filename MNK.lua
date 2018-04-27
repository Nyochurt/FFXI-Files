-------------------------------------------------------------------------------------------------------------------
-- Setup functions for this job.  Generally should not be modified.
-------------------------------------------------------------------------------------------------------------------

-- Initialization function for this job file.
function get_sets()
    mote_include_version = 2
    
    -- Load and initialize the include file.
    include('Mote-Include.lua')
	include('Sel-Stahp.lua')
	--include('gearfilewip.lua')
end


-- Setup vars that are user-independent.  state.Buff vars initialized here will automatically be tracked.
function job_setup()
    state.Buff.Footwork = buffactive.Footwork or false
    state.Buff.Impetus = buffactive.Impetus or false

    state.FootworkWS = M(false, 'Footwork on WS')

    info.impetus_hit_count = 0
    windower.raw_register_event('action', on_action_for_impetus)
end


-------------------------------------------------------------------------------------------------------------------
-- User setup functions for this job.  Recommend that these be overridden in a sidecar file.
-------------------------------------------------------------------------------------------------------------------

-- Setup vars that are user-dependent.  Can override this function in a sidecar file.
function user_setup()
    state.OffenseMode:options('Normal', 'MA', 'SomeAcc', 'Acc', 'AccPDT', 'PDT', 'DW', 'DWAcc', 'DWAccPDT', 'PDT', 'Staff', 'StaffAcc', 'StaffAccPDT', 'PDT')
    state.WeaponskillMode:options('Normal', 'SomeAcc', 'Acc', 'Fodder')
    state.HybridMode:options('Normal', 'PDT', 'Counter')
    state.PhysicalDefenseMode:options('PDT', 'HP')
	state.IdleMode:options('Normal', 'Regen', 'PDT')
	
	
--------------------------------------------------------------------------------------------------------------------
-- Augmented and Abbreviated gear	
--------------------------------------------------------------------------------------------------------------------
		-- Amby Cape
		gear.Segomo = {}
		gear.Segomo.TP =				{name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+5','"Dbl.Atk."+10',}}
		gear.Segomo.ACC =				{name="Segomo's Mantle", augments={'DEX+20','Accuracy+20 Attack+20','Crit.hit rate+10',}}
		gear.Segomo.WSD =				{name="Segomo's Mantle", augments={'STR+20','Accuracy+20 Attack+20','Weapon skill damage +10%',}}
		
		-- Adhemar
		gear.Adhemar = {}
		gear.Adhemar.Head =				{name="Adhemar Bonnet", augments={'DEX+10','AGI+10','Accuracy+15',}}
		gear.Adhemar.Legs = 			{name="Adhemar Kecks", augments={'DEX+10','AGI+10','Accuracy+15',}}
		
		-- Herculean --
		gear.Herc = {}
		gear.Herc.Head = {name="Herculean Helm", augments={'Accuracy+17 Attack+17','Weapon skill damage +1%','STR+4','Accuracy+15',}}
		gear.Herc.Body = {name="Herculean Vest", augments={'Pet: Attack+28 Pet: Rng.Atk.+28','MND+1','Weapon skill damage +1%','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
		gear.Herc.Hands = {name="Herculean Gloves", augments={'Accuracy+13','Mag. Acc.+6 "Mag.Atk.Bns."+6','Accuracy+20 Attack+20',}}
		gear.Herc.Legs = {name="Herculean Trousers", augments={'Phys. dmg. taken -5%',}}
		gear.Herc.Feet = {name="Herculean Boots", augments={'INT+6','Pet: Attack+12 Pet: Rng.Atk.+12','Damage taken-2%','Accuracy+13 Attack+13','Mag. Acc.+20 "Mag.Atk.Bns."+20',}}
		
		gear.Herc.Head.PetMacc = {name="Herculean Helm", augments={'Pet: Mag. Acc.+30','Pet: "Store TP"+7','Pet: INT+8','Pet: "Mag.Atk.Bns."+12',}}
		gear.Herc.Legs.Acc = {name="Herculean Trousers", augments={'"Dual Wield"+3','DEX+12','Accuracy+12','Attack+15',}}
		gear.Herc.Legs.Acc2 = {name="Herculean Trousers", augments={'Accuracy+23 Attack+23','Crit.hit rate+1','Accuracy+12',}}
		gear.Herc.Legs.PetDT = {name="Herculean Trousers", augments={'Pet: Phys. dmg. taken -3%','Pet: Attack+6 Pet: Rng.Atk.+6',}}
		gear.Herc.Body.Acc = {name="Herculean Vest", augments={'Accuracy+23 Attack+23','Weapon skill damage +2%','STR+5','Accuracy+15',}}
		gear.Herc.Body.WSD = {name="Herculean Vest", augments={'Weapon skill damage +5%','Accuracy+15',}}
		
		-- Hizamaru --
		gear.Hiza = {}
		gear.Hiza.Head = {name="Hizamaru Somen +2"}
		gear.Hiza.Body = {name="Hiza. Haramaki +2"}
		gear.Hiza.Hands = {name="Hizamaru Kote +1"}
		gear.Hiza.Legs = {name="Hiza. Hizayoroi +2"}
		gear.Hiza.Feet = {name="Hiza. Sune-Ate +2"}
		-- Mummu --
		gear.Mummu = {}
		gear.Mummu.Head					= {name="Mummu Bonnet +1"}
		gear.Mummu.Body					= {name="Mummu Jacket +1"}
		gear.Mummu.Hands				= {name="Mummu Wrists +1"}
		gear.Mummu.Legs					= {name="Mummu Kecks +1"}
		gear.Mummu.Feet					= {name="Mummu Gamash. +1"}
	
		-- Naga --
		gear.Naga = {}
		gear.Naga.Head = {name="Naga Somen", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Body = {name="Naga Samue", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Hands = {name="Naga Tekko", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Legs = {name="Naga Hakama", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}
		gear.Naga.Feet = {name="Naga Kyahan", augments={'Pet: MP+80','Automaton: "Fast Cast"+4','System: 2 ID: 157 Val: 2',}}

		gear.Naga.Body.WS = {name="Naga Samue", augments={'HP+80','DEX+10','Attack+20',}}
		gear.Naga.Hands.PetMacc = {name="Naga Tekko", augments={'Pet: MP+80','Pet: Mag. Acc.+20','Pet: "Mag.Atk.Bns."+20',}}
		gear.Naga.Legs.A				= {name="Naga Hakama", augments={'STR+10','Accuracy+15','"Subtle Blow"+7',}}
		gear.Naga.Feet.PetMelee = {name="Naga Kyahan", augments={'Pet: HP+100','Pet: Accuracy+25','Pet: Attack+25',}}

		
		-- Rao --
		gear.RaoPetDT = {}
		gear.RaoPetDT.Head = {name="Rao Kabuto", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Body = {name="Rao Togi", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Hands = {name="Rao Kote", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Legs = {name="Rao Haidate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}
		gear.RaoPetDT.Feet = {name="Rao Sune-Ate", augments={'Pet: HP+100','Pet: Accuracy+15','Pet: Damage taken -3%',}}

		gear.RaoMaster = {}
		gear.RaoMaster.Head = {name="Rao Kabuto", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Body = {name="Rao Togi", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Hands = {name="Rao Kote", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Legs = {name="Rao Haidate", augments={'STR+10','DEX+10','Attack+15',}}
		gear.RaoMaster.Feet = {name="Rao Sune-Ate", augments={'STR+10','DEX+10','Attack+15',}}
		
		
		-- Rawhide --
		gear.Rawhide = {}
		gear.Rawhide.Body = {name="Rawhide Vest", augments={'HP+50','"Subtle Blow"+7','"Triple Atk."+2',}}
		gear.Rawhide.Legs = {name="Rawhide Trousers", augments={'MP+50','"Fast Cast"+5','"Refresh"+1',}}

		-- Ryuo --
		gear.Ryuo = {}
		gear.Ryuo.Head = {name="Ryuo Somen", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Body = {name="Ryuo Domaru", augments={'STR+10','DEX+10','Accuracy+15',}}
		gear.Ryuo.Hands = {name="Ryuo Tekko", augments={'DEX+10','Accuracy+20','"Dbl.Atk."+3',}}
		gear.Ryuo.Legs = {name="Ryuo Hakama", augments={'Accuracy+20','"Store TP"+4','Phys. dmg. taken -3',}}
		gear.Ryuo.Feet = {name="Ryuo Sune-Ate", augments={'STR+10','Attack+20','Crit. hit rate+3%',}}
		
		-- Miscellaneous --
		gear.Samnuha = {}
		gear.Samnuha.Legs = 			{name="Samnuha Tights", augments={'STR+10','DEX+10','"Dbl.Atk."+3','"Triple Atk."+3',}}	
		gear.Samnuha.Body =				{name="Samnuha Coat", augments={'Mag. Acc.+14','"Mag.Atk.Bns."+13','"Fast Cast"+4','"Dual Wield"+3',}}
		
		gear.Tam = {}
		gear.Tam = 						{name="Dampening Tam", augments={'DEX+9','Accuracy+13','Mag. Acc.+14','Quadruple Attack +2',}}
		
    update_combat_form()
    update_melee_groups()

    select_default_macro_book()
end


-- Define sets and vars used by this job file.
function init_gear_sets()
    --------------------------------------
    -- Start defining the sets
    --------------------------------------
    
    -- Precast Sets
    
    -- Precast sets to enhance JAs on use
    sets.precast.JA['Hundred Fists'] = 									{legs="Hesychast's Hose +1"}
    sets.precast.JA['Boost'] = 											{hands="Anchorite's Gloves +1"}
    sets.precast.JA['Dodge'] = 											{feet="Anchorite's Gaiters +1"}
    sets.precast.JA['Focus'] = 											{head="Anchorite's Crown +1"}
    sets.precast.JA['Counterstance'] = 									{feet="Hesychast's Gaiters +1"}
    sets.precast.JA['Footwork'] = 										{feet="Bhikku Gaiters +1"}
    sets.precast.JA['Formless Strikes'] = 								{body="Hesychast's Cyclas +1"}
    sets.precast.JA['Mantra'] = 										{feet="Hesychast's Gaiters +1"}

	-- MND (Affected by Boost)
    sets.precast.JA['Chi Blast'] = 										{ammo="Amar Cluster",
																		head=gear.Tam,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs="Jokushu Haidate",
																		feet="Shukuyu Sune-Ate",
																		neck="Weike Torque",
																		waist="Luminary Sash",
																		left_ear="Odnowa Earring +1",
																		right_ear="Digni. Earring",
																		left_ring="Stikini Ring",
																		right_ring="Metamor. Ring +1",
																		back="Grounded Mantle",}

	-- Cure for 2x VIT (Removes Blind & Poison) - AF Body 3x VIT - AF Body + Relic Hands = 3.6x VIT
    sets.precast.JA['Chakra'] = 										{ammo="Iron Gobbet",
																		head="Genmei Kabuto",
																		body="Reiki Osode",
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Unmoving Collar",
																		waist="Eschan Stone",
																		left_ear="Odnowa Earring +1",
																		right_ear="Handler's Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",																		
																		back="Xucau Mantle",}
										
    -- Waltz set (chr and vit)
    sets.precast.Waltz = 												{ammo="Brigantia Pebble",
																		head="Genmei Kabuto",
																		body="Reiki Osode",
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Unmoving Collar",
																		waist="Black Belt",
																		left_ear="Handler's Earring +1",
																		right_ear="Handler's Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back="Tantalic Cape",}
        
    -- Don't need any special gear for Healing Waltz.
    sets.precast.Waltz['Healing Waltz'] = {}

	--Steps - Acc
    sets.precast.Step = 												{ammo="Falcon Eye",
																		head=gear.Hiza.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Subtlety Spec.",
																		waist="Eschan Stone",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Segomo.ACC,}
   
   sets.precast.Flourish1 = 											sets.precast.Step

    -- Fast cast sets for spells
    sets.precast.FC = 													{ammo="Sapience Orb",
																		head=gear.Herc.Head,
																		body=gear.Samnuha.Coat,
																		hands=gear.Leyline,
																		legs=gear.Rawhide.Legs,
																		feet=gear.Herc.Feet,
																		neck="Voltsurge Torque",
																		waist="Cetl Belt",
																		left_ear="Etiolation Earring",
																		right_ear="Loquac. Earring",}

    sets.precast.FC.Utsusemi = 											sets.precast.FC
	
    -- Weaponskill sets
    -- Default set for any weaponskill that isn't any more specifically defined
    sets.precast.WS = 													{}
																		
    sets.precast.WSAcc = 												{head="Sukeroku Hachi.",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		back="Vespid Mantle",}
																		
    sets.precast.WSMod = 												{}
																		
    sets.precast.MaxTP = 												{ear1="Bladeborn Earring",
																		ear2="Steelflash Earring"}
																		
    sets.precast.WS.Acc = 												set_combine(sets.precast.WS, sets.precast.WSAcc)
	
    sets.precast.WS.Mod = 												set_combine(sets.precast.WS, sets.precast.WSMod)

   
   -- Specific weaponskill sets.   
    ---------------
	   -- H2H --
	---------------
	
	-- Combo - STR/VIT
	sets.precast.WS["Combo"] = 											{ammo="Knobkierrie",
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
																		back=gear.Segomo.WSD,}
	-- Shoulder Tackle - VIT
	sets.precast.WS["Shoulder Tackle"] =								{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back="Tantalic Cape"}
	-- 1" Punch - VIT-
	sets.precast.WS["One Inch Punch"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.Hiza.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back="Tantalic Cape"}
	-- Backhand Blow - STR/DEX
	sets.precast.WS["Backhand Blow"] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Raging Fists - STR/DEX
	sets.precast.WS["Raging Fists"] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Spinning Attack - STR
	sets.precast.WS["Spinning Attack"] =								{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Howling Fist - DEX/STR
	sets.precast.WS["Howling Fist"] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Dragon Kick - STR/DEX
	sets.precast.WS["Dragon Kick"] =									{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body="Reiki Osode",																		
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Asuran Fists - STR/VIT
	sets.precast.WS["Asuran Fists"] = 									{ammo="Knobkierrie",
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
																		back=gear.Segomo.WSD,}
	-- Tornado Kick - STR/VIT
	sets.precast.WS["Tornado Kick"] = 									{ammo="Knobkierrie",
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
																		back=gear.Segomo.WSD,}
	-- Shijin Spiral - DEX
    sets.precast.WS["Shijin Spiral"] = 									{ammo="Knobkierrie",
																		head=gear.Herc.Head,
																		body=gear.Mummu.Body,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Dominance Earring",
																		right_ear="Pixie Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Victory Smite - STR
    sets.precast.WS["Victory Smite"] = 									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	-- Ascetic's Fury - STR/VIT
	sets.precast.WS["Ascetic's Fury"] = 								{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.RaoMaster.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Genmei Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}

    sets.precast.WS["Raging Fists"].Acc = 								set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSAcc)
    sets.precast.WS["Howling Fist"].Acc = 								set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSAcc)
    sets.precast.WS["Asuran Fists"].Acc = 								set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSAcc)
    sets.precast.WS["Ascetic's Fury"].Acc = 							set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSAcc)
    sets.precast.WS["Victory Smite"].Acc = 								set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSAcc)
    sets.precast.WS["Shijin Spiral"].Acc = 								set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSAcc)
    sets.precast.WS["Dragon Kick"].Acc = 								set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSAcc)
    sets.precast.WS["Tornado Kick"].Acc = 								set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSAcc)

    sets.precast.WS["Raging Fists"].Mod = 								set_combine(sets.precast.WS["Raging Fists"], sets.precast.WSMod)
    sets.precast.WS["Howling Fist"].Mod = 								set_combine(sets.precast.WS["Howling Fist"], sets.precast.WSMod)
    sets.precast.WS["Asuran Fists"].Mod = 								set_combine(sets.precast.WS["Asuran Fists"], sets.precast.WSMod)
    sets.precast.WS["Ascetic's Fury"].Mod = 							set_combine(sets.precast.WS["Ascetic's Fury"], sets.precast.WSMod)
    sets.precast.WS["Victory Smite"].Mod = 								set_combine(sets.precast.WS["Victory Smite"], sets.precast.WSMod)
    sets.precast.WS["Shijin Spiral"].Mod = 								set_combine(sets.precast.WS["Shijin Spiral"], sets.precast.WSMod)
    sets.precast.WS["Dragon Kick"].Mod = 								set_combine(sets.precast.WS["Dragon Kick"], sets.precast.WSMod)
    sets.precast.WS["Tornado Kick"].Mod = 								set_combine(sets.precast.WS["Tornado Kick"], sets.precast.WSMod)

	---------------
	  -- Clubs --
	---------------	
	
	-- Shining Strike - STR/MND
	sets.precast.WS["Shining Strike"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}

	-- Seraph Strike - STR/MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Seraph Strike"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}
	
	-- Brainshaker - STR
	sets.precast.WS["Brainshaker"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}	
	
	-- Starlight - Skill
	sets.precast.WS["Starlight"] =										{}
	
	-- Moonlight - Skill (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Moonlight"] =										{}

	-- Skullbreaker - STR
	sets.precast.WS["Skullbreaker"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}

	-- True Strike - STR
	sets.precast.WS["True Strike"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",																		
																		back=gear.Segomo.TP,}

	-- Judgement - STR/MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Judgement"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}

	-- Black Halo - 30% STR/MND 70%
	sets.precast.WS["Black Halo"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Flash Nova - STR/MND
	sets.precast.WS["Flash Nova"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
--[[	-- Realmrazer - MND 73% / 76% / 79% / 82% / 85%
	sets.precast.WS["Realmrazer"] =										{ammo="Knobkierrie",
																		head="Sukeroku Hachi.",
																		body=gear.Herc.Body.WSD,
																		hands=gear.Ryuo.Hands,
																		legs=gear.RaoMaster.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Rufescent Ring",
																		right_ring="Metamor. Ring +1",
																		back="Vespid Mantle",}
]]--
	---------------
	  -- Staff --
	---------------
	
	-- Heavy Swing - STR
	sets.precast.WS["Heavy Swing"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}
	-- Rock Crusher - STR/INT
	sets.precast.WS["Rock Crusher"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}

	-- Earth Crusher - STR/INT
	sets.precast.WS["Earth Crusher"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Starburst - STR/MND
	sets.precast.WS["Starburst"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Rufescent Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Sunburst - STR/MND
	sets.precast.WS["Sunburst"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Rufescent Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Shell Crusher - STR
	sets.precast.WS["Earth Crusher"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Full Swing - STR
	sets.precast.WS["Full Swing"] =										{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body="Reiki Osode",
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Ryuo.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}

	-- Spirit Taker - INT/MND
	sets.precast.WS["Spirit Taker"] =									{ammo="Knobkierrie",
																		head="Sukeroku Hachi.",
																		body=gear.Herc.Body.WSD,
																		hands=gear.Ryuo.Hands,
																		legs=gear.RaoMaster.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Rufescent Ring",
																		right_ring="Metamor. Ring +1",
																		back="Vespid Mantle",}
	
	-- Retribution - 30% STR/MND 50%
	sets.precast.WS["Retribution"] =									{ammo="Knobkierrie",
																		head=gear.RaoMaster.Head,
																		body=gear.Herc.Body.WSD,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.Hiza.Legs,
																		feet="Shukuyu Sune-Ate",
																		neck="Fotia Gorget",
																		waist="Fotia Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Rufescent Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.WSD,}
	
	-- Cataclysm STR/INT 30%
    sets.precast.WS['Cataclysm'] = 										{ammo="Knobkierrie",
																		head="Pixie Hairpin +1",
																		body="Reiki Osode",
																		hands=gear.Leyline,
																		legs=gear.Hiza.Legs,
																		feet=gear.Herc.Feet,
																		neck="Sanctity Necklace",
																		waist="Eschan Stone",
																		left_ear="Friomisi Earring",
																		right_ear="Crematio Earring",
																		left_ring="Shiva Ring",
																		right_ring="Regal Ring",
																		back="Toro Cape",}
------------------------------------------------------------------------------------------------------    
    -- Midcast Sets
    sets.midcast.FastRecast = 											sets.precast.FC
        
    -- Specific spells
    sets.midcast.Utsusemi = 											sets.precast.FC

    -- Sets to return to when not performing an action.    
    -- Resting sets
    sets.resting = 														{head=gear.RaoMaster.Head,
																		body=gear.Hiza.Body,
																		hands=gear.RaoMaster.Hands,
																		legs=gear.RaoMaster.Legs,
																		feet=gear.RaoMaster.Feet,
																		neck="Sanctity Necklace",
																		waist="Moonbow Belt",
																		left_ear="Infused Earring",	
																		right_ear="Odnowa Earring +1",
																		left_ring="Patricius Ring",	
																		right_ring="Defending Ring",
																		back="Moonbeam Cape",}
    
    -- Idle sets
	sets.idle =															sets.resting
    sets.idle.Regen = 													sets.resting
	
	sets.idle.PDT = 													{head="Genmei Kabuto",
																		body="Emet Harness +1",
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

    --[[sets.idle.Town = {ammo="Thew Bomblet",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Sheltered Ring",ring2="Paguroidea Ring",
        back="Atheling Mantle",waist="Black Belt",legs="Qaaxo Tights",feet="Herald's Gaiters"}]]--
    
    --[[sets.idle.Weak = {ammo="Thew Bomblet",
        head="Felistris Mask",neck="Wiglen Gorget",ear1="Brutal Earring",ear2="Bloodgem Earring",
        body="Hesychast's Cyclas",hands="Hesychast's Gloves +1",ring1="Sheltered Ring",ring2="Meridian Ring",
        back="Iximulew Cape",waist="Black Belt",legs="Qaaxo Tights",feet="Herald's Gaiters"}]]--
    
    -- Defense sets
    sets.defense.PDT = 													{head="Genmei Kabuto",
																		body="Emet Harness +1",
																		hands="Kurys Gloves",
																		legs=gear.Herc.Legs,
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Infused Earring",
																		right_ear="Genmei Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back="Moonbeam Cape",}

    sets.defense.HP = 													{ammo="Amar Cluster",
																		head="Genmei Kabuto",
																		body=gear.Naga.Body.WS,
																		hands=gear.Naga.Hands,
																		legs=gear.Naga.Legs.A,
																		feet=gear.Naga.Feet,
																		neck="Sanctity Necklace",
																		waist="Eschan Stone",
																		left_ear="Odnowa Earring",
																		right_ear="Odnawa Earring +1",
																		left_ring="Etana Ring",
																		right_ring="Adoulin Ring",
																		back="Moonbeam Cape",}

    sets.defense.MDT = 													{head=gear.Naga.Head,
																		body=gear.Hiza.Body,
																		hands="Kurys Gloves",
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Etiolation Earring",
																		right_ear="Odnowa Earring +1",
																		left_ring="Yacuruna Ring",
																		right_ring="Defending Ring",
																		back="Reiki Cloak",}

    sets.Kiting = 														{feet="Herald's Gaiters"}

    sets.ExtraRegen = {}

    -- Engaged sets

    -- Variations for TP weapon and (optional) offense/defense modes.  Code will fall back on previous
    -- sets if more refined versions aren't defined.
    -- If you create a set with both offense and defense modes, the offense mode should be first.
    -- EG: sets.engaged.Dagger.Accuracy.Evasion
    
    -- Normal melee sets
    sets.engaged = 														{    ammo="Amar Cluster",
    head=gear.Adhemar.Head,
    body="Ken. Samue",
    hands=gear.Herc.Hands,
    legs=gear.Samnuha.Legs,
    feet=gear.Herc.Feet,
    neck="Clotharius Torque",
    waist="Moonbow Belt",
    left_ear="Sherida Earring",
    right_ear="Brutal Earring",
    left_ring="Hetairoi Ring",
    right_ring="Niqmaddu Ring",
    back=gear.Segomo.TP,}
	
	sets.engaged.MA =													{ammo="Falcon Eye",
																		head=gear.Hiza.Head,
																		body="Bhikku Cyclas +1",
																		hands=gear.Mummu.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Herc.Feet,
																		neck="Clotharius Torque",
																		waist="Moonbow Belt",
																		left_ear="Mache Earring",
																		right_ear="Mache Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}
																		
    sets.engaged.SomeAcc = 												{ammo="Amar Cluster",
																		head="Blistering Sallet +1",
																		body="Mummu Jacket +1",
																		hands=gear.Ryuo.Hands,
																		legs=gear.Ryuo.Legs,
																		feet=gear.Herc.Feet,
																		neck="Sanctity Necklace",
																		waist="Moonbow Belt",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}
																		
    sets.engaged.Acc = 													{ammo="Falcon Eye",
																		head=gear.Hiza.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.Ryuo.Hands,
																		legs=gear.Hiza.Legs,
																		feet=gear.Hiza.Feet,
																		neck="Subtlety Spec.",
																		waist="Eschan Stone",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Segomo.ACC,}

	sets.engaged.AccPDT =												{ammo="Falcon Eye",
																		head="Genmei Kabuto",
																		body=gear.Ryuo.Body,
																		hands=gear.Herc.Hands,
																		legs=gear.Herc.Legs,
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Defending Ring",
																		back="Xucau Mantle",}

    sets.engaged.PDT = 													{head="Genmei Kabuto",
																		body="Emet Harness +1",
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
																		
	sets.engaged.DW = 													{ammo="Knobkierrie",
																		head=gear.Ryuo.Head,
																		body=gear.Samnuha.Body,
																		hands="Mummu Wrists +1",
																		legs=gear.Herc.Legs.Acc,
																		feet=gear.Hiza.Feet,
																		neck="Clotharius Torque",
																		waist="Moonbow Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}

	sets.engaged.DWAcc = 												{ammo="Falcon Eye",
																		head=gear.Ryuo.Head,
																		body=gear.Samnuha.Body,
																		hands="Mummu Wrists +1",
																		legs=gear.Herc.Legs.Acc,
																		feet=gear.Hiza.Feet,
																		neck="Sanctity Necklace",
																		waist="Eschan Stone",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Segomo.ACC,}

	sets.engaged.DWAccPDT = 											{ammo="Falcon Eye",
																		head=gear.Ryuo.Head,
																		body=gear.Samnuha.Body,
																		hands=gear.Herc.Hands,
																		legs=gear.Herc.Legs.Acc,
																		feet=gear.Hiza.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Patricius Ring",
																		right_ring="Defending Ring",
																		back="Xucau Mantle",}																		
    
	sets.engaged.Staff = 												{ammo="Falcon Eye",
																		head="Mummu Bonnet +1",
																		body=gear.Herc.Body.Acc,
																		hands=gear.Herc.Hands,
																		legs=gear.Herc.Legs.Acc2,
																		feet="Mummu Gamash. +1",
																		neck="Clotharius Torque",
																		waist="Moonbow Belt",
																		left_ear="Sherida Earring",
																		right_ear="Brutal Earring",
																		left_ring="Niqmaddu Ring",
																		right_ring="Regal Ring",
																		back=gear.Segomo.TP,}

	sets.engaged.StaffAcc = 											{ammo="Falcon Eye",
																		head=gear.Herc.Head,
																		body=gear.Herc.Body.Acc,
																		hands=gear.Ryuo.Hands,
																		legs="Mummu Kecks +1",
																		feet="Mummu Gamash. +1",
																		neck="Sanctity Necklace",
																		waist="Eschan Stone",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Cacoethic Ring",
																		back=gear.Segomo.ACC,}

	sets.engaged.StaffAccPDT = 											{ammo="Falcon Eye",
																		head="Genmei Kabuto",
																		body=gear.Ryuo.Body,
																		hands=gear.Herc.Hands,
																		legs=gear.Herc.Legs,
																		feet=gear.Herc.Feet,
																		neck="Loricate Torque +1",
																		waist="Moonbow Belt",
																		left_ear="Digni. Earring",
																		right_ear="Zennaroi Earring",
																		left_ring="Cacoethic Ring +1",
																		right_ring="Defending Ring",
																		back="Xucau Mantle",}
	sets.engaged.Mod = {}

    -- Defensive melee hybrid sets
    sets.engaged.PDT = {ammo="Thew Bomblet",
        head="Uk'uxkaj Cap",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Iximulew Cape",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Otronif Boots +1"}
    sets.engaged.SomeAcc.PDT = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Anguinus Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
    sets.engaged.Acc.PDT = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Twilight Torque",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Qaaxo Tights",feet="Qaaxo Leggings"}
    sets.engaged.Counter = {ammo="Thew Bomblet",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Otronif Gloves",ring1="K'ayres Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}
    sets.engaged.Acc.Counter = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Ej Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Patricius Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Anchorite's Hose",feet="Otronif Boots +1"}


    -- Hundred Fists/Impetus melee set mods
    sets.engaged.HF = 													set_combine(sets.engaged)
    sets.engaged.HF.Impetus = 											set_combine(sets.engaged, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.HF = 												set_combine(sets.engaged.Acc)
    sets.engaged.Acc.HF.Impetus = 										set_combine(sets.engaged.Acc, {body="Bhikku Cyclas +1"})
    sets.engaged.Counter.HF = 											set_combine(sets.engaged.Counter)
    sets.engaged.Counter.HF.Impetus = 									set_combine(sets.engaged.Counter, {body="Bhikku Cyclas +1"})
    sets.engaged.Acc.Counter.HF = 										set_combine(sets.engaged.Acc.Counter)
    sets.engaged.Acc.Counter.HF.Impetus = 								set_combine(sets.engaged.Acc.Counter, {body="Bhikku Cyclas +1"})


    --[[ Footwork combat form
    sets.engaged.Footwork = 											{ammo="Thew Bomblet",
        head="Felistris Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Qaaxo Harness",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Atheling Mantle",waist="Windbuffet Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}
    sets.engaged.Footwork.Acc = {ammo="Honed Tathlum",
        head="Whirlpool Mask",neck="Asperity Necklace",ear1="Bladeborn Earring",ear2="Steelflash Earring",
        body="Otronif Harness +1",hands="Hesychast's Gloves +1",ring1="Rajas Ring",ring2="Epona's Ring",
        back="Letalis Mantle",waist="Anguinus Belt",legs="Hesychast's Hose +1",feet="Anchorite's Gaiters +1"}]]
        
    -- Quick sets for post-precast adjustments, listed here so that the gear can be Validated.
    sets.impetus_body = {body="Bhikku Cyclas +1"}
    sets.footwork_kick_feet = {feet="Shukuyu sune-ate"}
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for standard casting events.
-------------------------------------------------------------------------------------------------------------------

-- Set eventArgs.handled to true if we don't want any automatic gear equipping to be done.
-- Set eventArgs.useMidcastGear to true if we want midcast gear equipped on precast.
function job_precast(spell, action, spellMap, eventArgs)
    -- Don't gearswap for weaponskills when Defense is on.
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        eventArgs.handled = true
    end
end

-- Run after the general precast() is done.
function job_post_precast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and state.DefenseMode.current ~= 'None' then
        if state.Buff.Impetus and (spell.english == "Ascetic's Fury" or spell.english == "Victory Smite") then
            -- Need 6 hits at capped dDex, or 9 hits if dDex is uncapped, for Tantra to tie or win.
            if (state.OffenseMode.current == 'Fodder' and info.impetus_hit_count > 5) or (info.impetus_hit_count > 8) then
                equip(sets.impetus_body)
            end
        elseif state.Buff.Footwork and (spell.english == "Dragon's Kick" or spell.english == "Tornado Kick") then
            equip(sets.footwork_kick_feet)
        end
        
        -- Replace Moonshade Earring if we're at cap TP
        if player.tp == 3000 then
            equip(sets.precast.MaxTP)
        end
    end
end

function job_aftercast(spell, action, spellMap, eventArgs)
    if spell.type == 'WeaponSkill' and not spell.interrupted and state.FootworkWS and state.Buff.Footwork then
        send_command('cancel Footwork')
    end
end

-------------------------------------------------------------------------------------------------------------------
-- Job-specific hooks for non-casting events.
-------------------------------------------------------------------------------------------------------------------

-- Called when a player gains or loses a buff.
-- buff == buff gained or lost
-- gain == true if the buff was gained, false if it was lost.
function job_buff_change(buff, gain)
    -- Set Footwork as combat form any time it's active and Hundred Fists is not.
    if buff == 'Footwork' and gain and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    elseif buff == "Hundred Fists" and not gain and buffactive.footwork then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
    
    -- Hundred Fists and Impetus modify the custom melee groups
    if buff == "Hundred Fists" or buff == "Impetus" then
        classes.CustomMeleeGroups:clear()
        
        if (buff == "Hundred Fists" and gain) or buffactive['hundred fists'] then
            classes.CustomMeleeGroups:append('HF')
        end
        
        if (buff == "Impetus" and gain) or buffactive.impetus then
            classes.CustomMeleeGroups:append('Impetus')
        end
    end

    -- Update gear if any of the above changed
    if buff == "Hundred Fists" or buff == "Impetus" or buff == "Footwork" then
        handle_equipping_gear(player.status)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- User code that supplements standard library decisions.
-------------------------------------------------------------------------------------------------------------------

function customize_idle_set(idleSet)
    if player.hpp < 75 then
        idleSet = set_combine(idleSet, sets.ExtraRegen)
    end
    
    return idleSet
end

-- Called by the 'update' self-command.
function job_update(cmdParams, eventArgs)
    update_combat_form()
    update_melee_groups()
end


-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------

function update_combat_form()
    if buffactive.footwork and not buffactive['hundred fists'] then
        state.CombatForm:set('Footwork')
    else
        state.CombatForm:reset()
    end
end

function update_melee_groups()
    classes.CustomMeleeGroups:clear()
    
    if buffactive['hundred fists'] then
        classes.CustomMeleeGroups:append('HF')
    end
    
    if buffactive.impetus then
        classes.CustomMeleeGroups:append('Impetus')
    end
end


-- Select default macro book on initial load or subjob change.
function select_default_macro_book()
    -- Default macro set/book
    if player.sub_job == 'DNC' then
        set_macro_page(3, 12)
    elseif player.sub_job == 'NIN' then
        set_macro_page(5, 12)
    elseif player.sub_job == 'THF' then
        set_macro_page(7, 12)
    elseif player.sub_job == 'RUN' then
        set_macro_page(9, 12)
    else
        set_macro_page(1, 12)
    end
end


-------------------------------------------------------------------------------------------------------------------
-- Custom event hooks.
-------------------------------------------------------------------------------------------------------------------

-- Keep track of the current hit count while Impetus is up.
function on_action_for_impetus(action)
    if state.Buff.Impetus then
        -- count melee hits by player
        if action.actor_id == player.id then
            if action.category == 1 then
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- Reactions (bitset):
                        -- 1 = evade
                        -- 2 = parry
                        -- 4 = block/guard
                        -- 8 = hit
                        -- 16 = JA/weaponskill?
                        -- If action.reaction has bits 1 or 2 set, it missed or was parried. Reset count.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 1
                        end
                    end
                end
            elseif action.category == 3 then
                -- Missed weaponskill hits will reset the counter.  Can we tell?
                -- Reaction always seems to be 24 (what does this value mean? 8=hit, 16=?)
                -- Can't tell if any hits were missed, so have to assume all hit.
                -- Increment by the minimum number of weaponskill hits: 2.
                for _,target in pairs(action.targets) do
                    for _,action in pairs(target.actions) do
                        -- This will only be if the entire weaponskill missed or was parried.
                        if (action.reaction % 4) > 0 then
                            info.impetus_hit_count = 0
                        else
                            info.impetus_hit_count = info.impetus_hit_count + 2
                        end
                    end
                end
            end
        elseif action.actor_id ~= player.id and action.category == 1 then
            -- If mob hits the player, check for counters.
            for _,target in pairs(action.targets) do
                if target.id == player.id then
                    for _,action in pairs(target.actions) do
                        -- Spike effect animation:
                        -- 63 = counter
                        -- ?? = missed counter
                        if action.has_spike_effect then
                            -- spike_effect_message of 592 == missed counter
                            if action.spike_effect_message == 592 then
                                info.impetus_hit_count = 0
                            elseif action.spike_effect_animation == 63 then
                                info.impetus_hit_count = info.impetus_hit_count + 1
                            end
                        end
                    end
                end
            end
        end
        
        --add_to_chat(123,'Current Impetus hit count = ' .. tostring(info.impetus_hit_count))
    else
        info.impetus_hit_count = 0
    end
    
end