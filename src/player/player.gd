class_name Player
extends CharacterBody2D

## Whether the player is flipped horizontally.
@export var flip_h := false: set = set_flip_h

@export_group("Movement")
## Maximum horizontal movement speed.
@export var maximum_speed: float

@export_subgroup("On Floor")
## Moving acceleration while the player is running.
@export var running_acc: float
## Moving deceleration while the player is running.
@export var running_dec: float

@export_subgroup("In Air")
## Moving acceleration while the player is jumping/going up.
@export var jumping_acc: float
## Moving deceleration while the player is jumping/going up.
@export var jumping_dec: float
## Moving acceleration while the player is falling.
@export var falling_acc: float
## Moving deceleration while the player is falling.
@export var falling_dec: float

@export_group("Vertical Movement")
@export_subgroup("Gravity")
## Multiplier applied to gravity force while jump action is not pressed.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [method default_gravity_force].
@export_range(1, 2) var jump_not_pressed_gravity_multiplier: float
## Multiplier applied to gravity force while down action is pressed and the player is falling.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [method default_gravity_force].
@export_range(2, 3) var down_pressed_gravity_multiplier: float
## Maximum value the gravity can reach.
@export var default_gravity_limit: float
## Multiplier applied to maximum gravity force while down action is pressed and the player is falling.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member default_gravity_limit].
@export_range(1, 2) var down_pressed_gravity_limit_multiplier: float

@export_subgroup("Jump")
## Normal jump height.
@export var jump_height: float
## Time to reach jump peak.
@export_range(0, 1) var jump_time_to_peak: float
## Time to fall after reaching jump peak.
@export_range(0, 1) var jump_time_to_land: float
## Maximum upward velocity to detect jump peak.
@export var jump_peak_velocity: float
## Multiplier applied to gravity force at jump peak.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [method default_gravity_force].
@export_range(0, 1) var at_jump_peak_gravity_multiplier: float
## Multiplier applied to horizontal velocity when reaching jump peak.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by the [member CharacterBody2D.velocity].x value.
@export_range(1, 2) var jump_peak_horizontal_boost_multiplier: float
## Calculated jump force.
@onready var jump_force: float = (2.0 * jump_height) / jump_time_to_peak
## Calculated gravity force for jumping.
@onready var jumping_gravity: float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
## Calculated gravity force for falling.
@onready var falling_gravity: float = (2.0 * jump_height) / (jump_time_to_land * jump_time_to_land)

@export_group("On Wall")
@export_subgroup("Wall Slide")
## Maximum vertical speed while wall sliding.
@export var maximum_wall_sliding_speed: float
## Multiplier applied to wall sliding speed while the player is pressing the down action.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member wall_sliding_speed].
@export_range(1, 2) var down_pressed_wall_slide_speed_multiplier: float
## Vertical acceleration while wall sliding.
@export var wall_sliding_acc: float

@export_subgroup("Wall Jump")
## Horizontal force of the wall jump.
@export var wall_jump_horizontal_force: float
## Vertical force of the wall jump.
@export var wall_jump_vertical_force: float
## Minimum distance from the wall required for the player to initiate a wall jump.[br][br]
## [b]Note:[/b] This will work only if the player is moving towards the wall.
@export var wall_jump_distance: float
## Moving acceleration while the player is wall jumping.
@export var wall_jumping_acc: float
## Moving deceleration while the player is wall jumping.
@export var wall_jumping_dec: float
## Moving deceleration while the player is wall jumping and moving in the direction of the wall.
@export var wall_jumping_toward_wall_dec: float

## Flips the player horizontally based on the given value.
func set_flip_h(value: bool) -> void:
	if is_inside_tree():
		flip_h = value
		
		if value:
			scale.y = -abs(scale.y)
			rotation_degrees = 180
			return
		
		scale.y = abs(scale.y)
		rotation_degrees = 0
	
	else:
		await tree_entered
		
		set_flip_h(value)

## Updates [member flip_h] based on [method horizontal_input].
func update_flip_h() -> void:
	var input_dir := signf(horizontal_input())
	
	if input_dir:
		flip_h = false if input_dir == 1 else true

## Player's horizontal facing direction.
func look_dir() -> float:
	return 1 if not flip_h else -1

## Horizontal input value based on left and right actions.
func horizontal_input() -> float:
	return Input.get_axis("left", "right")

## Applies horizontal movement by accelerating or decelerating the velocity towards the maximum speed.
func apply_movement(acc: float, dec: float) -> void:
	var movement_dir_h := movement_dir().x
	var speed := maximum_speed * horizontal_input()
	var apply_acc := (
			velocity.x <= speed and movement_dir_h == 1
			or velocity.x >= speed and movement_dir_h == -1
	)
	var delta := acc if apply_acc else dec
	
	velocity.x = move_toward(velocity.x, speed, delta) 

## Player's movement direction.
func movement_dir() -> Vector2:
	return velocity.sign()

## Applies gravity to the velocity and clamps it to the gravity limit.
func apply_gravity(delta: float) -> void:
	velocity.y += gravity_force() * delta
	 
	velocity.y = clampf(velocity.y, -INF, gravity_limit())

## Default values of the gravity force based on [member CharacterBody2D.velocity].y value.
func default_gravity_force() -> float:
	return falling_gravity if velocity.y >= 0.0 else jumping_gravity

## Gravity force based on the pressed key.
func gravity_force() -> float:
	return default_gravity_force() * (
			jump_not_pressed_gravity_multiplier if not Input.is_action_pressed("jump")
			else down_pressed_gravity_multiplier if Input.is_action_pressed("down") and velocity.y > 0
			else 1.0
	)

## Gravity limit based on the pressed key.
func gravity_limit() -> float:
	return default_gravity_limit * (
			down_pressed_gravity_multiplier if Input.is_action_pressed("down") and velocity.y > 0
			else 1.0
	)

## Applies a vertical upward force affecting the player's vertical speed.
## TODO: Make it calculate the applied force based on the current vertical speed.
func apply_vertical_force(force: float) -> void:
	velocity.y = -force

## Performs a jump by applying upward force.
## This function can be extended to add jump animations, sounds, particles, or other effects.
func jump() -> void:
	apply_vertical_force(jump_force)

## Triggers a jump if the jump action was just pressed.
func try_jump() -> void:
	if Input.is_action_just_pressed("jump"):
		jump()
