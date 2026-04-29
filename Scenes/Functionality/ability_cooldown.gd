extends TextureProgressBar

@export var character: Node2D

@onready var recharge: float
@onready var cooldown: float
@onready var visual_min: float
@onready var visual_max: float
@onready var on_cooldown = false


func _ready() -> void:
	if character.is_in_group("Ryl"):
		step = 3
		recharge = character.dash_recharge
		cooldown = character.dash_cooldown
		# offset for progressbar appearing
		visual_min = 20.0 
		visual_max = 80.0
		value = visual_max
	if character.is_in_group("Elvyria"):
		recharge = character.shield_recharge
		cooldown = character.shield_cooldown
		# offset for progressbar appearing
		visual_min = 4.0
		visual_max = 97.0
		value = visual_max

func _process(_delta: float) -> void:
	if character.is_in_group("Ryl"):
		cooldown = character.dash_cooldown
	if character.is_in_group("Elvyria"):
		cooldown = character.shield_cooldown
	print(cooldown)
	if cooldown > 0 and !on_cooldown:
		start_cooldown(recharge)
	
func start_cooldown(duration: float):
	on_cooldown = true
	# Start the progress at the visual minimum
	value = visual_min
	var tween = create_tween()
	# Tween only across the visible range
	tween.tween_property(self, "value", visual_max, duration)
	await get_tree().create_timer(duration).timeout
	on_cooldown = false
