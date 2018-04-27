	
	-- I did my best to account for all combos of buffs, but if I missed something, 
	-- (After you check both sections) please let me know so it can be added or if any mistakes were made.
	-- Testing has been done for both HasteII and HasteI sections, all appear to be working properly, 
	-- but GeoHaste and Embrava have not been tested yet.

	-- Other Notes :
	--	This is not setup for DNC main with Haste Samba Merits, adjustments need to be made to account for this. (5% non-meritted, 10% fully meritted)
	--	I will be attempting to do the same as below for H2H... but Martial Arts is a much different beast than Dual Wield.
	--	Riki's original that I worked from made some assupmtions about +song gear, I left those out.  
	--	This is WORST CASE SCENARIO assumed for all buffs.
	-- 	Caps : Gear Haste = 256/1024	Magic Haste = 448/1024	Job Ability Haste = 256/1024
	--	For Subjobs with different DW tiers, see my RDM lua (although take note, my RDM.lua ONLY uses the HasteII section)
	--	Shield awareness is still a WIP, the subjob portion of shield awareness works, but I havent figured out how to make this function see a shield
	--	and put you into a different set that doesn't need the DW/Haste values.
	--  http://chiaia.optic-ice.com/Calculator.html#
	
	-- Credit where it's due, this is mainly Rikimarueye's work, I just made it prettier (with some formatting and full comments),
	-- and updated it with the new baseline March Values, and small changes like moving Embrava from 30% to 25%.
	-- Tib
	
	-- Other things needed for this to work properly :
	--	****Very important note : if you dont know what the --[[ and ]]-- are for, they are to comment out sections without having to -- each line
	--	these *HAVE* to be removed if you are copy/pasting the items below or shit wont work.
	
		-- Haste toggle to switch between Haste I and Haste II (in function user_setup() with the rest of the cycle and toggle options)
			--	state.HasteMode = M(false, 'Haste 2')
		
		-- Bind for above toggle (additional local binds, also in function user_setup(), this is just what was there, change as necessary)
			--	send_command('bind ^` gs c toggle HasteMode')
		
		-- Add this section into function user_setup()
	--[[	----------------------------------------------------------------
			-- Determine haste for maximum dual wield effeciency
			---------------------------------------------------------------- 	
			determine_haste_group()
	]]--
		
		-- Your gear sets, I included an example of what they should look like. ***(If you need more, check my NIN.lua --Tib)
		--	I know some people like them formatted differently, the important things bleow are the ** sets.engaged.XXX and sets.engaged.Acc.XXX **
	--[[	----------------------------------------------------------------	
			-- 16 DW To Cap Delay (15 DW is 79.98% Delay Reduction)
			----------------------------------------------------------------
			sets.engaged.Haste_35 = 										{ammo="Seeth. Bomblet +1",
																			head=gear.Ryuo.Head,
																			body="Vatic Byrnie",
																			hands=gear.Ryuo.Hands,
																			legs=gear.Naga.Legs.A,
																			feet=gear.Loyalist,
																			neck="Clotharius Torque",
																			waist="Sarissapho. Belt",
																			left_ear="Trux Earring",
																			right_ear="Eabani Earring",
																			left_ring="Regal Ring",
																			right_ring="Apate Ring",
																			back=gear.Andartia.TP,}
			----------------------------------------------------------------
			-- 16 DW To Cap Delay
			----------------------------------------------------------------
			sets.engaged.Acc.Haste_35 = 									set_combine(sets.engaged.Haste_35,{
																			ammo="Yamarang",				
																			neck="Subtlety Spec.",
																			waist="Eschan Stone",	
																			left_ear="Zennaroi Earring",
																			left_ring="Cacoethic Ring",
																			right_ring="Cacoethic Ring +1",
																			back=gear.Andartia.ACC,})
			---------------------------------------------------------------
			-- 8 DW To Cap Delay (7 DW is 79.67% Delay Reduction)
			----------------------------------------------------------------
			sets.engaged.Haste_40 =											{ammo="Seeth. Bomblet +1",
																			head=gear.Ryuo.Head,
																			body="Vatic Byrnie",
																			hands=gear.Ryuo.Hands,
																			legs=gear.Samnuha.Legs,
																			feet=gear.Loyalist,
																			neck="Clotharius Torque",
																			waist="Sarissapho. Belt",
																			left_ear="Trux Earring",
																			right_ear="Brutal Earring",
																			left_ring="Regal Ring",
																			right_ring="Apate Ring",
																			back=gear.Andartia.TP,}	
	]]--
		
		-- Add this section into Job Specific hooks for non-casting events
	--[[	----------------------------------------------------------------------------
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
	]]--
		
		-- Add this just above "Utility functions specific to this job" 
	--[[	----------------------------------------------------------------------------
			-- Called by the default 'update' self-command.
			----------------------------------------------------------------------------
			function job_update(cmdParams, eventArgs)
				determine_haste_group()
			end
	]]--
		-- Everything below goes under : Utility functions specific to this job.
		
		-- Sub function : if sub_job_id == XX then (resources/Jobs) (nin = 13 dnc = 19)
		
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
	if state.HasteMode.value == true then																					-- ***This Section is for Haste II*** --
		if 		(buffactive[33] and (buffactive[580] or (buffactive.march == 2) or buffactive[604]) and buffactive[370]) or			-- HasteII + (GeoHaste or 2x march or MG) + Samba
				(buffactive[228] and (buffactive[33] or buffactive[580] or (buffactive.march == 2) and buffactive[370])) then		-- Embrava + (HasteII or GeoHaste or 2x march) + Samba
			add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCappedSamba')
        elseif 	((buffactive[33] or buffactive[580]) and (buffactive.march == 1 and buffactive [370])) or							-- (HasteII or GeoHaste) + (1x march +Samba)
				(buffactive[604] and buffactive.march == 2 and buffactive[370]) or													-- MG + 2x march + Samba
				((buffactive[228] and buffactive[604]) and buffactive[370]) then													-- Embrava + MG + Samba
            add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('Haste_40Samba')
		elseif 	(buffactive[580] and (buffactive[33] or (buffactive.march == 2) or buffactive[604])) or   							-- GeoHaste + (HasteII or 2x march or MG)
				(buffactive[604] and ((buffactive.march == 2) and buffactive[370])) or												-- MG + 2x March + Samba
				(buffactive[33] and ((buffactive.march == 2) or buffactive[604])) or												-- HasteII + (2x march or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCapped')
        elseif 	((buffactive[33] or buffactive[580]) and buffactive.march == 1) or													-- (HasteII or GeoHaste) + 1x march
				(buffactive[604] and buffactive.march == 2) or																		-- MG + 2x march
				(buffactive[228] and buffactive[604]) then																			-- Embrava + MG
            add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('Haste_40')	
        elseif 	((buffactive[33] or buffactive[580]) and buffactive[370]) or 														-- (HasteII or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then																	-- Embrava + 1x march
		    add_to_chat(8, '-------------Haste 35%-------------')
			classes.CustomMeleeGroups:append('Haste_35')
		elseif 	(buffactive[604] and buffactive.march == 1 and buffactive[370]) or													-- MG + 1x march + Samba
				((buffactive.march == 2) and buffactive[370]) or																	-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or																			-- Embrava + Samba
				(buffactive[33] or buffactive[580]) then																			-- HasteII or GeoHaste  
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
        elseif 	(buffactive[604] and (buffactive.march == 1)) or																	-- MG + 1x march 
				(buffactive.march == 2) or																							-- 2x march
				(buffactive[228]) then																								-- Embrava
		    add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('Haste_25')
		elseif 	(buffactive[604] and buffactive[370]) then																			-- MG + Samba
		    add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('Haste_20')
	    elseif 	(buffactive.march == 1 and buffactive[370]) or 																		-- 1x march + Samba
				(buffactive[604]) then																								-- MG
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('Haste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('Haste_5')
--[[		elseif	state.OffenseMode.value == 'Acc' and																			-- No Haste and No Haste Accuracy
				(not buffactive[604] and 																							-- These sections are really only useful for jobs
				not buffactive[580] and 																							-- that also single wield on a regular basis (ie RDM)
				not buffactive[370] and 																							-- What these sections do is free up sets.engaged and
				not buffactive[228] and 																							-- sets.engaged.Acc
				not buffactive[214] and 																							-- Notes : Experimental atm, function is SubJob aware,
				not buffactive[33]) then																							-- but NOT Shield aware yet.
            add_to_chat(8, '-------------No  Haste-------------')																	-- I Actually have secondary sets specifically for 
            equip(sets.engaged.Acc.NINHaste_0)																						-- Single wielding that I have to manually switch to.
		elseif	(not buffactive[604] and 																							-- In my RDM.lua these are the "sets.engaged.SW" and
				not buffactive[580] and 																							-- "sets.engaged.SWAcc" sets.
				not buffactive[370] and 																							-- This section is ONLY NECESSARY for subs with differing DW
				not buffactive[228] and 																							-- tiers (note the NIN in front of haste in the set name).
				not buffactive[214] and 																							-- For jobs with only a single DW tier, like NIN or DNC mains,
				not buffactive[33]) then																							-- these sets are exactly the same as sets.engaged and sets.engaged.Acc
            add_to_chat(8, '-------------No  Haste-------------')																	-- Tib
            equip(sets.engaged.NINHaste_0)]]		
		end
    else																													-- ***This section is for Haste I*** --										
		if 		(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) and buffactive[370] or  		-- GeoHaste + (2x march or Haste or MG) + Samba
				(buffactive[228] and buffactive[580] and buffactive[370]) then														-- Embrava + GeoHaste + Samba
	        add_to_chat(8, '-------------Magic Haste Capped + Samba--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCappedSamba')
        elseif 	(buffactive[228] and (buffactive[33] or buffactive[604]) and buffactive[370]) or									-- Embrava + (Haste or MG) + Samba
				((buffactive[33] or buffactive[604]) and ((buffactive.march == 2) and buffactive[370])) then						-- (Haste or MG) + (2x march + Samba)
            add_to_chat(8, '-------------Haste 40% + Samba-------------')
		    classes.CustomMeleeGroups:append('Haste_40Samba')
		elseif 	(buffactive[580] and ((buffactive.march == 2) or buffactive[33] or buffactive[604])) or   							-- GeoHaste + (2x march or Haste or MG)
				(buffactive[228] and buffactive[580]) then																			-- Embrava + GeoHaste
	        add_to_chat(8, '-------------Magic Haste Capped--------------')
	        classes.CustomMeleeGroups:append('MagicHasteCapped')
		elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive.march == 1) or							-- ((Haste + MG) or GeoHaste) + 1x march
				((buffactive[33] or buffactive[604]) and buffactive.march == 2) or													-- (Haste or MG) + 2x march
				(buffactive[228] and buffactive.march == 1 and buffactive[370]) or													-- Embrava + 1x march + Samba
				((buffactive[33] or buffactive[604]) and buffactive[228]) then														-- (Haste or MG) + Embrava
            add_to_chat(8, '-------------Haste 40%-------------')
		    classes.CustomMeleeGroups:append('Haste_40')        
		elseif 	(((buffactive[33] and buffactive[604]) or buffactive[580]) and buffactive[370]) or 									-- ((Haste + MG) or GeoHaste) + Samba
				(buffactive[228] and buffactive.march == 1) then 																	-- Embrava + 1x march
            add_to_chat(8, '-------------Haste 35%-------------')
            classes.CustomMeleeGroups:append('Haste_35')
		elseif 	((buffactive[33] or buffactive[604]) and buffactive.march == 1 and buffactive[370]) or 								-- (Haste or MG) + 1x march + Samba		
				(buffactive.march == 2 and buffactive[370]) or																		-- 2x march + Samba
				(buffactive[228] and buffactive[370]) or  																			-- Embrava + Samba
				(buffactive[33] and buffactive[604]) or																				-- Haste + MG
				(buffactive[580]) then 																								-- GeoHaste
            add_to_chat(8, '-------------Haste 30%-------------')
            classes.CustomMeleeGroups:append('Haste_30')
		elseif  ((buffactive[33] or buffactive[604]) and buffactive.march == 1) or 													-- (Haste or MG) + 1x march	
				(buffactive.march == 2) or 																							-- 2x march
				(buffactive[228]) then																								-- Embrava
			add_to_chat(8, '-------------Haste 25%-------------')
			classes.CustomMeleeGroups:append('Haste_25')
		elseif 	((buffactive[33] or buffactive[604]) and buffactive[370]) then														-- (Haste or MG) + Samba
		    add_to_chat(8, '-------------Haste 20%-------------')
			classes.CustomMeleeGroups:append('Haste_20')
		elseif	((buffactive.march == 1) and buffactive[370]) or																	-- 1x march + Samba
				(buffactive[33] or buffactive[604]) then																			-- Haste or MG
            add_to_chat(8, '-------------Haste 15%-------------')
            classes.CustomMeleeGroups:append('Haste_15')
        elseif 	(buffactive.march == 1) then																						-- 1x march
            add_to_chat(8, '-------------Haste 10%-------------')
            classes.CustomMeleeGroups:append('Haste_10')
		elseif 	(buffactive[370]) then																								-- Samba
            add_to_chat(8, '-------------Haste  5%-------------')
            classes.CustomMeleeGroups:append('Haste_5')
--[[		elseif	state.OffenseMode.value == 'Acc' and																			-- No Haste and No Haste Accuracy
				(not buffactive[604] and 																							-- These sections are really only useful for jobs
				not buffactive[580] and 																							-- that also single wield on a regular basis (ie RDM)
				not buffactive[370] and 																							-- What these sections do is free up sets.engaged and
				not buffactive[228] and 																							-- sets.engaged.Acc
				not buffactive[214] and 																							-- Notes : Experimental atm, function is SubJob aware,
				not buffactive[33]) then																							-- but NOT Shield aware yet.
            add_to_chat(8, '-------------No  Haste-------------')																	-- I Actually have secondary sets specifically for 
            equip(sets.engaged.Acc.NINHaste_0)																						-- Single wielding that I have to manually switch to.
		elseif	(not buffactive[604] and 																							-- In my RDM.lua these are the "sets.engaged.SW" and
				not buffactive[580] and 																							-- "sets.engaged.SWAcc" sets.
				not buffactive[370] and 																							-- This section is ONLY NECESSARY for subs with differing DW
				not buffactive[228] and 																							-- tiers (note the NIN in front of haste in the set name).
				not buffactive[214] and 																							-- For jobs with only a single DW tier, like NIN or DNC mains,
				not buffactive[33]) then																							-- these sets are exactly the same as sets.engaged and sets.engaged.Acc
            add_to_chat(8, '-------------No  Haste-------------')																	-- Tib
            equip(sets.engaged.NINHaste_0)]]	
        end
    end
end