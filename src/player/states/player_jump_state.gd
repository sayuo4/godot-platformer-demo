class_name PlayerJumpState
extends PlayerState

func _physics_update(delta: float) -> void:
	player.apply_gravity(delta)
	player.apply_movement(player.jumping_acc, player.jumping_dec)

	player.move_and_slide()
