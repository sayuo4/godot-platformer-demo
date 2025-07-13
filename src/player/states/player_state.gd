class_name PlayerState
extends State

var player: Player

func _ready() -> void:
	super._ready()
	await get_parent().ready
	
	if state_machine.target_node is not Player:
		push_error("Player state: '" + str(get_path()) + "' is added to a state machine that doesn't have the player as the target node")
		return
	
	player = state_machine.target_node as Player
