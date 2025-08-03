class_name PlayerJumpState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.jumping_acc, player.jumping_dec)
	
	player.try_start_jump_buffer_timer()
	player.try_start_wall_jump_buffer_timer()
	player.try_wall_jump()
	player.try_coyote_wall_jump()
	
	player.update_flip_h()
	
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		switch_to_state(state_machine.states.get("PlayerFallState"))

func _on_player_left_wall() -> void:
	if is_active():
		player.start_wall_jump_coyote_timer()

func _on_player_touched_wall() -> void:
	if is_active():
		player.try_wall_jump_buffer()
