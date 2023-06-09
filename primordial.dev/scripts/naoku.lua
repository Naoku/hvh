local screen_size = render.get_screen_size()
local screen_center = vec2_t(screen_size.x / 2, screen_size.y / 2)
local font = render.create_font("Verdana", 13, 24, e_font_flags.ANTIALIAS)
local font1 = render.create_font("Noto Sans", 16, 24, e_font_flags.ANTIALIAS )
local waterkark_logo_position = vec2_t(screen_size.x-360, 8) 
local waterkark_logo_size = vec2_t(332, 32) 
local mouse_difference = vec2_t(0, 0) 

--logger
local logs = {}
local logrender = {}
local logtime = {}
local boollog = {true,true,true,true,true}
local curTime = {}
local sizeLog = {}
local hitgroup_names = {'generic', 'head', 'chest', 'stomach', 'left arm', 'right arm', 'left leg', 'right leg', 'neck', '?', 'gear'}
--logger

--clantag
time = 0
clantag_version = 1
clan = {
    "A",
    "AB",
    "ABC",
    "ABCD",
    "ABCDE",
    "ABCDEF",
    "ABCDEFG",
    "ABCDEFGH",
    "BCDEFGH",
    "CDEFGH",
    "DEFGH",
    "EFGH",
    "FGH",
    "GH",
    "H"
}
--clantag


-- autopeek circle
radius1 = 5
function world_circle(origin, radius, color)
	local previous_screen_pos, screen
    for i = 1, radius*20 do
		local pos = vec3_t(radius * math.cos(i/3) + origin.x, radius * math.sin(i/3) + origin.y, origin.z);

        local screen = render.world_to_screen(pos) 
        if not screen then return end
		if screen.x ~= nil and previous_screen_pos then
            
            render.line(previous_screen_pos, screen, color)
			previous_screen_pos = screen

        elseif screen.x ~= nil then
            previous_screen_pos = screen
		end
	end
end
-- autopeek circle


local visuals_enabled = menu.add_checkbox("Switch", "Enable Visuals", true)


    local watermark_enabled = menu.add_checkbox("Visuals", "Watermark", 0)
    watermark_enabled:set_visible(false)

    local autopeek_circle_enabled = menu.add_checkbox("Visuals", "Autopeek Circle", 0)
    autopeek_circle_enabled:set_visible(false)

    local custom_crosshair_enable = menu.add_checkbox("Visuals", "Custom Crosshair", false)
    custom_crosshair_enable:set_visible(false)

        local custom_crosshair_color = custom_crosshair_enable:add_color_picker("Custom color")

        local custom_crosshair_offset = menu.add_slider("Visuals", "Offset", 0, 500, 1, 0)
        custom_crosshair_offset:set(70)
        custom_crosshair_offset:set_visible(false)

        local custom_crosshair_padding = menu.add_slider("Visuals", "Padding", -250, 250, 1, 0)
        custom_crosshair_padding:set(10)
        custom_crosshair_padding:set_visible(false)

    local arrows_enable = menu.add_checkbox("Visuals", "Desync Arrows", false)
    arrows_enable:set_visible(false)
    
    local logging_enable = menu.add_checkbox("Visuals", "Enable Logger", false)
    logging_enable:set_visible(false)

    local ragdoll_gravity_enable = menu.add_checkbox("Visuals", "Ragdoll Gravity", false)
    ragdoll_gravity_enable:set_visible(false)
    local ragdoll_gravity = menu.add_selection("Visuals", "Ragdoll Gravity", {"Up", "Up Slow", "Rocket"},3)
    ragdoll_gravity:set_visible(false)

    local viewmodel_x = menu.add_slider("Viewmodel", "x", -20, 20, 1, 0)
    viewmodel_x:set_visible(false)
    local viewmodel_y = menu.add_slider("Viewmodel", "y", -20, 20, 1, 0)
    viewmodel_y:set_visible(false)
    local viewmodel_z = menu.add_slider("Viewmodel", "z", -20, 20, 1, 0)
    viewmodel_z:set_visible(false)
    local viewmodel_fov = menu.add_slider("Viewmodel", "fov", -10, 150, 1, 0)
    viewmodel_fov:set_visible(false)

    viewmodel_x:set(0)
    viewmodel_y:set(0)
    viewmodel_z:set(0)
    viewmodel_fov:set(60)



local ragebot_enabled = menu.add_checkbox("Switch", "Enable Ragebot Improvements", true)

    local hp_plus_and_baim_enable = menu.add_checkbox("Ragebot", "Enable", false)
    hp_plus_and_baim_enable:set_visible(false)
        local hp_and_baim_weapons = menu.add_multi_selection("Ragebot", "Weapons", {"Scout", "AWP", "Auto"})
        hp_and_baim_weapons:set_visible(false)

            local scout_dmg = menu.add_slider("Ragebot", "SCOUT HP+(?)", 1, 10)
            scout_dmg:set_visible(false)
            local scout_force_baim = menu.add_checkbox("Ragebot", "SCOUT baim under hp", false)
            scout_force_baim:set_visible(false)
            local scout_force_baim_dmg = menu.add_slider("Ragebot", "SCOUT baim hp", 1, 100)
            scout_force_baim_dmg:set_visible(false)


            local awp_dmg = menu.add_slider("Ragebot", "AWP HP+(?)", 1, 10)
            awp_dmg:set_visible(false)
            local awp_force_baim = menu.add_checkbox("Ragebot", "AWP baim under hp", false)
            awp_force_baim:set_visible(false)
            local awp_force_baim_dmg = menu.add_slider("Ragebot", "AWP baim hp", 1, 101)
            awp_force_baim_dmg:set_visible(false)


            local auto_force_baim = menu.add_checkbox("Ragebot", "AUTO baim under hp", false)
            auto_force_baim:set_visible(false)
            local auto_force_baim_dmg = menu.add_slider("Ragebot", "AUTO baim hp", 1, 100)
            auto_force_baim_dmg:set_visible(false)




local misc_enabled = menu.add_checkbox("Switch", "Enable Miscellaneous", true)
    local clantag_enabled = menu.add_checkbox("Miscellaneous", "Clantag", false)
    clantag_enabled:set_visible(false)

local antiaim_enabled = menu.add_checkbox("Switch", "Enable Antiaim", true)

    local desync_side_enable = menu.add_checkbox("Desync", "Enable Custom Desync")
    desync_side_enable:set_visible(false)
    local custom_desync_side = menu.add_selection("Desync", "Desync Side", {"left","right","jitter 1", "jitter 2","peek fake","peak real"})
    custom_desync_side:set_visible(false)
    local desync_default_side = menu.add_selection("Desync", "Default Desync Side", {"left","right"})
    desync_default_side:set_visible(false)
    local custom_desync_left = menu.add_slider("Desync", "Desync Left", 0,100)
    custom_desync_left:set_visible(false)
    local custom_desync_right = menu.add_slider("Desync", "Desync Right", 0,100)
    custom_desync_right:set_visible(false)



local active_tab = menu.add_selection("Switch","Active Tab", {"Visuals","Ragebot","Miscellaneous","AntiAim"},4)

local function active_menu_tab()
    if active_tab:get() == 1 then -- visuals
        --visuals tab
        watermark_enabled:set_visible(true)
        autopeek_circle_enabled:set_visible(true)
        custom_crosshair_enable:set_visible(true)
        custom_crosshair_offset:set_visible(true)
        custom_crosshair_padding:set_visible(true)
        arrows_enable:set_visible(true)
        logging_enable:set_visible(true)
        ragdoll_gravity_enable:set_visible(true)
        ragdoll_gravity:set_visible(true)
        viewmodel_x:set_visible(true)
        viewmodel_y:set_visible(true)
        viewmodel_z:set_visible(true)
        viewmodel_fov:set_visible(true)
        --visuals tab

        --ragebot tab
        hp_plus_and_baim_enable:set_visible(false)
        hp_and_baim_weapons:set_visible(false)
        scout_dmg:set_visible(false)
        scout_force_baim:set_visible(false)
        scout_force_baim_dmg:set_visible(false)
        awp_dmg:set_visible(false)
        awp_force_baim:set_visible(false)
        awp_force_baim_dmg:set_visible(false)
        auto_force_baim:set_visible(false)
        auto_force_baim_dmg:set_visible(false)
        --ragebot tab

        --misc
        clantag_enabled:set_visible(false)
        --misc 

        --aa
        desync_side_enable:set_visible(false)
        custom_desync_side:set_visible(false)
        desync_default_side:set_visible(false)
        custom_desync_left:set_visible(false)
        custom_desync_right:set_visible(false)
        --aa
    elseif active_tab:get() == 2 then --ragebot
        --visuals tab
        watermark_enabled:set_visible(false)
        autopeek_circle_enabled:set_visible(false)
        custom_crosshair_enable:set_visible(false)
        custom_crosshair_offset:set_visible(false)
        custom_crosshair_padding:set_visible(false)
        arrows_enable:set_visible(false)
        logging_enable:set_visible(false)
        ragdoll_gravity_enable:set_visible(false)
        ragdoll_gravity:set_visible(false)
        viewmodel_x:set_visible(false)
        viewmodel_y:set_visible(false)
        viewmodel_z:set_visible(false)
        viewmodel_fov:set_visible(false)
        --visuals tab

        --ragebot tab
        hp_plus_and_baim_enable:set_visible(true)
        hp_and_baim_weapons:set_visible(true)
        scout_dmg:set_visible(true)
        scout_force_baim:set_visible(true)
        scout_force_baim_dmg:set_visible(true)
        awp_dmg:set_visible(true)
        awp_force_baim:set_visible(true)
        awp_force_baim_dmg:set_visible(true)
        auto_force_baim:set_visible(true)
        auto_force_baim_dmg:set_visible(true)
        --ragebot tab

        --misc
        clantag_enabled:set_visible(false)
        --misc 

        --aa
        desync_side_enable:set_visible(false)
        custom_desync_side:set_visible(false)
        desync_default_side:set_visible(false)
        custom_desync_left:set_visible(false)
        custom_desync_right:set_visible(false)
        --aa

    elseif active_tab:get() == 3 then --Miscellaneous
        --visuals tab
        watermark_enabled:set_visible(false)
        autopeek_circle_enabled:set_visible(false)
        custom_crosshair_enable:set_visible(false)
        custom_crosshair_offset:set_visible(false)
        custom_crosshair_padding:set_visible(false)
        arrows_enable:set_visible(false)
        logging_enable:set_visible(false)
        ragdoll_gravity_enable:set_visible(false)
        ragdoll_gravity:set_visible(false)
        viewmodel_x:set_visible(false)
        viewmodel_y:set_visible(false)
        viewmodel_z:set_visible(false)
        viewmodel_fov:set_visible(false)
        --visuals tab

        --ragebot tab
        hp_plus_and_baim_enable:set_visible(false)
        hp_and_baim_weapons:set_visible(false)
        scout_dmg:set_visible(false)
        scout_force_baim:set_visible(false)
        scout_force_baim_dmg:set_visible(false)
        awp_dmg:set_visible(false)
        awp_force_baim:set_visible(false)
        awp_force_baim_dmg:set_visible(false)
        auto_force_baim:set_visible(false)
        auto_force_baim_dmg:set_visible(false)
        --ragebot tab

        --misc
        clantag_enabled:set_visible(true)
        --misc 

        --aa
        desync_side_enable:set_visible(false)
        custom_desync_side:set_visible(false)
        desync_default_side:set_visible(false)
        custom_desync_left:set_visible(false)
        custom_desync_right:set_visible(false)
        --aa

    elseif active_tab:get() == 4 then -- anti aim
        --visuals tab
        watermark_enabled:set_visible(false)
        autopeek_circle_enabled:set_visible(false)
        custom_crosshair_enable:set_visible(false)
        custom_crosshair_offset:set_visible(false)
        custom_crosshair_padding:set_visible(false)
        arrows_enable:set_visible(false)
        logging_enable:set_visible(false)
        ragdoll_gravity_enable:set_visible(false)
        ragdoll_gravity:set_visible(false)
        viewmodel_x:set_visible(false)
        viewmodel_y:set_visible(false)
        viewmodel_z:set_visible(false)
        viewmodel_fov:set_visible(false)
        --visuals tab

        --ragebot tab
        hp_plus_and_baim_enable:set_visible(false)
        hp_and_baim_weapons:set_visible(false)
        scout_dmg:set_visible(false)
        scout_force_baim:set_visible(false)
        scout_force_baim_dmg:set_visible(false)
        awp_dmg:set_visible(false)
        awp_force_baim:set_visible(false)
        awp_force_baim_dmg:set_visible(false)
        auto_force_baim:set_visible(false)
        auto_force_baim_dmg:set_visible(false)
        --ragebot tab

        --misc
        clantag_enabled:set_visible(false)
        --misc 

        --aa
        desync_side_enable:set_visible(true)
        custom_desync_side:set_visible(true)
        custom_desync_left:set_visible(true)
        custom_desync_right:set_visible(true)
        --aa

    end
end

local function custom_watermark()
    if visuals_enabled:get() and watermark_enabled:get() then
        if menu.is_open() then
            if input.is_key_held(e_keys.MOUSE_LEFT) and input.is_mouse_in_bounds(vec2_t(waterkark_logo_position.x-25,waterkark_logo_position.y-25), vec2_t(waterkark_logo_size.x+50, waterkark_logo_size.y+50)) then
                waterkark_logo_position = input.get_mouse_pos() + mouse_difference
            else
                mouse_difference = waterkark_logo_position - input.get_mouse_pos()
            end
        end
    
        local fps =  client.get_fps()
        local user = user.name
        local tick = client.get_tickrate()
        local h, m, s = client.get_local_time()
        local time = string.format("%02d:%02d:%02d", h, m, s)
        local text = string.format("Naoku.lua    %s    %s fps    %s tick    %2s",user, fps, tick, time)
    
        local text_size = render.get_text_size(font,text)
        render.rect_fade(vec2_t(waterkark_logo_position.x, waterkark_logo_position.y), vec2_t(text_size.x+10,waterkark_logo_size.y), color_t(0,0,0,100), color_t(0,0,0,220), 3)
        render.rect(waterkark_logo_position, vec2_t(text_size.x+10,waterkark_logo_size.y), color_t(255,255,255,120), 3)
    
        render.text(font1,text,vec2_t(waterkark_logo_position.x + 10, waterkark_logo_position.y+7),color_t(255,255,255,255))
    end
end

local function custom_sniper_crosshair()
    local local_player = entity_list.get_local_player()
    if visuals_enabled:get() and custom_crosshair_enable:get() and local_player ~= nil and local_player:get_prop("m_bIsScoped") == 1 then
        pos = vec2_t(screen_center.x, screen_center.y - custom_crosshair_offset:get())
        size = vec2_t(1, custom_crosshair_offset:get())
        pos.y = pos.y - (custom_crosshair_padding:get() - 1)
        render.rect_fade(pos, size, color_t(0, 0, 0, 0), custom_crosshair_color:get())

        pos = vec2_t(screen_center.x, screen_center.y + (custom_crosshair_offset:get() * 0 ))
        size = vec2_t(1, custom_crosshair_offset:get() - ( custom_crosshair_offset:get() * 0 ))
        pos.y = pos.y + custom_crosshair_padding:get()
        render.rect_fade(pos, size, custom_crosshair_color:get(), color_t(0, 0, 0, 0))

        pos = vec2_t(screen_center.x - custom_crosshair_offset:get(), screen_center.y)
        size = vec2_t(custom_crosshair_offset:get(), 1)
        pos.x = pos.x - (custom_crosshair_padding:get() - 1)
        render.rect_fade(pos, size, color_t(0, 0, 0, 0), custom_crosshair_color:get(), true)

        pos = vec2_t(screen_center.x + (custom_crosshair_offset:get() * 0 ), screen_center.y)
        size = vec2_t(custom_crosshair_offset:get() - ( custom_crosshair_offset:get() * 0 ), 1)
        pos.x = pos.x + custom_crosshair_padding:get()
        render.rect_fade(pos, size, custom_crosshair_color:get(), color_t(0, 0, 0, 0), true)
    end
end

local function custom_desync_arrows()
    local local_player = entity_list.get_local_player()
    if visuals_enabled:get() and arrows_enable:get() and local_player ~= nil then
        if local_player:get_prop("m_bIsScoped") == 1 then
            scoped_arrows = 15
        else
            scoped_arrows = 0
        end
        if antiaim.get_desync_side() == 1 then
            render.triangle_filled(vec2_t.new(screen_center.x - 15, screen_center.y + scoped_arrows), 10, color_t.new(0,200,255), 270)
            render.triangle(vec2_t.new(screen_center.x + 15, screen_center.y + scoped_arrows), 10, color_t.new(255,255,255), 90)
        end

        if antiaim.get_desync_side() == 2 then
            render.triangle_filled(vec2_t.new(screen_center.x + 15, screen_center.y + scoped_arrows), 10, color_t.new(0,200,255), 90)
            render.triangle(vec2_t.new(screen_center.x - 15, screen_center.y + scoped_arrows), 10, color_t.new(255,255,255), 270)
        end
    end
end

local function custom_autopeek_cirle()
    local local_player = entity_list.get_local_player()
    local current_rainbow = (global_vars.real_time() * 25) % 100
    if visuals_enabled:get() and ragebot.get_autopeek_pos() and autopeek_circle_enabled:get() and radius1 < 20 and local_player:is_alive() then
        world_circle(ragebot.get_autopeek_pos(), radius1, color_t.from_hsb(current_rainbow / 100, 1, 1))
        radius1 = radius1 + 0.1
    else
        radius1 = 5
    end
end

local function custom_ragdoll_gravity()
    if visuals_enabled:get() and ragdoll_gravity_enable:get() then
        if ragdoll_gravity:get() == 1 then
            cvars.cl_ragdoll_gravity:set_int(-2000)
        elseif ragdoll_gravity:get() == 2 then
            cvars.cl_ragdoll_gravity:set_int(-500)
        elseif ragdoll_gravity:get() == 3 then
            cvars.cl_ragdoll_gravity:set_int(-20000)
        end
    end
end

local function custom_viewmodel()
    cvars.sv_competitive_minspec:set_int(0)
    cvars.viewmodel_fov:set_int(viewmodel_fov:get())
    cvars.viewmodel_offset_x:set_int(viewmodel_x:get())
    cvars.viewmodel_offset_y:set_int(viewmodel_y:get())
    cvars.viewmodel_offset_z:set_int(viewmodel_z:get())
end

local function custom_clantag()
    local local_player = entity_list.get_local_player()

    if misc_enabled:get() and clantag_enabled:get() then
        if global_vars.cur_time() - time > 0.75 and local_player ~= nil then
            clantag_version = clantag_version + 1
            if clantag_version == 15 then
                clantag_version = 1
            end
    
            clan_tag = clan[clantag_version]
            clan_tag_off = clan_tag
            client.set_clantag(clan_tag)
            time = global_vars.cur_time()
        end
    end

    if not clantag_enabled:get() and clan_tag_off == clan_tag then
        client.set_clantag("")
        clan_tag_off = ""
    end
end


function onHit(e)
    local hitString = string.format("Hit %s - %s [%s]", e.player:get_name(), e.damage, hitgroup_names[e.hitgroup + 1] or '?')
    local logs_size = render.get_text_size(font, hitString)
    table.insert(logs, hitString)
    table.insert(logrender, true)
    table.insert(sizeLog, logs_size)
    if #logs > 5 then
        table.remove(logs, 1)
        table.remove(logrender, 1)
        table.remove(logtime, 1)
        table.remove(boollog, 1)
        table.remove(curTime, 1)
        table.remove(sizeLog, 1)
    end
    client.log(color_t(255, 255, 255),"Hit",color_t(0, 255, 0), e.player:get_name(),color_t(255, 255, 255), "in the", hitgroup_names[e.hitgroup + 1] or '?', "for", e.damage, "[predicted dmg:", e.aim_damage, "hc:", math.floor(e.aim_hitchance),  "bt:", e.backtrack_ticks,"]")
    boollog[#logs] = true
end

function onMiss(e)
    local missString = string.format("Missed %s %s [%s]", e.player:get_name(), hitgroup_names[e.aim_hitgroup + 1] or '?', e.reason_string)
    local logs_size = render.get_text_size(font, missString)
    table.insert(logs, missString)
    table.insert(logrender, true)
    table.insert(sizeLog, logs_size)
    if #logs > 5 then
        table.remove(logs, 1)
        table.remove(logrender, 1) 
        table.remove(logtime, 1)
        table.remove(boollog, 1)
        table.remove(curTime, 1)
        table.remove(sizeLog, 1)
    end
    client.log(color_t(255, 255, 255),"Missed",color_t(255, 0, 0), e.player:get_name().."'s",color_t(255, 255, 255), hitgroup_names[e.aim_hitgroup + 1] or '?',  "[predicted dmg:", e.aim_damage, "hc:", math.floor(e.aim_hitchance),  "bt:", e.backtrack_ticks,"]")
    boollog[#logs] = true
end

function handleVisibility()
    for i = 1, #logs do
        if boollog[i] then
            curTime[i] = client.get_unix_time() + 5
            boollog[i] = false
            logtime[i] = 255
        end
        if not curTime[i] then goto endrendering end
        if curTime[i] < client.get_unix_time() then
            logtime[i] = logtime[i] - 1
        end
        if logtime[i] == 10 then
            table.remove(logs, i)
            table.remove(logrender, i)
            table.remove(logtime, i)
            table.remove(boollog, i)
            table.remove(curTime, i)
            table.remove(sizeLog, i)
        end
        ::endrendering::
    end 
end

function drawLog()
    if logging_enable:get() then
        local screen_size = render.get_screen_size()
        for i = 1, #logs do
            if logrender[i] then
                if sizeLog[i] then
                    if not logtime[i] or not logs[i] then return end

                    local color_log = 0 + logtime[i]
                    if color_log > 101 then
                        color_log = 100
                    end

                    render.rect_filled(vec2_t(screen_size.x/2 - sizeLog[i].x/2 - sizeLog[i].x/40, screen_size.y/2 + (i*45) + 200 - 10), vec2_t(sizeLog[i].x + 9, sizeLog[i].y + 9), color_t(0,0,0,color_log), 3)
                    render.text(font, logs[i], vec2_t(screen_size.x/2, screen_size.y/2 + (i*45) + 200), color_t(255, 255, 255, logtime[i]), true)
                    render.rect(vec2_t(screen_size.x/2 - sizeLog[i].x/2 - sizeLog[i].x/40, screen_size.y/2 + (i*45) + 200 - 10), vec2_t(sizeLog[i].x + 9, sizeLog[i].y + 9), color_t(255,255,255,logtime[i]), 3)
                end
            end
        end
    end
end

local function set_dmg(ctx)
    if not ctx or not ctx.player:is_alive() or ctx == nil then
        return
    end

    local health = ctx.player:get_prop("m_iHealth")

    local local_player = entity_list.get_local_player()
    if not local_player or not local_player:is_alive() then
        return
    end

    local current_weapon = local_player:get_active_weapon():get_name()
    if not current_weapon then
        return
    end

    local scout_dmg_override = menu.find("aimbot", "scout", "target overrides", "min. damage")[2]:get()
    local awp_dmg_override = menu.find("aimbot", "awp", "target overrides", "min. damage")[2]:get()
    local auto_dmg_override = menu.find("aimbot", "auto", "target overrides", "min. damage")[2]:get()
    if ragebot_enabled:get() then
        if current_weapon == "ssg08" and hp_and_baim_weapons:get(1) and hp_plus_and_baim_enable:get() and not scout_dmg_override then
            if scout_force_baim:get() and health < scout_force_baim_dmg:get() then
                ctx:set_hitscan_group_state(e_hitscan_groups.HEAD, false)
            end
            ctx:set_min_dmg(tonumber(health + scout_dmg:get()))
        elseif current_weapon == "awp" and hp_and_baim_weapons:get(2) and hp_plus_and_baim_enable:get() and not awp_dmg_override then
            if awp_force_baim:get() and health < awp_force_baim_dmg:get() then
                ctx:set_hitscan_group_state(e_hitscan_groups.HEAD, false)
            end
            ctx:set_min_dmg(tonumber(health + awp_dmg:get()))

        elseif current_weapon == "scar20" or "g3sg1" and hp_and_baim_weapons:get(2) and hp_plus_and_baim_enable:get() and not auto_dmg_override then
            if auto_force_baim:get() and health < auto_force_baim_dmg:get() then
                ctx:set_hitscan_group_state(e_hitscan_groups.HEAD, false)
            end
        end
    end
end

local function custom_antiaim(ctx)
    if antiaim_enabled:get() and desync_side_enable:get() then
        if custom_desync_side:get() == 1 then --left
            menu.find("antiaim","main","desync","left amount"):set(custom_desync_left:get())
            menu.find("antiaim","main","desync","right amount"):set(custom_desync_right:get())
            desync_default_side:set_visible(false)
            menu.find("antiaim","main","desync","side"):set(2)

        elseif custom_desync_side:get() == 2 then --right
            menu.find("antiaim","main","desync","left amount"):set(custom_desync_left:get())
            menu.find("antiaim","main","desync","right amount"):set(custom_desync_right:get())
            desync_default_side:set_visible(false)
            menu.find("antiaim","main","desync","side"):set(3)

        elseif custom_desync_side:get() == 3 then --jitter 1
            menu.find("antiaim","main","desync","left amount"):set(custom_desync_left:get())
            menu.find("antiaim","main","desync","right amount"):set(custom_desync_right:get())
            desync_default_side:set_visible(false)
            menu.find("antiaim","main","desync","side"):set(4)

        elseif custom_desync_side:get() == 4 then --jitter 2

            menu.find("antiaim","main","desync","left amount"):set(math.random(0,custom_desync_left:get()))
            menu.find("antiaim","main","desync","right amount"):set(math.random(custom_desync_right:get()))
            desync_default_side:set_visible(false)
            menu.find("antiaim","main","desync","side"):set(4)
            jitter_desync = math.random(-1,1)
            ctx:set_desync(jitter_desync)

        elseif custom_desync_side:get() == 5 then --peek fake
            menu.find("antiaim","main","desync","left amount"):set(custom_desync_left:get())
            menu.find("antiaim","main","desync","right amount"):set(custom_desync_right:get())

            desync_default_side:set_visible(true)

            menu.find("antiaim","main","desync","side"):set(5)
            if desync_default_side:get() == 1 then
                menu.find("antiaim","main","desync","default side"):set(1)
            else
                menu.find("antiaim","main","desync","default side"):set(2)
            end

        elseif custom_desync_side:get() == 6 then --peek real
            menu.find("antiaim","main","desync","left amount"):set(custom_desync_left:get())
            menu.find("antiaim","main","desync","right amount"):set(custom_desync_right:get())

            desync_default_side:set_visible(true)

            menu.find("antiaim","main","desync","side"):set(6)

            if desync_default_side:get() == 1 then
                menu.find("antiaim","main","desync","default side"):set(1)
            else
                menu.find("antiaim","main","desync","default side"):set(2)
            end
        end
    end
end

callbacks.add(e_callbacks.HITSCAN, set_dmg)
callbacks.add(e_callbacks.AIMBOT_MISS, onMiss)
callbacks.add(e_callbacks.AIMBOT_HIT, onHit)


callbacks.add(e_callbacks.ANTIAIM, function(ctx)
    custom_antiaim(ctx)
end)

callbacks.add(e_callbacks.PAINT, function()
    active_menu_tab()
    drawLog()
    handleVisibility()
    custom_watermark()
    custom_sniper_crosshair()
    custom_desync_arrows()
    custom_autopeek_cirle()
    custom_ragdoll_gravity()
    custom_clantag()
    custom_viewmodel()
end)

local function on_shutdown()
    client.set_clantag("")
end

callbacks.add(e_callbacks.SHUTDOWN,on_shutdown)

