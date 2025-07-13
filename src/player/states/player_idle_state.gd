class_name PlayerIdleState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.running_acc, player.running_dec)
	player.try_jump()
	
	player.move_and_slide()
