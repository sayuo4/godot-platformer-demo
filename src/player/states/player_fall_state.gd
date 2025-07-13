class_name PlayerFallState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.falling_acc, player.falling_dec)

	player.move_and_slide()
