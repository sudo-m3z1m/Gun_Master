extends Camera2D

var shake_strength: float = 0

func _process(delta):
	shake()

func shake() -> void:
	offset = Vector2(randf_range(-shake_strength, shake_strength)\
	, randf_range(-shake_strength, shake_strength))

func make_shake(shake_time: float, strength: float) -> void:
	shake_strength = strength
	$ScreenShakeTimer.timeout.connect(shake_reset)
	$ScreenShakeTimer.start(shake_time)

func shake_reset() -> void:
	shake_strength = 0
	$ScreenShakeTimer.timeout.disconnect(shake_reset)
