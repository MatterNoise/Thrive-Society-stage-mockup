extends StaticBody3D
class_name IBuildingClass

var BuildingOwner : String
var BuildingType : String

func _exit_tree() -> void:
	CivilizationsInfo.delete_building_to_civilization_info(BuildingOwner, self)
