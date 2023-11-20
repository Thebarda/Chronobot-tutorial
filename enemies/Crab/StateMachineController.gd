extends Node

@export var node_finite_state_machine: NodeFiniteStateMachine

func _on_timer_timeout():
	node_finite_state_machine.transition_to("walk")
	

func _on_timer_idle_timeout():
	node_finite_state_machine.transition_to("idle")
