class_name PlayerAirEntryState
extends PlayerState

func _enter(_previous_state: State) -> void:
	if player.velocity.y >= 0:
		switch_to_state(state_machine.states.get("PlayerFallState"))
		return
	
	switch_to_state(state_machine.states.get("PlayerJumpState"))
