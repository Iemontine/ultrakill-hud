-- create convars
CreateClientConVar("ultrakill_hud_opacity", 80, true, false, "0-100%", 0, 100)
CreateClientConVar("ultrakill_hud_enable", 1, true, false, "1 = enabled, 0 = disabled", 0, 1)
CreateClientConVar("ultrakill_hud_xoffset", 1, true, false, "-1000 - 1000", -1000, 1000)
CreateClientConVar("ultrakill_hud_yoffset", 1, true, false, "-1000 - 1000", -1000, 1000)

-- create utility menu
hook.Add("PopulateToolMenu", "UltrakillHUD", function()
    spawnmenu.AddToolMenuOption("Utilities", "ULTRAKILL", "UltrakillHUD", "[HUD]", "", "", function(panel)
        panel:ClearControls()
        panel:CheckBox("Draw ULTRAKILL HUD", "ultrakill_hud_enable")
        panel:NumSlider("ULTRAKILL HUD Opacity", "ultrakill_hud_opacity", 0, 100, 2)
        panel:ControlHelp("Opacity of the background HUD boxes as a % (0-100)")
        panel:NumSlider("X Offset", "ultrakill_hud_xoffset", -1000, 1000, 2)
        panel:NumSlider("Y Offset", "ultrakill_hud_yoffset", -1000, 1000, 2)
        panel:Help("Customization options coming soon! 6/14/2023")
        panel:Help("(Made by lemontine)")
    end)
end)
