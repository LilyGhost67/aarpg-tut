class_name State_Idle extends State

var running : bool = false                      #for running

@onready var walk: State = $"../Walk"
@onready var attack: State = $"../Attack"
@onready var run: State = $"../Run"


## What happens when the player enter this State?
func Enter() -> void:
	player.update_animation("idle")
	pass


## What happens when the player exits this State?
func Exit() -> void:
	pass


## What happens during the _process update in this State?
func Process( _delta : float ) -> State:
	if player.direction != Vector2.ZERO:
		return walk
	
	
	player.velocity = Vector2.ZERO
	return null


## What happens during the _physics_process update in this State?
func Physics( _delta : float ) -> State:
	return null


## What happens with input events in this State?
func HandleInput( _event: InputEvent ) -> State:
	if _event.is_action_pressed("attack"):
		return attack
	
	if _event.is_action_pressed("run"):                    #for running
		return run
	
	
	return null


func EndRun() -> void:                 #for running
	running = false
