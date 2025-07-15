class_name PlayerGroundEntryState
extends PlayerState

func _enter(_previous_state: State) -> void:
	if player.velocity.x != 0:
		switch_to_state(state_machine.states.get("PlayerRunState"))
		return
	
	switch_to_state(state_machine.states.get("PlayerIdleState"))
