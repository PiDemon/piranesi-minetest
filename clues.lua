---------
--clues--
---------
minetest.register_node("piranesi:clue_1", {
		description = "clue 1",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"normal_clue_inv.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "paper_background.png^(starting_clue.png^[makealpha:255,255,255)"
			minetest.show_formspec(player:get_player_name(), "clue", "size[9,11]".."image_button[0,0;9,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:clue_2", {
		description = "clue 2",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"normal_clue_inv.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "paper_background.png^(machine_clue.png^[makealpha:255,255,255)"
			minetest.show_formspec(player:get_player_name(), "clue", "size[9,11]".."image_button[0,0;9,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:clue_3", {
		description = "clue 3",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"normal_clue_inv.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "paper_background.png^(clock_clue.png^[makealpha:255,255,255)"
			minetest.show_formspec(player:get_player_name(), "clue", "size[9,11]".."image_button[0,0;9,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:clue_4", {
		description = "clue 4",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"normal_clue_inv.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "paper_background.png^(forge_clue.png^[makealpha:255,255,255)"
			minetest.show_formspec(player:get_player_name(), "clue", "size[9,11]".."image_button[0,0;9,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:clue_manu", {
		description = "clue manu",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"manu_clue_inv.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "manuscript_clue.png^[makealpha:255,255,255"
			minetest.show_formspec(player:get_player_name(), "clue", "size[9,11]".."image_button[0,0;9,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:star_chart", {
		description = "star chart",
		drawtype = "signlike",
		paramtype = "light",
		walkable = false,
		sunlight_propagates = true,
		paramtype2 = "wallmounted",
		selection_box = { type = "wallmounted" },
		tiles = {"star_chart_small.png"},
		groups = {cracky = 1},
		on_punch = function(pos, node, player, pointed_thing)
			local image = "star_chart.png"
			minetest.show_formspec(player:get_player_name(), "clue", "size[22,11]".."image_button[0,0;22,11;"..image..";clue;;false;false;]")
		end
})
minetest.register_node("piranesi:book", {
	description = "nook",
	tiles = {"red_book_cover.png", "red_book_cover.png", "red_book_side_2.png", "red_book_side_1.png", "red_book_side_3.png^[transformFX", "red_book_side_3.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -6/16, 4/16, -4/16, 6/16},
		},
	},
	on_punch = function(pos, node, player, pointed_thing)
		local image1 = "book_background.png^(study_clue_1.png^[makealpha:255,255,255)"
		local image2 = "book_background.png^(study_clue_2.png^[makealpha:255,255,255)"
		minetest.show_formspec(player:get_player_name(), "clue", "size[18,11]".."image_button[0,0;9,11;"..image1..";clue;;false;false;]".."image_button[9,0;9,11;"..image2..";clue;;false;false;]")
	end
})
minetest.register_node("piranesi:book1", {
	description = "nook1",
	tiles = {"red_book_cover.png", "red_book_cover.png", "red_book_side_2.png", "red_book_side_1.png", "red_book_side_3.png^[transformFX", "red_book_side_3.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -6/16, 4/16, -4/16, 6/16},
		},
	},
	on_punch = function(pos, node, player, pointed_thing)
		local image1 = "book_background.png^(folklore_clue_1.png^[makealpha:255,255,255)"
		local image2 = "book_background.png^(folklore_clue_2.png^[makealpha:255,255,255)"
		minetest.show_formspec(player:get_player_name(), "clue", "size[18,11]".."image_button[0,0;9,11;"..image1..";clue;;false;false;]".."image_button[9,0;9,11;"..image2..";clue;;false;false;]")
	end
})
minetest.register_node("piranesi:book2", {
	description = "nook2",
	tiles = {"red_book_cover.png", "red_book_cover.png", "red_book_side_2.png", "red_book_side_1.png", "red_book_side_3.png^[transformFX", "red_book_side_3.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -6/16, 4/16, -4/16, 6/16},
		},
	},
	on_punch = function(pos, node, player, pointed_thing)
		local image1 = "book_background.png^(pot_clue.png^[makealpha:255,255,255)"
		local image2 = "empty.png"
		minetest.show_formspec(player:get_player_name(), "clue", "size[18,11]".."image_button[0,0;9,11;"..image1..";clue;;false;false;]".."image_button[9,0;9,11;"..image2..";clue;;false;false;]")
	end
})
minetest.register_node("piranesi:book3", {
	description = "nook3",
	tiles = {"red_book_cover.png", "red_book_cover.png", "red_book_side_2.png", "red_book_side_1.png", "red_book_side_3.png^[transformFX", "red_book_side_3.png"},
	groups = {crumbly=1, hand=1},
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-4/16, -0.5, -6/16, 4/16, -4/16, 6/16},
		},
	},
	on_punch = function(pos, node, player, pointed_thing)
		local image1 = "book_background.png^(final_clue.png^[makealpha:255,255,255)"
		local image2 = "empty.png"
		minetest.show_formspec(player:get_player_name(), "clue", "size[18,11]".."image_button[0,0;9,11;"..image1..";clue;;false;false;]".."image_button[9,0;9,11;"..image2..";clue;;false;false;]")
	end
})