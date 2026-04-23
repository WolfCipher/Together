extends HBoxContainer

@export var character: Node2D
@export var heart: PackedScene
var max_health : float
var health : float
var numHearts : int

func _ready() -> void:
	max_health = character.max_health
	health = character.health
	
	# character should have max_health/4 + remainder fraction hearts
	numHearts = int(max_health / 4.0)
	# get another heart to hold the remaining fractional value
	if (max_health - (numHearts*4.0) != 0):
		numHearts = numHearts + 1
	
	for i in numHearts:
		var currHeart = heart.instantiate()
		# heart begins full
		currHeart.get_child(0).frame = 4;
		
		add_child(currHeart)
	

func _process(_delta: float) -> void:
	health = character.health
	
	# character's heart sprites should be determined by health amount
	var fullHearts = int(health / 4.0)
	var amountOver = int(health - (fullHearts*4.0))
	
	# hearts after fullHearts should be changed
	if (fullHearts != numHearts):
		if (character.is_in_group("Elvyria")):
			var fractionalHeart = get_child(fullHearts)
			fractionalHeart.get_child(0).frame = amountOver;
			
			for i in range(fullHearts + 1.0, numHearts):
				var nextHeart = get_child(i)
				nextHeart.get_child(0).frame = 0;
		if (character.is_in_group("Ryl")):
			var edgeHeart = numHearts - (fullHearts + 1)
			var fractionalHeart = get_child(edgeHeart)
			fractionalHeart.get_child(0).frame = amountOver;
			
			for i in range(0, edgeHeart):
				var nextHeart = get_child(i)
				nextHeart.get_child(0).frame = 0;

	
