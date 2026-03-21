-- create convars
local ho = CreateClientConVar("ultrakill_hud_opacity", 80, true, false, "0-100%", 0, 100)
local he = CreateClientConVar("ultrakill_hud_enable", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)
local hx = CreateClientConVar("ultrakill_hud_xoffset", 0, true, false, "-1000 - 1000", -1000, 1000)
local hy = CreateClientConVar("ultrakill_hud_yoffset", 0, true, false, "-1000 - 1000", -1000, 1000)
local hs = CreateClientConVar("ultrakill_hud_sound", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)
local hesm = CreateClientConVar("ultrakill_hud_enable_style_meter", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)

local default_colors = {
	charge = {56, 223, 247},
	gun = {64, 223, 255},
	damage = {255, 163, 0},
	hard = {63, 63, 63},
	secondary = {255, 0, 0},
	apbase = {0, 100, 255},
}

local colors_file = "ultrakill_hud_colors.json"
local color_prefs = table.Copy(default_colors)

local function LoadColorPrefs()
	local raw = file.Read(colors_file, "DATA")
	if not raw then return end
	local decoded = util.JSONToTable(raw)
	if not istable(decoded) then return end
	for key, rgb in pairs(default_colors) do
		local src = decoded[key]
		if istable(src) and src[1] and src[2] and src[3] then
			color_prefs[key] = {
				math.Clamp(tonumber(src[1]) or rgb[1], 0, 255),
				math.Clamp(tonumber(src[2]) or rgb[2], 0, 255),
				math.Clamp(tonumber(src[3]) or rgb[3], 0, 255),
			}
		end
	end
end

local function SaveColorPrefs()
	file.Write(colors_file, util.TableToJSON(color_prefs, true))
end

LoadColorPrefs()

local function HudColor(key)
	if key == "gun" then key = "charge" end
	if key == "hpbase" then key = "secondary" end
	local rgb = color_prefs[key] or default_colors.charge
	return Color(rgb[1], rgb[2], rgb[3])
end
-- constants and fonts
surface.CreateFont('UltrakillHUD', { font = 'VCR OSD Mono', size = 24, weight = 5000, antialias = true, })  -- for health/shields
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
local lastHPTime = 0
local lastAP = 0
local lastAPTime = 0
local animateHP = true
local animateAP = true
local diffHP = 0
local diffAP = 0
local ap_animated = 0
local hp_animated = 0
local hud_on = false
local hpcol = HudColor("secondary")
local apcol = HudColor("apbase")

if GetConVar("ultrakill_hud_text") then RunConsoleCommand("ultrakill_hud_text", 0) end
if GetConVar("feedbacker_chatnotif") then RunConsoleCommand("feedbacker_chatnotif", 0) end
if GetConVar("ultrakill_max_stamina") then stamina = GetConVar("ultrakill_max_stamina"):GetInt() end

hook.Add("HUDPaintBackground", "", function()
	if !LocalPlayer():Alive() or LocalPlayer():Health() == 0 or !he:GetBool() then -- this causes the health bar to fill up on respawn
		lastST = 0
		lastSR = 0
		lastHP = 0 -- makes it start red
		lastHPTime = 0
		lastAP = 0
		lastAPTime = 0
		diffAP = 0
		diffHP = 0
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
		local color_charge = HudColor("charge")
		local color_gun = HudColor("gun")
		local color_damage = HudColor("damage")
		local color_hard_damage = HudColor("hard")
		local hp_base = HudColor("secondary")
		local ap_base = HudColor("apbase")
		local max_stamina = LocalPlayer():GetNW2Int("UltrakillBase_MaxStamina", GetConVar("ultrakill_max_stamina"):GetInt())
		local render_stamina = true
		local uk_enabled_cvar = GetConVar("ultrakill_enabled")
		if uk_enabled_cvar ~= nil and uk_enabled_cvar:IsValid() then
			render_stamina = uk_enabled_cvar:GetBool()
		end
		if stamina ~= nil then
			-- If we have live stamina data from net, prefer rendering it even if the convar is off/missing
			render_stamina = true
		end
		hpcol = hp_base -- reset to base each frame so flashes don't stick
		apcol = ap_base

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
			local hpmod

			-- if the player's health changes
			if lastHP ~= hp then
				diffHP = hp - lastHP
				if diffHP ~= 0 and hp ~= 0 and lastHP ~= 0 then -- check difference in health to see if gain/loss, hp~=0 and lastHP~=0 make sure it fills up as red on start
					animateHP = true
					lastHPTime = CurTime()
					hp_animated = lastHP
				end
				lastHP = hp
			end
			hpmod = (math.Clamp(hp / LocalPlayer():GetMaxHealth(), 0, 1) * 252)
			local hp_overlay = (math.Clamp(hp_animated / LocalPlayer():GetMaxHealth(), 0, 1) * 252)
			-- get shield values, animate shields if necessary
				local ap = LocalPlayer():Armor()
				local apmod

			-- if the player's shield changes
			if lastAP ~= ap then
				diffAP = ap - lastAP
				if diffAP ~= 0 then -- check difference in health to see if gain/loss, missing addutional conditions that hp checks to make sure it animates when gaining AP for the first time
					animateAP = true
					lastAPTime = CurTime()
					ap_animated = lastAP
				end
				lastAP = ap
			end
			apmod = (math.Clamp(ap / LocalPlayer():GetMaxArmor(), 0, 1) * 252)
			local ap_overlay = (math.Clamp(ap_animated / LocalPlayer():GetMaxArmor(), 0, 1) * 252)
		-- if player has shields, split healthbar in half
			if ap > 0 then
				apmod = (apmod / 2)*1.077
				ap_overlay = (ap_overlay / 2)*1.077
				hpmod = (hpmod / 2)*.94
				hp_overlay = (hp_overlay / 2)*.94
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
				if render_stamina then
					local x = -93
					local s = math.max(max_stamina, stamina or 0)
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
				if render_stamina then
					local x = -93
					local s = math.max(max_stamina, stamina or 0)
					-- fade highlight duration for freshly regained pip
					local highlight_window = 0.35
					if lastSR > 0 and CurTime() - lastSR > highlight_window then
						lastSR = 0
					end

					for i = 1, math.Clamp(stamina, 0, s) do
						if i == stamina and lastSR > 0 then
							local t = math.Clamp((CurTime() - lastSR) / highlight_window, 0, 1)
							draw.RoundedBox(6, x, 73, 252/s, 20, Color(
								Lerp(t, 255, color_charge.r),
								Lerp(t, 255, color_charge.g),
								Lerp(t, 255, color_charge.b)
							))
						else
							draw.RoundedBox(6, x, 73, 252/s, 20, color_charge)
						end
						x = -93 + 252 / s * i
					end

					if lastST != 0 and stamina < s then
						local regenAlpha = stamina == 0 and 255 or 80
						local c = Color(color_charge.r, color_charge.g, color_charge.b, regenAlpha)
						local t = math.Clamp((CurTime() - lastST) / GetConVar("ultrakill_regen_time"):GetFloat(), 0, 1)
						draw.RoundedBox(6, x, 73, Lerp(t, 0, 252/s), 20, c)
					end
				else
					draw.RoundedBox(6, -93, 73, 84, 20, color_charge)
					draw.RoundedBox(6, -9, 73, 84, 20, color_charge)
					draw.RoundedBox(6, 75, 73, 84, 20, color_charge)
				end
			-- draw hard damage
				local aphpRounded = false
				if GetConVar("ultrakill_enabled") and GetConVar("ultrakill_enabled"):GetBool() then
					local hard_damage = LocalPlayer():GetNW2Int( "UltrakillBase_HardDamage" )
					if hard_damage ~= 0 then
						local hdmod = (math.Clamp(hard_damage / LocalPlayer():GetMaxHealth(), 0, 1) * 252)
						aphpRounded = ((100 - hard_damage) - hp  < 0.01)
						if ap > 0 then
							hdmod = (hdmod / 2)*.91
							draw.RoundedBoxEx(5, 159 - hdmod - 136, 45, hdmod, 25, color_hard_damage, !aphpRounded, false, !aphpRounded, false)
						else
							draw.RoundedBoxEx(5, 159 - hdmod, 45, hdmod, 25, color_hard_damage, !aphpRounded, true, !aphpRounded, true)
						end
					end
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
					local am = ap < 0
					if diffHP > 0 then
						local healCol = Color(0, 255, 0)
						local healBlend = 1 - math.Clamp((CurTime() - lastHPTime) / 0.5, 0, 1)
						hpcol = Color(
							Lerp(healBlend, hp_base.r, healCol.r),
							Lerp(healBlend, hp_base.g, healCol.g),
							Lerp(healBlend, hp_base.b, healCol.b)
						)
					else
						hpcol = hp_base
					end
					-- draw lingering damage (old value) behind the live bar
					if hp_overlay > hpmod then
						draw.RoundedBoxEx(5, -93, 45, hp_overlay, 25, color_damage, true, (!am and !aphpRounded), true, (!am and !aphpRounded))
					end
					draw.RoundedBoxEx(5, -93, 45, hpmod, 25, hpcol, true, (!am and !aphpRounded), true, (!am and !aphpRounded))
					draw.SimpleText(hp, "UltrakillHUD", -77, 45.7 + (22.5 / 2), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
					if ap > 0 then
						if diffAP > 0 then
							local healCol = Color(0, 200, 255)
							local healBlend = 1 - math.Clamp((CurTime() - lastAPTime) / 0.5, 0, 1)
							apcol = Color(
								Lerp(healBlend, ap_base.r, healCol.r),
								Lerp(healBlend, ap_base.g, healCol.g),
								Lerp(healBlend, ap_base.b, healCol.b)
							)
						else
							apcol = ap_base
						end
						-- lingering shield damage behind live bar
						if ap_overlay > apmod then
							draw.RoundedBoxEx(5, -18.5 + 41, 45, ap_overlay, 25, color_damage, false, true, false, true)
						end
						draw.RoundedBoxEx(5, -18.5 + 41, 45, apmod, 25, apcol, false, true, false, true)
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

						-- calculate mag color blending from health (warning) to primary
						local color_mag = Color(hp_base.r + (clip1/maxclip1)*(color_charge.r-hp_base.r), hp_base.g + (clip1/maxclip1)*(color_charge.g-hp_base.g), hp_base.b + (clip1/maxclip1)*(color_charge.b-hp_base.b))

						-- ugly ass hardcoding the font sizes
						if string.len(ammo1Str) == 1 then
							if ammo1 < 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD2", 199, -80, hp_base, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(ammo1Str, "UltrakillHUD2", 199, -80, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						elseif string.len(ammo1Str) == 2 then
							if ammo1 < 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD3", 199, -53, hp_base, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
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
								draw.DrawText(tostring(ammo2), "UltrakillHUD5", 199, 2.5, hp_base, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(clip1, "UltrakillHUD4", 199, -90, color_mag, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -90, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
								draw.DrawText(tostring(ammo2), "UltrakillHUD4", 199, 5, hp_base, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						else -- weapon does not use ammo
							if ammo1 <= 3 then
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -45, hp_base, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							else
								draw.DrawText(ammo1Str, "UltrakillHUD4", 199, -45, color_charge, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
							end
						end
					else -- if weapon does not use ammo
						draw.RoundedBox(5, 169, -95, 60, 131, Color(0, 0, 0, opacity))
						surface.DisableClipping(true)
						surface.SetDrawColor(color_charge)
						surface.SetMaterial(Material("materials/lightning.png"))
						surface.DrawTexturedRect(175,-89, 50, 118)
						surface.DisableClipping(false)
					end
				end
			-- feedbacker/knuckleblaster fist (tinted to primary/secondary)
				draw.RoundedBox(5, 169, 39, 60, 58, Color(0, 0, 0, opacity))
				local fistColor = HudColor("charge")
				if GetConVar("feedbacker_arm") ~= nil and GetConVar("feedbacker_arm"):GetString() == "KNUCKLEBLASTER" then
					fistColor = HudColor("secondary")
				end
				-- boost brightness so the grayscale fist pops against the background
				local boost = 1.35
				fistColor = Color(
					math.min(255, math.floor(fistColor.r * boost)),
					math.min(255, math.floor(fistColor.g * boost)),
					math.min(255, math.floor(fistColor.b * boost)),
					255
				)
				surface.DisableClipping(true)
				surface.SetDrawColor(fistColor)
				surface.SetMaterial(Material("materials/fist.png"))
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
end)

net.Receive("ULTRAKILL_UpdateStaminaCount", function() -- taken directly from ultrakill dash
	local ply = LocalPlayer()
	local oldstamina = stamina
	stamina = net.ReadUInt(4) -- messages are only 4 bits long based on observed payloads
	local spawned = net.ReadBool()
	local max_stamina = LocalPlayer():GetNW2Int("UltrakillBase_MaxStamina", GetConVar("ultrakill_max_stamina"):GetInt())

	if stamina < max_stamina and lastST == 0 then lastST = CurTime() end

	if !spawned then
		if stamina > oldstamina then
			lastST, lastSR = CurTime(), CurTime()
			if stamina == max_stamina then
				if hs:GetBool() then ply:EmitSound("ultrakill/batterycharged.wav", 0, 170) end
				lastST = 0
			elseif hs:GetBool() and stamina == max_stamina - 1 then
				ply:EmitSound("ultrakill/batterycharged.wav", 0, 160)
			elseif hs:GetBool() then
				ply:EmitSound("ultrakill/batterycharged.wav", 0, 150)
			end
		elseif stamina < oldstamina then
			lastST = CurTime()
			lastSR = 0
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
		panel:Help("Colors (saved to data/" .. colors_file .. ")")

		local mixers = {}
		local function addColorMixer(label, key)
			local mixer = vgui.Create("DColorMixer", panel)
			mixer:SetLabel(label)
			mixer:SetPalette(false)
			mixer:SetAlphaBar(false)
			mixer:SetWangs(true)
			local rgb = color_prefs[key] or default_colors[key]
			mixer:SetColor(Color(rgb[1], rgb[2], rgb[3]))
			mixer.ValueChanged = function(_, col)
				color_prefs[key] = {col.r, col.g, col.b}
				SaveColorPrefs()
			end
			panel:AddItem(mixer)
			mixers[key] = mixer
		end

		addColorMixer("Primary (stamina/charge + gun icon)", "charge")
		addColorMixer("Secondary (health / warning)", "secondary")
		addColorMixer("Damage flash", "damage")
		addColorMixer("Hard damage bar", "hard")
		addColorMixer("Armor base", "apbase")
		addColorMixer("Gun icon", "gun")

		local resetBtn = vgui.Create("DButton", panel)
		resetBtn:SetText("Reset HUD colors to defaults")
		resetBtn:Dock(TOP)
		resetBtn:DockMargin(0, 6, 0, 6)
		resetBtn.DoClick = function()
			for key, rgb in pairs(default_colors) do
				color_prefs[key] = {rgb[1], rgb[2], rgb[3]}
				if mixers[key] then mixers[key]:SetColor(Color(rgb[1], rgb[2], rgb[3])) end
			end
			SaveColorPrefs()
		end
		panel:AddItem(resetBtn)

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