class_name PlayerWallJumpState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.wall_jump_acc, player.wall_jump_dec())
	player.try_wall_jump()
	player.update_flip_h()
	
	player.move_and_slide()
	
	# TODO: Switch to air entry state after reaching jump's peak.
	if player.get_slide_collision_count() > 0:
		switch_to_state(state_machine.states.get("PlayerAirEntryState"))
