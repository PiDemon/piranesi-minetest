-----------
--compass--
-----------
local register_compass = function(texture,name)
	minetest.register_tool("piranesi:compass"..name, {
		description = "Compass",
		inventory_image = texture,
		wield_image = texture,
	})
end
register_compass("compass_north.png","north")
register_compass("compass_west.png","west")
register_compass("compass_east.png","east")
register_compass("compass_south.png","south")

minetest.register_globalstep(function(dtime)
	--there should only be one player...
	player = minetest.get_player_by_name("singleplayer")
	if player then
		for i,stack in ipairs(player:get_inventory():get_list("main")) do
			if stack:get_name():sub(1, 16) == "piranesi:compass" then
				index = i
				compass=true 
				break
			end
		end
		if compass then -- potientially player might drop their compass?
			local angle = math.deg(player:get_look_horizontal())
			local direction
			if 135 > angle and angle > 45 then
				direction = "west"
			elseif 225 > angle and angle >= 135 then
				direction = "south"
			elseif 315 > angle and angle >= 225 then
				direction = "east"
			else
				direction = "north"
			end
			player:get_inventory():set_stack("main",index,"piranesi:compass"..direction)
		end
	end
end)