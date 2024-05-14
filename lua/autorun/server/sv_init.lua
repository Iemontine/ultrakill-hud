-- UNCOMMENT THIS FILE TO REVEAL IMPORTED CODE FROM ULTRAMOD STYLEMETER. GOOD LUCK. SORRY.

-- -- AddCSLuaFile("autorun/shared.lua")
-- -- AddCSLuaFile("autorun/client/cl_init.lua")
-- -- AddCSLuaFile("autorun/client/HUD.lua")

-- -- include("autorun/shared.lua"


-- hook.Add('PlayerInitialSpawn','UltraMod_PlayerInitialSpawn',function(ply,transition)
--     ply.StylePoints = 0
--     ply.StyleTimer = 0
-- end)
-- hook.Add('PlayerSpawn','UltraMod_PlayerSpawn',function(ply,transition)
--     ply.StylePoints = 0
--     ply.StyleTimer = 0
-- end)

-- -- local function AddStyleBonus(ply,bonus)

-- --     if #ply.StyleFeed > 5 then
-- --         if timer.Exists(ply.queuet) then
-- --             ply.StyleQueue[#ply.StyleQueue + 1] = bonus
-- --             timer.Adjust(ply.queuet .. "hehehehaw",timer.TimeLeft(ply.queuet .. "hehehehaw") + 0.3,1,nil)
-- --             timer.Adjust(ply.queuet,0.25,timer.RepsLeft(ply.queuet) + 1,function()  
-- --                 table.remove(ply.StyleFeed,1)
-- --                 ply.StyleFeed[#ply.StyleFeed + 1] = ply.StyleQueue[1]
-- --                 table.remove(ply.StyleQueue,1)
-- --             end)
-- --         else
-- --             ply.StyleQueue[#ply.StyleQueue + 1] = bonus
-- --             timer.Create(ply.queuet,0.25,1,function()  
-- --                 table.remove(ply.StyleFeed,1)
-- --                 ply.StyleFeed[#ply.StyleFeed + 1] = ply.StyleQueue[1]
-- --                 table.remove(ply.StyleQueue,1)
-- --             end)
-- --         end
-- --     else
-- --         ply.StyleFeed[#ply.StyleFeed + 1] = bonus
-- --         timer.Simple(2.5 + #ply.StyleFeed / 3,function() 
-- --             val = table.RemoveByValue(ply.StyleFeed,bonus)
-- --             if val == false then
-- --                 table.RemoveByValue(ply.StyleQueue,bonus)
-- --             end
        
-- --         end)
-- --         if not timer.Exists(ply.queuet .. "hehehehaw") then
-- --             timer.Create(ply.queuet .. "hehehehaw",2.5,1,function() table.Empty(ply.StyleFeed) end)
-- --         end
-- --     end

-- -- end

-- local styleDecreaseInterval = 0.1
-- local lastDecrease = 0
-- hook.Add("Think", "ultrahud_thinking", function()
--     for i, v in ipairs( player.GetAll() ) do
--         local Style = v.StylePoints
--         if Style >= 700 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'ULTRAKILL '..v.StylePoints)
--         elseif Style >= 600 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'SSShitstorm '..v.StylePoints)
--         elseif Style >= 500 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'SSadistic '..v.StylePoints)
--         elseif Style >= 400 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'Supreme '..v.StylePoints)
--         elseif Style >= 300 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'Anarchic '..v.StylePoints)
--         elseif Style >= 200 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'Brutal '..v.StylePoints)
--         elseif Style >= 100 * 2 then
--             v:PrintMessage(HUD_PRINTCENTER, 'Chaotic '..v.StylePoints)
--         elseif Style > 0 then 
--             v:PrintMessage(HUD_PRINTCENTER, 'Destructive '..v.StylePoints)
--         end
--         if CurTime() >= (styleDecreaseInterval + (lastDecrease or 0)) and Style > 0 then
--             v.StylePoints = v.StylePoints - 1 -- use lerp to do this
--             if v.StylePoints == 0 then
--                 v:PrintMessage(HUD_PRINTCENTER, 'No style '..v.StylePoints)
--             end
--             lastDecrease = CurTime()
--         end
--         -- if Style >= 700 * 2 then
--         --     draw.SimpleText("ULTRAKILL",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(255 - DC,196 - DC,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 700 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 600 * 2 then
--         --     draw.SimpleText("SSShitstorm",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(255 - DC,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 600 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 500 * 2 then
--         --     draw.SimpleText("SSadistic",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(255 - DC,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 500 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 400 * 2 then
--         --     draw.SimpleText("Supreme",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(255 - DC,0,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 400 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 300 * 2 then
--         --     draw.SimpleText("Anarchic",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(255 - DC,153 - DC,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 300 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 200 * 2 then
--         --     draw.SimpleText("Brutal",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(238 - DC,255 - DC,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 200 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style >= 100 * 2 then
--         --     draw.SimpleText("Chaotic",StyleRankFont,ScrW() - 260 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(9 - DC,255 - DC,0),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,(Style - 100 * 2) * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- elseif Style > 0 then 
--         --     draw.SimpleText("Destructive",StyleRankFont,ScrW() - 265 + math.Rand(-Shake,Shake),ScrH() / 2 + 50 + math.Rand(-Shake,Shake),Color(0,0,255 - DC),TEXT_ALIGN_CENTER,TEXT_ALIGN_CENTER)
--         --     draw.RoundedBox(3,ScrW() - 450,ScrH() / 2 + 90,Style * 1.75,20,Color(255 - DC,255 - DC,255 - DC))
--         -- end
--     end
-- end)

-- hook.Add( "OnNPCKilled", "ultrahud_npc_killed", function( npc, attacker, inflictor )
--     if attacker:IsPlayer() and dmg == DMG_BLAST then
--         if target:IsOnGround() then
--             if target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
--                 attacker.StylePoints = attacker.StylePoints + 45 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Exploded")
--             end
--         else
--             if target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
--                 attacker.StylePoints = attacker.StylePoints + 120 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Fireworks")
--             end
--         end
--     elseif attacker:IsPlayer() then
--         if target:IsOnGround() then
--             if target:IsPlayer() and dmg == DMG_SLAM or target:IsNPC() and dmg == DMG_SLAM or target:IsNextBot() and dmg == DMG_SLAM then
--                 attacker.StylePoints = attacker.StylePoints + 60 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Ground-Slam")
--             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == DMG_CRUSH then
--                 attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"PropKill")
--             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == 67108865 then
--                 attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Atomizzzzed")
--             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and (dmg == DMG_PUNCH  or dmg == DMG_KNUCKLEBLASTER) then
--                 str = ""
--                 val = 0
--                 if target:GetMaxHealth() > 150 then
--                     str = "Big-"
--                     val = 100
--                 end
--                 attacker.StylePoints = attacker.StylePoints + (40 + val) * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,str .. "FistKill") 
--             elseif target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
--                 str = ""
--                 val = 0
--                 if target:GetMaxHealth() > 150 then
--                     str = "Big-"
--                     val = 60
--                 end
--                 attacker.StylePoints = attacker.StylePoints + (30 + val) * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,str .. "Kill") 
--             end
--         elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == DMG_CRUSH then
--             attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
--             AddStyleBonus(ply,"PropKill")
--         elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == 67108864 then
--             attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
--             AddStyleBonus(ply,"Atomizzzzed")
--         else
--             if target:IsPlayer() and dmg == DMG_SLAM or target:IsNPC() and dmg == DMG_SLAM or target:IsNextBot() and dmg == DMG_SLAM then
--                 attacker.StylePoints = attacker.StylePoints + 160 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Air-Slam")
--             elseif target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
--                 attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
--                 AddStyleBonus(ply,"Airshot")
--             end
--         end
--     end
--     attacker.StylePoints = attacker.StylePoints + 50
-- end)

-- -- hook.Add("entity_killed","ultramod_ent_death",function( data )
-- --     local target = ents.GetByIndex(data.entindex_killed)
-- --     local attacker = ents.GetByIndex(data.entindex_attacker)
-- --     if isnumber(data.entindex_inflictor) then
-- --         local inflictor = ents.GetByIndex(data.entindex_inflictor)
-- --     else
-- --         local inflictor = nil
-- --     end
-- --     local dmg = data.damagebits
-- --     local ply = attacker

-- --     if attacker != target and attacker:IsPlayer() then

-- --     if attacker:IsPlayer() and dmg == DMG_BLAST then
-- --         if target:IsOnGround() then
-- --             if target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
-- --                 attacker.StylePoints = attacker.StylePoints + 45 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Exploded")
-- --             end
-- --         else
-- --             if target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
-- --                 attacker.StylePoints = attacker.StylePoints + 120 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Fireworks")
-- --             end
-- --         end
-- --     elseif attacker:IsPlayer() then
-- --         if target:IsOnGround() then
-- --             if target:IsPlayer() and dmg == DMG_SLAM or target:IsNPC() and dmg == DMG_SLAM or target:IsNextBot() and dmg == DMG_SLAM then
-- --                 attacker.StylePoints = attacker.StylePoints + 60 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Ground-Slam")
-- --             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == DMG_CRUSH then
-- --                 attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"PropKill")
-- --             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == 67108865 then
-- --                 attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Atomizzzzed")
-- --             elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and (dmg == DMG_PUNCH  or dmg == DMG_KNUCKLEBLASTER) then
-- --                 str = ""
-- --                 val = 0
-- --                 if target:GetMaxHealth() > 150 then
-- --                     str = "Big-"
-- --                     val = 100
-- --                 end
-- --                 attacker.StylePoints = attacker.StylePoints + (40 + val) * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,str .. "FistKill") 
-- --             elseif target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
-- --                 str = ""
-- --                 val = 0
-- --                 if target:GetMaxHealth() > 150 then
-- --                     str = "Big-"
-- --                     val = 60
-- --                 end
-- --                 attacker.StylePoints = attacker.StylePoints + (30 + val) * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,str .. "Kill") 
-- --             end
-- --         elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == DMG_CRUSH then
-- --             attacker.StylePoints = attacker.StylePoints + 30 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"PropKill")
-- --         elseif (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and dmg == 67108864 then
-- --             attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"Atomizzzzed")
-- --         else
-- --             if target:IsPlayer() and dmg == DMG_SLAM or target:IsNPC() and dmg == DMG_SLAM or target:IsNextBot() and dmg == DMG_SLAM then
-- --                 attacker.StylePoints = attacker.StylePoints + 160 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Air-Slam")
-- --             elseif target:IsNPC() or target:IsNextBot() or target:IsPlayer() then
-- --                 attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --                 AddStyleBonus(ply,"Airshot")
-- --             end
-- --         end
-- --     end

-- --     if attacker:GetVelocity():Length() > 2500 and dmg == DMG_BLAST and not attacker.Dash then
-- --         attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --         AddStyleBonus(ply,"Ballistic-Missile")
-- --     end 

-- --     if attacker:IsPlayer() and dmg == 8388609 then
-- --         attacker.StylePoints = attacker.StylePoints + 169 * (attacker.StyleMultiplier + 1)
-- --         AddStyleBonus(ply,"GMODed")
-- --     end

-- --     if attacker:IsPlayer() and attacker:InVehicle() then
-- --         attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --         AddStyleBonus(ply,"Transformers")
-- --     end

-- --     if attacker:IsPlayer() and target:IsPlayer() and target != attacker then
-- --         attacker.StylePoints = attacker.StylePoints + 150 * (attacker.StyleMultiplier + 1)
-- --         AddStyleBonus(ply,"Player-Kill")
-- --     end

-- --     for i, ent in ipairs(ents.FindInSphere(target:GetPos(),GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt())) do
-- --         if ent:IsPlayer() and ent != target and target != attacker then
        
-- --             local healUp = 1 * math.Round((105 + GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt() - (target:GetPos() - ent:GetPos()):Length()) / 3) / 15 * 40
        
-- --             if ent:Health() < ent:GetMaxHealth() and healUp < GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt() then
-- --                 ent:SetHealth(ent:Health() + 1 * healUp)
-- --             else
-- --                 ent:SetHealth(ent:Health() + GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt())
-- --             end
-- --             if ent:Health() > ent:GetMaxHealth() then
-- --                 ent:SetHealth(ent:GetMaxHealth())
-- --             end
-- --         end
-- --     end

-- --     end

-- -- end)

-- -- hook.Add("EntityTakeDamage","UltraMod_EntityTakeDamage",function(target,dmg)
    
-- --     local Damage = dmg:GetDamage()

-- --     local IsSNPC = false

-- --     local vall, valll, str = string.find( target:GetClass() , "npc_vj_" , 0 , false)

-- --     if vall != nil and valll != nil then
-- --         IsSNPC = true
-- --     end
    
-- --     if target:IsPlayer() and dmg:GetAttacker() != nil and dmg:GetAttacker():GetPos():Distance(target:GetPos()) <= 80 then
-- --         target.Parryable = true
-- --         target.ParryDmg = DamageInfo()
-- --         target.ParryDmg:SetDamage(dmg:GetDamage())
-- --         target.ParryDmg:SetAttacker(dmg:GetAttacker())
-- --         timer.Simple(1.5,function() target.Parryable = nil target.ParryDmg = nil end)
-- --     end

-- --     if target:Health() > 0 then

-- --         for i, ent in ipairs(ents.FindInSphere(dmg:GetDamagePosition(),GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt())) do
-- --             if ent:IsPlayer() and ent != target and target != dmg:GetAttacker() then
            
-- --                 local healUp = 1 * math.Round((105 + GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt() - (dmg:GetDamagePosition() - ent:GetPos()):Length()) / 3) / 15 * dmg:GetDamage()
            
-- --                 if ent:Health() < ent:GetMaxHealth() and healUp < GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt() then
-- --                     ent:SetHealth(ent:Health() + 1 * healUp)
-- --                 else
-- --                     ent:SetHealth(ent:Health() + GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt())
-- --                 end
-- --                 if ent:Health() > ent:GetMaxHealth() then
-- --                     ent:SetHealth(ent:GetMaxHealth())
-- --                 end
-- --             end
-- --         end

-- --     end
    


-- --     attacker = dmg:GetAttacker()


-- --     if IsSNPC == true and target.IMDEADNOTBIGSUPRISE != true and attacker:IsPlayer() and target:Health() - Damage <= 0 then
-- --         target.IMDEADNOTBIGSUPRISE = true 
-- --         local val = 30
-- --         local bonus = "Kill"
-- --         if not target:IsOnGround() then
-- --             local val = 30 * (attacker.StyleMultiplier + 1)
-- --             local bonus = "Air-Shot"
-- --         elseif dmg:GetDamageType() == DMG_CRUSH and dmg:GetInflictor() != nil and dmg:GetInflictor():IsValid() and dmg:GetInflictor():GetClass() != "prop_combine_ball" then
-- --             val = val + 10 * (attacker.StyleMultiplier + 1)
-- --             bonus = "PropKill"
-- --         elseif dmg:GetInflictor() != nil and dmg:GetInflictor():IsValid() and dmg:GetInflictor():GetClass() == "prop_combine_ball" then
-- --             val = val + 20 * (attacker.StyleMultiplier + 1)
-- --             bonus = "Atomizzzzed"
-- --         elseif dmg:GetDamageType() == DMG_SLAM then
-- --             val = val + 30 * (attacker.StyleMultiplier + 1)
-- --             bonus = "Ground-Slam"
-- --         elseif dmg:GetDamageType() == DMG_BLAST then
-- --             val = val + 30 * (attacker.StyleMultiplier + 1)
-- --             bonus = "Exploded"
-- --             if not target:IsOnGround() then
-- --                 bonus = "Fireworks"
-- --                 val = val + 60 * (attacker.StyleMultiplier + 1)
-- --             end
-- --         elseif dmg:GetDamageType() == DMG_PUNCH or dmg:GetDamageType() == DMG_KNUCKLEBLASTER then
-- --             val = val + 30 * (attacker.StyleMultiplier + 1)
-- --             bonus = "FistKill"
-- --         end

-- --         if dmg:GetDamageType() == DMG_BLAST and attacker:GetVelocity():Length() > 2000 and not attacker.Dash then
-- --             attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"Ballistic-Missile")
-- --         end 
    
-- --         if dmg:GetDamageType() == 8388609 then
-- --             attacker.StylePoints = attacker.StylePoints + 169 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"GMODed")
-- --         end
    
-- --         if attacker:InVehicle() then
-- --             attacker.StylePoints = attacker.StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"Transformers")
-- --         end
    
-- --         if target:IsPlayer() and target != attacker:IsPlayer() then
-- --             attacker.StylePoints = attacker.StylePoints + 150 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(ply,"Player-Kill")
-- --         end

-- --         for i, ent in ipairs(ents.FindInSphere(dmg:GetDamagePosition(),GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt())) do
-- --             if ent:IsPlayer() and ent != target and target != dmg:GetAttacker() then
            
-- --                 local healUp = 1 * math.Round((105 + GetConVar("ultrakill_gamemode_maxbloodregendistance"):GetInt() - (dmg:GetDamagePosition() - ent:GetPos()):Length()) / 3) / 15 * dmg:GetDamage()
            
-- --                 if ent:Health() < ent:GetMaxHealth() and healUp < GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt() then
-- --                     ent:SetHealth(ent:Health() + 1 * healUp)
-- --                 else
-- --                     ent:SetHealth(ent:Health() + GetConVar("ultrakill_gamemode_maxbloodregenperdamagedealt"):GetInt())
-- --                 end
-- --                 if ent:Health() > ent:GetMaxHealth() then
-- --                     ent:SetHealth(ent:GetMaxHealth())
-- --                 end
-- --             end
-- --         end

-- --         attacker.StylePoints = attacker.StylePoints + val
-- --         AddStyleBonus(attacker,bonus)
-- --     end

-- --     if (target:IsNPC() or target:IsNextBot() or target:IsPlayer()) and target:GetMaxHealth() >= 150 and dmg:GetAttacker():IsPlayer() and dmg:GetDamageType() == DMG_PUNCH then
-- --         dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + 40 * (attacker.StyleMultiplier + 1)
-- --         AddStyleBonus(dmg:GetAttacker(),"Disrespect")
-- --     end

-- --     if target:IsPlayer() and dmg:GetInflictor():IsValid() and dmg:GetInflictor().Coin == true then
-- --         dmg:SetDamage(math.Round(dmg:GetDamage() / 5))
-- --     end

-- --     if dmg:GetInflictor().PumpCharge != true and (target:IsPlayer() and target == dmg:GetAttacker() and dmg:GetInflictor().ExplAttacker == target or target:IsPlayer() and target == dmg:GetAttacker() and dmg:GetInflictor().atk == target or dmg:GetInflictor() != nil and dmg:GetInflictor():IsValid() and dmg:GetInflictor():GetOwner() == dmg:GetAttacker()) and dmg:GetAttacker():IsPlayer() and target:IsPlayer() and dmg:GetAttacker() == target and dmg:GetDamageType() == DMG_BLAST then
-- --         if dmg:GetInflictor().MRail == true then
-- --             if math.Round(math.random()) == 1 then
-- --                 dmg:SetDamage(50)
-- --             else
-- --                 dmg:SetDamage(35)
-- --             end
-- --             target:SetVelocity(dmg:GetDamageForce() * 0.3)
-- --         elseif dmg:GetInflictor().Shot == true then
-- --             dmg:SetDamage(35)
-- --             target:SetVelocity(dmg:GetDamageForce() * 0.05)
-- --         else
-- --             dmg:SetDamage(35)
-- --             target:SetVelocity(dmg:GetDamageForce() * 0.025)
-- --         end
-- --     elseif dmg:GetAttacker() == target and dmg:GetInflictor().PumpCharge == true then -- SetThird
-- --         dmg:SetDamage(50)
-- --         target:SetVelocity(target:GetAimVector() * -1500)
-- --     end

-- -- end)

-- -- hook.Add("PostEntityTakeDamage","UltraMod_PostEntityTakeDamage",function(target,dmg,took)

-- --     if dmg:GetInflictor().Coin == true and dmg:GetAttacker():IsPlayer() and dmg:GetInflictor().Parried == true then
-- --         local ply = dmg:GetAttacker()
-- --         if target:IsNPC() or target:IsNextBot() or target:IsPlayer() and target != ply then
-- --             dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + 50 * (attacker.StyleMultiplier + 1)
-- --             AddStyleBonus(dmg:GetAttacker(),"Fistful-Of-Soda")
-- --         end
-- --     elseif dmg:GetInflictor().Coin == true and dmg:GetAttacker():IsPlayer() then
-- --         local ply = dmg:GetAttacker()
-- --         if target:IsNPC() or target:IsNextBot() or target:IsPlayer() and target != ply then
-- --             if ply:GetActiveWeapon():GetPrintName() == "Marksman" or ply:GetActiveWeapon():GetPrintName() == "Pierceshot" and dmg:GetInflictor().Piercer == false or ply:GetActiveWeapon():GetPrintName() == "Slab Marksman" or ply:GetActiveWeapon():GetPrintName() == "Slab Pierceshot" and dmg:GetInflictor().Piercer == false then
-- --                 if dmg:GetInflictor().Chain == 1 then
-- --                     dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + (50 + 15 * dmg:GetInflictor().Chain) * (attacker.StyleMultiplier + 1)
-- --                     AddStyleBonus(dmg:GetAttacker(),"Ricoshot")
-- --                 else
-- --                     dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + (50 + 15 * dmg:GetInflictor().Chain) * (attacker.StyleMultiplier + 1)
-- --                     AddStyleBonus(dmg:GetAttacker(),"Ricoshotx" .. tostring(dmg:GetInflictor().Chain))
-- --                 end
-- --             else
-- --                 if dmg:GetInflictor().Chain == 1 then
-- --                     AddStyleBonus(dmg:GetAttacker(),"ULTRARicoshot")
-- --                     dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + (100 + 15 * dmg:GetInflictor().Chain) * (attacker.StyleMultiplier + 1)
-- --                 else
-- --                     AddStyleBonus(dmg:GetAttacker(),"ULTRARicoshotx" .. tostring(dmg:GetInflictor().Chain))
-- --                     dmg:GetAttacker().StylePoints = dmg:GetAttacker().StylePoints + (100 + 15 * dmg:GetInflictor().Chain) * (attacker.StyleMultiplier + 1)
-- --                 end
-- --             end
-- --         end
-- --     end

-- --     if took then

-- --         if target:IsPlayer() and target != dmg:GetAttacker() then
-- --             if target.StylePoints > 0 then
-- --                 target.StylePoints = target.StylePoints - dmg:GetDamage() * 5
-- --             end
-- --             if target.StylePoints < 0 then
-- --                 target.StylePoints = 0
-- --             end
-- --         end

-- --     end

-- -- end)

-- -- -- -- -ply:GetVelo

-- -- -- hook.Add("Tick","UltraMod_Tick",function()
-- -- --     for _,ply in next, player.GetAll() do
-- -- --         if ply:Alive() then

-- -- --         if ply.Sliding == false and ply.Dash == false and ply.Slamming == false then
-- -- --             ply:SetWalkSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- -- --             ply:SetRunSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- -- --             ply:SetJumpPower(500)
-- -- --         end

-- -- --         if not ply.Sliding and ply.DashStorage == true then
-- -- --             ply.DashStorage = false
-- -- --         end

-- -- --         if ply.FistList != nil and #ply.FistList > 2 then
-- -- --             table.remove(ply.FistList,1)
-- -- --         end

-- -- --         if ply.FistSwitchList != nil and #ply.FistSwitchList > 2 then
-- -- --             table.remove(ply.FistSwitchList,1)
-- -- --         end

-- -- --         if ply.WhipLashList != nil and #ply.WhipLashList > 2 then
-- -- --             table.remove(ply.WhipLashList,1)
-- -- --         end

-- -- --         if #ply.SlamList > 2 then
-- -- --             table.remove(ply.SlamList,1)
-- -- --         end

-- -- --         if #ply.SlideList > 2 then
-- -- --             table.remove(ply.SlideList,1)
-- -- --         end

-- -- --         if #ply.DashList > 2 then
-- -- --             table.remove(ply.DashList,1)
-- -- --         end

-- -- --         if ply.DashJump or ply.DashStorage then
-- -- --             ply:SetGravity(1)
-- -- --         end

-- -- --         if ply.StylePoints != nil and ply.StylePoints > 1600 then
-- -- --             ply.StylePoints = 1600
-- -- --         end

-- -- --         if (not ply:IsOnGround() or ply.Sliding == true) then
-- -- --             if ply.StyleMultiplier < 2 then
-- -- --                 ply.StyleMultiplier = ply.StyleMultiplier + 0.012
-- -- --             end
-- -- --         elseif ply.StyleMultiplier != 0 then
-- -- --             ply.StyleMultiplier = 0
-- -- --         end

-- --         -- Mid air speed adjustments ----------------------------------------

-- --         if ply.Slamming == false and ply:KeyDown(IN_FORWARD) and ply.Dash == false and ply.Sliding == false and CurTime() - ply.WallJumpDelay >= 0.3 or ply.Sliding == false and ply.SlamStore == true and ply:KeyDown(IN_FORWARD) and ply.Dash == false and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --             if not ply:IsOnGround() and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --                 ply:SetVelocity(ply:GetForward() * (5 * math.acos(ply:GetForward():Dot(ply:GetVelocity()) / (ply:GetForward():Length() * ply:GetVelocity():Length())))) 
-- --             end
-- --         end
-- --         if ply.Slamming == false and ply:KeyDown(IN_BACK) and ply.Dash == false and ply.Sliding == false and CurTime() - ply.WallJumpDelay >= 0.3 or ply.Sliding == false and ply.SlamStore == true and ply:KeyDown(IN_BACK) and ply.Dash == false and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --             if not ply:IsOnGround() and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --                 ply:SetVelocity(-ply:GetForward() * (5 * math.acos((-ply:GetForward()):Dot(ply:GetVelocity()) / ((-ply:GetForward()):Length() * ply:GetVelocity():Length()))))
-- --             end
-- --         end
-- --         if ply.Slamming == false and ply:KeyDown(IN_MOVERIGHT) and ply.Dash == false and ply.Sliding == false and CurTime() - ply.WallJumpDelay >= 0.3 or ply.Sliding == false and ply.SlamStore == true and ply:KeyDown(IN_MOVERIGHT) and ply.Dash == false and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --             if not ply:IsOnGround() and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --                 ply:SetVelocity(ply:GetRight() * (5 * math.acos(ply:GetRight():Dot(ply:GetVelocity()) / (ply:GetRight():Length() * ply:GetVelocity():Length()))))
-- --             end
-- --         end
-- --         if ply.Slamming == false and ply:KeyDown(IN_MOVELEFT) and ply.Dash == false and ply.Sliding == false and CurTime() - ply.WallJumpDelay >= 0.3 or ply.Sliding == false and ply.SlamStore == true and ply:KeyDown(IN_MOVELEFT) and ply.Dash == false and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --             if not ply:IsOnGround() and CurTime() - ply.WallJumpDelay >= 0.3 then
-- --                 ply:SetVelocity(-ply:GetRight() * (5 * math.acos((-ply:GetRight()):Dot(ply:GetVelocity()) / ((-ply:GetRight()):Length() * ply:GetVelocity():Length()))))
-- --             end
-- --         end

-- --         --------------------------------

-- --         net.Receive(tostring(ply) .. "Slide/Slam",function() ply.SlamKey = net.ReadBool() ply.SlideKey = net.ReadBool() ply.DashKey = net.ReadBool() end)
-- --         ply.SlamList[#ply.SlamList + 1] = ply.SlamKey
-- --         ply.SlideList[#ply.SlideList + 1] = ply.SlideKey
-- --         ply.DashList[#ply.DashList + 1] = ply.DashKey

-- --         local Slam = ply.SlamList[1] == false and ply.SlamList[2] == true
-- --         local SlamKeyDown = ply.SlamList[1] == true and ply.SlamList[2] == true
-- --         local Slide = ply.SlideList[1] == false and ply.SlideList[2] == true
-- --         local SlideKeyDown = ply.SlideList[1] == true and ply.SlideList[2] == true
-- --         local SlideKeyUp = ply.SlideList[1] == true and ply.SlideList[2] == false
-- --         local Dash = ply.DashList[1] == false and ply.DashList[2] == true


-- --         local function DASH(Dir)

-- --             if not ply:KeyDown(IN_ATTACK) or not ply:KeyDown(IN_USE) then
-- --                 local d = math.Round( 10 * GetConVar("ultrakill_gamemode_dashdistance_multiplier"):GetFloat()  )
-- --                 local del = 0.10
-- --                 local delay = del * GetConVar("ultrakill_gamemode_dashdistance_multiplier"):GetFloat()
-- --                 ply:SetGravity(0.00001)
-- --                 ply:SetVelocity(-ply:GetVelocity())
-- --                 ply:SetPos(ply:GetPos() + Vector(0,0,1))
-- --                 ply.Dash = true
-- --                 ply.DashTime = CurTime() + delay + 0.011
-- --                 ply.SlamStore = false
-- --                 ply.Slamming = false
-- --                 ply.Stamina = ply.Stamina - 100
-- --                 if ply:InVehicle() then
-- --                     ply:GetVehicle():EmitSound(Sound('Movement/Dash.mp3'),100,100,1,CHAN_AUTO,SND_NOFLAGS)
-- --                 else
-- --                     ply:EmitSound(Sound('Movement/Dash.mp3'),100,100,1,CHAN_AUTO,SND_NOFLAGS)
-- --                 end
-- --                 timer.Create(ply.tname4 .. "hehehehaw",delay / d,d,function()
-- --                     if ply:InVehicle() and ply:GetVehicle():GetPhysicsObject() != nil and ply:GetVehicle():GetPhysicsObject():IsValid() then
-- --                         ply:GetVehicle():GetPhysicsObject():SetVelocity(Dir:GetNormalized() * 1500)
-- --                         ply:GetVehicle():GetPhysicsObject():SetAngleVelocity(Vector(0,0,0))
-- --                         for i, ent in pairs(constraint.GetAllConstrainedEntities(ply:GetVehicle())) do
-- --                             if ent != nil and ent:IsValid() then
-- --                                 ent:GetPhysicsObject():SetVelocity(Dir:GetNormalized() * 1500)
-- --                                 ent:GetPhysicsObject():SetAngleVelocity(Vector(0,0,0))
-- --                             end
-- --                         end
-- --                     else
-- --                         ply:SetLocalVelocity(Dir:GetNormalized() * 1500)
-- --                     end
-- --                 end)
-- --                 timer.Simple(delay + 0.1,function()
-- --                     if ply.DashJump == false then
-- --                         ply:SetLocalVelocity(Dir:GetNormalized() * 500)
-- --                         ply.Dash = false 
-- --                         ply.DashJump = false
-- --                         ply:SetGravity(1)
-- --                         if ply:InVehicle() then
-- --                             ply:GetVehicle():GetPhysicsObject():SetVelocity(Dir:GetNormalized() * 400)
-- --                         end
-- --                     else

-- --                         ply.Dash = false 
-- --                         ply.DashJump = false
-- --                         ply:SetGravity(1)
-- --                         if ply:InVehicle() then
-- --                             ply:GetVehicle():GetPhysicsObject():SetVelocity(Dir:GetNormalized() * 400)
-- --                         end

-- --                     end
-- --                 end)

-- --             end

-- --         end

-- --         if Dash and ply.Dash == false and ply.Stamina >= 100 and not ply:KeyDown(IN_FORWARD) and not ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_MOVELEFT) and not ply:KeyDown(IN_MOVERIGHT) then
            
-- --             DASH(Vector(ply:GetAimVector()[1],ply:GetAimVector()[2],0))

-- --         end

-- --         if ply:KeyDown(IN_FORWARD) and ply.Dash == false and ply.Stamina >= 100 then

-- --             local val1 = ply:GetForward()
-- --             local val2 = ply:GetForward() + ply:GetRight()
-- --             local val3 = ply:GetForward() - ply:GetRight()
-- --             if ply:InVehicle() then
-- --                 local car = ply:GetVehicle()
-- --                 val1 = car:GetForward() - Vector(0,0,car:GetForward()[3])
-- --                 val2 = car:GetForward() + car:GetRight() - Vector(0,0,car:GetForward()[3] + car:GetRight()[3])
-- --                 val3 = car:GetForward() - car:GetRight() - Vector(0,0,car:GetForward()[3] - car:GetRight()[3])   
-- --             end

-- --             if ply:KeyDown(IN_FORWARD) and not ply:KeyDown(IN_MOVERIGHT) and not ply:KeyDown(IN_MOVELEFT) and Dash then DASH(val1) end
-- --             if ply:KeyDown(IN_MOVERIGHT) and Dash then DASH(val2) end
-- --             if ply:KeyDown(IN_MOVELEFT) and Dash then DASH(val3) end

-- --         end

-- --         if ply:KeyDown(IN_BACK) and ply.Dash == false and ply.Stamina >= 100 then

-- --             local val1 = -ply:GetForward()
-- --             local val2 = -ply:GetForward() + ply:GetRight()
-- --             local val3 = -ply:GetForward() - ply:GetRight()
-- --             if ply:InVehicle() then
-- --                 local car = ply:GetVehicle()
-- --                 val1 = -car:GetForward() - Vector(0,0,-car:GetForward()[3])  
-- --                 val2 = -car:GetForward() + car:GetRight() - Vector(0,0,-car:GetForward()[3] + car:GetRight()[3])  
-- --                 val3 = -car:GetForward() - car:GetRight() - Vector(0,0,-car:GetForward()[3] - car:GetRight()[3])  
-- --             end

-- --             if ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_MOVERIGHT) and not ply:KeyDown(IN_MOVELEFT) and Dash then DASH(val1) end
-- --             if ply:KeyDown(IN_MOVERIGHT) and Dash then DASH(val2) end
-- --             if ply:KeyDown(IN_MOVELEFT) and Dash then DASH(val3) end

-- --         end

-- --         if ply:KeyDown(IN_MOVERIGHT) and ply.Dash == false and ply.Stamina >= 100 then

-- --             local val1 = ply:GetRight()
-- --             local val2 = -ply:GetForward() + ply:GetRight()
-- --             local val3 = ply:GetForward() + ply:GetRight()
-- --             if ply:InVehicle() then
-- --                 local car = ply:GetVehicle()
-- --                 val1 = car:GetRight() - Vector(0,0,car:GetRight()[3]) 
-- --                 val2 = -car:GetForward() + car:GetRight() - Vector(0,0,-car:GetForward()[3] + car:GetRight()[3]) 
-- --                 val3 = car:GetForward() + car:GetRight() - Vector(0,0,car:GetForward()[3] + car:GetRight()[3]) 
-- --             end

-- --             if ply:KeyDown(IN_MOVERIGHT) and not ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_FORWARD) and Dash then DASH(val1) end
-- --             if ply:KeyDown(IN_BACK) and Dash then DASH(val2) end
-- --             if ply:KeyDown(IN_FORWARD) and Dash then DASH(val3) end

-- --         end

-- --         if ply:KeyDown(IN_MOVELEFT) and ply.Dash == false and ply.Stamina >= 100 then

-- --             local val1 = -ply:GetRight()
-- --             local val2 = -ply:GetForward() - ply:GetRight()
-- --             local val3 = ply:GetForward() - ply:GetRight()
-- --             if ply:InVehicle() then
-- --                 local car = ply:GetVehicle()
-- --                 val1 = -car:GetRight() - Vector(0,0,-car:GetRight()[3]) 
-- --                 val2 = -car:GetForward() - car:GetRight() - Vector(0,0,-car:GetForward()[3] - car:GetRight()[3]) 
-- --                 val3 = car:GetForward() - car:GetRight() - Vector(0,0,car:GetForward()[3] - car:GetRight()[3]) 
-- --             end

-- --             if ply:KeyDown(IN_MOVELEFT) and not ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_FORWARD) and Dash then DASH(val1) end
-- --             if ply:KeyDown(IN_BACK) and Dash then DASH(val2) end
-- --             if ply:KeyDown(IN_FORWARD) and Dash then DASH(val3) end

-- --         end

-- --         local CheckGround = {}
-- --         local CheckResult = {}
-- --         CheckGround.start = ply:GetPos()
-- --         CheckGround.endpos = ply:GetPos() + Vector(0,0,-90)
-- --         CheckGround.filter = {ply}
-- --         CheckGround.output = CheckResult
-- --         util.TraceLine(CheckGround)

-- --         local prevel = ply:GetVelocity()
-- --         local SpeedTransfer = 0

-- --         if Slam and ply.Sliding == false and not ply:IsOnGround() and not CheckResult.HitWorld and ply.Slamming == false and ply.Riding != true or Slam and ply.Sliding == false and not ply:IsOnGround() and CheckResult.Entity:IsValid() and CheckResult.Entity:GetPhysicsObject():IsValid() and ply.Slamming == false and ply.Riding != true and not ply:InVehicle() then

-- --             --ply.Sliding

-- --             ply.SSU = false
-- --             local tN = tostring(math.random(1,99999999999999999999))
-- --             ply.SlamBack = CurTime()
-- --             ply:SetVelocity(-ply:GetVelocity())
-- --             ply:SetWalkSpeed(300 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             ply:SetRunSpeed(300 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             ply.Slamming = true
-- --             timer.Simple(0.01,function()
-- --                 timer.Create(tN,0.01,0,function()
                
-- --                     local HullTrace = {}
-- --                     local TraceResult = {}
-- --                     HullTrace.start = ply:GetPos()
-- --                     HullTrace.endpos = ply:GetPos() + Vector(0,0,-25* GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() )
-- --                     HullTrace.filter = {ply}
-- --                     HullTrace.mask = MASK_SOLID
-- --                     HullTrace.maxs = Vector(15,15,15)
-- --                     HullTrace.mins = Vector(-15,-15,-15)
-- --                     HullTrace.output = TraceResult
-- --                     util.TraceHull(HullTrace)

-- --                     if TraceResult.Entity:IsNPC() and TraceResult.Entity:IsValid() or TraceResult.Entity:IsPlayer() and TraceResult.Entity != ply and TraceResult.Entity:IsValid() or TraceResult.Entity:IsNextBot() and TraceResult.Entity:IsValid() then

-- --                         local dmg = DamageInfo()
-- --                         dmg:SetDamage(50 * (CurTime() - ply.SlamBack + 0.5) * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat())
-- --                         dmg:SetDamageType(DMG_SLAM)
-- --                         dmg:SetDamageForce(Vector(0,0,-100))
-- --                         dmg:SetAttacker(ply)
-- --                         dmg:SetInflictor(ply)
-- --                         dmg:SetDamagePosition(TraceResult.HitPos)
-- --                         TraceResult.Entity:TakeDamageInfo(dmg)
-- --                         TraceResult.Entity:TakePhysicsDamage(dmg)
-- --                         ply.Slamming = false

-- --                     end

-- --                     if ply:IsOnGround() then

-- --                         ply:EmitSound("Movement/Land.mp3")

-- --                         ply.SlamLandTime = CurTime()
-- --                         if SlamKeyDown and ply.Stamina >= 100 then
-- --                             effects.BeamRingPoint(TraceResult.HitPos,0.5,0,400,40,1,Color(151,151,151,250))
-- --                             ply.Stamina = ply.Stamina - 100
-- --                             for i, ent in ipairs(ents.FindInSphere(TraceResult.HitPos,200)) do

-- --                                 if ent:IsValid() and ent:IsPlayer() and ent != ply and ent:IsOnGround() or ent:GetPhysicsObject():IsValid() and not ent:IsWorld() and ent != ply and ent:GetPhysicsObject():IsMotionEnabled() and ent:GetClass() != "Whip" then
-- --                                     if ent:IsPlayer() or ent:IsNPC() or ent:IsNextBot() then
-- --                                         ent:SetVelocity( Vector(0,0,2300 * (ply.SlamLandTime - ply.SlamBack) * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() + 200) )
-- --                                     else
-- --                                         ent:GetPhysicsObject():ApplyForceCenter(Vector(0,0,20000 * (ply.SlamLandTime - ply.SlamBack) * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() / 5 * ent:GetPhysicsObject():GetMass() + 200 ))
-- --                                     end
-- --                                 end

-- --                             end
-- --                             effects.BeamRingPoint(ply:GetPos() + Vector(0,0,10),0.5,50,300,50,0,Color(255,255,255))
-- --                         end
-- --                         timer.Remove(tN)
-- --                         ply.Slamming = false 
-- --                     end

-- --                     if ply:Health() <= 0 or ply.Riding == true then

-- --                         ply.Slamming = false
-- --                         timer.Remove(tN)

-- --                     end

-- --                     if ply.Slamming != true then

-- --                         if ply.SlamStore != true then
                            
-- --                         end
-- --                         ply.SlamLandTime = CurTime()
-- --                         if ply.Riding != true then
-- --                             ply.CanJumpBack = true
-- --                         end
-- --                         timer.Simple(0.30,function()
-- --                             ply.CanJumpBack = false
-- --                             ply:SetWalkSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --                             ply:SetRunSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --                         end)

-- --                     end

-- --                     if not ply:IsValid() then

-- --                         timer.Remove(tN)

-- --                     end

-- --                     if ply.Slamming == true and ply.SlamStore != true then

-- --                         local coef = 1
-- --                         if ply:WaterLevel() != 0 then
-- --                             coef = 0.6
-- --                         end

-- --                         ply:SetLocalVelocity(Vector(0,0,-1500 * coef * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat()))

-- --                     end

-- --                     if ply.Slamming == true then

-- --                         effects.BeamRingPoint(ply:GetPos(),0.6,0,50,2,0)

-- --                     end

-- --                 end)
-- --             end)

-- --         elseif Slide and CheckResult.HitWorld and not ply.Slamming or Slide and CheckResult.Entity:IsValid() and CheckResult.Entity:GetPhysicsObject():IsValid() and not ply:InVehicle() and not ply.Slamming then
            
-- --             if ply.Dash == true then
-- --                 ply.DashStorage = true
-- --             end

-- --             if ply:KeyDown(IN_FORWARD) then
-- --                 ply.SlideDir = ply:GetForward()
-- --                 ply.SlideStartRight = ply:GetRight()
-- --             end

-- --             if ply:KeyDown(IN_BACK) then
-- --                 ply.SlideDir = -ply:GetForward()
-- --                 ply.SlideStartRight = -ply:GetRight()
-- --             end

-- --             if ply:KeyDown(IN_MOVERIGHT) then
-- --                 ply.SlideDir = ply:GetRight()
-- --                 ply.SlideStartRight = ply:GetForward()
-- --             end

-- --             if ply:KeyDown(IN_MOVELEFT) then
-- --                 ply.SlideDir = -ply:GetRight()
-- --                 ply.SlideStartRight = -ply:GetForward()
-- --             end

-- --             if not ply:KeyDown(IN_MOVELEFT) and not ply:KeyDown(IN_FORWARD) and not ply:KeyDown(IN_BACK) and not ply:KeyDown(IN_MOVERIGHT) then

-- --                 ply.SlideDir = Vector(ply:GetAimVector()[1],ply:GetAimVector()[2],0):GetNormalized()
-- --                 ply.SlideStartRight = ply:GetRight()

-- --             end

-- --             SpeedTransfer = ply.Speed05:Length() * 0.9
-- --             timer.Simple(0.1,function() SpeedTransfer = 0 end)

-- --             ply:SetRunSpeed(2000 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             ply:SetWalkSpeed(2000 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             ply:SetLocalVelocity(Vector(0,0,0) + ply.SlideDir * 805 * GetConVar("ultrakill_gamemode_slidespeed_multiplier"):GetFloat() + ply.SlideDir * ply:GetVelocity():Length() * 0.9 )
-- --             ply:DropToFloor()
-- --             ply.Sliding = true
-- --             ply.Slidesfxid = ply:StartLoopingSound("Movement/Slide.wav")
-- --         end

-- --         if (SlideKeyDown and ply:IsOnGround()) and ply.Sliding then

-- --             local Turn = Vector(0,0,0)

-- --             if ply.CanJumpBack == true then
-- --                 SpeedTransfer = SpeedTransfer + (CurTime() - ply.SlamBack + 0.4) * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() * 10
-- --                 --ply.CanJumpBack = false
-- --             end

-- --             if ply:KeyDown(IN_MOVERIGHT) then

-- --                 Turn = ply.SlideStartRight
                
-- --             end

-- --             if ply:KeyDown(IN_MOVELEFT) then
                
-- --                 Turn = -ply.SlideStartRight

-- --             end

-- --             ply:SetLocalVelocity(ply.SlideDir * 805 * GetConVar("ultrakill_gamemode_slidespeed_multiplier"):GetFloat() + ply.SlideDir * SpeedTransfer + Turn * 30)

-- --             local Eff = EffectData()
-- --             Eff:SetOrigin(ply:GetPos() + ply.SlideDir * 0.5)
-- --             Eff:SetScale(1)
-- --             Eff:SetNormal(ply.SlideDir + ply:GetRight() / 2 )
-- --             util.Effect("WheelDust",Eff)
-- --             Eff:SetNormal(ply.SlideDir + -ply:GetRight() / 2 )
-- --             util.Effect("WheelDust",Eff)
-- --             Eff:SetNormal((-ply.SlideDir + Vector(0,0,0.7)):GetNormalized() )
-- --             Eff:SetOrigin(ply:GetPos() + ply.SlideDir * 50 + Vector(0,0,5))
-- --             util.Effect("MetalSpark",Eff)
-- --         end

-- --         if ply:WaterLevel() >= 1 and ply:WaterLevel() < 3 and ply.Sliding then
-- --             ply:SetVelocity(Vector(0,0,30) + ply.SlideDir * 18)
-- --         end
        
-- -- -- GetVelocity()

-- --         if Slide and ply.InitViewOffset != nil  and ply.InitHullMins != nil and ply.InitViewOffsetDucked != nil and ply.InitHullDuckMins != nil and ply.InitHullDuckMaxs != nil then
-- --             ply:SetViewOffset(ply.InitViewOffset - Vector(0,0,60))
-- --             ply:SetHull(ply.InitHullMins,ply.InitHullMaxs - Vector(0,0,60))
-- --             ply:SetViewOffsetDucked(ply.InitViewOffsetDucked)
-- --             ply:SetHullDuck(ply.InitHullDuckMins,ply.InitHullDuckMaxs)
-- --             if ply:Crouching() then
-- --                 ply:SetViewOffsetDucked(ply.InitViewOffset - Vector(0,0,60))
-- --                 ply:SetHullDuck(ply.InitHullMins,ply.InitHullMaxs - Vector(0,0,60))
-- --                 ply:SetViewOffsetDucked(ply.InitViewOffsetDucked)
-- --                 ply:SetHullDuck(ply.InitHullDuckMins,ply.InitHullDuckMaxs)
-- --             end
-- --         elseif ply.InitViewOffset != nil  and ply.InitHullMins != nil and ply.InitViewOffsetDucked != nil and ply.InitHullDuckMins != nil and ply.InitHullDuckMaxs != nil then
-- --             ply:SetViewOffset(ply.InitViewOffset)
-- --             ply:SetHull(ply.InitHullMins,ply.InitHullMaxs)
-- --             ply:SetViewOffsetDucked(ply.InitViewOffsetDucked)
-- --             ply:SetHullDuck(ply.InitHullDuckMins,ply.InitHullDuckMaxs)
-- --         end

-- --         if (SlideKeyUp or ply:KeyPressed(IN_JUMP)) and ply.Sliding then

-- --             if timer.Exists(ply.tname4 .. "amazing") then
-- --                 timer.Remove(ply.tname4 .. "amazing")
-- --             end

-- --             ply.CanJumpBack = false
-- --             ply.DashStorage = false
-- --             ply.Sliding = false
-- --             ply:StopLoopingSound(ply.Slidesfxid)
-- --             ply:EmitSound("Movement/Slideend.mp3",100,math.random(95,105))
-- --             ply.Slidesfxid = 0
-- --             ply:SetRunSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             ply:SetWalkSpeed(500 * GetConVar("ultrakill_gamemode_playerspeedmodifier"):GetFloat())
-- --             if ply:KeyPressed(IN_JUMP) then
-- --                 ply.WasOnGround = false
-- --             end

-- --         end

-- --         if ply:KeyPressed(IN_JUMP) and ply.WhipLashing == true and ply.WhipEnt:IsValid() and ply.WhipEnt.TouchEnt != nil and ply.WhipEnt.TouchEnt:IsValid() then
-- --             local b1,b2 = ply.WhipEnt.TouchEnt:GetModelBounds()
-- --             local S = (b1 - b2):Length()
-- --             if S < 120 and not ply.WhipEnt.TouchEnt:IsPlayer() then
-- --                 ply.WhipEnt:SetParent(nil)
-- --                 ply.WhipGo = false
-- --             end
-- --         end

-- --         if ply.Sliding == true and not ply:IsOnGround() and ply.WasOnGround == true then
-- --             ply:StopLoopingSound(ply.Slidesfxid)
-- --             ply.WasOnGround = false
-- --         elseif ply.Sliding == true and ply:IsOnGround() and ply.WasOnGround == false then
-- --             ply.Slidesfxid = ply:StartLoopingSound("Movement/Slide.wav")
-- --             ply.WasOnGround = true
-- --         end

-- --         if ply:KeyPressed(IN_JUMP) then
-- --             ply.WasOnGround = false
-- --         end

-- --         if ply:IsOnGround() then
-- --             if ply.WasOnGround == false and ply:GetVelocity()[3] > 2 then
-- --                 ply:EmitSound("Movement/Land.mp3")
-- --                 ply.WasOnGround = true
-- --             end
-- --             ply.SlamStore = false
-- --             ply.Slamming = false
-- --             ply.CurWallJumps = GetConVar("ultrakill_gamemode_maxwalljumps"):GetInt()
-- --             ply.WallJumpDelay = CurTime()
-- --         end

-- --         if ply.Sliding == false then
-- --             ply:StopLoopingSound(ply.Slidesfxid)
-- --         end

-- --         local CheckGround1 = {}
-- --         local CheckResult1 = {}
-- --         CheckGround1.start = ply:GetPos()
-- --         CheckGround1.endpos = ply:GetPos() + Vector(0,0,-20)
-- --         CheckGround1.filter = {ply}
-- --         CheckGround1.output = CheckResult1
-- --         util.TraceLine(CheckGround1)

-- --         if CheckResult1.Hit == true and ply:KeyPressed(IN_JUMP) then
            
-- --             ply:EmitSound("Movement/Jump.mp3")

-- --         end

-- --         if ply:KeyPressed(IN_JUMP) and ply.Dash == true and ply.Stamina >= 100 and ply.DashJump != true and not ply:InVehicle() and (CheckResult1.Hit and CheckResult.Entity:GetPhysicsObject():IsValid() or CheckResult1.HitWorld) then
-- --             timer.Remove(ply.tname4 .. "hehehehaw")
-- --             ply.Dash = false 
-- --             ply.DashJump = false
-- --             ply.DashStorage = false
-- --             ply.DashJump = true
-- --             ply.Stamina = ply.Stamina - 100
-- --             ply:SetGravity(1)
-- --             ply:SetVelocity(Vector(0,0,0.8) * ply:GetJumpPower())

-- --         end

-- --         if ply.CanJumpBack and ply:KeyPressed(IN_JUMP) then

-- --             ply:SetPos( ply:GetPos() + Vector(0,0,10) )
-- --             if CurTime() - ply.SlamBack < 10 * GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() then
-- --                 local val = 1
-- --                 if ply:Crouching() then
-- --                     val = 1.5
-- --                 end
-- --                 ply:SetVelocity( Vector(0,0,2500 * (ply.SlamLandTime - ply.SlamBack + 0.05) ^ 1.5 * val / GetConVar("ultrakill_gamemode_slamspeed_multiplier"):GetFloat() ) + Vector(0,0,150) )
-- --             else
-- --                 ply:SetVelocity( Vector(0,0,650 * 10 + 180) )
-- --             end

-- --         end

-- --         local Hull1 = {}
-- --         local res1 = {}
-- --         Hull1.start = ply:GetPos() + Vector(0,0,60)
-- --         Hull1.endpos = ply:GetPos() + Vector(0,0,60) + ply:GetForward() * 15
-- --         Hull1.filter = {ply}
-- --         Hull1.maxs = Vector(15,15,15)
-- --         Hull1.mins = -Vector(15,15,15)
-- --         Hull1.output = res1

-- --         local Hull2 = {}
-- --         local res2 = {}
-- --         Hull2.start = ply:GetPos() + Vector(0,0,60)
-- --         Hull2.endpos = ply:GetPos() + Vector(0,0,60) + ply:GetForward() * -15
-- --         Hull2.filter = {ply}
-- --         Hull2.maxs = Vector(15,15,15)
-- --         Hull2.mins = -Vector(15,15,15)
-- --         Hull2.output = res2

-- --         local Hull3 = {}
-- --         local res3 = {}
-- --         Hull3.start = ply:GetPos() + Vector(0,0,60)
-- --         Hull3.endpos = ply:GetPos() + Vector(0,0,60) + ply:GetRight() * 15
-- --         Hull3.filter = {ply}
-- --         Hull3.maxs = Vector(15,15,15)
-- --         Hull3.mins = -Vector(15,15,15)
-- --         Hull3.output = res3

-- --         local Hull4 = {}
-- --         local res4 = {}
-- --         Hull4.start = ply:GetPos() + Vector(0,0,60)
-- --         Hull4.endpos = ply:GetPos() + Vector(0,0,60) + ply:GetRight() * -15
-- --         Hull4.filter = {ply}
-- --         Hull4.maxs = Vector(15,15,15)
-- --         Hull4.mins = -Vector(15,15,15)
-- --         Hull4.output = res4

-- --         util.TraceHull(Hull1)
-- --         util.TraceHull(Hull2)
-- --         util.TraceHull(Hull3)
-- --         util.TraceHull(Hull4)

-- --         if res1.HitWorld and res1.HitNormal[3] < 0.5 or res1.Entity:IsValid() and res1.HitNormal[3] < 0.5 and res1.Entity:GetPhysicsObject():IsValid() and res1.Entity:GetPhysicsObject():IsValid() or res2.HitWorld and res2.HitNormal[3] < 0.5 or res2.Entity:IsValid() and res2.HitNormal[3] < 0.5 and res2.Entity:GetPhysicsObject():IsValid() and res2.Entity:GetPhysicsObject():IsValid() or res3.HitWorld and res3.HitNormal[3] < 0.5 or res3.Entity:IsValid() and res3.HitNormal[3] < 0.5 and res3.Entity:GetPhysicsObject():IsValid() and res3.Entity:GetPhysicsObject():IsValid() or res4.HitWorld and res4.HitNormal[3] < 0.5 or res4.Entity:IsValid() and res4.HitNormal[3] < 0.5 and res4.Entity:GetPhysicsObject():IsValid() and res4.Entity:GetPhysicsObject():IsValid() then
            
-- --             local function iCheck(Tdata)
-- --                 if Tdata.Entity:IsValid() and Tdata.Entity:GetPhysicsObject():IsValid() then
-- --                     return true
-- --                 end
-- --                 return false
-- --             end

-- --             if ply:KeyDown(IN_JUMP) and ply.CurWallJumps > 0 and CurTime() - ply.WallJumpDelay >= 0.3 and ply.Sliding == false then

-- --                 if ply.Slamming == true then
-- --                     ply.SlamStore = true
-- --                     ply:SetVelocity(Vector(-ply:GetVelocity()[1] / 3,-ply:GetVelocity()[2] / 3,-ply:GetVelocity()[3]))
-- --                 else
-- --                     ply:SetVelocity(Vector(-ply:GetVelocity()[1] / 3,-ply:GetVelocity()[2] / 3,math.abs(ply:GetVelocity()[3]) / 2 - ply:GetVelocity()[3] / 2 ))
-- --                 end
-- --                 ply.WallJumped = true
-- --                 ply:EmitSound("Movement/Jump.mp3")
-- --                 timer.Simple(0.01,function()
-- --                     ply:SetVelocity( ply:GetForward() * res1.Fraction * 300 + -ply:GetForward() * res2.Fraction * 300 + ply:GetRight() * res3.Fraction * 300 + -ply:GetRight() * res4.Fraction * 300 + Vector(0,0,550) )
-- --                 end)
-- --                 timer.Simple(0.2,function() ply.WallJumped = false end)
-- --                 ply.WallJumpDelay = CurTime()
-- --                 ply.CurWallJumps = ply.CurWallJumps - 1

-- --             end

-- --             if ply.Slamming == false and ply.Sliding == false and ply.Dash == false and ply.WallJumped == false then
-- --                 if res1.HitWorld and ply:KeyDown(IN_FORWARD) or res2.HitWorld and ply:KeyDown(IN_BACK) or res3.HitWorld and ply:KeyDown(IN_MOVERIGHT) or res4.HitWorld and ply:KeyDown(IN_MOVELEFT) then 
-- --                     if ply.WallJumped == false and not ply:IsOnGround() then
-- --                         ply:SetVelocity((Vector(0,0,-ply:GetVelocity()[3] / 16)))
-- --                         local efd = EffectData()
-- --                         efd:SetOrigin( -6 * ( ply:GetForward() * res1.Fraction + -ply:GetForward() * res2.Fraction + ply:GetRight() * res3.Fraction + -ply:GetRight() * res4.Fraction ):GetNormalized() + ply:GetPos() + Vector(0,0,40))
-- --                         efd:SetMagnitude(0.25)
-- --                         efd:SetScale(0.5)
-- --                         efd:SetRadius(3)
-- --                         efd:SetNormal(( ply:GetForward() * res1.Fraction + -ply:GetForward() * res2.Fraction + ply:GetRight() * res3.Fraction + -ply:GetRight() * res4.Fraction ):GetNormalized() - ply:GetVelocity() )
-- --                         util.Effect("Sparks",efd)
-- --                     end
-- --                 end
-- --             end

-- --         end

-- --         SetGlobalFloat(tostring(ply) .. "Stamina",ply.Stamina)
-- --         SetGlobalFloat(tostring(ply) .. "StylePoints",ply.StylePoints)
-- --         SetGlobalFloat(tostring(ply) .. "StylePoints05",ply.StylePoints05)
-- --         SetGlobalFloat(tostring(ply) .. "StyleMultiplier",ply.StyleMultiplier)

-- --         local booll = false 
-- --         if ply.Dash == true and ply.DashStorage != true then
-- --             booll = true
-- --         end

-- --         SetGlobalBool(tostring(ply) .. "Dash",booll)

-- --         local boolr = false

-- --         local StyleString = ""
-- --         for i, entry in ipairs(ply.StyleFeed) do
-- --             if i != 1 then
-- --                 StyleString = StyleString .. " " .. entry
-- --             else
-- --                 StyleString = StyleString .. entry
-- --             end
-- --         end

-- --         SetGlobalString(tostring(ply) .. "StyleFeed",StyleString)

-- --         net.Receive( tostring(ply) .. "Fist", function(len,ply) ply.Punch = net.ReadBool() ply.Switch = net.ReadBool() ply.WhipLash = net.ReadBool() end)
-- --         if ply.FistList != nil then
-- --             if ply.Punch != nil then
-- --                 ply.FistList[#ply.FistList + 1] = ply.Punch
-- --             else
-- --                 ply.FistList[#ply.FistList + 1] = false
-- --             end
-- --         else
-- --             ply.FistList = {false,false}
-- --         end
-- --         if ply.FistSwitchList != nil then
-- --             if ply.Punch != nil then
-- --                 ply.FistSwitchList[#ply.FistSwitchList + 1] = ply.Switch
-- --             else
-- --                 ply.FistSwitchList[#ply.FistSwitchList + 1] = false
-- --             end
-- --         else
-- --             ply.FistSwitchList = {false,false}
-- --         end
-- --         if ply.WhipLashList != nil then
-- --             if ply.Punch != nil then
-- --                 ply.WhipLashList[#ply.WhipLashList + 1] = ply.WhipLash
-- --             else
-- --                 ply.WhipLashList[#ply.WhipLashList + 1] = false
-- --             end
-- --         else
-- --             ply.WhipLashList = {false,false}
-- --         end

-- --         if ply.FistSwitchList[1] == false and ply.FistSwitchList[2] == true and tobool(tonumber( ply:GetInfo("ultrakill_gamemode_knuckleblaster"))) and tobool(tonumber( ply:GetInfo("ultrakill_gamemode_feedbacker"))) then
-- --             if ply.CurFist == 0 then
-- --                 ply.CurFist = 1
-- --                 ply.KnuckleBlast = false
-- --             elseif ply.CurFist == 1 then
-- --                 ply.CurFist = 0
-- --                 ply.KnuckleBlast = false
-- --             end
-- --         elseif tobool(tonumber( ply:GetInfo("ultrakill_gamemode_knuckleblaster"))) == false then
-- --             ply.CurFist = 0
-- --         elseif tobool(tonumber( ply:GetInfo("ultrakill_gamemode_feedbacker"))) == false then
-- --             ply.CurFist = 1
-- --         end

-- --         SetGlobalInt(tostring(ply) .. "FistType",ply.CurFist)
-- --         SetGlobalBool(tostring(ply) .. "IsSliding",ply.Sliding)

-- --         if ply.FistList != nil and ply.FistList[1] == true and ply.FistList[2] == false or ply.FistList[1] == false and ply.FistList[2] == false then
-- --             ply.KnuckleBlast = false
-- --         end

-- --         if ply.FistList != nil and ply.FistList[1] == false and ply.FistList[2] == true and ply.CurFist == 0 and ply.FistDelay <= CurTime() and tobool(tonumber( ply:GetInfo("ultrakill_gamemode_feedbacker"))) then
-- --             net.Start(tostring(ply) .. "FistSound0")
-- --                 if  ply.FistList != nil then
-- --                     net.WriteTable(ply.FistList)
-- --                 else
-- --                     net.WriteTable(false,false)
-- --                 end
-- --             net.Send(ply)
-- --             local HullTrace = {}
-- --             local TR = {}
-- --             local TR2 = {}
-- --             local TR3 = {}
-- --             HullTrace.start = ply:GetShootPos()
-- --             HullTrace.endpos = ply:GetShootPos() + ply:GetAimVector() * 120
-- --             HullTrace.filter = {ply,ply:GetVehicle()}
-- --             HullTrace.maxs = Vector(15,15,15)
-- --             HullTrace.mins = -Vector(15,15,15)
-- --             HullTrace.output = TR
-- --             util.TraceHull(HullTrace)
-- --             HullTrace.start = ply:GetShootPos()
-- --             HullTrace.endpos = ply:GetShootPos() + ply:GetAimVector() * 120
-- --             HullTrace.filter = function(e) if e == ply or e.Coin == true or ply:InVehicle() and e == ply:GetVehicle() then return false end return true end
-- --             HullTrace.maxs = Vector(15,15,15)
-- --             HullTrace.mins = -Vector(15,15,15)
-- --             HullTrace.output = TR2
-- --             util.TraceHull(HullTrace)
-- --             HullTrace.start = ply:GetShootPos()
-- --             HullTrace.endpos = ply:GetShootPos() + ply:GetAimVector() * 120
-- --             HullTrace.filter = function(e) if e == ply or ply:InVehicle() and e == ply:GetVehicle() then return false end return true end
-- --             HullTrace.maxs = Vector(15,15,15)
-- --             HullTrace.mins = -Vector(15,15,15)
-- --             HullTrace.output = TR3
-- --             util.TraceHull(HullTrace)
-- --             ply.ConsequtivePunches = ply.ConsequtivePunches + 1
-- --             ply.FistDelay = CurTime() + 0 + 0.55 * ply.ConsequtivePunches
-- --             if TR.Entity:IsValid() then

-- --                 local bonus = 0

-- --                 if ply.Parryable == true and TR.Entity == ply.ParryDmg:GetAttacker() then
-- --                     ply.StylePoints = ply.StylePoints + 50
-- --                     gamemode.Call("AddStyleBonus",ply,"Parry")
-- --                     ply:SetHealth(100)
-- --                     TR.Entity:SetVelocity((TR.Entity:GetPos() - ply:GetPos()):GetNormalized() * 500 + Vector(0,0,50))
-- --                     bonus = ply.ParryDmg:GetDamage() * 2
-- --                 end
                
-- --                 local dmgi = DamageInfo()
-- --                 dmgi:SetDamage(20 + bonus)
-- --                 dmgi:SetDamageForce(ply:GetAimVector() * 20000)
-- --                 dmgi:SetDamagePosition(ply:GetPos())
-- --                 dmgi:SetDamageType(DMG_PUNCH)
-- --                 dmgi:SetAttacker(ply)
-- --                 dmgi:SetInflictor(ply)
-- --                 TR.Entity:TakeDamageInfo(dmgi)
-- --                 TR.Entity:TakePhysicsDamage(dmgi)

-- --                 if TR2.Entity.CannonBall == true then
-- --                     TR2.Entity.Parried = true
-- --                     TR2.Entity:GetPhysicsObject():SetVelocity(ply:GetAimVector() * 2500)
-- --                 end

-- --                 TR.Entity.Parried = true
                
-- --             end
-- --             if TR3.Entity:IsValid() then
-- --                 if TR3.Entity.Coin == true then

-- --                     local dmgi = DamageInfo()
-- --                     dmgi:SetDamage(20)
-- --                     dmgi:SetDamageForce(ply:GetAimVector() * 20000)
-- --                     dmgi:SetDamagePosition(ply:GetPos())
-- --                     dmgi:SetDamageType(DMG_PUNCH)
-- --                     dmgi:SetAttacker(ply)
-- --                     dmgi:SetInflictor(ply)
-- --                     TR3.Entity:TakeDamageInfo(dmgi)
-- --                     TR3.Entity:TakePhysicsDamage(dmgi)

-- --                     TR3.Entity.Parried = true
-- --                     TR3.Entity:SetPos( ply:GetShootPos() + ply:GetAimVector() * 140 )
-- --                     TR3.Entity.Parried = true
-- --                     TR3.Entity.atk = ply

-- --                 end
-- --             end
-- --             if TR2.Entity:IsValid() then
-- --                 local b1, b2 = TR2.Entity:GetModelBounds()
-- --                 local S = (b1 - b2):Length()
-- --                 if TR2.Entity.Pellet == true then

-- --                     TR2.Entity.Parried = true
-- --                     local EsVel = TR2.Entity:GetVelocity()
-- --                     TR2.Entity:SetOwner(ply)

-- --                     TR2.Entity:SetPos( ply:GetShootPos() + ply:GetAimVector() * 140 )

-- --                     if TR2.Entity.Pellet == true and TR2.Entity != nil and TR2.Entity:IsValid() then
-- --                         TR2.Entity:GetPhysicsObject():SetVelocity( EsVel:Length() * ply:GetAimVector() )
-- --                     end
-- --                     TR2.Entity.Parried = true
-- --                     TR2.Entity.atk = ply

-- --                 elseif TR2.Entity:GetPhysicsObject():IsValid() and TR2.Entity:GetPhysicsObject() != nil and (TR2.Entity:GetPhysicsObject():GetVelocity() - ply:GetVelocity()):Length() > 300 and S < 2000 and TR2.Entity.Coin != true and not TR2.Entity:IsNPC() and not TR2.Entity:IsNextBot() and not TR2.Entity:IsPlayer() or TR2.Entity.SawBlade == true then

-- --                     TR2.Entity:GetPhysicsObject():SetVelocity(ply:GetAimVector() * TR2.Entity:GetVelocity():Length() * 2)
-- --                     TR2.Entity:SetOwner(ply)
-- --                     gamemode.Call("AddStyleBonus",ply,"Parry")
-- --                     ply:SetHealth(100)
-- --                     ply.StylePoints = ply.StylePoints + 50

-- --                 end

-- --                 TR2.Entity.Parried = true

-- --             end
-- --         elseif ply.FistList[1] == false and ply.FistList[2] == true and ply.CurFist == 1 and ply.KnuckleDelay <= CurTime() and tobool(tonumber( ply:GetInfo("ultrakill_gamemode_knuckleblaster"))) then
-- --             net.Start(tostring(ply) .. "FistSound1")
-- --                 net.WriteTable(ply.FistList)
-- --             net.Send(ply)
-- --             local HullTrace = {}
-- --             local TR = {}
-- --             HullTrace.start = ply:GetShootPos()
-- --             HullTrace.endpos = ply:GetShootPos() + ply:GetAimVector() * 150
-- --             HullTrace.filter = function(e) if e == ply or e == ply:GetVehicle() or e.Coin == true then return false end return true end
-- --             HullTrace.maxs = Vector(20,20,20)
-- --             HullTrace.mins = -Vector(20,20,20)
-- --             HullTrace.output = TR
-- --             util.TraceHull(HullTrace)
-- --             if TR.Entity:IsValid() then
-- --                 local dmgi = DamageInfo()
-- --                 dmgi:SetDamage(80)
-- --                 dmgi:SetDamageForce(ply:GetAimVector() * 50000)
-- --                 dmgi:SetDamagePosition(TR.HitPos)
-- --                 dmgi:SetReportedPosition(ply:GetShootPos())
-- --                 dmgi:SetDamageType(DMG_KNUCKLEBLASTER)
-- --                 dmgi:SetAttacker(ply)
-- --                 dmgi:SetInflictor(ply)
-- --                 TR.Entity:TakeDamageInfo(dmgi)
-- --                 TR.Entity:TakePhysicsDamage(dmgi)
-- --             end
-- --             ply.KnuckleDelay = CurTime() + 0.95
-- --             ply.KnuckleBlast = true
-- --             timer.Simple(0.9,function()  
-- --                 if ply.FistList[1] == true and ply.FistList[2] == true and ply.KnuckleBlast == true then
-- --                     for i, entit in ipairs(ents.FindInSphere(ply:GetPos() + Vector(0,0,10) + ply:GetAimVector() * 10,200)) do
-- --                         if entit != ply and entit != game.GetWorld() then
-- --                             if entit:IsNPC() or entit:IsNextBot() or entit:IsPlayer() then
-- --                                 local dmgin = DamageInfo()
-- --                                 dmgin:SetDamage(60)
-- --                                 dmgin:SetDamageForce(ply:GetAimVector() * 1500 )
-- --                                 dmgin:SetReportedPosition(ply:GetPos() + Vector(0,0,10) + ply:GetAimVector() * 10)
-- --                                 dmgin:SetAttacker(ply)
-- --                                 dmgin:SetInflictor(ply)
-- --                                 dmgin:SetDamageType(DMG_BLAST)
-- --                                 dmgin:SetDamagePosition(entit:GetPos())
-- --                                 entit:TakeDamageInfo(dmgin)
-- --                                 entit:SetVelocity((entit:GetPos() - ply:GetShootPos() + ply:GetAimVector() * 10):GetNormalized() * 500 + ply:GetAimVector() * 1000)
-- --                             elseif entit.Coin == true then
-- --                                 entit:GetPhysicsObject():ApplyForceCenter(((ply:GetPos() + Vector(0,0,10) + ply:GetAimVector() * 10) - entit:GetPos()):GetNormalized() * -8000)
-- --                             else
-- --                                 local dmgin = DamageInfo()
-- --                                 dmgin:SetDamage(0)
-- --                                 dmgin:SetDamageForce(ply:GetAimVector() * 1500 )
-- --                                 dmgin:SetReportedPosition(ply:GetPos() + Vector(0,0,10) + ply:GetAimVector() * 10)
-- --                                 dmgin:SetAttacker(ply)
-- --                                 dmgin:SetInflictor(ply)
-- --                                 dmgin:SetDamageType(DMG_BLAST)
-- --                                 dmgin:SetDamagePosition(entit:GetPos())
-- --                                 entit:TakeDamageInfo(dmgin)
-- --                                 entit:SetVelocity((entit:GetPos() - ply:GetShootPos() + ply:GetAimVector() * 10):GetNormalized() * 1500)
-- --                             end
-- --                         end
-- --                     end
-- --                     local effc = EffectData()
-- --                     effc:SetOrigin(ply:GetPos() + Vector(0,0,50) + ply:GetAimVector() * 20)
-- --                     util.Effect("HelicopterMegaBomb",effc)
-- --                     val = math.Round( math.random(4,1) )
-- --                     if not ply:InVehicle() then
-- --                         ply:EmitSound('BaseExplosionEffect.Sound',70,100,70)
-- --                     else
-- --                         ply:GetVehicle():EmitSound('BaseExplosionEffect.Sound',70,100,70)
-- --                     end
-- --                     ply.KnuckleDelay = CurTime() + 0.5
                
-- --                 end
-- --             end)

-- --         end

-- --         --timer

-- --         if ply.WhipDelay == false and ply.WhipLashing == true and ply.WhipLash == false then
-- --             ply.WhipGo = false
-- --         end

-- --         if ply.WhipLashList[1] == false and ply.WhipLashList[2] == true and not ply:InVehicle() and (ply.WhipEnt == nil or not ply.WhipEnt:IsValid()) then
            
-- --             ply.WhipLashing = true
-- --             ply.WhipDir = ply:GetAimVector()
-- --             ply.WhipEnt = ents.Create("Whip")
-- --             ply.WhipEnt:SetPos( ply:GetShootPos() )
-- --             ply.WhipEnt:SetAngles(ply:GetAimVector():Angle() + Angle(-90,0,0))
-- --             ply.WhipEnt:SetOwner(ply)
-- --             ply.WhipEnt:Spawn()
-- --             ply.WhipEnt.InitDir = ply:GetAimVector()
-- --             constraint.CreateKeyframeRope(ply:GetPos() + Vector(0,0,70),1,"phoenix_storms/metalset_1-2",ply,ply,Vector(0,0,50),0,ply.WhipEnt,Vector(0,0,0),0)
-- --             ply.WhipEnt:GetPhysicsObject():SetBuoyancyRatio(0.01)
-- --             ply.WhipEnt:GetPhysicsObject():EnableMotion( true )
-- --             ply.WhipEnt:GetPhysicsObject():SetMass( 1 )
-- --             ply.WhipEnt:GetPhysicsObject():EnableDrag( false )

-- --         end

-- --         end

-- --     end

-- -- end)

-- -- hook.Add("OnPhysgunPickup","UltraMod_OnPhysgunPickup",function(ply,ent)

-- --     ent:SetOwner(ply)

-- -- end)

-- -- hook.Add("PhysgunDrop","UltraMod_PhysgunDrop",function(ply,ent)

-- --     ent:SetOwner(nil)

-- -- end)

-- -- --[[hook.Add("OnNPCKilled","UltraMod_OnNPCKilled",function(npc,atk,inf)

-- --     local efdeta = EffectData()
-- --     efdeta:SetOrigin(npc:GetPos() + Vector(0,0,50))
-- --     efdeta:SetEntity(npc)
-- --     efdeta:SetMagnitude(0.2)
-- --     efdeta:SetScale(0.2)
-- --     efdeta:SetRadius(0.2)
-- --     efdeta:SetNormal(Vector(0,0,1))
-- --     efdeta:SetAngles(Angle(0,0,0))
-- --     efdeta:SetFlags(1)
-- --     efdeta:SetColor(0)
-- --     efdeta:SetDamageType(DMG_BULLET)
-- --     efdeta:SetStart(npc:GetPos() + Vector(0,0,50))
-- --     util.Effect("HL1Gib",efdeta)

-- -- end)]]

-- -- hook.Add("PlayerCanHearPlayersVoice","UltraMod_PlayerCanHearPlayersVoice",function(l,t)

-- --     local Trace = {}
-- --     Trace.start = l:GetPos()
-- --     Trace.endpos = t:GetPos()
-- --     Trace.filter = table.Add(player.GetAll())
-- --     if Trace.HitWorld and (l:GetPos() - t:GetPos()):Length() >= 300 then
-- --         return false 
-- --     else
-- --         return true
-- --     end

-- -- end)

-- -- hook.Add("PhysgunPickup","PhysgunPickup",function(ply,ent)

-- --     if ent.Rocket == true and ent.Frozen == true then
-- --         return false
-- --     end
-- --     return true

-- -- end)
