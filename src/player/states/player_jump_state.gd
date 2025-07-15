class_name PlayerJumpState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.jumping_acc, player.jumping_dec)
	player.update_flip_h()
	
	player.move_and_slide()
	
	if player.velocity.y >= 0:
		switch_to_state(state_machine.states.get("PlayerFallState"))
