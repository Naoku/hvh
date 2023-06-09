keybindlist_position = vec2_t(0,0)
keybindlist_modes = {"[toggle]", "[hold]", "[on]", "[on]","[off]"}
keybindlist_position = vec2_t(200, 200) --* initialize menu position
mouse_difference = vec2_t(0, 0) --* simple dragging

local keybindings = {
    ["Double Tap"] = menu.find("aimbot","general","exploits","doubletap","enable"),
    ["Hide Shots"] = menu.find("aimbot","general","exploits","hideshots","enable"),
    ["Auto Peek"] = menu.find("aimbot","general","misc","autopeek"),
    ["Fake Duck"] = menu.find("antiaim","main","general","fakeduck"),
    ["Invert Desync"] = menu.find("antiaim","main","manual","invert desync"),
    ["Manual Left"] = menu.find("antiaim","main","manual","left"),
    ["Manual Back"] = menu.find("antiaim","main","manual","back"),
    ["Manual Right"] = menu.find("antiaim","main","manual","right"),
    ["Auto Direction"] = menu.find("antiaim","main","auto direction","enable"),
    ["Slow Walk"] = menu.find("misc","main","movement","slow walk"),
    ["Fake Ping"] = menu.find("aimbot","general","fake ping","enable"),
    ["Damage Override"] = menu.find("aimbot","scout","target overrides", "min. damage"),
    
}

local keybind_enable = menu.add_checkbox("joelus ui | keybinds", "keybinds", true)
local keybind_colour = keybind_enable:add_color_picker("keybinds colour")
local font = render.create_font("Verdana", 12, 24, e_font_flags.ANTIALIAS)

local function keybinds()
    if keybind_enable:get() or entity_list.get_local_player() then 
        offset = 0
        if input.is_key_held(e_keys.MOUSE_LEFT) and input.is_mouse_in_bounds(keybindlist_position, vec2_t(200, 200)) and menu.is_open() then
            keybindlist_position = input.get_mouse_pos() + mouse_difference
        else
            mouse_difference = keybindlist_position - input.get_mouse_pos()
        end

        render.rect_filled(vec2_t(keybindlist_position.x-10, keybindlist_position.y), vec2_t(195, 16), color_t(13,13,13,110),3)
        render.rect_filled(vec2_t(keybindlist_position.x-10, keybindlist_position.y), vec2_t(195, 1), keybind_colour:get(),3)
        render.text(font, "keybinds", vec2_t(keybindlist_position.x+175/2, keybindlist_position.y+8), color_t(255,255,255,255), true)


        keybindlist_positiony2 = keybindlist_position.y+20
        for i, v in pairs(keybindings) do
            local dap = v[2]
            if dap:get() or menu.is_open() then
                functiontext = render.get_text_size(font, i)
                itssize = render.get_text_size(font, keybindlist_modes[dap:get_mode()+1])

                render.rect_filled(vec2_t(keybindlist_position.x-10, keybindlist_positiony2+offset*18+offset*1), vec2_t(195, itssize.y+2), color_t(13,13,13,110),3)
                render.text(font, keybindlist_modes[dap:get_mode()+1], vec2_t(keybindlist_position.x + 175 - itssize.x, keybindlist_positiony2+18*offset+offset*1), color_t(255,255,255,255))
                render.text(font, i, vec2_t(keybindlist_position.x+2, keybindlist_positiony2+18*offset+offset*1), color_t(255,255,255,255))
                offset = offset + 1
            end
        end
    end
end

callbacks.add(e_callbacks.PAINT, keybinds)