class_name State
extends Node

var state_machine: StateMachine

func _ready() -> void:
	await get_parent().ready
	
	if get_parent() is not StateMachine:
		push_error("The parent node of state: '" + str(get_path()) + "' is not a state machine")
		return
	
	state_machine = get_parent()

## Checks if this is the currently active state.
func is_active() -> bool:
	return state_machine.active_state == self

## Switches to the given state if it's called on the active state.
func switch_to_state(new_state: State) -> void:
	if is_active():
		state_machine.active_state = new_state

## Called when the state becomes active.
func _enter(_previous_state: State) -> void:
	pass

## Called when the state becomes inactive.
func _exit(_new_state: State) -> void:
	pass

## Called every process frame while the state is active.
func _update(_delta: float) -> void:
	pass

## Called every physics frame while the state is active.
func _physics_update(_delta: float) -> void:
	pass
