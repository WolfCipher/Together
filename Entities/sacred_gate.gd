extends Area2D

@export var to_fade_out : Node2D
@export var to_fade_in : Node2D
var next_is_in = true # can switch between what is faded out / in

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(to_fade_out)
	print(to_fade_in)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func change_world():
	print("change world")
	if next_is_in:
		SceneCache.create_fog.emit(to_fade_in, to_fade_out)
	else:
		SceneCache.create_fog.emit(to_fade_out, to_fade_in)
		
	next_is_in = !next_is_in

func _on_area_entered(area: Area2D) -> void:
	# activate on Mystical magic
	print("Touchie", area)
	
	if area.is_in_group("ElvyriaMelee"):
		change_world()
