local function uaa()
    a = math.random(0,100)
    menu.find("misc","main","movement","speed"):set(a)

    b = math.random(2,3)
    menu.find("antiaim","main","desync","side"):set(b)
end

callbacks.add(e_callbacks.PAINT, uaa)