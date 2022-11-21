
-----------
--machine--
-----------
--items
minetest.register_craftitem("piranesi:gear", {
		description = "Gear",
		inventory_image = "gear.png",
})
minetest.register_node("piranesi:keyblock_metal", {
		description = "dsfdavfrzc",
		inventory_image = "key_metal.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"key_metal.png"},
		groups = {hand = 1},
		drop = "piranesi:key_metal",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:key_metal", {
		description = "Metal Key",
		inventory_image = "key_metal.png",
})
minetest.register_node("piranesi:plateblock", {
		description = "dsfdavfrzc",
		inventory_image = "plate.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"plate.png"},
		groups = {hand = 1},
		drop = "piranesi:plate",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:plate", {
		description = "Metal Plate",
		inventory_image = "plate.png",
})
minetest.register_node("piranesi:swordblock", {
		description = "dsfdavfrzc",
		inventory_image = "sword.png",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"sword.png"},
		groups = {hand = 1},
		drop = "piranesi:sword",
		after_dig_node = remove_collectable
})
minetest.register_craftitem("piranesi:sword", {
		description = "Metal Sword",
		inventory_image = "sword.png",
})
--pots/molds (shamelessly taken from aether_new because I made it)
minetest.register_node("piranesi:pot", {
		description = "Obsidian Pot",
		tiles = {"default_obsidian.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -7/16, 0.5},
				{-0.5, -0.5, -0.5, 0.5, 0.5, -7/16},
				{0.5, 0.5, 0.5, -0.5, -0.5, 7/16},
				{0.5, 0.5, 0.5, 7/16, -0.5, -0.5},
				{-0.5, -0.5, -0.5, -7/16, 0.5, 0.5},
			},
		},
		groups = {cracky = 1, hand = 1},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
			if itemstack:get_name() == "piranesi:plate" or itemstack:get_name() == "piranesi:sword" or itemstack:get_name() == "piranesi:key_metal" then
				pos.y = pos.y-1
				if minetest.get_node(pos).name == "piranesi:hot_stone" then
					pos.y = pos.y+1
					minetest.set_node(pos, {name = "piranesi:pot_full"})
					itemstack = itemstack:take_item()
					return itemstack
				end
			end
		end
})
minetest.register_node("piranesi:pot_full", {
		description = "Obsidian Pot",
		tiles = {{name = "aether_obsidian.png^(aether_pot.png^[colorize:#ff4000:95)", animation = {type = "vertical_frames", aspect_w = 16, aspect_h = 16, length = 2}},"default_obsidian.png", "default_obsidian.png","default_obsidian.png","default_obsidian.png","default_obsidian.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 4/16, 0.5},
				{-0.5, -0.5, -0.5, 0.5, 0.5, -7/16},
				{0.5, 0.5, 0.5, -0.5, -0.5, 7/16},
				{0.5, 0.5, 0.5, 7/16, -0.5, -0.5},
				{-0.5, -0.5, -0.5, -7/16, 0.5, 0.5},
			},
		},
		groups = {cracky = 1, hand = 1},

})
minetest.register_node("piranesi:mold", {
		description = "Mold",
		tiles = {"mold.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -6/16, 0.5},
			},
		},
		groups = {cracky = 1},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
			if itemstack:get_name() == "piranesi:pot_full" then
				minetest.set_node(pos, {name = "piranesi:mold_full"})
				itemstack = itemstack:take_item()
				return itemstack
			end
		end
})
minetest.register_node("piranesi:mold_full", {
		description = "Mold",
		tiles = {"mold_full.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -6/16, 0.5},
			},
		},
		groups = {cracky = 1, hand = 1},
		on_construct = function(pos)
			pos.y = pos.y-1
			if minetest.get_node(pos).name == "piranesi:ice" then
				pos.y = pos.y+1
				minetest.set_node(pos, {name = "piranesi:mold_done"})
			end
		end
})
minetest.register_node("piranesi:mold_done", {
		description = "Mold",
		tiles = {"mold_done.png"},
		drawtype = "nodebox",
		node_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, -6/16, 0.5},
			},
		},
		groups = {cracky = 1, hand = 1},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
			if itemstack:get_name() == "" then
				minetest.set_node(pos, {name = "piranesi:mold"})
			end
		end
})
minetest.register_node("piranesi:hot_stone", {
	description = "Hot Stone",
	tiles = {"default_stone.png"},
	groups = {cracky = 3},
	drop = "default:cobble",
	legacy_mineral = true,
	sounds = default.node_sound_stone_defaults(),
})
minetest.register_node("piranesi:ice", {
	description = "Cold Ice",
	tiles = {"default_ice.png"},
	
	paramtype = "light",
	groups = {cracky = 3, cools_lava = 1, slippery = 3},
	sounds = default.node_sound_glass_defaults(),
})
--lights
minetest.register_node("piranesi:machine_red", {
		description = "Machine Red",
		tiles = {"machine_top.png", "machine.png", "machine_red.png", "machine.png^machine_grass.png", "machine_gear.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:machine_blue", {
		description = "Machine Blue",
		tiles = {"machine_top.png", "machine.png", "machine_blue.png", "machine.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:machine_green", {
		description = "Machine Green",
		tiles = {"machine_top.png", "machine.png", "machine_green.png", "machine.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:machine_yellow", {
		description = "Machine Yellow",
		tiles = {"machine_top.png", "machine.png", "machine_yellow.png", "machine.png^machine_grass.png", "machine.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})

minetest.register_node("piranesi:red_a", {
		description = "Machine Red animated",
		tiles = {"machine_top.png", "machine.png", {name = "red_ani.png", animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 5}}, "machine.png^machine_grass.png", "machine_gear.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:blue_a", {
		description = "Machine blue animated",
		tiles = {"machine_top.png", "machine.png", {name = "blue_ani.png", animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 5}}, "machine.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:green_a", {
		description = "Machine green animated",
		tiles = {"machine_top.png", "machine.png", {name = "green_ani.png", animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 5}}, "machine.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:yellow_a", {
		description = "Machine yellow animated",
		tiles = {"machine_top.png", "machine.png", {name = "yellow_ani.png", animation = {type = "vertical_frames", aspect_w = 32, aspect_h = 32, length = 5}}, "machine.png^machine_grass.png", "machine.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})
--levers
minetest.register_node("piranesi:machine_lever", {
		description = "Machine Lever",
		tiles = {"machine_top.png", "machine.png", "machine.png", "machine_lever.png", "machine.png", "machine_gear.png"},
		groups = {crumbly=1},
		on_punch = function(pos, node, puncher, pointed_thing)
			minetest.set_node(pos, {name = "piranesi:machine_lever_a"})
			pos.z=pos.z+1
			if minetest.get_node(pos).name == "piranesi:machine_gear_1" then
			pos.y=pos.y+1
			if minetest.get_node(pos).name == "piranesi:machine_gear_2" then
			pos.z=pos.z-1
			if minetest.get_node(pos).name == "piranesi:machine_gear_2" then
				pos.y=pos.y-1
				pos.x=pos.x+1
				minetest.set_node(pos, {name = "piranesi:green_a"})
				pos.z=pos.z+1
				minetest.set_node(pos, {name = "piranesi:blue_a"})
				pos.y=pos.y+1
				minetest.set_node(pos, {name = "piranesi:yellow_a"})
				pos.z=pos.z-1
				minetest.set_node(pos, {name = "piranesi:red_a"})
				pos.y=pos.y-1
				pos.x=pos.x-1
				pos.z=pos.z+1
				minetest.set_node(pos, {name = "piranesi:machine_gear_1_a"})
				pos.y=pos.y+1
				minetest.set_node(pos, {name = "piranesi:machine_gear_2_a"})
				pos.z=pos.z-1
				minetest.set_node(pos, {name = "piranesi:machine_gear_2_a"})
				pos.y=pos.y-1
			else pos.z=pos.z+1 pos.y=pos.y-1 end
			else pos.y=pos.y-1 pos.z=pos.z+1 end
			else pos.z=pos.z-1 end
			minetest.after(1,function(pos) minetest.set_node(pos, {name = "piranesi:machine_lever"}) end, pos)
		end,
})
minetest.register_node("piranesi:machine_lever_a", {
		description = "Machine Lever active",
		tiles = {"machine_top.png", "machine.png", "machine.png", "machine_lever_a.png", "machine.png", "machine_gear.png"},
		groups = {crumbly=1},

})
--gears
--1 
minetest.register_node("piranesi:machine_gear_1_e", {
		description = "Machine Gear Empty 1",
		tiles = {"machine_top.png", "machine.png", "machine.png", "machine_gear_big.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
			if itemstack:get_name() == "piranesi:gear" then
				minetest.set_node(pos, {name = "piranesi:machine_gear_1"})
			end
			itemstack:take_item()
			return itemstack
		end,
})
minetest.register_node("piranesi:machine_gear_1", {
		description = "Machine Gear 1",
		tiles = {"machine_top.png", "machine.png", "machine.png", "machine_gear_big.png^gear.png", "machine.png", "machine.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:machine_gear_1_a", {
		description = "Machine Gear Animated 1",
		tiles = {"machine_top.png", "machine.png", "machine.png", {name = "gear_animated.png", animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 0.5}} , "machine.png", "machine.png"},
		groups = {crumbly=1},
})
--2 (grass)
minetest.register_node("piranesi:machine_gear_2_e", {
		description = "Machine Gear Empty 2",
		tiles = {"machine_top.png", "machine.png", "machine.png^machine_grass.png", "machine_gear_big.png^machine_grass.png", "machine.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
		on_punch = function(pos, node, puncher, pointed_thing)
			local itemstack = puncher:get_inventory():get_stack("main", puncher:get_wield_index())
			if itemstack:get_name() == "piranesi:gear" then
				minetest.set_node(pos, {name = "piranesi:machine_gear_2"})
			end
			itemstack:take_item()
			return itemstack
		end,
})
minetest.register_node("piranesi:machine_gear_2", {
		description = "Machine Gear 2",
		tiles = {"machine_top.png", "machine.png", "machine.png^machine_grass.png", "machine_gear_big.png^gear.png^machine_grass.png", "machine.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})
minetest.register_node("piranesi:machine_gear_2_a", {
		description = "Machine Gear Animated 2",
		tiles = {"machine_top.png", "machine.png", "machine.png^machine_grass.png", {name = "gear_animated_grass.png", animation = {type = "vertical_frames", aspect_w = 64, aspect_h = 64, length = 1}} , "machine.png^machine_grass.png", "machine.png^machine_grass.png"},
		groups = {crumbly=1},
})