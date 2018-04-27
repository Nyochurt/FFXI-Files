--------------------------------------------------------------------------------------------------------------------
-- SETUP FUNCTIONS FOR THIS JOB.
--------------------------------------------------------------------------------------------------------------------
-- Also, you'll need the Shortcuts addon to handle the auto-targetting of the custom pact commands.
--[[
    Custom commands:
	gs c scholar light              Light Arts/Addendum
	gs c scholar dark                                       Dark Arts/Addendum
	gs c scholar cost               Penury                  Parsimony
	gs c scholar speed              Celerity                Alacrity
	gs c scholar aoe                Accession               Manifestation
	gs c scholar power              Rapture                 Ebullience
	gs c scholar duration           Perpetuance
	gs c scholar accuracy           Altruism                Focalization
	gs c scholar enmity             Tranquility             Equanimity
	gs c scholar skillchain                                 Immanence
	gs c scholar addendum           Addendum: White         Addendum: Black
	gs c skillchain [SkillChainType]
        Attempts to use the indicated skillchain type.
        SkillChainType can be one of:
            Level 1:
				Compression
				Detonation
				Impaction
				Induration
				Liquefaction
				Reverberation
				Scision
				Transfixion
			Level 2:
				Distortion
				Fragmentation
				Fusion
				Gravitation
--]]				
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
    state.Buff.Alacrity = 											buffactive.Alacrity or false
	state.Buff.Celerity = 											buffactive.Celerity or false
	state.Buff.Doom = 												buffactive.Doom or false
	state.Buff.Ebullience = 										buffactive.Ebullience or false
	state.Buff.Klimaform =											buffactive.Klimaform or false
	state.Buff.Immanence = 											buffactive.Immanence or false
    state.Buff.Perpetuance = 										buffactive.Perpetuance or false
    state.Buff.Rapture = 											buffactive.Rapture or false
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
	state.AutoSubMode = 											M(false, 'Auto Sublimation')
	----------------------------------------------------------------
	-- Magic burst on or off
	----------------------------------------------------------------
	state.BurstMode = 												M{['description']='Burst Mode', 'Burst Off', 'Burst On'}
	----------------------------------------------------------------
	-- Skilchaine Mode
	----------------------------------------------------------------
	state.SCmode =													M(false, 'SCmode')
	----------------------------------------------------------------
	-- Custom magic tiers
	----------------------------------------------------------------
	lowTierNukes = 													S{"Stone", "Water", "Aero", "Fire", "Blizzard", "Thunder",
																	"Stone II", "Water II", "Aero II", "Fire II", "Blizzard II", "Thunder II",
																	"Stone III", "Water III", "Aero III", "Fire III", "Blizzard III", "Thunder III",
																	"Stonega", "Waterga", "Aeroga", "Firaga", "Blizzaga", "Thundaga",
																	"Stonega II", "Waterga II", "Aeroga II", "Firaga II", "Blizzaga II", "Thundaga II"}
	
	highTierNukes = 												S{"Stone IV", "Water IV", "Aero IV", "Fire IV", "Blizzard IV", "Thunder IV",
																	"Stone V", "Water V", "Aero V", "Fire V", "Blizzard V", "Thunder V",}
	
	helixNukes = 													S{"Pyrohelix", "Cryohelix", "Anemohelix", "Geohelix", "Ionohelix", "Hydrohelix",
																	"Luminohelix", "Noctohelix", "Pyrohelix II", "Cryohelix II", "Anemohelix II",
																	"Geohelix II", "Ionohelix II", "Hydrohelix II", "Luminohelix II", "Noctohelix II",}
	
	divineNukes = 													S{'Banish', 'Banish II', 'Banish III', 'Banishga', 'Banishga II', 'Banishga III',
																	'Holy', 'Holy II'}
	
	naSpells = 														S{'Paralyna','Silena','Viruna','Erase','Stona','Blindna','Poisona','Erase'}
	
	barSpells =														S{'Barfira','Barfire','Barwater','Barwatera','Barstone','Barstonra','Baraero',
																	'Baraera','Barblizzara','Barblizzard','Barthunder','Barthundra'}
----------------------------------------------------------------------------
-- Augmented Gear
----------------------------------------------------------------------------
	-- Weapons
		gear.Staff.Akademos = {}
		gear.Staff.Akademos.C 			= {name="Akademos", augments={'INT+15','"Mag.Atk.Bns."+15','Mag. Acc.+15',}}
		gear.Staff.Akademos.D 			= {name="Akademos", augments={'Mag. Acc.+20','Enha.mag. skill +15','Enfb.mag. skill +15',}}
    
		gear.Staff.Serenity = {}
		gear.Staff.Serenity 			= {name="Serenity", augments={'MP+35','Enha.mag. skill +8','"Cure" spellcasting time -6%',}}
	
		gear.Staff.Grioavolr = {}
		gear.Staff.Grioavolr.Nuke 		= {name="Grioavolr", augments={'"Fast Cast"+3','INT+1','Mag. Acc.+29','"Mag.Atk.Bns."+29','Magic Damage +6',}}
		gear.Staff.Grioavolr.Enf 		= {name="Grioavolr", augments={'Enfb.mag. skill +15','MND+17','Mag. Acc.+22',}}
		gear.Staff.Grioavolr.Enh 		= {name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}
    
	-- Artifact --
		gear.SCHAF = {}
		gear.SCHAF.Head 				= {name="Acad. Mortar. +1"}
		gear.SCHAF.Body 				= {name="Acad. Gown +2"}
		gear.SCHAF.Hands				= {name="Acad. Bracers +1"}
		gear.SCHAF.Legs 				= {name="Acad. Pants +2"}
		gear.SCHAF.Feet 				= {name="Acad. Loafers +2"}
	
	-- Relic119 
		gear.SCHRelic = {}
		gear.SCHRelic.Head 				= {name="Peda. M.Board +1", augments={'Enh. "Altruism" and "Focalization"',}}
		gear.SCHRelic.Body 				= {name="Peda. Gown +1", augments={'Enhances "Enlightenment" effect',}}
		gear.SCHRelic.Hands 			= {name="Peda. Bracers +1", augments={'Enh. "Tranquility" and "Equanimity"',}}
		gear.SCHRelic.Legs 				= {name="Peda. Pants +1", augments={'Enhances "Tabula Rasa" effect',}}
		gear.SCHRelic.Feet 				= {name="Peda. Loafers +1", augments={'Enhances "Stormsurge" effect',}}
	
	-- Empyrean
		gear.SCHEmpy = {}
		gear.SCHEmpy.Head 				= {name="Arbatel Bonnet +1"}
		gear.SCHEmpy.Body 				= {name="Arbatel Gown +1"}
		gear.SCHEmpy.Hands 				= {name="Arbatel Bracers +1"}
		gear.SCHEmpy.Legs 				= {name="Arbatel Pants +1"}
		gear.SCHEmpy.Feet 				= {name="Arbatel Loafers +1"}
	
    -- JSE Capes
		gear.SCHJSECape = {}  
		gear.SCHJSECape.HelDur 			= {name="Bookworm's Cape", augments={'INT+2','MND+2','Helix eff. dur. +19','"Regen" potency+8',}}
	
		gear.Lugh = {}  				-- Nuke cape for INT Enfeebles, FC for MND Enfeebles
		gear.Lugh.Nuke 					= { name="Lugh's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
		gear.Lugh.FC 					= { name="Lugh's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Fast Cast"+10',}}
		--gear.Lugh.Haste 				= {name="Lugh's Cape", augments={'INT+2','Mag. Acc+2 /Mag. Dmg.+2',}}

    -- Telchine
		gear.Telchine = {}
		gear.Telchine.Head				= {name="Telchine Cap", augments={'Evasion+14','Spell interruption rate down -7%','Enh. Mag. eff. dur. +7',}}
		gear.Telchine.Body 				= {name="Telchine Chas.", augments={'Evasion+14','Spell interruption rate down -9%','Enh. Mag. eff. dur. +7',}}
		gear.Telchine.Hands				= {name="Telchine Gloves", augments={'Mag. Evasion+10','"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
		gear.Telchine.Legs				= {name="Telchine Braconi", augments={'Accuracy+10','Enh. Mag. eff. dur. +9',}}
		gear.Telchine.Feet				= {name="Telchine Pigaches", augments={'Accuracy+10','"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
	
	-- Helios
		gear.Helios = {}
		gear.Helios.Body 				= {name="Helios Jacket", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','"Drain" and "Aspir" potency +10','Mag. crit. hit dmg. +9%',}}
    
    -- Psycloth
		gear.Psycloth = {}
		gear.Psycloth.Body 				= {name="Psycloth Vest", augments={'Elem. magic skill +20','INT+7','Enmity-6',}}
		gear.Psycloth.Hands 			= {name="Psycloth Manillas", augments={'Mag. Acc.+10','Spell interruption rate down +15%','MND+7',}}
		gear.Psycloth.Legs 				= {name="Psycloth Lappas", augments={'MP+80','Mag. Acc.+15','"Fast Cast"+7'}}
		gear.Psycloth.Feet 				= {name="Psycloth Boots", augments={'MP+50','INT+7','"Conserve MP"+6',}}
    
	-- Chironic
		gear.Chironic = {}
		gear.Chironic.Head = {}
		gear.Chironic.Head.DrAsp 		= {name="Chironic Hat", augments={'Mag. Acc.+21 "Mag.Atk.Bns."+21','"Drain" and "Aspir" potency +8','INT+11','"Mag.Atk.Bns."+3',}}
		gear.Chironic.Body = {}
		gear.Chironic.Body.DrAsp 		= {name="Chironic Doublet", augments={'Mag. Acc.+25','"Drain" and "Aspir" potency +10','MND+4','"Mag.Atk.Bns."+3',}}
		gear.Chironic.Hands = {}
		gear.Chironic.Hands.Macc		= {name="Chironic Gloves", augments={'Mag. Acc.+24','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Fast Cast"+4','Accuracy+1 Attack+1',}}
		gear.Chironic.Legs = {}
		gear.Chironic.Legs.Macc 		= {name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','MND+2','Mag. Acc.+13',}}
		gear.Chironic.Feet = {}
		gear.Chironic.Feet.Melee 		= {name="Chironic Slippers", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+2','STR+15','Accuracy+11',}}
	
    -- Amalric 
		gear.Amalric = {}
		gear.Amalric.Head = {}
		gear.Amalric.Head.A 			= {name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
		--gear.Amalric.Head.B 			= {name="Amalric Coif", augments={'MP+60','INT+10','Enmity-5',}}
		gear.Amalric.Body = {}
		--gear.Amalric.Body.A 			= {name="Amalric Doublet", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
		gear.Amalric.Body.D 			= {name="Amalric Doublet", augments={'MP+60','"Mag.Atk.Bns."+20','"Fast Cast"+3'}}
		gear.Amalric.Hands = {}
		gear.Amalric.Hands.A 			= {name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
		gear.Amalric.Hands.D 			= {name="Amalric Gages", augments={'INT+10','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
		gear.Amalric.Legs = {}
		--gear.Amalric.Legs.A			= {name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
		gear.Amalric.Legs.C 			= {name="Amalric Slops", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
		gear.Amalric.Feet = {}
		gear.Amalric.Feet 				= {name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}} 

    -- Merlinic
		gear.Merlinic = {}
		gear.Merlinic.Head = {}
		gear.Merlinic.Head.DrAsp 		= {name="Merlinic Hood", augments={'Mag. Acc.+7','"Drain" and "Aspir" potency +10','MND+4',}}
		gear.Merlinic.Head.FC 			= {name="Merlinic Hood", augments={'Mag. Acc.+29','"Fast Cast"+6','CHR+8',}}
		gear.Merlinic.Head.MAB 			= {name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+9%','CHR+5','Mag. Acc.+11','"Mag.Atk.Bns."+13',}}
		gear.Merlinic.Body = {}
		gear.Merlinic.Body.Burst 		= {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+11%','CHR+10','Mag. Acc.+13',}}
		gear.Merlinic.Body.DrAsp		= {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','MND+4','"Mag.Atk.Bns."+13',}}
		gear.Merlinic.Body.FC 			= {name="Merlinic Jubbah", augments={'"Fast Cast"+7',}}
		gear.Merlinic.Body.MAB 			= {name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Enmity-3','INT+13','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Hands = {}
		gear.Merlinic.Hands.DrAsp 		= {name="Merlinic Dastanas", augments={'Accuracy+12','"Drain" and "Aspir" potency +10','INT+2','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Hands.FC			= {name="Merlinic Dastanas", augments={'Mag. Acc.+26','"Fast Cast"+6','INT+1','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Hands.Ref			= {name="Merlinic Dastanas", augments={'Pet: "Dbl.Atk."+1 Pet: Crit.hit rate +1','Rng.Acc.+27','"Refresh"+1',}}
		gear.Merlinic.Legs = {}
		gear.Merlinic.Legs.DrAsp 		= {name="Merlinic Shalwar", augments={'Mag. Acc.+22','"Drain" and "Aspir" potency +11','AGI+10','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Legs.MAB 			= {name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+8%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Legs.Mdmg			= {name="Merlinic Shalwar", augments={'Mag. Acc.+28','Magic Damage +15','INT+4','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Legs.Ref			= {name="Merlinic Shalwar", augments={'"Dual Wield"+1','Pet: Attack+27 Pet: Rng.Atk.+27','"Refresh"+1','Accuracy+11 Attack+11',}}
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
	
	--Kaykaus
		gear.Kaykaus = {}
		gear.Kaykaus.Head				= {name="Kaykaus Mitra", augments={'MP+60','"Cure" spellcasting time -5%','Enmity-5',}}
		gear.Kaykaus.Body 				= {name="Kaykaus Bliaut", augments={'MP+60','"Cure" potency +5%','"Conserve MP"+6',}}
		gear.Kaykaus.Hands 				= {name="Kaykaus Cuffs", augments={'MP+60','MND+10','Mag. Acc.+15',}}
		gear.Kaykaus.Legs 				= {name="Kaykaus Tights", augments={'MP+60','MND+10','Mag. Acc.+15',}}
		gear.Kaykaus.Feet 				= {name="Kaykaus Boots", augments={'Mag. Acc.+15','"Cure" potency +5%','"Fast Cast"+3',}}
	
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
		gear.Mallquis.Body 				= {name="Mallquis Saio +1"}
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
	windower.send_command('bind ^z gs c toggle AutoSubMode')
	windower.send_command('bind ^c gs c cycle CapacityMode')
    windower.send_command('bind ^q gs c cycle BurstMode')
    windower.send_command('bind ^` input /ma Stun <t>;input /echo Target <t> Stunned')
	----------------------------------------------------------------
	-- Auto sublimation
	----------------------------------------------------------------
	auto_sublimation()
	----------------------------------------------------------------
	-- Specific time gear
	----------------------------------------------------------------
--	timedgear()
	----------------------------------------------------------------
	-- Select macro book
	----------------------------------------------------------------
    select_default_macro_book()
	--get_current_strategem_count()
end
----------------------------------------------------------------------------
-- Called when this job file is unloaded (eg: job change)
----------------------------------------------------------------------------
function user_unload()
    windower.send_command('unbind ^`')
    windower.send_command('unbind ^q')
	windower.send_command('unbind ^z')
	windower.send_command('unbind ^c')
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
	sets.idle = 													{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Ghastly Tathlum +1",
																	head="Befouled Crown",
																	body=gear.Jhakri.Body,
																	hands=gear.Merlinic.Hands.Ref,
																	legs=gear.Merlinic.Legs.Ref,
																	feet=gear.Merlinic.Feet.Ref,
																	neck="Sanctity Necklace",
																	waist="Luminary Sash",
																	left_ear="Graiai Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Pahtli Cape",}
	----------------------------------------------------------------
	-- Resting MP recovery gear
	----------------------------------------------------------------
	sets.resting = 													{main="Boonwell Staff",
																	sub="Ariesian Grip",
																	ammo="Clarus Stone",
																	head="Befouled Crown",
																	body=gear.Jhakri.Body,
																	hands="Nares Cuffs",
																	legs="Menhit Slacks",
																	feet=gear.Merlinic.Feet.Ref,
																	neck="Beak Necklace +1",
																	waist="Hierarch Belt",
																	left_ear="Magnetic Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Pahtli Cape",}
    ----------------------------------------------------------------
	-- Physical Defense set(s)
	----------------------------------------------------------------
	sets.defense.PDT =  		   									{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Mallquis.Body,
																	hands=gear.Vanya.Hands,
																	legs=gear.Hagondes.Legs,
																	feet=gear.Chironic.Feet.Melee,
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
    sets.defense.MDT = 	    										{ammo="Amar Cluster",
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
	-- Town set
	----------------------------------------------------------------
    --[[sets.idle.Town = 											set_combine(sets.idle,{
																	head="Jhakri Coronal +1",
																	body="Jhakri Robe +1",
																	hands="Jhakri Cuffs +1",
																	legs="Jhakri Slops +1",
																	feet="Jhakri Pigaches +1",})]]--
    ----------------------------------------------------------------
	-- Kiting set(s)
	----------------------------------------------------------------
	sets.Kiting = 													{feet="Herald's gaiters"}
    ----------------------------------------------------------------
	-- Latent Refresh set(s)
	----------------------------------------------------------------
    sets.latent_refresh =											{waist="Fucho-no-obi",left_ear=gear.Moonshade}
    ----------------------------------------------------------------
	-- Bonus set(s)
	----------------------------------------------------------------
	sets.Hachirin = 												{waist="Hachirin-no-Obi"}
	sets.Storm = 													{feet=gear.SCHRelic.Feet}
	sets.CP = 														{back="Mecisto. Mantle"}
	sets.Protect_Shell = 											{right_ring="Sheltered Ring"}
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
	sets.precast.JA['Tabula Rasa'] = 								{legs=gear.SCHRelic.Legs}
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
	sets.precast.WS["Seraph Strike"] =								{ammo="Amar Cluster",
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
	sets.precast.WS["Skullbreaker"] =								{ammo="Amar Cluster",
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
	-- 100% STR
	sets.precast.WS["True Strike"] =								{ammo="Amar Cluster",
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
	-- 50% STR / 50% MND - STR/MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS["Judgement"] =									{ammo="Amar Cluster",
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
	-- 30% STR / 70% MND
	sets.precast.WS["Black Halo"] =									{ammo="Amar Cluster",
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
																	back=gear.Lugh.Nuke,}
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
	sets.precast.WS['Viper Bite'] = 								{ammo="Amar Cluster",
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
	sets.precast.WS['Cyclone'] = 									{ammo="Pemphredo Tathlum",
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
																	back=gear.Lugh.Nuke,}
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
	sets.precast.WS['Energy Drain'] = 								{ammo="Amar Cluster",
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
																	back=gear.Lugh.Nuke,}
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
																	back=gear.Lugh.Nuke,}
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
	sets.precast.WS["Sunburst"] =									{ammo="Amar Cluster",
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
	sets.precast.WS["Earth Crusher"] =								{ammo="Amar Cluster",
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
	-- 50% STR
	sets.precast.WS["Full Swing"] =									{ammo="Amar Cluster",
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
																	back=gear.Lugh.Nuke,}
	-- 30% STR / 50% MND
	sets.precast.WS["Retribution"] =								{ammo="Amar Cluster",
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
	-- Max MP
	sets.precast.WS['Myrkr'] = 										{sub="Niobid Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.Amalric.Head.A,
																	body=gear.Amalric.Body.D,
																	hands=gear.Amalric.Hands.A,
																	legs=gear.Psycloth.Legs,
																	feet=gear.Psycloth.Feet,
																	neck="Sanctity Necklace",
																	waist="Hierarch Belt",
																	left_ear="Etiolation Earring",
																	right_ear="Graiai Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Pahtli Cape",}
	----------------------------------------------------------------
    -- Spell Catch All Precast set	(82% this set, 17 over cap if /rdm)
	----------------------------------------------------------------
    sets.precast.FC = 												{sub="Clerisy Strap",				--  2
																	ammo="Sapience Orb",				--  2
																	head=gear.Merlinic.Head.FC,			-- 14
																	body="Zendik Robe",					-- 13
																	hands=gear.Merlinic.Hands.FC,		--  6
																	legs=gear.Psycloth.Legs,			--  7
																	feet=gear.Merlinic.Feet.FC,			-- 12
																	neck="Voltsurge Torque",			--  4
																	waist="Witful Belt",				--  3
																	left_ring="Kishar Ring",			--  4
																	right_ring="Prolix Ring",			-- 2
																	left_ear="Loquac. Earring",			--  2
																	right_ear="Etiolation Earring",		--  1
																	back=gear.Lugh.FC,}					-- 10
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
    -- Spell Quickcast Magic 10% Cap
	----------------------------------------------------------------
	sets.precast.FC.QC =											{back="Perimede Cape",waist="Witful Belt"}
	----------------------------------------------------------------
	-- Dark Magic Precast set(s) (Stun Drain Aspir only!!)
	----------------------------------------------------------------
	sets.precast.FC['Dark Magic'] =    								set_combine(sets.precast.FC,sets.precast.FC.QC)
	----------------------------------------------------------------
	-- Divine Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Divine Magic'] = 								set_combine(sets.precast.FC,sets.precast.FC.QC)
	----------------------------------------------------------------
	-- Elemental Magic Precast set(s)
	----------------------------------------------------------------
    sets.precast.FC['Elemental Magic'] = 							set_combine(sets.precast.FC,{hands=gear.Mallquis.Hands})
	sets.precast.FC.Impact = 										set_combine(sets.precast.FC,{head=empty,body="Twilight Cloak"})
	----------------------------------------------------------------
	-- Enfeebling Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enfeebling Magic'] = 							set_combine(sets.precast.FC,sets.precast.FC.QC)
	----------------------------------------------------------------
	-- Enhancing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enhancing Magic'] = 							set_combine(sets.precast.FC,sets.precast.FC.QC,
																	{head="Umuthi Hat",waist="Siegel Sash"})
	
	sets.precast.FC.Stoneskin = 									set_combine(sets.precast.FC,
																	{main=gear.Staff.Grioavolr.Enh,
																	ammo="Sapience Orb",
																	head="Umuthi Hat",
																	legs="Doyen Pants",
																	neck="Nodens Gorget",
																	waist="Siegel Sash",
																	left_ear="Loquac. Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Patricius Ring",
																	right_ring="Defending Ring",
																	back="Perimede Cape",})
	----------------------------------------------------------------
	-- Healing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Healing Magic'] =								set_combine(sets.precast.FC,sets.precast.FC.QC)
	
	sets.precast.FC.Cure =											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Sapience Orb",
																	head=gear.Vanya.Head,
																	body=gear.Chironic.Body,
																	hands=gear.Vanya.Hands,
																	legs="Doyen Pants",
																	feet=gear.Vanya.Feet,
																	neck="Incanter's Torque",
																	waist="Luminary Sash",
																	left_ear="Mendi. Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Kishar Ring",
																	right_ring="Stikini Ring",
																	back="Pahtli Cape",}
													
	sets.precast.FC.Curaga =										sets.precast.FC.Cure
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
	sets.midcast.FastRecast = 										{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Sapience Orb",
																	head=gear.Merlinic.Head.FC,
																	body="Zendik Robe",
																	hands=gear.Merlinic.Hands.FC,
																	legs=gear.Psycloth.Legs,
																	feet=gear.Merlinic.Feet.FC,
																	neck="Voltsurge Torque",
																	waist="Witful Belt",
																	left_ear="Loquac. Earring",
																	right_ear="Etiolation Earring",
																	back=gear.Lugh.FC,}
	----------------------------------------------------------------
	-- Dark Magic Midcast set(s)
	----------------------------------------------------------------
    sets.midcast['Dark Magic'] = 									{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head="Striga Crown",
																	body=gear.Psycloth.Body,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.SCHRelic.Legs,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",	
																	waist="Luminary Sash",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.SCHJSECape.HelDur,}
																	
	sets.midcast.Drain =											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head="Pixie Hairpin +1",
																	body=gear.Merlinic.Body.DrAsp,
																	hands=gear.Merlinic.Hands.DrAsp,
																	legs=gear.Merlinic.Legs.DrAsp,
																	feet=gear.Merlinic.Feet.DrAsp,
																	neck="Erra Pendant",
																	waist="Fucho-no-Obi",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",
																	left_ring="Excelsis Ring",
																	right_ring="Evanescence Ring",
																	back=gear.SCHJSECape.HelDur,}
																			
	sets.midcast.Aspir =											sets.midcast.Drain
	
	sets.midcast.Stun = 											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Sapience Orb",
																	head=gear.Merlinic.Head.FC,
																	body=gear.Psycloth.Body,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.Psycloth.Legs,
																	feet=gear.SCHRelic.Feet,
																	neck="Erra Pendant",
																	waist="Cetl Belt",
																	left_ear="Loquac. Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Stikini Ring",
																	right_ring="Adoulin Ring",
																	back="Perimede Cape",}

	sets.midcast.Stun.Resistant = 									{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head="Striga Crown",
																	body=gear.Psycloth.Body,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Perimede Cape",}
    
	sets.midcast.Kaustra = 											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head="Pixie Hairpin +1",
																	body=gear.Psycloth.Body,
																	hands=gear.Chironic.Hands,
																	legs=gear.SCHRelic.Legs,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",
																	waist="Refoccilation Stone",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",
																	left_ring="Etana Ring",
																	right_ring="Adoulin Ring",
																	back=gear.SCHJSECape.HelDur,}
	----------------------------------------------------------------
	-- Divine Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Divine Magic'] = 									{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Vanya.Body,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Mediums,
																	neck="Incanter's Torque",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.FC,}
	
	sets.midcast.Repose = 											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Chironic.Body.DrAsp,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.FC,}
	
	sets.midcast.DivineNuke	=										{main=gear.Staff.Grioavolr.Nuke,
																	sub="Clerisy Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.Amalric.Hands.A,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Lugh.FC,}																			
	----------------------------------------------------------------
	-- Elemental Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Elemental Magic'] = 								{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.SCHRelic.Head,
																	body=gear.Psycloth.Body,
																	hands=gear.Psycloth.Hands,
																	legs=gear.Amalric.Legs.C,
																	feet=gear.SCHEmpy.Feet,
																	neck="Incanter's Torque",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.Nuke,}
																	
	sets.midcast.LowTierNuke =					 					{main=gear.Staff.Grioavolr.Nuke,
																	sub="Thrace Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.Mallquis.Head,
																	body=gear.Mallquis.Body,
																	hands=gear.Mallquis.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB ,
																	neck="Eddy Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Crematio Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Lugh.Nuke,}
																	
    sets.midcast.LowTierNuke.Resistant =					 		sets.midcast['Elemental Magic']
	
	sets.midcast.HighTierNuke = 									{main=gear.Staff.Grioavolr.Nuke,
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Lugh.Nuke,}
																			
    sets.midcast.HighTierNuke.Resistant = 							sets.midcast['Elemental Magic']
	
	sets.midcast.HelixNuke =										{main=gear.Staff.Grioavolr.Nuke,
																	sub="Thrace Strap",
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
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Lugh.Nuke,}
	
	--[[sets.midcast.HelixNuke = 										{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.Amalric.Hands.D,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Sanctity Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Adoulin Ring",
																	back=gear.SCHJSECape.HelDur,}]]--
	
	sets.midcast.HelixNuke.Resistant = 								sets.midcast.HelixNuke
																			
	sets.midcast.ElementalEnfeeble = 								sets.midcast['Elemental Magic']
	
	sets.midcast.Impact = 											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=empty,
																	body="Twilight Cloak",
																	hands=gear.Psycloth.Hands,
																	legs=gear.Amalric.Legs.C,
																	feet=gear.SCHEmpy.Feet,
																	neck="Incanter's Torque",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.Nuke,}
	----------------------------------------------------------------
	-- Enfeebling Magic Midcast set(s)
	----------------------------------------------------------------
    sets.midcast['Enfeebling Magic'] = 								{main=gear.Staff.Grioavolr.Enf,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Vanya.Body,
																	hands="Regal Cuffs",
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Mediums,
																	neck="Erra Pendant",
																	waist="Rumination Sash",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.FC,}
	
	sets.midcast['Enfeebling Magic'].Resistant = 					{main=gear.Staff.Grioavolr.Enf,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Chironic.Head.DrAsp,
																	body=gear.Vanya.Body,
																	hands=gear.Chironic.Hands.Macc,
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Mediums,
																	neck="Incanter's Torque",
																	waist="Rumination Sash",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.FC,}
    
	sets.midcast['Enfeebling Magic'].Mnd = 							{main=gear.Staff.Grioavolr.Enf,
																	sub="Enki Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Chironic.Head.DrAsp,
																	body=gear.Vanya.Body,
																	hands="Regal Cuffs",
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Mediums,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Lugh.FC,}
																	
	sets.midcast['Enfeebling Magic'].Mnd.Resistant =				sets.midcast['Enfeebling Magic'].Resistant
	----------------------------------------------------------------
	-- Enhancing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Enhancing Magic'] = 								{main=gear.Staff.Grioavolr.Enh,
																	sub="Fulcio Grip",
																	ammo="Sapience Orb",
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
																	
	sets.midcast.Aquaveil = 										set_combine(sets.midcast['Enhancing Magic'],{head=gear.Amalric.Head.A,hands="Regal Cuffs",})
	
	sets.midcast.BarSpell = 										sets.midcast['Enhancing Magic']
	
	sets.midcast.Refresh =											{main=gear.Staff.Grioavolr.Enh,
																	sub="Fulcio Grip",
																	ammo="Sapience Orb",
																	head=gear.Amalric.Head.A,
																	body=gear.Telchine.Body,
																	hands=gear.Telchine.Hands,
																	legs=gear.Telchine.Legs,
																	feet="Inspirited Boots",
																	neck="Incanter's Torque",
																	waist="Gishdubar Sash",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Grapevine Cape",}
																	
	sets.midcast.Regen = 											{main=gear.Staff.Grioavolr.Enh,
																	sub="Fulcio Grip",
																	ammo="Sapience Orb",
																	head=gear.SCHEmpy.Head,
																	body=gear.Telchine.Body,
																	hands=gear.Telchine.Hands,
																	legs=gear.Telchine.Legs,
																	feet=gear.Telchine.Feet,
																	neck="Sanctity Necklace",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Metamor. Ring +1",
																	back=gear.SCHJSECape.HelDur,}
																	
	sets.midcast.Stoneskin =					 					{main=gear.Staff.Grioavolr.Enh,
																	ammo="Sapience Orb",
																	head="Umuthi Hat",
																	legs="Doyen Pants",
																	neck="Nodens Gorget",
																	waist="Siegel Sash",
																	left_ear="Loquac. Earring",
																	right_ear="Earthcry Earring",
																	left_ring="Kishar Ring",
																	right_ring="Defending Ring",
																	back="Perimede Cape",}
	
	sets.midcast.Storm = 											set_combine(sets.midcast['Enhancing Magic'],{feet=gear.SCHRelic.Feet})
	----------------------------------------------------------------
	-- Healing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Healing Magic'] = 								sets.midcast.FastRecast
	
	sets.midcast.Cure =												{main=gear.Staff.Serenity,
																	sub="Clerisy Strap",
																	ammo="Sapience Orb",
																	head=gear.Kaykaus.Head,
																	body="Vrikodara Jupon",
																	hands=gear.Kaykaus.Hands,
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Vanya.Feet,
																	neck="Nodens Gorget",
																	waist="Luminary Sash",
																	left_ear="Mendi. Earring",
																	right_ear="Etiolation Earring",
																	left_ring="Stikini Ring",
																	right_ring="Metamor. Ring +1",
																	back="Pahtli Cape",}
																	
	sets.midcast.Curaga = 											sets.midcast.Cure
																			
	sets.midcast.Cursna = 											sets.midcast['Healing Magic']
																			
	sets.midcast.NaSpell = 											sets.midcast['Healing Magic']
----------------------------------------------------------------------------
-- ENGAGED SETS
----------------------------------------------------------------------------
	sets.engaged =													{}
	sets.engaged.Melee =											{ammo="Amar Cluster",
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
																	
	sets.engaged.MeleeACC =											{ammo="Amar Cluster",
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
    sets.buff.Alacrity = 											{feet=gear.SCHRelic.Feet}
    sets.buff.Celerity = 											{feet=gear.SCHRelic.Feet}
	sets.buff.Doom = 												{waist="Gishdubar sash"}
    sets.buff.Ebullience = 											{head=gear.SCHEmpy.Head}
    sets.buff.Immanence = 											{hands=gear.SCHEmpy.Hands}
	sets.buff.Klimaform = 											{feet=gear.SCHEmpy.Feet}
    sets.buff.Perpetuance = 										{hands=gear.SCHEmpy.Hands}
    sets.buff.Rapture = 											{head=gear.SCHEmpy.Head}
	sets.Skillchain =												{body="Zendik Robe"}
	----------------------------------------------------------------
    -- Magic burst set (42%MB + 10%MBII)
	----------------------------------------------------------------
	sets.magic_burst = 												{main=gear.Staff.Akademos.C,				--10%
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,				-- 9%
																	body=gear.Merlinic.Body.MAB,
																	hands="Regal Cuffs",						
																	legs=gear.Merlinic.Legs.MAB,				-- 8%
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Mizu. Kubikazari",					--10%
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Mujin Band",								-- 5% II
																	right_ring="Locus Ring",					-- 5%
																	back=gear.Lugh.Nuke,}

	sets.magic_burst_helix =										{main=gear.Staff.Akademos.C,				--10%
																	sub="Niobid Strap",
																	ammo="Pemphredo Tathlum",
																	head=gear.Merlinic.Head.MAB,				-- 9%
																	body=gear.Merlinic.Body.MAB,
																	hands="Regal Cuffs",						
																	legs=gear.Merlinic.Legs.MAB,				-- 8%
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Mizu. Kubikazari",					--10%
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Barkaro. Earring",
																	left_ring="Mujin Band",								-- 5% II
																	right_ring="Locus Ring",					-- 5%
																	back=gear.Lugh.Nuke,}
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
			elseif (buffactive['Dark Arts'] or buffactive['Addendum: Black']) then
				sets.darkblackDark = set_combine(sets.precast.FC['Dark Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.darkblackDark)
			else
				equip(sets.precast.FC['Dark Magic'])
			end
		elseif spell.skill == 'Divine Magic' then
			if (buffactive['Light Arts'] or buffactive['Addendum: White']) then
				sets.lightwhiteDivine = set_combine(sets.precast.FC['Divine Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.lightwhiteDivine)
			else	
				equip(sets.precast.FC['Divine Magic'])
			end
		elseif spell.skill == 'Elemental Magic' then
			if (buffactive['Dark Arts'] or buffactive['Addendum: Black']) then
				sets.darkblackElemental = set_combine(sets.precast.FC['Elemental Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.darkblackElemental)
			else
			equip(sets.precast.FC['Elemental Magic'])
			end
		elseif spell.skill == 'Enfeebling Magic' then
			if (buffactive['Light Arts'] or buffactive['Addendum: White']) then
				sets.lightwhiteEnfeebling = set_combine(sets.precast.FC['Enfeebling Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.lightwhiteEnfeebling)
			else
				equip(sets.precast.FC['Enfeebling Magic'])
			end
		elseif spell.skill == 'Enhancing Magic' then
			if spell.english:startswith('Stoneskin') then
				equip(sets.precast.FC.Stoneskin)
			elseif (buffactive['Light Arts'] or buffactive['Addendum: White']) then
				sets.lightwhiteEnhancing = set_combine(sets.precast.FC['Enhancing Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.lightwhiteEnhancing)
			else
				equip(sets.precast.FC['Enhancing Magic'])
			end
		elseif spell.skill == 'Healing Magic' then
			if (buffactive['Light Arts'] or buffactive['Addendum: White']) then
				sets.lightwhiteEnhancing = set_combine(sets.precast.FC['Healing Magic'],{head=gear.SCHRelic.Head, feet=gear.SCHAF.Feet})
				equip(sets.lightwhiteHealing)
			else
				equip(sets.precast.FC['Healing Magic'])
			end
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
	if state.Buff.Alacrity then
		equip(sets.buff.Alacrity)
	end
	if state.Buff.Celerity then
		equip(sets.buff.Celerity)
	end
	if state.Buff.Doom then
		equip(sets.buff.Doom)
	end
	if state.Buff.Ebullience then
		equip(sets.buff.Ebullience)
	end
	if state.Buff.Immanence then
		equip(sets.buff.Immanence)
	end
	if state.Buff.Klimaform then
		equip(sets.buff.Klimaform)
	end
	if state.Buff.Perpetuance then
		equip(sets.buff.Perpetuance)
	end
	if state.Buff.Rapture then
		equip(sets.buff.Rapture)
	end
	if spell.action_type == 'Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element and not string.find(spell.english,'helix') then
			equip(sets.Hachirin)
			elseif spell.skill == 'Enhancing Magic' then
				if string.find(spell.english,'Protect') then
					equip(sets.Protect_Shell)
				end
				if string.find(spell.english,'Shell') then
					equip(sets.Protect_Shell)
				end
				if string.find(spell.english,'storm') then
					equip(sets.Storm)
				end
			elseif spell.skill == 'Enhancing Magic' then
				if spell.english:startswith('Warp*|Retrace|Escape|Tractor') then
					equip(sets.midcast.FastRecast)
				end	
			elseif state.BurstMode.value == 'Burst On' and spell.english:contains('helix') then 
				equip(sets.magic_burst_helix)
			elseif state.BurstMode.value == 'Burst On' and spell.skill == 'Elemental Magic' then
				equip(sets.magic_burst)
		end
	end
end
----------------------------------------------------------------------------
-- AFTERCAST FUNCTIONS
----------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
    if player.tp < 1000 then
        enable('main','sub')
	elseif not spell.interrupted then
        if spell.english == 'Sleep' then
			send_command('@wait 55;input /echo ------- '..spell.english..' is wearing off in 5 seconds -------')
		elseif spell.english == 'Break' then
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
	if buff == "Alacrity" then
		if gain then
			equip(sets.buff.Alacrity)
			disable('feet')
		else
			enable('feet')
		end
	elseif buff == "Celerity" then
		if gain then
			equip(sets.buff.Celerity)
			disable('feet')
		else
			enable('feet')
		end
	elseif buff == "Doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('waist','left_ring','right_ring')
		else
			enable('waist','left_ring','right_ring')
		end
	elseif buff == "Ebullience" then
		if gain then
			equip(sets.buff.Ebullience)
			disable('head')
		else
			enable('head')
		end
	elseif buff == "Immanence" then
		if gain then
			equip(sets.buff.Immanence)
			disable('hands')
		else
			enable('hands')
		end
	elseif buff == "Klimaform" then
		if gain then
			equip(sets.buff.Klimaform)
			disable('feet')
		else
			enable('feet')
		end
	elseif buff == "Perpetuance" then
		if gain then
			equip(sets.buff.Perpetuance)
			disable('hands')
		else
			enable('hands')
		end
	elseif buff == "Rapture" then
		if gain then
			equip(sets.buff.Rapture)
			disable('head')
		else
			enable('head')
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
		elseif divineNukes:contains(spell.english) then
            return 'DivineNuke'
		elseif highTierNukes:contains(spell.english) then
            return 'HighTierNuke'
        elseif helixNukes:contains(spell.english) then
            return 'HelixNuke'
		elseif naSpells:contains(spell.english) then
            return 'NaSpell'
		elseif barSpells:contains(spell.english) then
            return 'BarSpell'
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
    if player.mpp < 76 and player.tp < 1000 then
		idleSet = set_combine(idleSet, sets.latent_refresh)
	end
    if state.Buff.Alacrity then
		idleSet = set_combine(idleSet, sets.buff.Alacrity)
	end
    if state.Buff.Celerity then
		idleSet = set_combine(idleSet, sets.buff.Celerity)
	end
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
    if state.Buff.Ebullience then
		idleSet = set_combine(idleSet, sets.buff.Ebullience)
	end
    if state.Buff.Immanence then
		idleSet = set_combine(idleSet, sets.buff.Immanence)
	end
    if state.Buff.Klimaform then
		idleSet = set_combine(idleSet, sets.buff.Klimaform)
	end
    if state.Buff.Perpetuance then
		idleSet = set_combine(idleSet, sets.buff.Perpetuance)
	end
    if state.Buff.Rapture then
		idleSet = set_combine(idleSet, sets.buff.Rapture)
	end
    return idleSet
end
----------------------------------------------------------------------------
-- Modify the default melee set after it was constructed.
----------------------------------------------------------------------------
function customize_melee_set(meleeSet)
    if player.mpp < 51 then
		meleeSet = set_combine(meleeSet, sets.latent_refresh_waist)
	end
    if player.mpp < 76 and player.tp < 1000 then
		meleeSet = set_combine(meleeSet, sets.latent_refresh_sub)
	end
    if state.Buff.Alacrity then
		meleeSet = set_combine(meleeSet, sets.buff.Alacrity)
	end
    if state.Buff.Celerity then
		meleeSet = set_combine(meleeSet, sets.buff.Celerity)
	end
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
    if state.Buff.Ebullience then
		meleeSet = set_combine(meleeSet, sets.buff.Ebullience)
	end
    if state.Buff.Immanence then
		meleeSet = set_combine(meleeSet, sets.buff.Immanence)
	end
    if state.Buff.Klimaform then
		meleeSet = set_combine(meleeSet, sets.buff.Klimaform)
	end
	if state.Buff.Perpetuance then
		meleeSet = set_combine(meleeSet, sets.buff.Perpetuance)
	end
    if state.Buff.Rapture then
		meleeSet = set_combine(meleeSet, sets.buff.Rapture)
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
	if cmdParams[1] == 'user' and not (buffactive['light arts'] or buffactive['dark arts'] or buffactive['addendum: white'] or buffactive['addendum: black']) then
        if state.IdleMode.value == 'Stun' then
            send_command('@input /ja "Dark Arts" <me>')
        else
            send_command('@input /ja "Light Arts" <me>')
        end
    end
    update_active_strategems()
	auto_sublimation()
	capacitymode()
--	timedgear()
end
----------------------------------------------------------------------------
-- Called for custom player commands.
----------------------------------------------------------------------------
function job_self_command(cmdParams, eventArgs)
    if cmdParams[1]:lower() == 'skillchain' then
        sch_skillchain(cmdParams)
        eventArgs.handled = true
    end
	if cmdParams[1]:lower() == 'scholar' then
        handle_strategems(cmdParams)
        eventArgs.handled = true
    end
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------
-- Reset the state vars tracking strategems.
----------------------------------------------------------------------------
function update_active_strategems()
    state.Buff['Ebullience'] 	= buffactive['Ebullience'] or false
    state.Buff['Rapture'] 		= buffactive['Rapture'] or false
    state.Buff['Perpetuance'] 	= buffactive['Perpetuance'] or false
    state.Buff['Immanence'] 	= buffactive['Immanence'] or false
    state.Buff['Penury'] 		= buffactive['Penury'] or false
    state.Buff['Parsimony'] 	= buffactive['Parsimony'] or false
    state.Buff['Celerity'] 		= buffactive['Celerity'] or false
    state.Buff['Alacrity'] 		= buffactive['Alacrity'] or false
    state.Buff['Klimaform'] 	= buffactive['Klimaform'] or false
end
----------------------------------------------------------------------------
-- Scholar skillchains
----------------------------------------------------------------------------
function sch_skillchain(cmdParams)
    if areas.Cities:contains(world.area) then
        add_to_chat(122, 'You cannot use skillchains in town.')
        return
    end
	if not cmdParams[2] then
        add_to_chat(123,'No skillchain type given.')
        return
    end
	local sctype = cmdParams[2]:lower()
	if buffactive['dark arts'] then
		send_command('input /ja "Addendum: Black" <me>')
	elseif buffactive['addendum: black'] then
		add_to_chat(122,'Addendum: Black is already active.')
		send_command('input /ma "klimaform" <me>;pause 4.0')
	else
		send_command('input /ja "Dark Arts" <me>')
	end
	if sctype == 'compression' then
		send_command('input /ma "Voidstorm II" <me>;pause 5.0;input /p [Compression][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "blizzard" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "noctohelix";pause 2.0;input /p [Magicburst][Dark];pause 3.0;input /ma "Noctohelix II"')
	elseif sctype == 'detonation' then
		send_command('input /ma "Windstorm II" <me>;pause 5.0;input /p [Detonation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "stone" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "aero";pause 2.0;input /p [Magicburst][Wind];pause 3.0;input /ma "Aero V"')
	elseif sctype == 'impaction' then
		send_command('input /ma "Thunderstorm II" <me>;pause 5.0;input /p [Impaction][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "water" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "thunder";pause 2.0;input /p [Magicburst][Thunder];pause 3.0;input /ma "Thunder V"')
	elseif sctype == 'induration' then
		send_command('input /ma "Hailstorm II" <me>;pause 5.0;input /p [Induration][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "water" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "blizzard";pause 2.0;input /p [Magicburst][Ice];pause 3.0;input /ma "Blizzard V"')
	elseif sctype == 'liquefaction' then
		send_command('input /ma "Firestorm II" <me>;pause 5.0;input /p [Liquefaction][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "stone" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "fire";pause 2.0;input /p [Magicburst][Fire];pause 3.0;input /ma "Fire V"')
	elseif sctype == 'reverberation' then
		send_command('input /ma "Rainstorm II" <me>;pause 5.0;input /p [Reverberation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "stone" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "water";pause 2.0;input /p [Magicburst][Water];pause 3.0;input /ma "Water V"')
	elseif sctype == 'scission' then
		send_command('input /ma "Sandstorm II" <me>;pause 5.0;input /p [Scission][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "fire" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "stone";pause 2.0;input /p [Magicburst][Earth];pause 3.0;input /ma "Stone V"')
	elseif sctype == 'transfixion' then
		send_command('input /ma "Aurorastorm II" <me>;pause 5.0;input /p [Transfixion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "noctohelix" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "luminohelix";pause 2.0;input /p [Magicburst][Light];pause 3.0;input /ma "Luminohelix II"')
	elseif sctype == 'distortion' then
		send_command('input /ma "Hailstorm II" <me>;pause 5.0;input /p [Distortion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "luminohelix" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "stone";pause 2.0;input /p [Magicburst][Water][Ice]')
	elseif sctype == 'fragmentation' then
		send_command('input /ma "Windstorm II" <me>;pause 5.0;input /p [Fragmentation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "blizzard" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "water";pause 2.0;input /p [Magicburst][Wind][Thunder]')
	elseif sctype == 'fusion' then
		send_command('input /ma "Firestorm II" <me>;pause 5.0;input /p [Fusion][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "fire" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "thunder";pause 2.0;input /p [Magicburst][Fire][Light]')
	elseif sctype == 'gravitation' then
		send_command('input /ma "Sandstorm II" <me>;pause 5.0;input /p [Gravitation][Skillchain];pause .1;input /ja "Immanence" <me>;pause 2.5;input /ma "aero" <t>;pause 5.0;input /ja "Immanence" <me>;pause 2.5;input /ma "noctohelix";pause 2.0;input /p [Magicburst][Stone][Dark]')
	else
		add_to_chat(123,'Error: Unknown skillchain ['..sctype..']')
	end
end
----------------------------------------------------------------------------
-- General handling of strategems in an Arts-agnostic way
----------------------------------------------------------------------------
function handle_strategems(cmdParams)
    if not cmdParams[2] then
        add_to_chat(123,'Error: No strategem command given.')
        return
    end
    local strategem = cmdParams[2]:lower()
 
    if strategem == 'light' then
        if buffactive['light arts'] then
            send_command('input /ja "Addendum: White" <me>')
        elseif buffactive['addendum: white'] then
            add_to_chat(122,'Error: Addendum: White is already active.')
        else
            send_command('input /ja "Light Arts" <me>')
        end
    elseif strategem == 'dark' then
        if buffactive['dark arts'] then
            send_command('input /ja "Addendum: Black" <me>')
        elseif buffactive['addendum: black'] then
            add_to_chat(122,'Error: Addendum: Black is already active.')
        else
            send_command('input /ja "Dark Arts" <me>')
        end
    elseif buffactive['light arts'] or buffactive['addendum: white'] then
        if strategem == 'cost' then
            send_command('input /ja Penury <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Celerity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Accession <me>')
        elseif strategem == 'power' then
            send_command('input /ja Rapture <me>')
        elseif strategem == 'duration' then
            send_command('input /ja Perpetuance <me>')
        elseif strategem == 'accuracy' then
            send_command('input /ja Altruism <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Tranquility <me>')
        elseif strategem == 'skillchain' then
            add_to_chat(122,'Error: Light Arts does not have a skillchain strategem.')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: White" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    elseif buffactive['dark arts']  or buffactive['addendum: black'] then
        if strategem == 'cost' then
            send_command('input /ja Parsimony <me>')
        elseif strategem == 'speed' then
            send_command('input /ja Alacrity <me>')
        elseif strategem == 'aoe' then
            send_command('input /ja Manifestation <me>')
        elseif strategem == 'power' then
            send_command('input /ja Ebullience <me>')
        elseif strategem == 'duration' then
            add_to_chat(122,'Error: Dark Arts does not have a duration strategem.')
        elseif strategem == 'accuracy' then
            send_command('input /ja Focalization <me>')
        elseif strategem == 'enmity' then
            send_command('input /ja Equanimity <me>')
        elseif strategem == 'skillchain' then
            send_command('input /ja Immanence <me>')
        elseif strategem == 'addendum' then
            send_command('input /ja "Addendum: Black" <me>')
        else
            add_to_chat(123,'Error: Unknown strategem ['..strategem..']')
        end
    else
        add_to_chat(123,'No arts have been activated.')
    end
end
----------------------------------------------------------------------------
-- Stratagem count
----------------------------------------------------------------------------
--[[function get_current_strategem_count()
    local allRecasts = windower.ffxi.get_ability_recasts()
    local stratsRecast = allRecasts[231]
    local maxStrategems = (player.main_job_level + 10) / 20
    local fullRechargeTime = 4*60
    local currentCharges = math.floor(maxStrategems - maxStrategems * stratsRecast / fullRechargeTime)
    return currentCharges
end]]--

----------------------------------------------------------------------------
-- Specific time gear
----------------------------------------------------------------------------
--[[function timedgear()
	if world.time >= 17*60 or world.time < 7*60 then
		if world.day_element ~= 'Water' then
			gear.Earring.name = gear.infused
		elseif world.day_element == 'Water' then
			gear.Earring.name = gear.hibernation
		end
	else
		gear.Earring.name = gear.dawn
	end
	if player.tp >= 500 then
		gear.Neck.name = gear.chryso
	elseif player.tp < 500 then
		gear.Neck.name = gear.bathy
	end
end]]--
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
-- Skillchain Mode
----------------------------------------------------------------------------
--[[function SCmode(cmdParams, action, spellMap, eventArgs)
	if state.SCmode.value == 'SCmode' then
		windower.send_command('/con input gs disable body';'<span class="shl">wait</span> 1';'/con input /equip body "Zendik Robe"')
		add_to_chat('------------------Skillchain Mode Active')
	elseif state.SCmode.value ~= 'SCmode' then
		enable('body')
	end
end]]
----------------------------------------------------------------------------
-- SUBJOB AND MACRO BOOK SELECTION
----------------------------------------------------------------------------
function select_default_macro_book()
    set_macro_page(1, 17)
end