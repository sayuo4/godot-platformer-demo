class_name PlayerIdleState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.running_acc, player.running_dec)
	player.try_jump()
	player.update_flip_h()
	
	player.move_and_slide()
	
	if not player.is_on_floor():
		switch_to_state(state_machine.states.get("PlayerAirEntryState"))
	elif player.velocity.x:
		switch_to_state(state_machine.states.get("PlayerRunState"))
