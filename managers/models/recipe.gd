class_name Recipe extends Resource

@export_group("General")
@export var name: String
@export var type: BeerType

func global_cost_calculator():
	print("recipe")
