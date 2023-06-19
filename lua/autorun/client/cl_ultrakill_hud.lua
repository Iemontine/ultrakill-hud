-- create convars
local ho = CreateClientConVar("ultrakill_hud_opacity", 80, true, false, "0-100%", 0, 100)
local he = CreateClientConVar("ultrakill_hud_enable", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)
local hx = CreateClientConVar("ultrakill_hud_xoffset", 0, true, false, "-1000 - 1000", -1000, 1000)
local hy = CreateClientConVar("ultrakill_hud_yoffset", 0, true, false, "-1000 - 1000", -1000, 1000)
local hs = CreateClientConVar("ultrakill_hud_sound", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)
-- constants and fonts
local color_charge = Color(56, 223, 247)
local color_charge2 = Color(247, 60, 56)
local color_gun = Color(64, 223, 255)
-- local color_gun = Color(255, 0, 0)
surface.CreateFont('UltrakillHUD', { font = 'VCR OSD Mono', size = 24, weight = 7000, antialias = true, })  -- for health/shields
surface.CreateFont('UltrakillHUD2', { font = 'VCR OSD Mono', size = 100, weight = 0, antialias = true, })   -- for large text (1 digit no ammo reserve)
surface.CreateFont('UltrakillHUD3', { font = 'VCR OSD Mono', size = 48, weight = 0, antialias = true, })    -- for big text (2 digit no ammo reserve)
surface.CreateFont('UltrakillHUD4', { font = 'VCR OSD Mono', size = 24, weight = 0, antialias = true, })    -- for max column == 4 
surface.CreateFont('UltrakillHUD5', { font = 'VCR OSD Mono', size = 30, weight = 0, antialias = true, })    -- for max column == 3 
surface.CreateFont('UltrakillHUD6', { font = 'VCR OSD Mono', size = 40, weight = 0, antialias = true, })    -- max column == 2 or 1

-- turn ULTRAKILL Arms chat relay
local stamina
local lastST = 0
local lastSR = 0
local lastHP = 0
local lastAP = 0
local animateHP = true
local animateAP = true
local ap_animated = 0
local hp_animated = 0
local hud_on = false

if GetConVar("ultrakill_hud_text") then RunConsoleCommand("ultrakill_hud_text", 0) end
if GetConVar("feedbacker_chatnotif") then RunConsoleCommand("feedbacker_chatnotif", 0) end
if GetConVar("ultrakill_max_stamina") then stamina = GetConVar("ultrakill_max_stamina"):GetInt() end

hook.Add("HUDPaintBackground", "", function()
	if !LocalPlayer():Alive() or !he:GetBool() then -- this causes the health bar to fill up on respawn
		lastST = 0
		lastSR = 0
		lastHP = 0
		lastAP = 0
		animateHP = true
		animateAP = true
		ap_animated = 0
		hp_animated = 0
		hud_on = false
		return -- also stops the hud from being rendered
	end

	if hs:GetBool() and !hud_on then
		EmitSound("ui_startup.wav", Vector(0, 0, 0), -2, CHAN_AUTO, 1, 40)
		hud_on = true
	end

	DisableClipping(true)
	-- cam.Start3D2D(ply:GetShootPos() - val + ply:GetAimVector() * 10 + ply:GetAimVector():Angle():Right() * (-9 + HUDY / 100) + ply:GetAimVector():Angle():Up() * (-5.25 + HUDX / 100) + ply:GetAimVector():Angle():Up() * 2.5 * GetConVar("ultrakill_gamemode_HudScale"):GetInt() / 2,(ply:GetAimVector():Angle():Right() + ply:GetAimVector() / 2 ):Angle() + Angle(0,0,-ply:GetAimVector():Angle()[1] + 90),0.0025 * GetConVar("ultrakill_gamemode_HudScale"):GetInt() / 2)
	cam.Start3D(nil, nil, 65, 0, 0, ScrW()/2, ScrH()) -- hud fov = 77, may want to investigate manipulating this as well as below EyeAngles() and EyePos() to create inertia effect
		local opacity = 255*(ho:GetInt()/100)

		-- desperately fight to make the angle of the HUD identical to ultrakill's
			local up, right, forward = EyeAngles():Up(), EyeAngles():Right(), EyeAngles():Forward()
			local ang = EyeAngles()
			ang:RotateAroundAxis(up, 180)
			ang:RotateAroundAxis(right, 114.5)
			ang:RotateAroundAxis(forward, -90)
			
			local pos = EyePos() + (forward * 7) + (up * (-2.5 + hy:GetFloat()/100)) + (right*(-1.9 + hx:GetFloat()/100))
			-- local pos = LocalPlayer():GetShootPos() + (forward * 7) + (up * (-2.5 + hy:GetFloat()/100)) + (right*(-1.9 + hx:GetFloat()/100))
		-- get health values, animate health if necessary
			local hp = LocalPlayer():Health()
			local hpcol = Color(255, 0, 0)
			local hpmod = (math.Clamp(hp / LocalPlayer():GetMaxHealth(), 0, 1) * 252)

			-- if the player's health changes
			if lastHP ~= hp then
				local diff = hp - lastHP
				if diff ~= 0 and diff ~= hp then -- check difference in health to see if health gain/loss
					animateHP = true
					hp_animated = lastHP
				end
				lastHP = hp
			end
			if animateHP then
				hpmod = (math.Clamp(hp_animated / LocalPlayer():GetMaxHealth(), 0, 1) * 252)
			else
				hpmod = (math.Clamp(hp / LocalPlayer():GetMaxHealth(), 0, 1) * 252)
			end
		-- get shield values, animate shields if necessary
			local ap = LocalPlayer():Armor()
			local apcol = Color(0, 100, 255)
			local apmod = (math.Clamp(ap / LocalPlayer():GetMaxArmor(), 0, 1) * 252)

			-- if the player's shield changes
			if lastAP ~= ap then
				local diff = ap - lastAP
				if diff ~= 0 and diff ~= ap then -- check difference in health to see if shield gain/loss
					animateAP = true
					ap_animated = lastAP
				end
				lastAP = ap
			end
			if animateAP then
				apmod = (math.Clamp(ap_animated / LocalPlayer():GetMaxArmor(), 0, 1) * 252)
			else
				apmod = (math.Clamp(ap / LocalPlayer():GetMaxArmor(), 0, 1) * 252)
			end
		-- if player has shields, split healthbar in half
			if ap > 0 then
				apmod = (apmod / 2)*1.077
				hpmod = (hpmod / 2)*.94
			end
		-- get relevant ammo info
			local weapon = LocalPlayer():GetActiveWeapon()
			local clip1, ammo1, maxclip1 = 0, 0, 0
			local clip2, ammo2, maxclip2 = 0, 0, 0
			if IsValid(weapon) then
				clip1 = weapon:Clip1()
				ammo1 = LocalPlayer():GetAmmoCount(weapon:GetPrimaryAmmoType())
				maxclip1 = weapon:GetMaxClip1()
				clip2 = weapon:Clip2()
				ammo2 = LocalPlayer():GetAmmoCount(weapon:GetSecondaryAmmoType())
				maxclip2 = weapon:GetMaxClip2()
			end
		cam.Start3D2D(pos, ang, 0.016) -- starting drawing hud
			-- background 
				draw.RoundedBox(5, -100, -95, 266, 131, Color(0, 0, 0, opacity))-- gun box
				draw.RoundedBox(5, -100, 39, 266, 58, Color(0, 0, 0, opacity))  -- health, stamina box
				draw.RoundedBox(5, -93, 45, 252, 25, Color(0, 0, 0, opacity))  -- health bar
			-- stamina
				if GetConVar("ultrakill_enabled") and GetConVar("ultrakill_enabled"):GetBool() then
					local x = -93
					local s = GetConVar("ultrakill_max_stamina"):GetInt()
					for i = 1, s do
						draw.RoundedBox(6, x, 73, 252/s, 20, Color(0, 0, 0, opacity))
						x = -93 + 252 / s * i
					end
				else
					draw.RoundedBox(6, -93, 73, 84, 20, Color(0, 0, 0, opacity))
					draw.RoundedBox(6, -9, 73, 84, 20, Color(0, 0, 0, opacity))
					draw.RoundedBox(6, 75, 73, 84, 20, Color(0, 0, 0, opacity))
				end
				-- draw stamina icons
				if GetConVar("ultrakill_enabled") and GetConVar("ultrakill_enabled"):GetBool() then
					local x = -93
					local s = GetConVar("ultrakill_max_stamina"):GetInt()
					for i = 1, math.Clamp(stamina, 0, s) do
						if i == stamina then
							draw.RoundedBox(6, x, 73, 252/s, 20, Color(
								Lerp(CurTime() - lastSR, 255, 56),
								Lerp(CurTime() - lastSR, 255, 223),
								Lerp(CurTime() - lastSR, 255, 247)
							))
						else
							draw.RoundedBox(6, x, 73, 252/s, 20, color_charge)
						end
						x = -93 + 252 / s * i
					end

					if lastST != 0 and stamina < s then
						local c = Color(0, 0, 0)
						if stamina == 0 then
							c = color_charge2
						else
							c = Color(56, 223, 247, 60)
						end
						draw.RoundedBox(6, x, 73, Lerp((CurTime() - lastST) / GetConVar("ultrakill_regen_time"):GetFloat(), 0, 252/s), 20, c)
					end
				else
					draw.RoundedBox(6, -93, 73, 84, 20, color_charge)
					draw.RoundedBox(6, -9, 73, 84, 20, color_charge)
					draw.RoundedBox(6, 75, 73, 84, 20, color_charge)
				end
			-- health and shields
				if animateHP then
					hp_animated = Lerp(1 - math.exp(-7 * FrameTime()), hp_animated, hp)
					if hp_animated == hp then animateHP = false end
				end
				if animateAP then
					ap_animated = Lerp(1 - math.exp(-7 * FrameTime()), ap_animated, ap)
					if ap_animated == ap then animateAP = false end
				end

				if hp > 0 then

					local am = ap > 0
					draw.RoundedBoxEx(5, -93, 45, hpmod, 25, hpcol, true, !am, true, !am)
					draw.SimpleText(hp, "UltrakillHUD", -77, 45.7 + (22.5 / 2), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					if ap > 0 then
						draw.RoundedBoxEx(5, -18.5 + 41, 44, apmod, 25.5, apcol, false, true, false, true)
						draw.SimpleText(ap, "UltrakillHUD", -15+59, 45.7 + (22.5 / 2), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					end
				end
			-- ammo
				if IsValid(weapon) then
					if weapon:GetPrimaryAmmoType() ~= -1 then
						draw.RoundedBox(5, 169, -95, 60, 131, Color(0, 0, 0, opacity))
						local primaryAmmoType = weapon:GetPrimaryAmmoType()
						local secondaryAmmoType = weapon:GetSecondaryAmmoType()
						local ammo1Str = ((clip1 > -1 and '\n/\n' or '')) .. ammo1

						-- calculate max column length
							local maxLen = 0
							local lines = {}
							-- split the multiline ammo1Str into its lines
							for line in ammo1Str:gmatch("[^\r\n]+") do table.insert(lines, line) end
							-- iterate over each line to find the longest column length
							for _, line in ipairs(lines) do
								local length = string.len(line)
								if length > maxLen then maxLen = length end
							end
							local maxcol = maxLen

						-- calculate mag color
						local color_mag = Color(color_charge2.r + (clip1/maxclip1)*(color_charge.r-color_charge2.r), color_charge2.g + (clip1/maxclip1)*(color_charge.g-color_charge2.g), color_charge2.b + (clip1/maxclip1)*(color_charge.b-color_charge2.b))

						-- ugly ass hardcoding the font sizes
						if string.len(ammo1Str) == 1 then
							if ammo1 < 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD2", 199, -80, color_charge2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(ammo1Str, "UltrakillHUD2", 199, -80, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						elseif string.len(ammo1Str) == 2 then
							if ammo1 < 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD3", 199, -53, color_charge2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(ammo1Str, "UltrakillHUD3", 199, -53, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						elseif primaryAmmoType ~= -1 and secondaryAmmoType == -1 and ammo1Str:find("\n", 1, true) ~= nil and clip1 ~= -1 then
							if maxcol <= 2 then
								draw.DrawText(clip1, "UltrakillHUD6", 199, -91.5, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD6", 199, -91.5, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							elseif maxcol == 3 then
								draw.DrawText(clip1, "UltrakillHUD5", 199, -76, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD5", 199, -76, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(clip1, "UltrakillHUD4", 199, -65, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -65, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						elseif primaryAmmoType ~= -1 and secondaryAmmoType ~= -1 and ammo1Str:find("\n", 1, true) ~= nil and clip1 ~= -1 then
							if maxcol <= 3 then
								draw.DrawText(clip1, "UltrakillHUD5", 199.5, -91.5, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD5", 199.5, -91.5, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(tostring(ammo2), "UltrakillHUD5", 199, 2.5, color_charge2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(clip1, "UltrakillHUD4", 199, -90, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -90, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(tostring(ammo2), "UltrakillHUD4", 199, 5, color_charge2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						else -- weapon does not use ammo
							if ammo1 <= 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -45, color_charge2, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -45, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						end
					else -- if weapon does not use ammo
						draw.RoundedBox(5, 169, -95, 60, 131, Color(0, 0, 0, opacity))
						surface.DisableClipping(true)
						surface.SetDrawColor(255, 255, 255)
						surface.SetMaterial(Material("materials/lightning.png"))
						surface.DrawTexturedRect(175,-89, 50, 118)
						surface.DisableClipping(false)
					end
				end
			-- feedbacker/knuckleblaster
				draw.RoundedBox(5, 169, 39, 60, 58, Color(0, 0, 0, opacity))
				local HUDImage
				if GetConVar("feedbacker_arm") ~= nil then
					if GetConVar("feedbacker_arm"):GetString() == 'KNUCKLEBLASTER' then
						HUDImage = Material("materials/knuckleblaster.png")
					else
						HUDImage = Material("materials/feedbacker.png")
					end
				else
					HUDImage = Material("materials/feedbacker.png")          
				end
				surface.DisableClipping(true)
				surface.SetDrawColor(255, 255, 255)
				surface.SetMaterial(HUDImage)
				surface.DrawTexturedRect(175, 44.5, 48, 48)
				surface.DisableClipping(false)
			-- weapon icon
				if IsValid(weapon) then
					if string.StartWith(weapon:GetClass(), "ultrakill_") then
						local weaponName = weapon:GetClass()
						surface.DisableClipping(true)
						surface.SetDrawColor(255, 255, 255)
						surface.SetMaterial(Material("materials/"..weapon:GetClass()..".png"))
						surface.DrawTexturedRect(-90, -80, 240, 100)
						surface.DisableClipping(false)
					else
						local weaponselect = GetAutoIcon(AutoIconParams(weapon), AUTOICON_HL2WEAPONSELECT)
						weaponselect:SetVector('$color2', color_gun:ToVector())
						-- render.SetMaterial(Material("vgui/white"))
						render.SetMaterial(weaponselect)
						render.OverrideBlend(true, BLEND_ONE_MINUS_DST_COLOR, BLEND_ONE, BLENDFUNC_ADD, BLEND_ZERO, BLEND_ONE, BLENDFUNC_ADD)
						render.DrawQuad(Vector(-110, -130, 0), Vector(170, -130, 0), Vector(170, 70, 0), Vector(-110, 70, 0))
						render.OverrideBlend(false)
					end
				end
			-- draw the cross and shield
				if hp > 0 then
					surface.DisableClipping(true)
					surface.SetDrawColor(227, 34, 34)
					surface.SetMaterial(Material("materials/health.png"))
					surface.DrawTexturedRect(-90,51, 12.75, 12.75)
					surface.DisableClipping(false)
					if ap > 0 then
						surface.DisableClipping(true)
						surface.SetDrawColor(20, 95, 207)
						surface.SetMaterial(Material("materials/shield.png"))
						surface.DrawTexturedRect(25, 47.5, 20, 20)
						surface.DisableClipping(false)
					end
				end
		cam.End3D2D()
	cam.End3D()
	DisableClipping(false)
end)

net.Receive("ULTRAKILL_UpdateStaminaCount", function() -- taken directly from ultrakill dash
	local ply = LocalPlayer()
	local oldstamina = stamina
	stamina = net.ReadUInt(31)
	local spawned = net.ReadBool()

	if stamina < GetConVar("ultrakill_max_stamina"):GetInt() and lastST == 0 then lastST = CurTime() end

	if !spawned then
		if stamina > oldstamina then
			lastST, lastSR = CurTime(), CurTime()
			if stamina == GetConVar("ultrakill_max_stamina"):GetInt() then
				if hs:GetBool() then ply:EmitSound("ultrakill/batterycharged.wav", 0, 170) end
				lastST = 0
			elseif hs:GetBool() and stamina == GetConVar("ultrakill_max_stamina"):GetInt() - 1 then
				ply:EmitSound("ultrakill/batterycharged.wav", 0, 160)
			elseif hs:GetBool() then
				ply:EmitSound("ultrakill/batterycharged.wav", 0, 150)
			end
		elseif hs:GetBool() and stamina == oldstamina then
			ply:EmitSound("ultrakill/batteryexpired.wav", 0, 50)
		else
			lastSR = 0
		end
	end
end)

-- create utility menu
hook.Add("PopulateToolMenu", "UltrakillHUD", function()
	spawnmenu.AddToolMenuOption("Utilities", "ULTRAKILL", "UltrakillHUD", "[HUD]", "", "", function(panel)
		panel:ClearControls()
		panel:CheckBox("Draw ULTRAKILL HUD", "ultrakill_hud_enable")
		panel:CheckBox("Enable HUD Sounds", "ultrakill_hud_sound")
		panel:NumSlider("ULTRAKILL HUD Opacity", "ultrakill_hud_opacity", 0, 100, 2)
		panel:ControlHelp("Opacity of the background HUD boxes as a % (0-100)")
		panel:NumSlider("X Offset", "ultrakill_hud_xoffset", -1000, 1000, 2)
		panel:NumSlider("Y Offset", "ultrakill_hud_yoffset", -1000, 1000, 2)
		panel:Help("Customization options coming soon! 6/14/2023")
		panel:Help("(Made by lemontine & spalumn)")
	end)
end)

-- hide the default HL2 hud
local hide = {
	['CHudHealth'] = true,
	['CHudAmmo'] = true,
	['CHudSecondaryAmmo'] = true,
	['CHudBattery'] = true,
}
hook.Add("HUDShouldDraw", "", function(name)
	if he:GetBool() and hide[name] then return false end
end)