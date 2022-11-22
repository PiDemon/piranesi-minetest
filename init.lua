piranesi = {}
piranesi.storage = minetest.get_mod_storage()
local path = minetest.get_modpath("piranesi")
local rooms_to_visit_constant = {"parlor.mts","kitchen.mts","fire_poles.mts","prison.mts","diner.mts","observatory.mts","theater.mts","garden.mts","pool.mts","bathroom.mts","bedroom.mts","potion.mts","library.mts"}
local rooms_to_visit_length = 13
local rooms_to_visit = rooms_to_visit_constant
local debug = false
piranesi.storage:set_string("moves","ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee") --e for empty, 20 moves stored
piranesi.storage:set_string("candles","88888888")
piranesi.storage:set_int("clockcode","88888")
piranesi.storage:set_int("crowns",0)
piranesi.storage:set_int("time",1)
---------------
--other files--
---------------
dofile(path .. "/decor.lua")
dofile(path .. "/machine.lua")
dofile(path .. "/compass.lua")
dofile(path .. "/clues.lua")
dofile(path .. "/sounds.lua")
-----------------
--general stuff--
-----------------
local particle = function(pos)
	minetest.add_particlespawner({
		amount = 100,
		time = 2,
		minpos = {x=pos.x-1, y=pos.y-0.5, z=pos.z-1},
		maxpos = {x=pos.x+1, y=pos.y-0.5, z=pos.z+1},
		minvel = {x=0, y=0.5, z=0},
		maxvel = {x=0, y=5, z=0},
		minexptime=3,
		maxexptime=5,
		minsize=0.5,
		maxsize=2,
		glow = 10,
		texture = "magic_particle.png",
	})
end

local choose_room = function(moves)
	if debug then
		return "forrest_maze.mts", "true"
	end
	--reset counter 
	if rooms_to_visit_length == 0 then
		rooms_to_visit_length = 12
		rooms_to_visit = rooms_to_visit_constant
	end
	--special rooms
	local moves = piranesi.storage:get_string("moves")
	----minetest.chat_send_all(moves:sub(27).." look here!")
	if moves:sub(25) == "eezpeezmeezpeezm" or moves:sub(25) == "eexpeexmeexpeexm" then
		return "forrest_maze.mts", "true"
	elseif moves:sub(35) == "sseezp"  then
		return "blocked.mts", ""
	elseif moves:sub(27) == "zpeexpeezmeexm"  then
		return "forge.mts", "true"
	elseif moves:sub(27) == "zpeexmeezmeexp"  then
		--remember we visited the throne room
		piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."tt")
		return "throneroom.mts", "true"
	elseif moves:sub(27) == "tteexpeexpeexp" then
		return "tower.mts", "true"
	elseif moves:sub(27) == "tteezpeezpeezp" then
		return "lake.mts", "true"
	elseif moves:sub(27) == "tteezmeezmeezm" then
		return "final_room.mts", ""
	elseif moves:sub(27) == "tteexmeexmeexm" then
		return "graveyard.mts", "true"
	elseif moves:sub(21) == "eezpeexpeexmeezpeexp" then
		return "candle_room.mts"
	end
	--randomly placed rooms
	if math.random(1,5) == 1 then
		local halls = {"quad_hall.mts","quad_hall.mts","quad_hall_ruins.mts","quad_hall_burning.mts","quad_hall_open.mts","quad_hall_open.mts"}
		return halls[math.random(1,6)]
	else
		local rand = math.random(1,rooms_to_visit_length)
		chosen_room = rooms_to_visit[rand]
		table.remove(rooms_to_visit,rand)
		rooms_to_visit_length = rooms_to_visit_length-1
		--minetest.chat_send_all(chosen_room)
		return chosen_room, ""
	end
end

local place_room = function(file, pos)
	--before placement...
	-- if file == "forrest_maze.mts" then
		-- if piranesi.storage:get_string("moves"):sub(39,40) == "zm" then
			-- pos.z=pos.z-20
		-- elseif piranesi.storage:get_string("moves"):sub(39,40) == "xm" then
			-- pos.x=pos.x-20
		-- end
	-- end
	if file == "graveyard.mts" then
		pos.y=pos.y-22
		minetest.place_schematic(pos, path .. "/schems/" .. "graveyard.mts")
	end
	
	minetest.place_schematic(pos, path .. "/schems/" .. file)
	
	--...and after.
	-- if file == "forest_maze.mts" then
		-- pos.x=pos.x+35
		-- pos.y=pos.y+1
		-- pos.z=pos.z+10
		-- minetest.set_node(pos, {name = "piranesi:shovelblock"})
		-- pos.x=pos.x-35
		-- pos.y=pos.y-1
		-- pos.z=pos.z-10
		
		-- pos.x=pos.x+16
		-- pos.y=pos.y+1
		-- pos.z=pos.z+26
		-- minetest.set_node(pos, {name = "flowers:dandelion_white"})
		-- pos.x=pos.x-16
		-- pos.y=pos.y-1
		-- pos.z=pos.z-26
	-- end
	if file == "garden.mts" then
		pos.y=pos.y-1
		minetest.place_schematic(pos, path .. "/schems/" .. "garden.mts")
		pos.y=pos.y+1
	end
	--minetest.after(1,function(file,pos)
		----minetest.chat_send_all("sdas")
		if file == "hall_z_plus.mts" or file == "hall_z_minus.mts" then
			pos.y=pos.y+1
			pos.z=pos.z+9
			pos.x=pos.x+16
			--minetest.set_node(pos, {name = "default:lava_source"})
			--main trigger
			minetest.get_node_timer(pos):start(0.1)
			pos.z = pos.z+2
			--spacer
			minetest.get_node_timer(pos):start(0.1)
			pos.z=pos.z-4
			--spacer
			minetest.get_node_timer(pos):start(0.1)
			pos.z=pos.z+2
			pos.y=pos.y-1
			pos.z=pos.z-9
			pos.x=pos.x-16
		end
		if file == "hall_x_plus.mts" or file == "hall_x_minus.mts" then
			pos.y=pos.y+1
			pos.x=pos.x+9
			pos.z=pos.z+3
			--minetest.set_node(pos, {name = "default:lava_source"})
			--main trigger
			minetest.get_node_timer(pos):start(0.1)
			pos.x = pos.x+2
			--spacer
			minetest.get_node_timer(pos):start(0.1)
			pos.x=pos.x-4
			--spacer
			minetest.get_node_timer(pos):start(0.1)
			pos.x=pos.x+2
			pos.y=pos.y-1
			pos.x=pos.x-9
			pos.z=pos.z-3
		end
		if file == "final_room.mts" then
			pos.y=pos.y-36
			minetest.place_schematic(pos, path .. "/schems/" .. "final_room.mts")
		end

		if file == "final_room_2.mts" then
			--pos.y=pos.y-36
			--minetest.place_schematic(pos, path .. "/schems/" .. "final_room_2.mts")
			pos.x=pos.x+9
			pos.y=pos.y+5
			pos.z=pos.z+9
			pos.y=pos.y-4
			minetest.get_node_timer(pos):start(0.1)
			pos.z=pos.z+1
			minetest.get_node_timer(pos):start(0.1)
			pos.x=pos.x+1
			minetest.get_node_timer(pos):start(0.1)
			pos.z=pos.z-1
			minetest.get_node_timer(pos):start(0.1)
			pos.x=pos.x-1
		end	
	--end
	--)
end

local place_halls = function(pos,big)
	if big ~= "true" then
		--x+
		pos.x=pos.x+20
		place_room("hall_x_plus.mts", pos)
		--x-
		pos.x=pos.x-40
		place_room("hall_x_minus.mts", pos)
		--reset x
		pos.x=pos.x+20
		--z+
		pos.z=pos.z+20
		place_room("hall_z_plus.mts", pos)
		--z-
		pos.z=pos.z-40
		place_room("hall_z_minus.mts", pos)
		--reset z
		pos.z=pos.z+20
	else
		--minetest.chat_send_all(piranesi.storage:get_string("moves"))
		if piranesi.storage:get_string("moves"):sub(39,40) == "zm" then
			--minetest.chat_send_all("sada")
			pos.z=pos.z-20
		elseif piranesi.storage:get_string("moves"):sub(39,40) == "xm" then		
			pos.x=pos.x-20
		end
		pos.z=pos.z-20
		place_room("hall_z_minus.mts", pos)
		pos.x=pos.x+20
		place_room("hall_z_minus.mts", pos)
		pos.x=pos.x+20
		pos.z=pos.z+20
		place_room("hall_x_plus.mts", pos)
		pos.z=pos.z+20
		place_room("hall_x_plus.mts", pos)
		pos.z=pos.z+20
		pos.x=pos.x-20
		place_room("hall_z_plus.mts", pos)
		pos.x=pos.x-20
		place_room("hall_z_plus.mts", pos)
		pos.x=pos.x-20
		pos.z=pos.z-20
		place_room("hall_x_minus.mts", pos)
		pos.z=pos.z-20 
		place_room("hall_x_minus.mts", pos)
		pos.x=pos.x+20
	end
end

remove_collectable = function(pos, oldnode, oldmetadata, digger)
	piranesi.storage:set_string(oldnode.name,"true")
--	minetest.get_inventory(minetest.get_player_name(digger)):add_item("main",unode.drop)
--	return true
end
------------------
--trigger blocks--
------------------
minetest.register_node("piranesi:trigger_spacer", {
	description = "Trigger Spacer",
    tiles = {},
	inventory_image = "default_goldblock.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	pointable = false,
	sunlight_propagates = true,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				if piranesi.storage:get_string("moves"):sub(39,40) ~= "ee" then
					piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."ee")
				end
				--minetest.chat_send_all(minetest.serialize(piranesi.storage:get_string("moves")))
			end
		end
		return true
end
})
minetest.register_node("piranesi:trigger_z_plus", {
	description = "Trigger Block z+",
    tiles = {},
	inventory_image = "default_diamond.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	pointable = false,
	sunlight_propagates = true,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				piranesi.storage:set_string("moves",piranesi.storage:get_string("moves").."zp")
				--get to the corner of the room schematic-wise
				pos.z=pos.z-9
				pos.y=pos.y-1
				pos.x=pos.x-16
				--place rooms on both ends with hallways
				if piranesi.storage:get_string("moves"):sub(39,40) == "ee" then
					piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."zp")
					pos.z=pos.z-20
					local room, big = choose_room()
					--place_halls(pos, big)
					--place_room(room, pos)
					pos.z=pos.z+40
					place_halls(pos, big)
					place_room(room, pos)
				end
				--minetest.chat_send_all("HHIIII")
			end
		end
		return true
end
})
minetest.register_node("piranesi:trigger_z_minus", {
	description = "Trigger Block z-",
    tiles = {},
	inventory_image = "default_diamond.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	pointable = false,
	sunlight_propagates = true,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				--get to the corner of the room schematic-wise
				piranesi.storage:set_string("moves",piranesi.storage:get_string("moves").."zm")
				pos.z=pos.z-9
				pos.y=pos.y-1
				pos.x=pos.x-16
				--place rooms on both ends with hallways
				if piranesi.storage:get_string("moves"):sub(39,40) == "ee" then
					piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."zm")
					pos.z=pos.z+20
					local room, big = choose_room()
					--place_halls(pos, big)
					--place_room(room, pos)
					pos.z=pos.z-40
					place_halls(pos, big)
					place_room(room, pos)
					----minetest.chat_send_all("HHIIeII")
				end
			end
		end
		return true
end
})
minetest.register_node("piranesi:trigger_x_plus", {
	description = "Trigger Block x+",
    tiles = {},
	inventory_image = "default_mese_crystal.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	pointable = false,
	sunlight_propagates = true,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(0.1)
	end,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		----minetest.chat_send_all("HHIIII")
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				--get to the corner of the room schematic-wise
				piranesi.storage:set_string("moves",piranesi.storage:get_string("moves").."xp")
				pos.x=pos.x-9
				pos.y=pos.y-1
				pos.z=pos.z-3
				--place rooms on both ends with hallways
				if piranesi.storage:get_string("moves"):sub(39,40) == "ee" then
					piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."xp")
					pos.x=pos.x-20
					local room, big = choose_room()
					--place_halls(pos, big)
					--place_room(room, pos)
					pos.x=pos.x+40
					place_halls(pos, big)
					place_room(room, pos)
				end
				
			end
		end
		return true
end
})
minetest.register_node("piranesi:trigger_x_minus", {
	description = "Trigger Block x-",
    tiles = {},
	inventory_image = "default_mese_crystal.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	buildable_to = false,
	sunlight_propagates = true,
	pointable = false,
	on_construct = function(pos)
		local timer = minetest.get_node_timer(pos)
		timer:start(0.1)
	end,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		----minetest.chat_send_all("HHIIII")
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				piranesi.storage:set_string("moves",piranesi.storage:get_string("moves").."xm")
				--get to the corner of the room schematic-wise
				pos.x=pos.x-9
				pos.y=pos.y-1
				pos.z=pos.z-3
				--place rooms on both ends with hallways
				if piranesi.storage:get_string("moves"):sub(39,40) == "ee" then
					piranesi.storage:set_string("moves",piranesi.storage:get_string("moves"):sub(3,40).."xm")
					pos.x=pos.x+20
					local room, big = choose_room()
					--place_halls(pos, big)
					--place_room(room, pos)
					pos.x=pos.x-40
					place_halls(pos, big)
					place_room(room, pos)
				end
			end
		end
		return true
end
})
minetest.register_node("piranesi:end", {
	description = "Trigger Block Ending",
    tiles = {},
	inventory_image = "default_diamond_block.png",
	groups = {cracky=1},
	drawtype = "airlike",
	paramtype = "light",
	walkable = false,
	pointable = false,
	buildable_to = false,
	sunlight_propagates = true,
	on_timer = function(pos)
		local objs = minetest.get_objects_inside_radius(pos, 0.9)
		for _, obj in pairs(objs) do --just a precaution in case some other entity ends up wandering through hallways,
			if obj:get_player_name() ~= "" then -- that makes sure only players trigger room changes.
				pos.y=pos.y+100
				place_room("outside_ruined.mts",pos)
				player:set_pos({x=pos.x+26,y=pos.y+6,z=pos.z+38})
			end
		end
		return true
end
})
----------------
--collectables--
----------------
local collectable_list = {"piranesi:axeblock","piranesi:shovelblock","piranesi:bottle_red_block","piranesi:bottle_green_block","piranesi:bottle_yellow_block","piranesi:bottle_blue_block","piranesi:crownblock","piranesi:crownblock1","piranesi:crownblock2",
"piranesi:swordblock", "piranesi:plateblock", "piranesi:keyblock_gold", "piranesi:keyblock_metal", 	"piranesi:dandelion_white","piranesi:geranium","piranesi:chrysanthemum_green","piranesi:dandelion_yellow","piranesi:rose",
"piranesi:keyblock_black","piranesi:lighterblock","piranesi:empty"}
minetest.register_abm({
    label = "piranesi:collectable_removal",
    nodenames = collectable_list,
    neighbors = {},
    interval = 0.5,
    chance = 1,
    min_y = -100,
    max_y = 100,
    catch_up = false,
    action = function(pos, node, active_object_count, active_object_count_wider)
		for _, item in pairs(collectable_list) do 
			if node.name == item then
				if piranesi.storage:get_string(item) == "true" then
					--minetest.chat_send_all(piranesi.storage:get_string(item))
					minetest.set_node(pos, {name="air"})
				end
			end
		end
	end
})
minetest.register_node("piranesi:shovelblock", {
	description = "Shovel Block",
	inventory_image = "default_tool_woodshovel.png",
	drawtype = "signlike",
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	paramtype2 = "wallmounted",
	selection_box = { type = "wallmounted" },
	tiles = {"default_tool_woodshovel.png"},
	groups = {hand = 1},
	drop = "piranesi:shovel_wood",
	after_dig_node = remove_collectable
})
minetest.register_tool("piranesi:shovel_wood", {
	description = "Shovel",
	inventory_image = "default_tool_woodshovel.png",
	wield_image = "default_tool_woodshovel.png^[transformR90",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			shovel = {times={[1]=2.00}, uses=0, maxlevel=1},
		},
		damage_groups = {fleshy=2},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {shovel = 1, flammable = 2}
})
minetest.register_node("piranesi:axeblock", {
		description = "Axe Block",
		inventory_image = "default_tool_steelaxe.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"default_tool_steelaxe.png"},
		groups = {hand = 1},
		drop = "piranesi:axe_steel",
		after_dig_node = remove_collectable
})
minetest.register_tool("piranesi:axe_steel", {
	description = "Axe",
	inventory_image = "default_tool_steelaxe.png",
	tool_capabilities = {
		full_punch_interval = 1.0,
		max_drop_level=0,
		groupcaps={
			axe={times={[1]=2.00}, uses=0, maxlevel=1},
		},
		damage_groups = {fleshy=4},
	},
	sound = {breaks = "default_tool_breaks"},
	groups = {axe = 1}
})
--flowers
local flowers = {
	{
		"rose",
		"Red Rose",
	},
	{
		"dandelion_yellow",
		"Yellow Dandelion",
	},
	{
		"chrysanthemum_green",
		"Green Chrysanthemum",
	},
	{
		"geranium",
		"Blue Geranium",
	},
	{
		"dandelion_white",
		"White Dandelion",
	},
}
local add_flower = function(name, desc)
	minetest.override_item("flowers:" .. name,{groups = {hand =1}})
	minetest.register_node("piranesi:" .. name, {
		description = desc,
		drawtype = "plantlike",
		waving = 1,
		tiles = {"flowers_" .. name .. ".png"},
		inventory_image = "flowers_" .. name .. ".png",
		wield_image = "flowers_" .. name .. ".png",
		sunlight_propagates = true,
		paramtype = "light",
		walkable = false,
		buildable_to = true,
		groups = {hand = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-2 / 16, -0.5, -2 / 16, 2 / 16, 3 / 16, 2 / 16},
		},
		drop = "flowers:" .. name,
		after_dig_node = remove_collectable
	})
end
for _,item in pairs(flowers) do
	add_flower(unpack(item))
end

-----------
--potions--
-----------
minetest.register_node("piranesi:bottle_red_block", {
	description = "Red Potion b",
	drawtype = "plantlike",
	tiles = {"bottle_red.png"},
	inventory_image = "bottle_red.png",
	wield_image = "bottle_red.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	sounds = default.node_sound_glass_defaults(),
	drop = "piranesi:bottle_red",
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:bottle_green_block", {
	description = "Green Potion b",
	drawtype = "plantlike",
	tiles = {"bottle_green.png"},
	inventory_image = "bottle_green.png",
	wield_image = "bottle_green.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	sounds = default.node_sound_glass_defaults(),
	drop = "piranesi:bottle_green",
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:bottle_yellow_block", {
	description = "Yellow Potion",
	drawtype = "plantlike",
	tiles = {"bottle_yellow.png"},
	inventory_image = "bottle_yellow.png",
	wield_image = "bottle_yellow.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	sounds = default.node_sound_glass_defaults(),
	drop = "piranesi:bottle_yellow",
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:bottle_blue_block", {
	description = "Blue Potion b",
	drawtype = "plantlike",
	tiles = {"bottle_blue.png"},
	inventory_image = "bottle_blue.png",
	wield_image = "bottle_blue.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	sounds = default.node_sound_glass_defaults(),
	drop = "piranesi:bottle_blue",
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:bottle_block", {
	description = "Potion Bottle b",
	drawtype = "plantlike",
	tiles = {"bottle.png"},
	inventory_image = "bottle.png",
	wield_image = "bottle.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	sounds = default.node_sound_glass_defaults(),
	drop = "piranesi:bottle"
})
minetest.register_craftitem("piranesi:bottle_red", {
	description = "Red Potion",
	inventory_image = "bottle_red.png",
	wield_image = "bottle_red.png",
})
minetest.register_craftitem("piranesi:bottle_green", {
	description = "Green Potion",
	inventory_image = "bottle_green.png",
	wield_image = "bottle_green.png",
})
minetest.register_craftitem("piranesi:bottle_yellow", {
	description = "Yellow Potion",
	inventory_image = "bottle_yellow.png",
	wield_image = "bottle_yellow.png",
})
minetest.register_craftitem("piranesi:bottle_blue", {
	description = "Blue Potion",
	inventory_image = "bottle_blue.png",
	wield_image = "bottle_blue.png",
})
minetest.register_craftitem("piranesi:bottle", {
	description = "Potion Bottle",
	inventory_image = "bottle.png",
	wield_image = "bottle.png",
})
minetest.register_craftitem("piranesi:bottle_purple", {
	description = "Purple Potion",
	inventory_image = "bottle_purple.png",
})
minetest.register_craftitem("piranesi:bottle_black", {
	description = "Black Potion",
	inventory_image = "bottle_purple.png",
})
--textures taken from xdecor
minetest.register_node("piranesi:cauldron", {
	description = "too lazzzyyyyyyyyy",
	tiles = {
		{
			name = "xdecor_cauldron_top_anim_boiling_water.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_sides.png"
	},
	groups = {cracky = 1},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		local data = minetest.get_meta(pos):get_string("data")
		particle(pos)
		if itemstack:get_name() == "piranesi:bottle_blue" then 
			data = data.."b"
		elseif itemstack:get_name() == "piranesi:bottle_yellow" then 
			data = data.."y"
		elseif itemstack:get_name() == "piranesi:bottle_green" then 
			data = data.."g"
		elseif itemstack:get_name() == "piranesi:bottle_red" then 
			data = data.."r"
		end
		if data == "brygbyr" then
			minetest.set_node(pos, {name = "piranesi:cauldron_black"})
		end
		if data == "yrbg" then
			minetest.set_node(pos, {name = "piranesi:cauldron_purple"})
		end
		minetest.get_meta(pos):set_string("data", data)
	end
})
minetest.register_node("piranesi:cauldron_purple", {
	description = "p c",
	tiles = {
		{
			name = "purple_boils.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_sides.png"
	},
	groups = {cracky = 1},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:bottle" then
			itemstack:take_item()
			puncher:get_inventory():add_item("main", "piranesi:bottle_purple")
			return itemstack
		end
	end
})
minetest.register_node("piranesi:cauldron_black", {
	description = "b c",
	tiles = {
		{
			name = "black_boils.png",
			animation = {type = "vertical_frames", length = 3.0}
		},
		"xdecor_cauldron_sides.png"
	},
	groups = {cracky = 1},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:bottle" then
			itemstack:take_item()
			puncher:get_inventory():add_item("main", "piranesi:bottle_black")
			return itemstack
		end
	end
})
--stone bowls 
minetest.register_node("piranesi:bowl_purple_pre", {
	description = "Stone Bowl",
	tiles = {"bowl_top.png", "bowl_top.png", "bowl_side_purple.png", "bowl_side_purple.png", "bowl_side_purple.png", "bowl_side_purple.png"},
	groups = {crumbly=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:bottle_purple" then
			itemstack:take_item()
			puncher:get_inventory():add_item("main", "piranesi:bottle")
			minetest.set_node(pos, {name = "piranesi:bowl_purple"})
		end
	end
})
minetest.register_node("piranesi:bowl_black_pre", {
	description = "Stone Bowl",
	tiles = {"bowl_top.png", "bowl_top.png", "bowl_side_black.png", "bowl_side_black.png", "bowl_side_black.png", "bowl_side_black.png"},
	groups = {crumbly=1},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:bottle_black" then
			itemstack:take_item()
			puncher:get_inventory():add_item("main", "piranesi:bottle")
			minetest.set_node(pos, {name = "piranesi:bowl_black"})
		end
	end
})
minetest.register_node("piranesi:bowl_purple", {
	description = "Stone Bowl",
	tiles = {"bowl_purple.png", "bowl_purple.png", "bowl_side_purple.png", "bowl_side_purple.png", "bowl_side_purple.png", "bowl_side_purple.png"},
	groups = {crumbly=1},
	on_construct = function(pos)
		minetest.after(1, function(pos)
			pos.y=pos.y+2
			minetest.set_node(pos, {name = "piranesi:crownblock1"})
		end, pos)
	end
})
minetest.register_node("piranesi:bowl_black", {
	description = "Stone Bowl",
	tiles = {"bowl_black.png", "bowl_black.png", "bowl_side_black.png", "bowl_side_black.png", "bowl_side_black.png", "bowl_side_black.png"},
	groups = {crumbly=1},
	on_construct = function(pos)
		player:get_inventory():add_item("main", "piranesi:coin_totem")
		particle(player:get_pos())
	end
})
----------
--crowns--
----------
minetest.register_node("piranesi:crown", {
	description = "Crown",
	tiles = {"empty.png", "empty.png", "crown_side.png", "crown_side.png", "crown_side.png", "crown_side.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	sunlight_propagates = true,
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -0.5, -7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, -7/16, 7/16, -3/16, -7/16},
			{-7/16, -0.5, 7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, 7/16, 7/16, -3/16, -7/16},
		},
	},
	on_construct = function(pos)
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "piranesi:throne_base" then
			piranesi.storage:set_int("crowns",piranesi.storage:get_int("crowns")+1)
			if piranesi.storage:get_int("crowns") == 3 then
				--the king--
				player:get_inventory():add_item("main", "piranesi:chess_totem")
				particle(player:get_pos())
			end	
		end
	end,
    after_destruct = function(pos, oldnode)
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "piranesi:throne_base" then
			piranesi.storage:set_int("crowns",piranesi.storage:get_int("crowns")-1)
		end
	end
})
minetest.register_node("piranesi:crownblock", {
	description = "Crown Block",
	tiles = {"empty.png", "empty.png", "crown_side.png", "crown_side.png", "crown_side.png", "crown_side.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -0.5, -7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, -7/16, 7/16, -3/16, -7/16},
			{-7/16, -0.5, 7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, 7/16, 7/16, -3/16, -7/16},
		},
	},
	drop = "piranesi:crown",
	sunlight_propagates = true,
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:crownblock1", {
	description = "Crown Block 1",
	tiles = {"empty.png", "empty.png", "crown_side.png", "crown_side.png", "crown_side.png", "crown_side.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -0.5, -7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, -7/16, 7/16, -3/16, -7/16},
			{-7/16, -0.5, 7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, 7/16, 7/16, -3/16, -7/16},
		},
	},
	drop = "piranesi:crown",
	sunlight_propagates = true,
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:crownblock2", {
	description = "Crown Block 2",
	tiles = {"empty.png", "empty.png", "crown_side.png", "crown_side.png", "crown_side.png", "crown_side.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-7/16, -0.5, -7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, -7/16, 7/16, -3/16, -7/16},
			{-7/16, -0.5, 7/16, -7/16, -3/16, 7/16},
			{-7/16, -0.5, 7/16, 7/16, -3/16, -7/16},
		},
	},
	drop = "piranesi:crown",
	sunlight_propagates = true,
	after_dig_node = remove_collectable
})
minetest.register_node("piranesi:throne_base", {
	description = "Throne",
	tiles = {"default_gold_block.png"},
	groups = {crumbly=1},
	on_construct = function(pos)
	end
})
-----------
--candles--
-----------
minetest.register_node("piranesi:lighterblock", {
		description = "FIRE",
		inventory_image = "lighter_closed.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"lighter_closed.png"},
		groups = {hand = 1},
		drop = "piranesi:lighter",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:lighter", {
		description = "Lighter",
		inventory_image = "lighter_open.png",
})
minetest.register_node("piranesi:candle", {
		description = "Candle Lit",
		inventory_image = "candle.png",
		weild_image = "candle.png",
		paramtype = "light",
		light_source = 10,
		sunlight_propagates = true,
		drawtype = "plantlike",
		tiles = {{
		    name = "candle.png",
		    animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 1}
		}},
		groups = {oddly_breakable_by_hand=3},
})
id = 0
while id < 8 do
	id = id+1
	minetest.register_node("piranesi:candle_unlit"..id, {
			description = "Candle"..id,
			inventory_image = "candle.png",
			weild_image = "candle.png",
			sunlight_propagates = true,
			drawtype = "plantlike",
			walkable = false,
			tiles = {"candle_unlit.png"},
			groups = {oddly_breakable_by_hand=3},
			on_punch = function(pos, node, puncher, pointed_thing)
				local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
				if itemstack:get_name() == "piranesi:lighter" then
					local number = minetest.get_node(pos).name:sub(22) --yeah, there are better ways to do this.
					piranesi.storage:set_string("candles",piranesi.storage:get_string("candles"):sub(2,8)..number)
					--minetest.chat_send_all(piranesi.storage:get_string("candles")..number)
					if piranesi.storage:get_string("candles") == "12345678" then
						--amulet--
						player:get_inventory():add_item("main", "piranesi:neck_totem")
						particle(player:get_pos())
					end
					minetest.set_node(pos, {name = "piranesi:candle"})
					minetest.after(1, function(pos)
						minetest.set_node(pos, {name = "piranesi:candle_unlit"..number})
					end, pos)
				end
			end
	})
end
----------
--totems--
----------
minetest.register_node("piranesi:chess_totem", {
	description = "Chess Piece",
	drawtype = "plantlike",
	tiles = {"chess_totem_2.png","empty.png"},
	inventory_image = "chess_totem.png",
	wield_image = "chess_totem.png",
	paramtype = "light",
	walkable = false,
	selection_box = {
		type = "fixed",
		fixed = {-0.25, -0.5, -0.25, 0.25, 0.3, 0.25}
	},
	groups = {hand = 1},
	on_construct = function(pos)
		pos.y = pos.y-1
		if minetest.get_node(pos).name == "piranesi:altar" then
			pos.y = pos.y+1
			pos.z=pos.z+1
			if minetest.get_node(pos).name == "piranesi:coin_totem" then
				pos.x=pos.x+1
				if minetest.get_node(pos).name == "piranesi:time_totem" then
					pos.z=pos.z-1
					if minetest.get_node(pos).name == "piranesi:neck_totem" then
						pos.x=pos.x-1
						pos.x=pos.x-9
						pos.y=pos.y-5
						pos.z=pos.z-9
						place_room("final_room_2.mts", pos)
					end
				end
			end
		end
	end,
})
minetest.register_node("piranesi:neck_totem", {
	description = "Amulet",
	drawtype = "signlike",
	paramtype2 = "wallmounted",
	tiles = {"neck_totem.png"},
	inventory_image = "neck_totem.png",
	wield_image = "neck_totem.png",
	paramtype = "light",
	walkable = false,
	selection_box = { type = "wallmounted" },
	groups = {hand = 1},
})
minetest.register_node("piranesi:time_totem", {
	description = "Watch",
	drawtype = "signlike",
	paramtype2 = "wallmounted",
	tiles = {"time_totem.png"},
	inventory_image = "time_totem.png",
	wield_image = "time_totem.png",
	paramtype = "light",
	walkable = false,
	selection_box = { type = "wallmounted" },
	groups = {hand = 1},
})
minetest.register_node("piranesi:coin_totem", {
	description = "Coin",
	drawtype = "signlike",
	paramtype2 = "wallmounted",
	tiles = {"coin_totem.png"},
	inventory_image = "coin_totem.png",
	wield_image = "coin_totem.png",
	paramtype = "light",
	walkable = false,
	selection_box = { type = "wallmounted" },
	groups = {hand = 1},
})

---------
--doors--
---------
minetest.register_node("piranesi:door_gold", {
	description = "Locked Door Gold",
	tiles = {"doors_door_castle2.png"},
	drawtype = "mesh",
	mesh = "door_a.obj",
	paramtype2 = "facedir",
	inventory_image = "doors_item_castle2.png",
	sunlight_propagates = true,
	selection_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
	collision_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
	groups = {cracky = 2},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:key_gold" then
			itemstack:take_item()
			minetest.set_node(pos, {name = "air"})
		end
	end
})
minetest.register_node("piranesi:keyblock_gold", {
		description = "gold keyblock",
		inventory_image = "key_gold.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"key_gold.png"},
		groups = {hand = 1},
		drop = "piranesi:key_gold",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:key_gold", {
		description = "Gold Key",
		inventory_image = "key_gold.png",
})
minetest.register_node("piranesi:door_black", {
	description = "Locked Door Black",
	tiles = {"doors_door_castle2.png"},
	drawtype = "mesh",
	mesh = "door_a.obj",
	paramtype2 = "facedir",
	inventory_image = "doors_item_castle2.png",
	sunlight_propagates = true,
	selection_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
	collision_box = {type = "fixed", fixed = {-1/2,-1/2,-1/2,1/2,3/2,-6/16}},
	groups = {cracky = 2},
	on_punch = function(pos, node, puncher, pointed_thing)
		local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
		if itemstack:get_name() == "piranesi:key_black" then
			itemstack:take_item()
			minetest.set_node(pos, {name = "air"})
		end
	end
	
})
minetest.register_node("piranesi:keyblock_black", {
		description = "gasdakeyblock",
		inventory_image = "key_black.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"key_black.png"},
		groups = {hand = 1},
		drop = "piranesi:key_black",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:key_black", {
		description = "Black Key",
		inventory_image = "key_black.png",
})
---------
--clock--
---------
local increase_time = function()
	local time = piranesi.storage:get_int("time")
	if time == 8 then
		return 1
	else 
		return time+1
	end
end

local read_time = function()
	local times = {"1200","600","300","330","600","630","900","930"}
	local index = piranesi.storage:get_int("time")
	return times[index]
end
	
minetest.register_node("piranesi:clock_button_input", {
		description = "clock_button_input",
		tiles = {"clock_button_input.png","clock_button_input.png","clock_button_side.png","clock_button_side.png","clock_button_side.png","clock_button_side.png"},
		groups = {cracky = 1},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 7/16, 0.5},
				{-4/16, 7/16, -4/16, 4/16, 0.5, 4/16},
			},
		},
		on_punch = function(pos, node, puncher, pointed_thing)
			piranesi.storage:set_string("clockcode",piranesi.storage:get_string("clockcode"):sub(2,5)..piranesi.storage:get_int("time"))
			--minetest.chat_send_all(piranesi.storage:get_string("clockcode"))
			if piranesi.storage:get_string("clockcode") == "11111" then
				--watch--
				player:get_inventory():add_item("main", "piranesi:time_totem")
				particle(player:get_pos())
			end
			minetest.set_node(pos,{name = "piranesi:clock_button_input_active"})
			minetest.after(0.5, function(pos)
				minetest.set_node(pos,{name = "piranesi:clock_button_input"})
			end, pos)
		end
})
minetest.register_node("piranesi:clock_button_input_active", {
		description = "clock_button_input",
		tiles = {"clock_button_input.png","clock_button_input.png","clock_button_side.png","clock_button_side.png","clock_button_side.png","clock_button_side.png"},
		groups = {cracky = 1},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 7/16, 0.5},
			},
		},
})
minetest.register_node("piranesi:clock_button_change", {
		description = "clock_button_change",
		tiles = {"clock_button_change.png","clock_button_change.png","clock_button_side.png","clock_button_side.png","clock_button_side.png","clock_button_side.png"},
		groups = {cracky = 1},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 7/16, 0.5},
				{-4/16, 7/16, -4/16, 4/16, 0.5, 4/16},
			},
		},
		on_punch = function(pos, node, puncher, pointed_thing)
			pos.x=pos.x+3
			pos.z=pos.z+3
			piranesi.storage:set_int("time",increase_time())
			minetest.place_schematic(pos, path .. "/schems/" .. read_time() .. ".mts")
			pos.x=pos.x-3
			pos.z=pos.z-3
			minetest.set_node(pos,{name = "piranesi:clock_button_change_active"})
			minetest.after(0.5, function(pos)
				minetest.set_node(pos,{name = "piranesi:clock_button_change"})
			end, pos)
		end
})
minetest.register_node("piranesi:clock_button_change_active", {
		description = "clock_button_change",
		tiles = {"clock_button_change.png","clock_button_change.png","clock_button_side.png","clock_button_side.png","clock_button_side.png","clock_button_side.png"},
		groups = {cracky = 1},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 7/16, 0.5},
			},
		},
})
minetest.register_node("piranesi:clock1200", {
		description = "clock",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"1200.png"},
		groups = {cracky = 1},
})
minetest.register_node("piranesi:clock330", {
		description = "clock",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"330.png"},
		groups = {cracky = 1},
})
minetest.register_node("piranesi:clock600", {
		description = "clock",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"600.png"},
		groups = {cracky = 1},
})
minetest.register_node("piranesi:clock900", {
		description = "clock",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"900.png"},
		groups = {cracky = 1},
})
minetest.register_node("piranesi:clock930", {
		description = "clock",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"930.png"},
		groups = {cracky = 1},
})
-------------------
--start the game!--
-------------------
minetest.register_on_newplayer(function(player)
	minetest.after(0.5, function(player) --to prevent lighting errors
		minetest.set_timeofday(0.5)
		local pos = {x=-8,y=-4,z=-10}
		minetest.place_schematic(pos, path .. "/schems/outside.mts")
		player:set_pos({x=0,y=0,z=0})
		player:set_physics_override({speed = 1.6})
		player:set_wielded_item("piranesi:compassnorth")
		pos.x = pos.x+10
		pos.z=pos.z+40
		place_room("hall_z_plus.mts", pos)
	end, player)
	piranesi.storage:set_string("moves","ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ee".."ss")
end)
minetest.register_on_joinplayer(function(player)
	player:set_physics_override({speed = 1.6})
	player:hud_set_hotbar_itemcount(20)
	player:set_inventory_formspec("size(5,5)")
	player:hud_set_hotbar_image("hotbar.png")
end)