class_name Player
extends CharacterBody2D

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

@export_group("Gravity")
## Multiplier applied to gravity force while jump action is not pressed.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member jumping_gravity] and [member falling_gravity].
@export_range(1, 2) var jump_not_pressed_gravity_multiplier: float
## Multiplier applied to gravity force while down action is pressed and the player is falling.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member jumping_gravity] and [member falling_gravity].
@export_range(2, 3) var down_pressed_gravity_multiplier: float
## Maximum value the gravity can reach.
@export var default_gravity_limit: float
## Multiplier applied to maximum gravity force while down action is pressed and the player is falling.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member default_gravity_limit].
@export_range(1, 2) var down_pressed_gravity_limit_multiplier: float

@export_group("Jump")
## Normal jump height.
@export var jump_height: float
## Time to reach jump peak.
@export_range(0, 1) var jump_time_to_peak: float
## Time to fall after reaching jump peak.
@export_range(0, 1) var jump_time_to_land: float
## Maximum upward velocity to detect jump peak.
@export var jump_peak_velocity: float
## Multiplier applied to gravity force at jump peak.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member jumping_gravity] and [member falling_gravity].
@export_range(0, 1) var at_jump_peak_gravity_multiplier: float
## Multiplier applied to horizontal velocity when reaching jump peak.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by the [member velocity].x value.
@export_range(1, 2) var jump_peak_horizontal_boost_multiplier: float
## Calculated jump force.
@onready var jump_force: float = (2.0 * jump_height) / jump_time_to_peak
## Calculated gravity force for jumping.
@onready var jumping_gravity: float = (2.0 * jump_height) / (jump_time_to_peak * jump_time_to_peak)
## Calculated gravity force for falling.
@onready var falling_gravity: float = (2.0 * jump_height) / (jump_time_to_land * jump_time_to_land)

@export_group("Wall Jump")
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

@export_group("Wall Slide")
## Maximum vertical speed while wall sliding.
@export var maximum_wall_sliding_speed: float
## Multiplier applied to wall sliding speed while the player is pressing the down action.[br][br]
## [b]Note:[/b] The value of this variable will be multiplied by [member wall_sliding_speed].
@export_range(1, 2) var down_pressed_wall_slide_speed_multiplier: float
## Vertical acceleration while wall sliding.
@export var wall_sliding_acc: float
