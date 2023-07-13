extends Camera2D

var camera_speed = 38
@export var zoom_speed = 0.06
@export var max_zoom = 3
@export var min_zoom = 0.4
@export var delta_max_show_distance: Vector2

func _ready():
	zoom = Vector2.ONE * 2
	pass

func get_zoom_motion(_axis) -> Vector2:
	var _zoom_motion = (1+ (_axis * zoom_speed)) * zoom.x
	var _r = clamp(_zoom_motion, min_zoom, max_zoom)
	return Vector2(_r, _r)

func _input(_event):
	if _event is InputEventMouseButton:
		var axis = Input.get_axis("zoom_minus", "zoom_plus")
		zoom = get_zoom_motion(axis)

func _physics_process(delta):
	var vec = get_viewport().get_mouse_position() - get_parent().position
	if vec.length() >= 600:
		vec = vec.normalized() * delta * camera_speed
		position += vec
		position.x = clamp(position.x, 0, get_viewport_rect().size.x)
		position.y = clamp(position.y, 0, get_viewport_rect().size.y)
