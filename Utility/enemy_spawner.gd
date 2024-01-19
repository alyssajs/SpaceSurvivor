extends Node2D

@export var spawns: Array[Spawn_info] = []

@onready var player = get_tree().get_first_node_in_group("player")

var time = 0



func _on_timer_timeout():
	time += 1
	var enemy_spawns = spawns 
	for type in enemy_spawns:
		if time >= type.time_start and time <= type.time_end:
			if type.spawn_delay_counter <= type.enemy_spawn_delay:
				type.spawn_delay_counter += 1
			else:
				type.spawn_delay_counter = 0
				var new_enemy = load(str(type.enemy.resource_path))
				var counter = 0
				while counter < type.enemy_num:
					var enemy_spawn = new_enemy.instantiate()
					enemy_spawn.global_position = get_random_position()
					add_child(enemy_spawn)
					counter += 1 

func get_random_position():
	#var vpr = get_viewport_rect().size * randf_range(1.1, 1.4)
	#var top_left = Vector2(player.global_position.x - vpr.x/2,
	 #player.global_position.y - vpr.y/2)
	#var top_right = Vector2(player.global_position.x + vpr.x/2,
	 #player.global_position.y - vpr.y/2)	
	#var bottom_left = Vector2(player.global_position.x - vpr.x/2,
	 #player.global_position.y + vpr.y/2)	
	#var bottom_right = Vector2(player.global_position.x + vpr.x/2,
	 #player.global_position.y + vpr.y/2)	
	#var pos_side = ["up", "down", "right", "left"].pick_random()
	#var spawn_pos1 = Vector2.ZERO
	#var spawn_pos2 = Vector2.ZERO
	#
	#match pos_side:
		#"up":
			#spawn_pos1 = top_left
			#spawn_pos2 = top_right
		#"down":
			#spawn_pos1 = bottom_left
			#spawn_pos2 = bottom_right
		#"right":
			#spawn_pos1 = top_right
			#spawn_pos2 = bottom_right
		#"left":
			#spawn_pos1 = top_left
			#spawn_pos2 = bottom_left
			#
	#var x_spawn = randf_range(spawn_pos1.x, spawn_pos2.x)
	#var y_spawn = randf_range(spawn_pos1.y, spawn_pos2.y)
	var vpr = get_viewport_rect().size
	var x_dist_sq = pow(vpr.x/2, 2)
	var y_dist_sq = pow(vpr.y/2, 2)
	var radius = pow(x_dist_sq + y_dist_sq, 0.5) * 1.1
	var random_angle = randf_range(0, 2 * PI)
	return Vector2(radius * cos(random_angle), radius * sin(random_angle))
