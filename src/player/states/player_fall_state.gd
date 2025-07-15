class_name PlayerFallState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.falling_acc, player.falling_dec)
	
	player.move_and_slide()
	
	if player.velocity.y < 0:
		switch_to_state(state_machine.states.get("PlayerJumpState"))
	elif player.is_on_floor():
		switch_to_state(state_machine.states.get("PlayerGroundEntryState"))
