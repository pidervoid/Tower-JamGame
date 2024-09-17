extends Node2D

var held_object = null
var held_object_position = Vector2(0, 0)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(!held_object):
		return
	held_object.apply_force(
		60 * get_global_mouse_position() - (held_object.global_position + held_object_position), 
		held_object_position
	)	
	



@onready var shape = load("res://shape.tscn")
func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		pass
	elif event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var newSquare = shape.instantiate()
		newSquare.position = get_global_mouse_position()
		newSquare.clicked.connect(_on_pickable_clicked)
		add_child(newSquare)




func _on_pickable_clicked(object: RigidBody2D):
	held_object_position = get_global_mouse_position() - object.global_position
	held_object = object