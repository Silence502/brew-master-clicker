class_name Storage extends Resource

# Ce signal sera émis à chaque changement d'inventaire
signal inventory_changed

var _is_mass_updating: bool = false

@export var hop: int = 100:
	set(value):
		hop = value
		inventory_changed.emit()

@export var barley: int = 100:
	set(value):
		barley = value
		inventory_changed.emit()

@export var water: int = 100:
	set(value):
		water = value
		inventory_changed.emit()

@export var wheat: int = 100:
	set(value):
		wheat = value
		inventory_changed.emit()

@export var yeast: int = 100:
	set(value):
		yeast = value
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
		
		print("storage.gd : ", hop)
	else:
		push_warning("Pas assez de stock !")
