extends Node
class_name SocietyStageGame

func create_new_building(StructureName : String, AtPosition : Vector3, BuildingOwner : String, ResourceCostFree : bool = false) -> IBuildingClass:
	var StructureScene : PackedScene = StructuresDefinitions.get_structure_standart_model(StructureName)
	var StructureInstance : IBuildingClass = StructureScene.instantiate()
	
	StructureInstance.BuildingOwner = BuildingOwner
	StructureInstance.BuildingType = StructureName
	
	add_child.call_deferred(StructureInstance)
	
	StructureInstance.position = AtPosition
	
	CivilizationsInfo.add_building_to_civilization_info(BuildingOwner, StructureInstance)
	if ResourceCostFree == false:
		var BuildinRequirements := StructuresDefinitions.get_structure_building_requirements(StructureName)
		for ISpentResource in BuildinRequirements:
			CivilizationsInfo.CivilizationsInfoDictionary[BuildingOwner].add_resource_amount_to_civ(ISpentResource, -BuildinRequirements[ISpentResource])
	
	#print(CivilizationsInfo.CivilizationsInfoDictionary[BuildingOwner].CivilizationResources)
	
	return StructureInstance
