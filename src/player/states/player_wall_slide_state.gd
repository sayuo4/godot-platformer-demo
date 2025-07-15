class_name PlayerWallSlideState
extends PlayerState

func _physics_update(_delta: float) -> void:
	player.apply_wall_slide()
	player.try_wall_jump()
	
	player.move_and_slide()
	
	var input_dir := signf(player.horizontal_input())
	
	if not player.is_on_wall() or input_dir != player.wall_dir():
		switch_to_state(state_machine.states.get("PlayerAirEntryState"))
	if player.is_on_floor():
		switch_to_state(state_machine.states.get("PlayerGroundEntryState"))
