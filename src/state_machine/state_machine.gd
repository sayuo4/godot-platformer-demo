class_name StateMachine
extends Node

## Emitted when the active state is changed.
signal state_transitioned(previous_state: State, new_state: State)

## Node managed by the state machine.
@export var target_node: Node

## States used by the state machine.[br][br]
## [b]Note:[/b] The value of this variable will be set based on the state machine child nodes.
var states: Dictionary[StringName, State]

## Currently active state.[br][br]
## [b]Note:[/b] The value of this variable should be a child of the state machine.
var active_state: State: set = set_active_state
## State to be activated by default.[br][br]
## [b]Note:[/b] The value of this variable will be set into [member active_state] when the current scene is ready.
@export var default_state: State

func _ready() -> void:
	if not target_node:
		push_error("Target node in state manager: '" + str(get_path()) + "' is null")
	
	for node: Node in get_children():
		var state := node as State
		
		if state:
			states[state.name] = state
	
	states.make_read_only()
	
	await get_tree().current_scene.ready
	
	active_state = default_state

func _process(delta: float) -> void:
	if active_state:
		active_state._update(delta)

func _physics_process(delta: float) -> void:
	if active_state:
		active_state._physics_update(delta)

## Transitions between states in the state machine.
## Calls [method State._exit] and [method State._enter] between states.
## Validates the new state, and emits a transition signal.
func set_active_state(new_state: State) -> void:
	var previous_state := active_state
	
	if new_state == previous_state:
		return
	
	if new_state:
		if not new_state in states.values():
			active_state = null
			push_error(
					"Trying to activate an unknown state: '" + str(new_state.get_path())
					+ "' in state machine: '" + str(get_path()) + "'"
			)
			return
		
		active_state = new_state
		
		if previous_state:
			previous_state._exit(new_state)
		
		new_state._enter(previous_state)
	else:
		active_state = null
	
	state_transitioned.emit(previous_state, new_state)
