extends Node

signal inventory_changed

var _is_mass_updating: bool = false

@export var hop: int = 100000:
	set(value):
		hop = value
		if not _is_mass_updating:
			inventory_changed.emit()

@export var barley: int = 1000000:
	set(value):
		barley = value
		if not _is_mass_updating:
			inventory_changed.emit()

@export var water: int = 100000:
	set(value):
		water = value
		if not _is_mass_updating:
			inventory_changed.emit()

@export var wheat: int = 1000000:
	set(value):
		wheat = value
		if not _is_mass_updating:
			inventory_changed.emit()

@export var yeast: int = 100000:
	set(value):
		yeast = value
		if not _is_mass_updating:
			inventory_changed.emit()

# Fonction utilitaire pour vérifier si on a assez de stock
func has_ingredients(recipe: BeerType) -> bool:
	return (hop >= recipe.hop and 
			barley >= recipe.barley and 
			water >= recipe.water and 
			wheat >= recipe.wheat and 
			yeast >= recipe.yeast)

# Fonction pour consommer les ingrédients d'un coup
func consume(recipe: BeerType) -> void:
	if has_ingredients(recipe):
		# 1. On active le mode silencieux
		_is_mass_updating = true
		
		# 2. On modifie tout (les setters ne font pas d'emit)
		hop -= recipe.hop
		barley -= recipe.barley
		water -= recipe.water
		wheat -= recipe.wheat
		yeast -= recipe.yeast
		
		# 3. On désactive le mode silencieux
		_is_mass_updating = false
		
		# 4. On émet UN SEUL signal pour tout le monde
		inventory_changed.emit()
	else:
		push_warning("Pas assez de stock !")
