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
    state.Buff.Saboteur = 													buffactive.saboteur or false
end
--------------------------------------------------------------------------------------------------------------------
-- USER SETUP FUNCTIONS FOR THIS JOB FILE.
--------------------------------------------------------------------------------------------------------------------
function user_setup()
    state.OffenseMode:options('None','Normal','Acc','SW','SWACC','tank')
    state.HybridMode:options('Normal', 'PhysicalDef', 'MagicalDef')
    state.CastingMode:options('Normal', 'Resistant')
    state.IdleMode:options('Normal', 'PDT', 'MDT')
	----------------------------------------------------------------
	-- Cycle between capacity point bonus gear and normal
	----------------------------------------------------------------
	state.CapacityMode = 											M{['description']='Capacity Bonus', 'Normal', 'Bonus Active'}
	----------------------------------------------------------------
	-- Determine haste for maximum dual wield effeciency
	---------------------------------------------------------------- 	
	determine_haste_group()
	----------------------------------------------------------------
	-- Auto sublimation on or off
	----------------------------------------------------------------
	state.AutoSubMode = 											M(false, 'Auto Sublimation')
	----------------------------------------------------------------
	-- Magic burst on or off
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
																	"Quake","Tornado","Freeze","Flare","Flood","Burst",
																	"Quake II","Tornado II","Freeze II","Flare II","Flood II","Burst II"}
	helixNukes = 													S{"Pyrohelix", "Cryohelix", "Anemohelix", "Geohelix", "Ionohelix", "Hydrohelix",
																	"Luminohelix", "Noctohelix", "Pyrohelix II", "Cryohelix II", "Anemohelix II",
																	"Geohelix II", "Ionohelix II", "Hydrohelix II", "Luminohelix II", "Noctohelix II",}
	divineNukes = 													S{'Banish', 'Banish II', 'Banish III', 'Banishga', 'Banishga II', 'Banishga III','Holy', 'Holy II'}
	naSpells = 														S{'Paralyna','Silena','Viruna','Erase','Stona','Blindna','Poisona','Erase'}
	barSpells =														S{'Barfira','Barfire','Barwater','Barwatera','Barstone','Barstonra','Baraero',
																	'Baraera','Barblizzara','Barblizzard','Barthunder','Barthundra'}
	Enspells =														S{'Enfire','Enfire II','Enblizzard','Enblizzard II','Enaero','Enaero II','Enstone','Enstone II',
																	'Enthunder','Enthunder II','Enwater','Enwater II'}
----------------------------------------------------------------------------
-- Augmented Gear
----------------------------------------------------------------------------

    -- Weapons
		gear.Staff.Serenity = {}
		gear.Staff.Serenity 			= {name="Serenity", augments={'MP+35','Enha.mag. skill +8','"Cure" spellcasting time -6%',}}
	
		gear.Staff.Grioavolr = {}
		gear.Staff.Grioavolr.Nuke 		= {name="Grioavolr", augments={'"Fast Cast"+3','INT+1','Mag. Acc.+29','"Mag.Atk.Bns."+29','Magic Damage +6',}}
		gear.Staff.Grioavolr.Enf 		= {name="Grioavolr", augments={'Enfb.mag. skill +15','MND+17','Mag. Acc.+22',}}
		gear.Staff.Grioavolr.Enh 		= {name="Grioavolr", augments={'Enh. Mag. eff. dur. +9','Mag. Acc.+25','"Mag.Atk.Bns."+17',}}

	-- Artifact --
		gear.RDMAF = {}
		gear.RDMAF.Head 				= {name="Atro. Chapeau +3"}
		gear.RDMAF.Body 				= {name="Atrophy Tabard +3"}
		gear.RDMAF.Hands 				= {name="Atrophy Gloves +3"}
		gear.RDMAF.Legs 				= {name="Atrophy Tights +3"}
		gear.RDMAF.Feet					= {name="Atrophy Boots +3"}
    
	-- Relic119 -- 						TierII Enfeebles/PhalanxII and Chainspell Bonuses
		gear.RDMRelic = {}
		gear.RDMRelic.Head 				= {name="Viti. Chapeau +2", augments={'Enhances "Dia III" effect','Enhances "Slow II" effect',}}
		gear.RDMRelic.Body 				= {name="Viti. Tabard +3", augments={'Enhances "Chainspell" effect',}}
		gear.RDMRelic.Hands				= {name="Viti. Gloves +2", augments={'Enhances "Phalanx II" effect',}}
		gear.RDMRelic.Legs 				= {name="Viti. Tights +3", augments={'Enhances "Bio III" effect','Enhances "Blind II" effect',}}
		gear.RDMRelic.Feet 				= {name="Vitivation Boots +1", augments={'Enhances "Paralyze II" effect',}}
	
	-- Empyrean --
		gear.RDMEmpy = {}
		gear.RDMEmpy.Head 				= {name="Leth. Chappel +1"}
		gear.RDMEmpy.Body 				= {name="Lethargy Sayon +1"}
		gear.RDMEmpy.Hands 				= {name="Leth. Gantherots +1"}
		gear.RDMEmpy.Legs 				= {name="Leth. Fuseau +1"}
		gear.RDMEmpy.Feet				= {name="Leth. Houseaux +1"}
	
    -- JSE Capes
		gear.RDMJSECape = {}  
		gear.RDMJSECape.EnhDur 			= {name="Ghostfyre Cape", augments={'Enfb.mag. skill +7','Enha.mag. skill +5','Mag. Acc.+5','Enh. Mag. eff. dur. +15',}}
	
		gear.Sucellos = {}  			-- Nuke cape for INT Enfeebles, Haste for MND Enfeebles
		gear.Sucellos.Haste 			= {name="Sucellos's Cape", augments={'MND+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','Haste+10',}}
		gear.Sucellos.Nuke				= {name="Sucellos's Cape", augments={'INT+20','Mag. Acc+20 /Mag. Dmg.+20','Mag. Acc.+10','"Mag.Atk.Bns."+10',}}
		gear.Sucellos.TP				= {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','"Dbl.Atk."+10',}}
		gear.Sucellos.WSD				= {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Attack+10','Weapon skill damage +10%',}}
		gear.Sucellos.DW				= {name="Sucellos's Cape", augments={'STR+20','Accuracy+20 Attack+20','Accuracy+10','"Dual Wield"+10',}}
		
    -- Telchine    
		gear.Telchine = {}
		gear.Telchine.Head 				= {name="Telchine Cap", augments={'Spell interruption rate down -7%','Enh. Mag. eff. dur. +8',}}
		gear.Telchine.Body 				= {name="Telchine Chas.", augments={'Evasion+14','Spell interruption rate down -9%','Enh. Mag. eff. dur. +9',}}
		gear.Telchine.Hands 			= {name="Telchine Gloves", augments={'Mag. Evasion+10','"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
		gear.Telchine.Legs 				= {name="Telchine Braconi", augments={'Accuracy+10','Enh. Mag. eff. dur. +9',}}
		gear.Telchine.Feet 				= {name="Telchine Pigaches", augments={'"Cure" spellcasting time -4%','Enh. Mag. eff. dur. +9',}}
	
	-- Helios

	-- Despair
		gear.Despair = {}
		gear.Despair.Body 				= {name="Despair Mail", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Hands	 			= {name="Despair Fin. Gaunt.", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Legs 				= {name="Despair Cuisses", augments={'STR+12','VIT+7','Haste+2%',}}
		gear.Despair.Feet 				= {name="Despair Greaves", augments={'DEX+10','STR+7','Phys. dmg. taken -3',}}
	
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
		gear.Chironic.Hands.Acc			= {name="Chironic Gloves", augments={'Accuracy+20 Attack+20','Accuracy+15','Attack+10',}}
		gear.Chironic.Hands.Macc		= {name="Chironic Gloves", augments={'Mag. Acc.+24','Mag. Acc.+19 "Mag.Atk.Bns."+19','"Fast Cast"+4','Accuracy+1 Attack+1',}}
		gear.Chironic.Legs = {}
		gear.Chironic.Legs.Macc 		= {name="Chironic Hose", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','Enmity-2','MND+2','Mag. Acc.+13',}}
		gear.Chironic.Feet = {}
		gear.Chironic.Feet.Melee 		= {name="Chironic Slippers", augments={'Accuracy+13 Attack+13','"Dbl.Atk."+2','STR+15','Accuracy+11',}}
	
	-- Carmine
		gear.Carmine = {}
		gear.Carmine.Head = {}
		gear.Carmine.Head 				= {name="Carmine Mask +1", augments={'Accuracy+20','Mag. Acc.+12','"Fast Cast"+4',}}
		gear.Carmine.Body = {}
		gear.Carmine.Body 				= {name="Carm. Scale Mail", augments={'Accuracy+10','DEX+10','MND+15',}}
		gear.Carmine.Hands = {}
		gear.Carmine.Hands 				= {name="Carmine Fin. Ga.", augments={'Accuracy+10','DEX+10','MND+15',}}
		gear.Carmine.Legs = {}
		gear.Carmine.Legs 				= {name="Carmine Cuisses +1", augments={'Accuracy+20','Attack+12','"Dual Wield"+6',}}
		gear.Carmine.Feet = {}
		gear.Carmine.Feet				= {name="Carmine Greaves +1", augments={'Accuracy+12','DEX+12','MND+20',}}
		gear.Carmine.Feet.PDT 			= {name="Carmine Greaves", augments={'HP+60','MP+60','Phys. dmg. taken -3',}}
	
    -- Amalric 
		gear.Amalric = {}
		gear.Amalric.Head = {}
		gear.Amalric.Head.A 			= {name="Amalric Coif", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15'}}
		--gear.Amalric.Head.B	 		= {name="Amalric Coif", augments={'MP+60','INT+10','Enmity-5',}}
		gear.Amalric.Body = {}
		gear.Amalric.Body.A 			= {name="Amalric Doublet +1", augments={'MP+80','Mag. Acc.+20','"Mag.Atk.Bns."+20',}}
		gear.Amalric.Body.C 			= {name="Amalric Doublet", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
		gear.Amalric.Hands = {}
		gear.Amalric.Hands.A 			= {name="Amalric Gages", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
		gear.Amalric.Hands.C 			= {name="Amalric Gages", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
		gear.Amalric.Hands.D 			= {name="Amalric Gages +1", augments={'INT+12','Mag. Acc.+20','"Mag.Atk.Bns."+20'}}
		gear.Amalric.Legs = {}
		--gear.Amalric.Legs.A 			= {name="Amalric Slops", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}}
		gear.Amalric.Legs.C 			= {name="Amalric Slops", augments={'INT+10','Elem. magic skill +15','Dark magic skill +15',}}
		gear.Amalric.Legs.D 			= {name="Amalric Slops", augments={'MP+60','"Mag.Atk.Bns."+20','Enmity-5',}}
		gear.Amalric.Feet = {}
		gear.Amalric.Feet 				= {name="Amalric Nails", augments={'MP+60','Mag. Acc.+15','"Mag.Atk.Bns."+15',}} 

    -- Merlinic
		gear.Merlinic = {}
		gear.Merlinic.Head = {}
		gear.Merlinic.Head.FC 			= {name="Merlinic Hood", augments={'Mag. Acc.+29','"Fast Cast"+6','CHR+8',}}
		gear.Merlinic.Head.DrAsp 		= {name="Merlinic Hood", augments={'Mag. Acc.+7','"Drain" and "Aspir" potency +10','MND+4',}}
		gear.Merlinic.Head.MAB 			= {name="Merlinic Hood", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+9%','CHR+5','Mag. Acc.+11','"Mag.Atk.Bns."+13',}}
		gear.Merlinic.Body = {}
		gear.Merlinic.Body.FC 			= {name="Merlinic Jubbah", augments={'"Fast Cast"+7',}}
		gear.Merlinic.Body.MAB 			= {name="Merlinic Jubbah", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Enmity-3','INT+13','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Body.Burst 		= {name="Merlinic Jubbah", augments={'"Mag.Atk.Bns."+30','Magic burst dmg.+11%','CHR+10','Mag. Acc.+13',}}
		gear.Merlinic.Body.DrAsp		= {name="Merlinic Jubbah", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Drain" and "Aspir" potency +10','MND+4','"Mag.Atk.Bns."+13',}}	
		gear.Merlinic.Hands = {}
		gear.Merlinic.Hands.DrAsp 		= {name="Merlinic Dastanas", augments={'Accuracy+12','"Drain" and "Aspir" potency +10','INT+2','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Hands.FC 			= {name="Merlinic Dastanas", augments={'Mag. Acc.+26','"Fast Cast"+6','INT+1','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Hands.Ref			= {name="Merlinic Dastanas", augments={'Crit. hit damage +1%','Pet: AGI+8','"Refresh"+2','Accuracy+15 Attack+15',}}
		gear.Merlinic.Legs = {}
		gear.Merlinic.Legs.DrAsp 		= {name="Merlinic Shalwar", augments={'Mag. Acc.+22','"Drain" and "Aspir" potency +11','AGI+10','"Mag.Atk.Bns."+6',}}
		gear.Merlinic.Legs.MAB 			= {name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','Magic burst dmg.+8%','MND+7','Mag. Acc.+15','"Mag.Atk.Bns."+12',}}
		gear.Merlinic.Legs.Macc			= {name="Merlinic Shalwar", augments={'Mag. Acc.+27','"Avatar perpetuation cost" -6','Accuracy+4 Attack+4','Mag. Acc.+19 "Mag.Atk.Bns."+19',}}
		gear.Merlinic.Legs.Ref			= {name="Merlinic Shalwar", augments={'"Store TP"+5','Accuracy+1','"Refresh"+2','Mag. Acc.+14 "Mag.Atk.Bns."+14',}}
		gear.Merlinic.Feet = {}
		gear.Merlinic.Feet.Burst 		= {name="Merlinic Crackows", augments={'Mag. Acc.+16 "Mag.Atk.Bns."+16','Magic burst dmg.+8%','MND+14','Mag. Acc.+15','"Mag.Atk.Bns."+10',}}
		gear.Merlinic.Feet.DrAsp 		= {name="Merlinic Crackows", augments={'Mag. Acc.+24','"Drain" and "Aspir" potency +9','INT+4',}}
		gear.Merlinic.Feet.MAB 			= {name="Merlinic Crackows", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','"Occult Acumen"+6','Mag. Acc.+10','"Mag.Atk.Bns."+15',}}
		gear.Merlinic.Feet.FC 			= {name="Merlinic Crackows", augments={'"Fast Cast"+7','INT+2',}}
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

	-- Taeon
		gear.Taeon = {}
	    gear.Taeon.Head					= {name="Taeon Chapeau", augments={'Accuracy+15 Attack+15','"Dual Wield"+3',}}
		gear.Taeon.Body 				= {name="Taeon Tabard", augments={'Accuracy+11','"Dual Wield"+5',}}
		gear.Taeon.Hands				= {name="Taeon Gloves", augments={'Accuracy+7 Attack+7','"Dual Wield"+5',}}
		gear.Taeon.Legs					= {}
		gear.Taeon.Feet					= {name="Taeon Boots", augments={'Attack+24','"Dual Wield"+4','"Snapshot"+5',}}
		
	-- Misc Augmented Gear
		-- Ayanmo
		gear.Ayanmo = {}
		gear.Ayanmo.Head 				= {name="Aya. Zucchetto +1"}
		gear.Ayanmo.Body				= {name="Ayanmo Corazza +1"}
		gear.Ayanmo.Hands				= {name="Aya. Manopolas +1"}
		gear.Ayanmo.Legs				= {name="Aya. Cosciales +1"}
		gear.Ayanmo.Feet				= {name="Aya. Gambieras +1"}
		
		-- Jhakri
		gear.Jhakri = {}
		gear.Jhakri.Head				= {head="Jhakri Coronal +1"}
		gear.Jhakri.Body				= {name="Jhakri Robe +2"}
		gear.Jhakri.Hands				= {name="Jhakri Cuffs +2"}
		gear.Jhakri.Legs				= {name="Jhakri Slops +1"}
		gear.Jhakri.Feet				= {name="Jhakri Pigaches +1"}

		gear.Witching = {}
		gear.Witching 					= {name="Witching Robe", augments={'MP+45','Mag. Acc.+14','"Mag.Atk.Bns."+14',}}
	
		gear.Mediums = {}
		gear.Mediums 					= {name="Medium's Sabots", augments={'MP+50','MND+10','"Conserve MP"+7','"Cure" potency +5%',}}
	
		gear.Leyline = {}
		gear.Leyline 					= {name="Leyline Gloves", augments={'Accuracy+14','Mag. Acc.+13','"Mag.Atk.Bns."+13','"Fast Cast"+2',}}
	
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
	windower.send_command('bind ^a gs c cycle MageMode')
    windower.send_command('bind ^` input /ma Stun <t>;input /echo Target <t> Stunned')
	----------------------------------------------------------------
	-- Auto sublimation
	----------------------------------------------------------------
	auto_sublimation()
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
	windower.send_command('unbind ^c')
	windower.send_command('unbind ^a')
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
																	head=gear.RDMRelic.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.Merlinic.Hands.Ref,
																	legs=gear.Merlinic.Legs.Ref,
																	feet=gear.Merlinic.Feet.Ref,
																	neck="Sanctity Necklace",
																	waist="Fucho-no-Obi",
																	left_ear=gear.Moonshade,
																	right_ear="Etiolation Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Xucau Mantle",}
	----------------------------------------------------------------
	-- Resting MP recovery gear
	----------------------------------------------------------------
	sets.resting = 													{main="Boonwell Staff",
																	sub="Ariesian Grip",
																	ammo="Clarus Stone",
																	head=gear.RDMRelic.Head,
																	body=gear.RDMAF.Body,
																	hands="Nares Cuffs",
																	legs="Menhit Slacks",
																	feet=gear.Merlinic.Feet.Ref,
																	neck="Beak Necklace +1",
																	waist="Hierach Belt",
																	left_ear=gear.Moonshade,
																	right_ear="Magnetic Earring",
																	left_ring="Mephitas's Ring +1",
																	right_ring="Mephitas's Ring",
																	back="Xucau Mantle",}
    ----------------------------------------------------------------
	-- Physical Defense set(s)
	----------------------------------------------------------------
	sets.defense.PDT =  											{ammo="Brigantia Pebble",
																	head="Blistering Sallet +1",
																	body="Emet Harness +1",
																	hands="Umuthi Gloves",
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Carmine.Feet.PDT,
																	neck="Loricate Torque +1",
																	waist="Cetl Belt",
																	left_ear="Genmei Earring",
																	right_ear="Infused Earring",
																	left_ring="Patricius Ring",
																	right_ring="Defending Ring",
																	back="Solemnity Cape",}
    ----------------------------------------------------------------
	-- Magical Defense set(s)
	----------------------------------------------------------------
    sets.defense.MDT = 	    										{ammo="Brigantia Pebble",
																	head=gear.Ayanmo.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.Ayanmo.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Ayanmo.Feet,
																	neck="Loricate Torque +1",
																	waist="Cetl Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Etiolation Earring",
																	left_ring="Yacuruna Ring",
																	right_ring="Defending Ring",
																	back="Solemnity Cape",}
	----------------------------------------------------------------
	-- Town set
	----------------------------------------------------------------
    --[[sets.idle.Town = 												set_combine(sets.idle,{
																	main=gear.Staff.Grioavolr.Nuke,
																	head=gear.RDMRelic.Head,
																	body=gear.RDMRelic.Body,
																	hands=gear.RDMRelic.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.RDMRelic.Feet,})]]--
	----------------------------------------------------------------
	-- Autolockstyle set
	----------------------------------------------------------------
	--sets.lockstyle =												sets.idle.Town																	
	----------------------------------------------------------------
	-- Kiting set(s)
	----------------------------------------------------------------
	sets.Kiting = 													{legs=gear.Carmine.Legs}
    ----------------------------------------------------------------
	-- Latent Refresh set(s)
	----------------------------------------------------------------
    sets.latent_refresh =											{waist="Fucho-no-obi",left_ear=gear.Moonshade,}
    ----------------------------------------------------------------
	-- Bonus set(s)
	----------------------------------------------------------------
	sets.Hachirin = 												{waist="Hachirin-no-Obi"}
	sets.CP = 														{back="Mecisto. Mantle"}
	sets.Protect_Shell = 											{}
	sets.Dia3_Slow2 = 												{head=gear.RDMRelic.Head}
	--sets.Bio3_Blind2 =											{legs=gear.RDMRelic.Legs}
	sets.Para2 = 													{feet=gear.RDMRelic.Feet}
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
																	back="Swith Cape",}
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
	sets.precast.JA['Chainspell'] = 								{body="Vitivation Tabard +1"}
    sets.precast.JA['Provoke'] =									{ammo="Iron Gobbet",
																	body="Emet Harness +1",
																	legs="Zoar Subligar",
																	neck="Unmoving Collar",
																	left_ear="Cryptic Earring",
																	right_ear="Trux Earring",
																	left_ring="Pernicious Ring",
																	right_ring="Supershear Ring",
																	back="Reiki Cloak",}
	----------------------------------------------------------------
	-- Weaponskill Precast set(s)
	----------------------------------------------------------------
	sets.precast.WS = 												{}
	-----------------------------
	--SWORD
	-----------------------------
	-- 40% STR / 40% DEX
	sets.precast.WS['Fast Blade'] =									{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}			
	-- 40% STR / 40% INT
	sets.precast.WS['Burning Blade'] =								{ammo="Pemphredo Tathlum",
																	head=gear.RDMAF.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- 40% STR / 40% INT	
	sets.precast.WS['Red Lotus Blade'] =							{ammo="Pemphredo Tathlum",
																	head=gear.RDMAF.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- 100% STR
	sets.precast.WS['Flat Blade'] =									{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}			
	-- 40% STR / 40% MND
	sets.precast.WS['Shining Blade'] =								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- 40% STR / 40% MND
	sets.precast.WS['Seraph Blade'] =								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- 100% STR
	sets.precast.WS['Circle Blade'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- Current HP / TP
	sets.precast.WS['Spirits Within'] =								{}			
	
	-- 60% STR
	sets.precast.WS['Vorpal Blade'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}				
	-- 50% STR / 50% MND
	sets.precast.WS['Savage Blade'] = 								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 30% STR / 50% MND	
    sets.precast.WS['Sanguine Blade'] = 							{ammo="Ghastly Tathlum +1",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Vanya.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Friomisi Earring",
																	right_ear="Crematio Earring",
																	left_ring="Stikini Ring",
																	right_ring="Rufescent Ring",
																	back="Toro Cape",}
    -- MND - 73% / 76% / 79% / 82% / 85%
	sets.precast.WS['Requiescat'] = 								{ammo="Amar Cluster",
																	head=gear.Merlinic.Head.DrAsp,
																	body=gear.Vanya.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Merlinic.Feet.Burst,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Stikini Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.Haste,}																	
	-- 80% DEX
	sets.precast.WS['Chant du cygne'] = 							{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Carmine.Body,
																	hands=gear.RDMAF.Hands,
																	legs="Gyve Trousers",
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Dominance Earring",		
																	right_ear="Pixie Earring",
																	left_ring="Apate Ring",
																	right_ring="Rajas Ring",
																	back=gear.Sucellos.WSD,}
	-- 30% STR / 50% MND	
	sets.precast.WS['Death Blossom'] = 								{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Carmine.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Carmine.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.Haste,}
	-----------------------------
	--DAGGER
	-----------------------------   
	-- 100% DEX
	sets.precast.WS['Wasp Sting'] = 								{ammo="Amar Cluster",
																	head=gear.Ayanmo.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Ayanmo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Dominance Earring",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rajas Ring",
																	back=gear.Sucellos.WSD}
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
																	right_ear="Crematio Earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Sucellos.WSD,}
	-- 100% CHR
	sets.precast.WS['Shadowstitch'] = 								{ammo="Amar Cluster",
																	head=gear.Merlinic.Head.FC,
																	body=gear.Merlinic.Body.Burst,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Vanya.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Handler's Earring +1",
																	right_ear="Handler's Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD,}	
	-- 100% DEX
	sets.precast.WS['Viper Bite'] = 								{ammo="Amar Cluster",
																	head=gear.Ayanmo.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Ayanmo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Dominance Earring",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rajas Ring",
																	back=gear.Sucellos.WSD}
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
																	right_ear="Crematio Earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Sucellos.WSD,}
	-- 100% MND
	sets.precast.WS['Energy Steal'] = 								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.Vanya.Body,
																	hands=gear.Carmine.Hands,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Merlinic.Feet.Burst,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Telos Earring",
																	right_ear="Sherida Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.Haste}
	-- 100% MND
	sets.precast.WS['Energy Drain'] = 								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.Vanya.Body,
																	hands=gear.Carmine.Hands,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Merlinic.Feet.Burst,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Telos Earring",
																	right_ear="Sherida Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.Haste}
	-- 50% DEX
	sets.precast.WS['Evisceration'] = 								{ammo="Amar Cluster",
																	head=gear.Ayanmo.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Ayanmo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Dominance Earring",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rajas Ring",
																	back=gear.Sucellos.WSD}
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
																	right_ear="Crematio Earring",
																	left_ring="Apate Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Sucellos.WSD,}
	-- AGI - 73% / 76% / 79% / 82% / 85%													
	sets.precast.WS['Exenterator'] = 								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.Ayanmo.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Telos Earring",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD,}
	-----------------------------
	--CLUB
	----------------------------- 
	-- 40% STR / 40% MND
	sets.precast.WS['Shining Strike'] =								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 40% STR / 40% MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Seraph Strike'] =								{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 100% STR
	sets.precast.WS['Brainshaker'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}	
	-- Skill
	sets.precast.WS['Starlight'] =									{}
	
	-- Skill (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Moonlight'] =									{}

	-- 100% STR
	sets.precast.WS['Skullbreaker'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 100% STR
	sets.precast.WS['True Strike'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 50% STR / 50% MND (/WAR, /WHM, /PLD, /DRK, /SAM, /BLU, /GEO.)
	sets.precast.WS['Judgement'] =									{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 50% STR / 50% MND
	sets.precast.WS['Flash Nova'] =									{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- MND - 73% / 76% / 79% / 82% / 85%
	sets.precast.WS['Realmrazer'] =									{ammo="Amar Cluster",
																	head=gear.Merlinic.Head.DrAsp,
																	body=gear.Vanya.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Merlinic.Feet.Burst,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Stikini Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.Haste,}
	-----------------------------
	--STAFF
	-----------------------------
	-- 100% STR
	sets.precast.WS['Heavy Swing'] =								{ammo="Amar Cluster",
																	head=gear.RDMAF.Head,
																	body=gear.Despair.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Despair.Legs,
																	feet=gear.Despair.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 40% STR / 40% INT
	sets.precast.WS['Rock Crusher'] =								{ammo="Pemphredo Tathlum",
																	head=gear.RDMAF.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}	
	-- 40% STR / 40% INT
	sets.precast.WS['Earth Crusher'] =								{ammo="Pemphredo Tathlum",
																	head=gear.RDMAF.Head,
																	body=gear.Jhakri.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.Jhakri.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Shiva Ring +1",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}	
	-- 40% STR / 40% MND
	sets.precast.WS['Starburst'] =									{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	-- 40% STR / 40% MND
	sets.precast.WS['Sunburst'] =									{ammo="Regal Gem",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Jhakri.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Fotia Gorget",
																	waist="Fotia Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Sherida Earring",
																	left_ring="Apate Ring",
																	right_ring="Rufescent Ring",
																	back=gear.Sucellos.WSD}
	----------------------------------------------------------------
    -- Spell Catch All Precast set
	----------------------------------------------------------------
	sets.precast.FC = 												{main=gear.Staff.Grioavolr.Nuke,	-- 7
																	sub="Clerisy Strap", 				-- 2
																	ammo="Sapience Orb", 				-- 2
																	head=gear.RDMAF.Head, 				--16
																	body=gear.RDMRelic.Body, 			--14
																	hands=gear.Leyline, 				-- 7
																	legs=gear.Psycloth.Legs, 			-- 7
																	feet=gear.Merlinic.Feet.FC, 		--12
																	neck="Voltsurge Torque", 			-- 4
																	waist="Witful Belt", 				-- 3
																	left_ear="Loquac. Earring", 		-- 2
																	right_ear="Etiolation Earring", 	-- 1
																	right_ring="Kishar Ring", 			-- 4
																	left_ring="Prolix Ring",			-- 2
																	back=gear.Sucellos.Haste,}
	----------------------------------------------------------------
    -- Spell Quickcast Magic 10% Cap
	----------------------------------------------------------------
	sets.precast.FC.QC =											{back="Perimede Cape",waist="Witful Belt"}
	----------------------------------------------------------------
	-- Dark Magic Precast set(s) (Stun Drain Aspir only!!)
	----------------------------------------------------------------
	sets.precast.FC['Dark Magic'] =    								sets.precast.FC
	sets.precast.FC.Drain = 										set_combine(sets.precast.FC,sets.precast.FC.QC,{})
    sets.precast.FC.Aspir = 										set_combine(sets.precast.FC,sets.precast.FC.QC,{})
    sets.precast.FC.Stun = 											set_combine(sets.precast.FC,sets.precast.FC.QC,{})
	----------------------------------------------------------------
	-- Divine Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Divine Magic'] = 								sets.precast.FC
	----------------------------------------------------------------
	-- Elemental Magic Precast set(s)
	----------------------------------------------------------------
    sets.precast.FC['Elemental Magic'] = 							sets.precast.FC
	----------------------------------------------------------------
	-- Enfeebling Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enfeebling Magic'] = 							set_combine(sets.precast.FC,sets.precast.FC.QC,{head=gear.RDMEmpy.Head})
	----------------------------------------------------------------
	-- Enhancing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Enhancing Magic'] = 							set_combine(sets.precast.FC,sets.precast.FC.QC,{head="Umuthi Hat",waist="Siegel Sash"})
	sets.precast.FC.Stoneskin = 									set_combine(sets.precast.FC['Enhancing Magic'],{head="Umuthi Hat",waist="Siegel Sash",legs="Doyen Pants",})
	----------------------------------------------------------------
	-- Healing Magic Precast set(s)
	----------------------------------------------------------------
	sets.precast.FC['Healing Magic'] =								set_combine(sets.precast.FC,sets.precast.FC.QC,{})
	sets.precast.FC.Cure =											set_combine(sets.precast.FC['Healing Magic'],
																	{main=gear.Staff.Serenity,
																	head=gear.Vanya.Head,
																	hands=gear.Vanya.Hands,
																	legs="Doyen pants",
																	ear2="Mendicant's earring",
																	back="Pahtli cape"})
																	
	sets.precast.FC.Curaga =										sets.precast.FC.Cure
    ----------------------------------------------------------------
    -- Ninjutsu Magic Precast set(s)
	----------------------------------------------------------------
 	sets.precast.FC['Ninjutsu'] =									set_combine(sets.precast.FC,sets.precast.FC.QC,{})   
    sets.precast.FC.Utsusemi = 										set_combine(sets.precast.FC['Ninjutsu'],{})
	---------------------------------------------------------------
	-- Dancer Steps/Flourishes/Waltz Precast set(s)
	---------------------------------------------------------------
	sets.precast.Step = 											{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Sucellos.TP,}
     
    sets.precast.Flourish = 										{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Sucellos.TP,}
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
																	head=gear.Carmine.Head,
																	body=gear.RDMRelic.Body,
																	hands=gear.Leyline,
																	legs=gear.Psycloth.Legs,
																	feet=gear.Merlinic.Feet.FC,
																	neck="Voltsurge Torque",
																	waist="Witful Belt",
																	left_ear="Loquac. Earring",
																	right_ear="Etiolation Earring",
																	right_ring="Kishar Ring",
																	back=gear.Sucellos.Haste,}
	----------------------------------------------------------------
	-- Dark Magic Midcast set(s)
	----------------------------------------------------------------
    sets.midcast['Dark Magic'] = 									{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Psycloth.Body,
																	hands=gear.Chironic.Hands,
																	legs=gear.Amalric.Legs.C,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",	
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Perimede Cape",}
																	
	sets.midcast.Drain =											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head="Pixie Hairpin +1",
																	body=gear.Merlinic.Body.DrAsp,
																	hands=gear.Merlinic.Hands.DrAsp,
																	legs=gear.Merlinic.Legs.DrAsp,
																	feet=gear.Merlinic.Feet.DrAsp,
																	neck="Erra Pendant",
																	waist="Fucho-no-Obi",
																	left_ear="Dark Earring",
																	right_ear="Abyssal Earring",
																	left_ring="Evanescence Ring",
																	right_ring="Excelsis Ring",
																	back=gear.Sucellos.Nuke,}
																	
	sets.midcast.Aspir =											sets.midcast.Drain
	
    sets.midcast.Stun = 											{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Carmine.Body,
																	hands=gear.Chironic.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Erra Pendant",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Evanescence Ring",
																	right_ring="Kishar Ring",
																	back=gear.Sucellos.Haste,}
	----------------------------------------------------------------
	-- Divine Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Divine Magic'] = 									set_combine(sets.midcast.FastRecast,{})
	
	sets.midcast.DivineNuke	=										set_combine(sets.midcast['Divine Magic'],{
																	body=gear.Vanya.Body,
																	legs=gear.Kaykaus.Legs,
																	feet=gear.Mediums,
																	neck="Incanter's torque",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini ring",
																	right_ring="Stikini ring",
																	back=gear.Sucellos.Nuke,})
	----------------------------------------------------------------
	-- Elemental Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Elemental Magic'] = 								{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.RDMAF.Head,
																	body=gear.Psycloth.Body,
																	hands=gear.Psycloth.Hands,
																	legs=gear.RDMRelic.Legs,
																	feet=gear.Merlinic.Feet.MAB,
																	neck="Incanter's Torque",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Elemental Earring",
																	left_ring="Resonance Ring",
																	right_ring="Stikini Ring",
																	back=gear.Sucellos.Nuke,}
	
	sets.midcast.LowTierNuke =					 					{main=gear.Staff.Grioavolr.Nuke,
																	sub="Enki Strap",
																	ammo="Ghastly Tathlum +1",
																	head=gear.Merlinic.Head.MAB,
																	body=gear.Merlinic.Body.MAB,
																	hands=gear.Jhakri.Hands,
																	legs=gear.Merlinic.Legs.MAB,
																	feet=gear.Amalric.Feet,
																	neck="Sanctity Necklace",
																	waist="Refoccilation Stone",
																	left_ear="Friomisi Earring", 
																	right_ear="Crematio Earring",
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Sucellos.Nuke,}
																	
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
																	right_ear="Crematio Earring",
																	left_ring="Resonance Ring",
																	right_ring="Adoulin Ring",
																	back=gear.Sucellos.Nuke,}
																	
    sets.midcast.HighTierNuke.Resistant = 							sets.midcast['Elemental Magic']
	
	sets.midcast.HelixNuke = 										set_combine(sets.midcast.HighTierNuke,{})
	
	sets.midcast.HelixNuke.Resistant = 								set_combine(sets.midcast.HelixNuke,{waist="Eschan stone"})
	
	sets.midcast.ElementalEnfeeble = 								sets.midcast['Elemental Magic']
	----------------------------------------------------------------
	-- Enfeebling Magic Midcast set(s)
	----------------------------------------------------------------
    sets.midcast['Enfeebling Magic'] = 								{main=gear.Staff.Grioavolr.Enf,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head=gear.RDMRelic.Head,
																	body=gear.RDMAF.Body,
																	hands="Regal Cuffs",
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Mediums,
																	neck="Duelist's Torque",
																	waist="Luminary Sash",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Kishar Ring",
																	back=gear.Sucellos.Haste,}

	sets.midcast.MndEnfeebles = 									sets.midcast['Enfeebling Magic']
	sets.midcast.IntEnfeebles = 									set_combine(sets.midcast['Enfeebling Magic'], {back=gear.Sucellos.Nuke})
	
	sets.midcast.MndEnfeebles.Resistant =							{main=gear.Staff.Grioavolr.Enf,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head=gear.RDMRelic.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMEmpy.Hands,
																	legs=gear.Chironic.Legs.Macc,
																	feet=gear.Mediums,
																	neck="Duelist's Torque",
																	waist="Rumination Sash",
																	left_ear="Digni. Earring",
																	right_ear="Gwati Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Sucellos.Haste,}
	
	sets.midcast.IntEnfeebles.Resistant =							sets.midcast.MndEnfeebles.Resistant	

	sets.midcast.Impact = 											set_combine(sets.midcast['Elemental Magic'],{head=empty,body="Twilight Cloak"})
 
    sets.midcast['Slow II'] = 										set_combine(sets.midcast['Enfeebling Magic'], 
																	{head=gear.RDMRelic.Head,
																	body=gear.RDMAF.Body,
																	back=gear.Sucellos.Haste,})
    
	sets.midcast['Slow II'].Resistant = 							sets.midcast.MndEnfeebles.Resistant
	
    sets.midcast['Paralyze II'] = 									set_combine(sets.midcast['Enfeebling Magic'], 
																	{head=gear.Merlinic.Head.MAB,
																	body=gear.RDMAF.Body,
																	feet=gear.RDMRelic.Feet,
																	back=gear.Sucellos.Haste,})
    
	sets.midcast['Paralyze II'].Resistant =							sets.midcast.MndEnfeebles.Resistant
	
	sets.midcast['Addle II'] = 										set_combine(sets.midcast['Enfeebling Magic'], 
																	{head=gear.Merlinic.Head.MAB,
																	body=gear.RDMAF.Body,
																	back=gear.Sucellos.Haste,})
    
	sets.midcast['Addle II'].Resistant = 							sets.midcast.MndEnfeebles.Resistant
	
	sets.midcast['Frazzle III'] = 									set_combine(sets.midcast['Enfeebling Magic'], 
																	{body=gear.RDMAF.Body,legs=gear.Chironic.Legs.Macc,back=gear.Sucellos.Nuke})
	
	sets.midcast['Frazzle III'].Resistant =							sets.midcast.MndEnfeebles.Resistant
	
	sets.midcast['Distract III'] = 									set_combine(sets.midcast['Enfeebling Magic'], 
																	{body=gear.RDMAF.Body,legs=gear.Chironic.Legs.Macc,back=gear.Sucellos.Nuke})
	
	sets.midcast['Distract III'].Resistant =						sets.midcast.MndEnfeebles.Resistant
	----------------------------------------------------------------
	-- Enhancing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Enhancing Magic'] = 								{main=gear.Staff.Grioavolr.Enh,
																	sub="Fulcio Grip",
																	ammo="Regal Gem",
																	head=gear.Telchine.Head,
																	body=gear.RDMRelic.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Telchine.Legs,
																	feet=gear.RDMEmpy.Feet,
																	neck="Incanter's Torque",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Sucellos.Haste,}
																	
	sets.midcast.Aquaveil =  										set_combine(sets.midcast['Enhancing Magic'],{head=gear.Amalric.Head.A,hands="Regal Cuffs"})
	sets.midcast.BarSpell =											set_combine(sets.midcast['Enhancing Magic'],{})
	
	sets.midcast['Enhancing Magic'].Enspell =						{ammo="Regal Gem",
																	head="Befouled Crown",
																	body=gear.RDMRelic.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMEmpy.Feet,
																	neck="Incanter's Torque",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.RDMJSECape.EnhDur,}
	
	sets.midcast.Refresh = 											{main=gear.Staff.Grioavolr.Enh,
																	sub="Clerisy Strap",
																	ammo="Sapience Orb",
																	head=gear.Amalric.Head.A,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMEmpy.Legs,
																	feet=gear.RDMEmpy.Feet,
																	neck="Voltsurge Torque",
																	waist="Gishdubar Sash",
																	left_ear="Loquac. Earring",
																	right_ear="Etiolation Earring",
																	right_ring="Kishar Ring",
																	back=gear.Sucellos.Haste,}
	
	sets.midcast.RefreshSelf = 										set_combine(sets.midcast.Refresh,{waist="Gishdubar Sash",back="Grapevine Cape",})
	
	sets.midcast.Regen = 											set_combine(sets.midcast['Enhancing Magic'],
																	{main=gear.Staff.Grioavolr.Enh,
																	head=gear.Telchine.Head,
																	body=gear.Telchine.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMEmpy.Legs,
																	feet=gear.RDMEmpy.Feet,
																	back=gear.Sucellos.Haste,})
																	
	sets.midcast.Stoneskin =					 					set_combine(sets.midcast.FastRecast,
																	{neck="Nodens gorget",waist="Siegel Sash",right_ear="Earthcry Earring",back="Perimede Cape",})
																
	sets.midcast.Gain =												{main=gear.Staff.Grioavolr.Enh,
																	sub="Fulcio Grip",
																	ammo="Regal Gem",
																	head=gear.Telchine.Head,
																	body=gear.RDMRelic.Body,
																	hands=gear.RDMRelic.Hands,
																	legs=gear.Telchine.Legs,
																	feet=gear.RDMEmpy.Feet,
																	neck="Incanter's Torque",
																	waist="Cetl Belt",
																	left_ear="Andoaa Earring",
																	right_ear="Augment. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back=gear.Sucellos.Haste,}
	----------------------------------------------------------------
	-- Healing Magic Midcast set(s)
	----------------------------------------------------------------
	sets.midcast['Healing Magic'] = 								set_combine(sets.midcast.FastRecast,{})
	
	sets.midcast.Cure =												{main=gear.Staff.Serenity,
																	sub="Enki Strap",
																	ammo="Regal Gem",
																	head=gear.Vanya.Head,
																	body="Vrikodara Jupon",
																	hands=gear.Leyline,
																	legs="Doyen Pants",
																	feet=gear.Vanya.Feet,
																	neck="Nodens Gorget",
																	waist="Rumination Sash",
																	left_ear="Loquac. Earring",
																	right_ear="Mendi. Earring",
																	left_ring="Stikini Ring",
																	right_ring="Stikini Ring",
																	back="Pahtli Cape",}
																	
	sets.midcast.Curaga = 											sets.midcast.Cure
	
	--[[sets.midcast.Cursna = 											set_combine(sets.midcast['Healing Magic'],{
																	feet="Gendewitha galoshes +1",
																	neck="Malison medallion",
																	right_ear="Beatific earring",
																	left_ring="Haoma's ring",
																	right_ring="Haoma's ring",
																	back="Oretania's cape +1"})]]--
	
	sets.midcast.NaSpell = 											sets.midcast.FastRecast
    ----------------------------------------------------------------
    -- Ninjutsu Magic set(s)
	----------------------------------------------------------------
 	sets.midcast['Ninjutsu'] =										set_combine(sets.midcast.FastRecast,{})   
    sets.midcast.Utsusemi = 										set_combine(sets.midcast['Ninjutsu'],{})
	----------------------------------------------------------------
	-- Waltz set
	----------------------------------------------------------------
    sets.midcast.Waltz = 											{ammo="Iron Gobbet",
																	head=gear.RDMAF.Head,
																	body=gear.RDMAF.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Unmoving Collar",
																	waist="Caudata Belt",
																	left_ear="Odnowa Earring +1",
																	right_ear="Genmei Earring",
																	left_ring="Metamor. Ring +1",
																	right_ring="Defending Ring",
																	back="Xucau Mantle",}																			
----------------------------------------------------------------------------
-- ENGAGED SETS
----------------------------------------------------------------------------
     -- Engaged sets

        -- Variations for TP weapon and (optional) offense/defense modes. Code will fall back on previous
        -- sets if more refined versions aren't defined.
        -- If you create a set with both offense and defense modes, the offense mode should be first.
        -- EG: sets.engaged.Dagger.Accuracy.Evasion
         
        --MeleeWeapons = {"Fettering Blade","Vampirism","Malevolence","Emissary","Genmei Shield"}
         
        -- Normal melee group
----------------------------------------------------------------------------
-- ENGAGED SETS
----------------------------------------------------------------------------
	sets.engaged = {}
	sets.engaged.Acc = {}
	
-- DANCER SUB
    ----------------------------------------------------------------
	-- 59 DW To Cap Delay (58 DW is 79.75% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_0 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 59 DW To Cap Delay
	---------------------------------------------------------------- 
	sets.engaged.Acc.DNCHaste_0 = 									{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 57 DW To Cap Delay (56 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_5 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 57 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_5 =									set_combine(sets.engaged.DNCHaste_5,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
    ----------------------------------------------------------------
	-- 55 DW To Cap Delay (54 DW is 79.84% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_10 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 55 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_10 =									set_combine(sets.engaged.DNCHaste_10,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
	----------------------------------------------------------------
	-- 52 DW To Cap Delay (51 DW is 79.58% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.DNCHaste_15 = 										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 52 DW To Cap Delay
	----------------------------------------------------------------     
	sets.engaged.Acc.DNCHaste_15 = 									set_combine(sets.engaged.DNCHaste_15,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})																	
    ----------------------------------------------------------------
	-- 49 DW To Cap Delay (48 DW is 79.62% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_20 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 49 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_20 =									set_combine(sets.engaged.DNCHaste_20,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
    ----------------------------------------------------------------
	-- 45 DW To Cap Delay (44 DW is 79.50% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_25 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 45 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_25 =									set_combine(sets.engaged.DNCHaste_25,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
	----------------------------------------------------------------
	-- 41 DW To Cap Delay (40 DW is 79.74% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.DNCHaste_30 = 										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 41 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_30 = 									set_combine(sets.engaged.DNCHaste_30,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
	----------------------------------------------------------------	
	-- 36 DW To Cap Delay (35 DW is 79.98% Delay Reduction, 34 DW is 79.58%)
	----------------------------------------------------------------
    sets.engaged.DNCHaste_35 = 										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 36 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_35 = 									set_combine(sets.engaged.DNCHaste_35,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
    ----------------------------------------------------------------
	-- 28 DW To Cap Delay (27 DW is 79.67% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_40 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 28 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_40 =									set_combine(sets.engaged.DNCHaste_40,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})																																					
	----------------------------------------------------------------
	-- 21 DW To Cap Delay (20 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.DNCMagicHasteCapped = 								{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Carmine.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}				
    ----------------------------------------------------------------
	-- 21 DW To Cap Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.DNCMagicHasteCapped = 							set_combine(sets.engaged.DNCMagicHasteCapped,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})		
    ----------------------------------------------------------------
	-- 19 DW To Cap Delay (18 DW is 79.85% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.DNCHaste_40Samba =									{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Taeon.Body,
																	hands=gear.Despair.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 19 DW to Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.DNCHaste_40Samba =								set_combine(sets.engaged.DNCHaste_40Samba,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
	----------------------------------------------------------------
	-- 9 DW To Cap Delay (8 DW is 79.77% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.DNCMagicHasteCappedSamba = 						{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Despair.Hands,
																	legs="Zoar Subligar",
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 9 DW To Cap Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.DNCMagicHasteCappedSamba = 					set_combine(sets.engaged.DNCMagicHasteCappedSamba,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
-- NINJA SUB
    ----------------------------------------------------------------
	-- 49 DW To Cap Delay (48 DW is 79.75% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_0 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.DW}
    ----------------------------------------------------------------
	-- 49 DW To Cap Delay
	---------------------------------------------------------------- 
	sets.engaged.Acc.NINHaste_0 = 									set_combine(sets.engaged.NINHaste_0,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.DW,})
    ----------------------------------------------------------------
	-- 47 DW To Cap Delay (46 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_5 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 47 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_5 =									set_combine(sets.engaged.NINHaste_5,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
    ----------------------------------------------------------------
	-- 45 DW To Cap Delay (44 DW is 79.84% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_10 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 45 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_10 =									set_combine(sets.engaged.NINHaste_10,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
	----------------------------------------------------------------
	-- 42 DW To Cap Delay (41 DW is 79.58% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.NINHaste_15 = 										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 42 DW To Cap Delay
	----------------------------------------------------------------     
	sets.engaged.Acc.NINHaste_15 = 									set_combine(sets.engaged.NINHaste_15,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})																	
    ----------------------------------------------------------------
	-- 39 DW To Cap Delay (38 DW is 79.62% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_20 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 39 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_20 =									set_combine(sets.engaged.NINHaste_20,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
    ----------------------------------------------------------------
	-- 35 DW To Cap Delay (34 DW is 79.50% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_25 =										{ammo="Amar Cluster",
																	head=gear.Taeon.Head,
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 35 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_25 =									set_combine(sets.engaged.NINHaste_25,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
	----------------------------------------------------------------
	-- 31 DW To Cap Delay (30 DW is 79.74% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.NINHaste_30 = 										{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 31 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_30 = 									set_combine(sets.engaged.NINHaste_30,
																	{ammo="Amar Cluster",				
																	head=gear.Carmine.Head,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
	----------------------------------------------------------------	
	-- 26 DW To Cap Delay (25 DW is 79.98% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.NINHaste_35 = 										{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 26 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_35 = 									set_combine(sets.engaged.NINHaste_35,
																	{ammo="Amar Cluster",	
																	head=gear.Carmine.Head,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
    ----------------------------------------------------------------
	-- 18 DW To Cap Delay (17 DW is 79.67% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_40 =										{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Taeon.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Carmine.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Dudgeon Earring",
																	right_ear="Heartseeker Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 18 DW To Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_40 =									set_combine(sets.engaged.NINHaste_40,
																	{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	feet=gear.RDMAF.Feet,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})																																					
	----------------------------------------------------------------
	-- 11 DW To Cap Delay (10 DW is 79.69% Delay Reduction)
	----------------------------------------------------------------
    sets.engaged.NINMagicHasteCapped = 								{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Taeon.Body,
																	hands=gear.Taeon.Hands,
																	legs="Zoar Subligar",
																	feet=gear.Carmine.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 11 DW To Cap Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.NINMagicHasteCapped = 							set_combine(sets.engaged.NINMagicHasteCapped,
																	{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})		
    ----------------------------------------------------------------
	-- 9 DW To Cap Delay (8 DW is 79.85% Delay Reduction)
	----------------------------------------------------------------
	sets.engaged.NINHaste_40Samba =									{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Despair.Hands,
																	legs="Zoar Subligar",
																	feet=gear.Taeon.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- 9 DW to Cap Delay
	----------------------------------------------------------------
	sets.engaged.Acc.NINHaste_40Samba =								set_combine(sets.engaged.NINHaste_40Samba,
																	{ammo="Amar Cluster",				
																	neck="Subtlety Spec.",
																	waist="Eschan Stone",	
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring",
																	right_ring="Cacoethic Ring +1",
																	back=gear.Sucellos.TP,})
	----------------------------------------------------------------
	-- Capped Delay
	----------------------------------------------------------------
    sets.engaged.NINMagicHasteCappedSamba = 						{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Despair.Hands,
																	legs="Zoar Subligar",
																	feet=gear.Carmine.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP}
    ----------------------------------------------------------------
	-- Capped Delay
	----------------------------------------------------------------    
	sets.engaged.Acc.NINMagicHasteCappedSamba = 					{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Sucellos.TP,}
--------------------------------------------------------------------																	
-- SINGLE WIELD
	sets.engaged.SW =												{ammo="Amar Cluster",
																	head="Blistering Sallet +1",
																	body=gear.Ayanmo.Body,
																	hands=gear.Ayanmo.Hands,
																	legs=gear.Carmine.Legs,
																	feet=gear.Carmine.Feet,
																	neck="Clotharius Torque",
																	waist="Sarissapho. Belt",
																	left_ear="Sherida Earring",
																	right_ear="Brutal Earring",
																	left_ring="Hetairoi Ring",
																	right_ring="Apate Ring",
																	back=gear.Sucellos.TP,}
	
	sets.engaged.SWACC =											{ammo="Amar Cluster",
																	head=gear.Carmine.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.RDMAF.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Sanctity Necklace",
																	waist="Eschan Stone",
																	left_ear="Digni. Earring",
																	right_ear="Zennaroi Earring",
																	left_ring="Cacoethic Ring +1",
																	right_ring="Cacoethic Ring",
																	back=gear.Sucellos.TP,}																	
--------------------------------------------------------------------
	sets.engaged.tank = 											{ammo="Iron Gobbet",
																	head=gear.Carmine.Head,
																	body=gear.Ayanmo.Body,
																	hands=gear.RDMAF.Hands,
																	legs=gear.Ayanmo.Legs,
																	feet=gear.RDMAF.Feet,
																	neck="Unmoving Collar",
																	waist="Sarissapho. Belt",
																	left_ear="Cryptic Earring",
																	right_ear="Trux Earring",
																	left_ring="Pernicious Ring",
																	right_ring="Defending Ring",
																	back="Reiki Cloak",}
----------------------------------------------------------------------------
-- CUSTOM SETS NOT COVERED ANYWHERE ELSE
----------------------------------------------------------------------------
	sets.buff.Doom = 												{waist="Gishdubar sash",}
    sets.buff.Saboteur = 											{hands=gear.RDMEmpy.Hands}
	----------------------------------------------------------------
    -- Magic burst set
	----------------------------------------------------------------
	sets.magic_burst = 												{head=gear.Merlinic.Head.MAB,    	-- 9%
																	body="Ea Houppelande",				-- 8%	- 8%II
																	hands="Ea Cuffs",      				-- 5%	- 5%II
																	legs=gear.Merlinic.Legs.MAB,     	-- 8%
																	feet=gear.Merlinic.Feet.MAB,   		
																	neck="Mizu. Kubikazari",        	-- 10% 
																	left_ring="Mujin Band",}        	--  	- 5%II
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
	elseif spell.type == "WeaponSkill" then
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
 	elseif spell.action_type == 'Magic' then
		if spell.skill == 'Dark Magic' then
			if spell.english:startswith('Stun') then
				equip(sets.precast.FC.Stun)		
			elseif spell.english:startswith('Drain') then
				equip(sets.precast.FC.Drain)
			elseif spell.english:startswith('Aspir') then
				equip(sets.precast.FC.Aspir)
			else
				equip(sets.precast.FC['Dark Magic'])
			end
		elseif spell.skill == 'Divine Magic' then
			equip(sets.precast.FC['Divine Magic'])
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
	if string.find(spell.english,'Refresh') and player.target == 'Self' then
		equip(sets.midcast.RefreshSelf)
	end
end
----------------------------------------------------------------------------
-- POST MIDCAST FUNCTIONS
----------------------------------------------------------------------------
function job_post_midcast(spell, action, spellMap, eventArgs)
	if state.Buff.Doom then
		equip(sets.buff.Doom)
	end
	if state.Buff.Saboteur then
		equip(sets.buff.Saboteur)
	end
	if spell.action_type == 'Magic' then
		if spell.element == world.day_element or spell.element == world.weather_element and not string.find(spell.english,'helix') or string.find(spell.english,'Stoneskin') then
			equip(sets.Hachirin)
			if spell.skill == 'Enfeebling Magic' then
				if string.find(spell.english,'Dia III') or string.find(spell.english,'Slow II') then
					equip(sets.Dia3_Slow2)
				end
				if string.find(spell.english,'Paralyze II') then
					equip(sets.Para2)
				end
				if string.find(spell.english,'Bio III') or string.find(spell.english,'Blind II') then
					equip(sets.Bio3_Blind2)
				end
			elseif spell.skill == 'Enhancing Magic' then
				if string.find(spell.english,'Enfire') or string.find(spell.english,'Enfire II') 
				or string.find(spell.english,'Enblizzard') or string.find(spell.english,'Enblizzard II')
				or string.find(spell.english,'Enaero') or string.find(spell.english,'Enaero II')
				or string.find(spell.english,'Enstone') or string.find(spell.english,'Enstone II')
				or string.find(spell.english,'Enthunder') or string.find(spell.english,'Enthunder II')
				or string.find(spell.english,'Enwater') or string.find(spell.english,'Enwater II') then
					equip(sets.midcast['Enhancing Magic'].Enspell)
				end
				if string.find(spell.english,'Protect') or string.find(spell.english,'Shell') then
					equip(sets.Protect_Shell)
				end
				if string.find(spell.english,'Regen') then
					equip(sets.midcast.Regen)
				end
			elseif spellMap == 'Refresh' or spellMap == 'Refresh II' or spellMap == 'Refresh III' then
				if spell.target.type == 'Self' then
					equip(sets.midcast.RefreshSelf)
				end
			elseif spell.skill == 'Enhancing Magic' then
				if spell.english:startswith('Gain') then
					equip(sets.midcast.Gain)
				end
			elseif spell.skill == 'Enhancing Magic' then
				if spell.english:startswith('Warp*|Retrace|Escape|Tractor') then
					equip(sets.midcast.FastRecast)
				end		
			end
		end
	end
	if spell.skill == 'Elemental Magic' and state.BurstMode.value == 'Burst On' then
		equip(sets.magic_burst)
	end
end
----------------------------------------------------------------------------
-- AFTERCAST FUNCTIONS
----------------------------------------------------------------------------
function job_aftercast(spell, action, spellMap, eventArgs)
	if not spell.interrupted then
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
function aftercast(spell)
	if player.status == 'Engaged' then
	equip(sets.TP[sets.TP.index[TP_ind]])
	end
end
-- Handle notifications of general user state change.
function job_state_change(stateField, newValue, oldValue)
    if stateField == 'Offense Mode' then
        if newValue == 'None' then
            enable('main','sub','range')
        else
            disable('main','sub','range')
        end
    end
end
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
	if buff == "Doom" then
		if gain then
			equip(sets.buff.Doom)
			disable('waist','left_ring','right_ring')
		else
			enable('waist','left_ring','right_ring')
		end
	elseif buff == "Saboteur" then
		if gain then
			equip(sets.buff.Saboteur)
			disable('hands')
		else
			enable('hands')
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
		elseif naSpells:contains(spell.english) then
            return 'BarSpell'
		end
    end
end
----------------------------------------------------------------------------
-- Modify the default idle set after it was constructed.
----------------------------------------------------------------------------
function customize_idle_set(idleSet)
    if player.mpp < 51 then
		idleSet = set_combine(idleSet, sets.latent_refresh_waist)
	end
    if (player.mpp < 76 and player.tp < 1000) and player.sub_job ~= ('NIN' or 'DNC') then
		idleSet = set_combine(idleSet, sets.latent_refresh_sub)
	end
	if state.Buff.Doom then
		idleSet = set_combine(idleSet, sets.buff.Doom)
	end
    if state.Buff.Saboteur then
		idleSet = set_combine(idleSet, sets.buff.Saboteur)
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
    if (player.mpp < 76 and player.tp < 1000) and player.sub_job ~= ('NIN' or 'DNC') then
		meleeSet = set_combine(meleeSet, sets.latent_refresh_sub)
	end
	if state.Buff.Doom then
		meleeSet = set_combine(meleeSet, sets.buff.Doom)
	end
    if state.Buff.Saboteur then
		meleeSet = set_combine(meleeSet, sets.buff.Saboteur)
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
	--magemode()
	--timedgear()
	determine_haste_group()
end
-------------------------------------------------------------------------------------------------------------------
-- Utility functions specific to this job.
-------------------------------------------------------------------------------------------------------------------
function job_handle_equipping_gear(status, eventArgs)

	if			player.equipment.ring1 == "Warp Ring" then
				disable('ring1')
	elseif		player.equipment.ring2 == "Warp Ring" then
				disable('ring2')
	else		enable('ring1','ring2')
	end
end
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

	if player.sub_job == "DNC" then																				-- ***This Section is for Haste II*** --
		if 		(buffactive[33] and (buffactive[580] or (buffactive.march == 2) or buffactive[604]) and buffactive[370]) or			-- HasteII + (GeoHaste or 2x march or MG) + Samba
				(buffactive[228] and (buffactive[33] or buffactive[580] or (buffactive.march == 2) and buffactive[370])) then		-- Embrava + (HasteII or GeoHaste or 2x march) + Samba
			--add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('DNCMagicHasteCappedSamba')
        elseif 	((buffactive[33] or buffactive[580]) and (buffactive.march == 1 and buffactive [370])) or							-- (HasteII or GeoHaste) + (1x march +Samba)
				(buffactive[604] and buffactive.march == 2 and buffactive[370]) or													-- MG + 2x march + Samba
				((buffactive[228] and buffactive[604]) and buffactive[370]) then													-- Embrava + MG + Samba
            --add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('DNCHaste_40Samba')
		elseif 	(buffactive[580] and (buffactive[33] or (buffactive.march == 2) or buffactive[604])) or   							-- GeoHaste + (HasteII or 2x march or MG)
				(buffactive[604] and ((buffactive.march == 2) and buffactive[370])) or												-- MG + 2x March + Samba
				(buffactive[33] and ((buffactive.march == 2) or buffactive[604])) or												-- HasteII + (2x march or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        --add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('DNCMagicHasteCapped')
        elseif 	((buffactive[33] or buffactive[580]) and buffactive.march == 1) or													-- (HasteII or GeoHaste) + 1x march
				(buffactive[604] and buffactive.march == 2) or																		-- MG + 2x march
				(buffactive[228] and buffactive[604]) then																			-- Embrava + MG
            --add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('DNCHaste_40')	
        elseif 	((buffactive[33] or buffactive[580]) and buffactive[370]) or 														-- (HasteII or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then																	-- Embrava + 1x march
		    --add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('DNCHaste_35')
		elseif 	(buffactive[604] and buffactive.march == 1 and buffactive[370]) or													-- MG + 1x march + Samba
				((buffactive.march == 2) and buffactive[370]) or																	-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or																			-- Embrava + Samba
				(buffactive[33] or buffactive[580]) then																			-- HasteII or GeoHaste  
            --add_to_chat(8, '-------------Haste 30% DNC-------------')
            classes.CustomMeleeGroups:append('DNCHaste_30')
        elseif 	(buffactive[604] and (buffactive.march == 1)) or																	-- MG + 1x march 
				(buffactive.march == 2) or																							-- 2x march
				(buffactive[228]) then																								-- Embrava
		    --add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('DNCHaste_25')
		elseif 	(buffactive[604] and buffactive[370]) then																			-- MG + Samba
		    --add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('DNCHaste_20')
	    elseif 	(buffactive.march == 1 and buffactive[370]) or 																		-- 1x march + Samba
				(buffactive[604]) then																								-- MG
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('DNCHaste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            --add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('DNCHaste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            --add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('DNCHaste_5')
		elseif	state.OffenseMode.value == 'Acc' and
				(not buffactive[604] and 
				not buffactive[580] and 
				not buffactive[370] and 
				not buffactive[228] and 
				not buffactive[214] and 
				not buffactive[33]) then
            --add_to_chat(8, '-------------No  Haste  ACC-------------')
            equip(sets.engaged.Acc.DNCHaste_0)
		elseif	(not buffactive[604] and 
				not buffactive[580] and 
				not buffactive[370] and 
				not buffactive[228] and 
				not buffactive[214] and 
				not buffactive[33]) then
            --add_to_chat(8, '-------------No  Haste-------------')
            equip(sets.engaged.DNCHaste_0)
		end
	elseif player.sub_job == "NIN" then																				-- ***This Section is for Haste II*** --
		if 		(buffactive[33] and (buffactive[580] or (buffactive.march == 2) or buffactive[604]) and buffactive[370]) or			-- HasteII + (GeoHaste or 2x march or MG) + Samba
				(buffactive[228] and (buffactive[33] or buffactive[580] or (buffactive.march == 2) and buffactive[370])) then		-- Embrava + (HasteII or GeoHaste or 2x march) + Samba
			--add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('NINMagicHasteCappedSamba')
        elseif 	((buffactive[33] or buffactive[580]) and (buffactive.march == 1 and buffactive [370])) or							-- (HasteII or GeoHaste) + (1x march +Samba)
				(buffactive[604] and buffactive.march == 2 and buffactive[370]) or													-- MG + 2x march + Samba
				((buffactive[228] and buffactive[604]) and buffactive[370]) then													-- Embrava + MG + Samba
            --add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('NINHaste_40Samba')
		elseif 	(buffactive[580] and (buffactive[33] or (buffactive.march == 2) or buffactive[604])) or   							-- GeoHaste + (HasteII or 2x march or MG)
				(buffactive[604] and ((buffactive.march == 2) and buffactive[370])) or												-- MG + 2x March + Samba
				(buffactive[33] and ((buffactive.march == 2) or buffactive[604])) or												-- HasteII + (2x march or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        --add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('NINMagicHasteCapped')
        elseif 	((buffactive[33] or buffactive[580]) and buffactive.march == 1) or													-- (HasteII or GeoHaste) + 1x march
				(buffactive[604] and buffactive.march == 2) or																		-- MG + 2x march
				(buffactive[228] and buffactive[604]) then																			-- Embrava + MG
            --add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('NINHaste_40')	
        elseif 	((buffactive[33] or buffactive[580]) and buffactive[370]) or 														-- (HasteII or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then																	-- Embrava + 1x march
		    --add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('NINHaste_35')
		elseif 	(buffactive[604] and buffactive.march == 1 and buffactive[370]) or													-- MG + 1x march + Samba
				((buffactive.march == 2) and buffactive[370]) or																	-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or																			-- Embrava + Samba
				(buffactive[33] or buffactive[580]) then																			-- HasteII or GeoHaste  
            --add_to_chat(8, '-------------Haste 30% NIN-------------')
            classes.CustomMeleeGroups:append('NINHaste_30')
        elseif 	(buffactive[604] and (buffactive.march == 1)) or																	-- MG + 1x march 
				(buffactive.march == 2) or																							-- 2x march
				(buffactive[228]) then																								-- Embrava
		    --add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('NINHaste_25')
		elseif 	(buffactive[604] and buffactive[370]) then																			-- MG + Samba
		    --add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('NINHaste_20')
	    elseif 	(buffactive.march == 1 and buffactive[370]) or 																		-- 1x march + Samba
				(buffactive[604]) then																								-- MG
            --add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('NINHaste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            --add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('NINHaste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            --add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('NINHaste_5')
		elseif	state.OffenseMode.value == 'Acc' and
				(not buffactive[604] and 
				not buffactive[580] and 
				not buffactive[370] and 
				not buffactive[228] and 
				not buffactive[214] and 
				not buffactive[33]) then
            --add_to_chat(8, '-------------No  Haste-------------')
            equip(sets.engaged.Acc.NINHaste_0)
		elseif	(not buffactive[604] and 
				not buffactive[580] and 
				not buffactive[370] and 
				not buffactive[228] and 
				not buffactive[214] and 
				not buffactive[33]) then
            --add_to_chat(8, '-------------No  Haste-------------')
            equip(sets.engaged.NINHaste_0)
		end
	elseif 		(state.OffenseMode.value == 'Acc' and 
				(player.sub_job ~= ("NIN" or "DNC"))) and	
				player.status == "Engaged" then	
				equip(sets.engaged.SWACC)
		elseif 	(state.OffenseMode.value == 'Normal' and 
				(player.sub_job ~= ("NIN" or "DNC"))) and	
				player.status == "Engaged" then
				equip(sets.engaged.SW) 
			
		
	end
end
----------------------------------------------------------------------------
-- SPECIFIC TIME GEAR
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
-- Cycle between Melee Mage and Casting Mage
----------------------------------------------------------------------------
--[[function magemode()
	if state.MageMode.value == 'Melee Mage' then
			disable('main','sub')
	elseif state.MageMode.value == 'Casting Mage' then
			enable('main','sub')
	end
end]]--

----------------------------------------------------------------------------
-- Auto Warp Ring
----------------------------------------------------------------------------
--[[function Warpring()
	if player.equipment.left_ring == "Warp Ring" then
		disable('left_ring')
		windower.send_command('@input <span class="shl">wait</span> 10';'@input /item "Warp Ring" <me>';'<span class="shl">wait</span> 10';'@input //gs enable left_ring;')
		return
	end
end]]
----------------------------------------------------------------------------
-- SUBJOB AND MACRO BOOK SELECTION
----------------------------------------------------------------------------
function select_default_macro_book()
    if player.sub_job == 'DNC' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'NIN' then
        set_macro_page(1, 20)
    elseif player.sub_job == 'WHM' then
        set_macro_page(1, 19)
    else
        set_macro_page(1, 20)
	end
end