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
	
	# update hearts
	if (character.is_in_group("Elvyria")):
		# fractional heart
		if ( numHearts != fullHearts):
			var fractionalHeart = get_child(fullHearts)
			fractionalHeart.get_child(0).frame = amountOver;
		
		# full hearts
		for i in range(0, fullHearts):
			var nextHeart = get_child(i)
			nextHeart.get_child(0).frame = 4;
		# empty hearts
		for i in range(fullHearts + 1.0, numHearts):
			var nextHeart = get_child(i)
			nextHeart.get_child(0).frame = 0;
	if (character.is_in_group("Ryl")):
		var edgeHeart = numHearts - (fullHearts + 1)
		
		if (numHearts != fullHearts):
			var fractionalHeart = get_child(edgeHeart)
			fractionalHeart.get_child(0).frame = amountOver;
		
		# full hearts
		for i in range(edgeHeart + 1.0, numHearts):
			var nextHeart = get_child(i)
			nextHeart.get_child(0).frame = 4;
		# empty hearts
		for i in range(0, edgeHeart):
			var nextHeart = get_child(i)
			nextHeart.get_child(0).frame = 0;

	
