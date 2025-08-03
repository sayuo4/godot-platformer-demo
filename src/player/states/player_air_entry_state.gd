class_name PlayerAirEntryState
extends PlayerState

func _enter(_previous_state: State) -> void:
	player.try_start_jump_coyote_timer()
	
	if player.velocity.y >= 0:
		switch_to_state(state_machine.states.get("PlayerFallState"))
		return
	
	switch_to_state(state_machine.states.get("PlayerJumpState"))
