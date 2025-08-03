class_name PlayerFallState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.falling_acc, player.falling_dec)
	
	player.try_start_jump_buffer_timer()
	player.try_start_wall_jump_buffer_timer()
	player.try_wall_slide()
	player.try_wall_jump()
	player.try_coyote_wall_jump()
	player.try_coyote_jump()
	
	player.update_flip_h()
	
	player.move_and_slide()
	
	if player.velocity.y < 0:
		switch_to_state(state_machine.states.get("PlayerJumpState"))
	elif player.is_on_floor():
		switch_to_state(state_machine.states.get("PlayerGroundEntryState"))

func _on_player_left_wall() -> void:
	if is_active():
		player.start_wall_jump_coyote_timer()

func _on_player_touched_wall() -> void:
	if is_active():
		player.try_wall_jump_buffer()
