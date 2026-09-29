extends Resource
class_name ICivilizationInfo

var CivilizationResources : Dictionary[String, int]
var CivilizationBuildings : Array[IBuildingClass]

var CivilizationName : String

var CivilizationPopulation : int

func set_resource_amount_to_civ(ResourceName : String, ResourceCuantity : int = 0) -> void:
	CivilizationResources[ResourceName] = ResourceCuantity

func add_resource_amount_to_civ(ResourceName : String, ResourceCuantity : int = 0) -> void:
	CivilizationResources[ResourceName] += ResourceCuantity

func get_civilization_resource(ResourceName : String) -> int:
	if CivilizationResources.has(ResourceName) == false:
		printerr("Mencioned resource is not declared!.")
	
	return CivilizationResources[ResourceName]
