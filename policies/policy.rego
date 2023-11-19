package terraform.functions

import input.resource_changes

# Get created resources
#creates := [res | res := resource_changes[_]; res.change.actions[_] == "create"]
creates = [res | res = resource_changes[_]; res.change.actions[_] == "create"]

# Check if creates is not empty
resources_created {
	count(creates) > 0
}

# Get resources by type and action
get_resources_by_type_and_action(type, action, resources) = filtered_resources {
	filtered_resources := [resource |
		resource := resources[_]
		resource.type = type
		resource.change.actions[_] = action
	]
}

resource_group_created = get_resources_by_type_and_action("azurerm_resource_group", "create", resource_changes)

missingTags(resource, tagList) {
	keys := {key | resource.change.after.tags[key]}
	missing := tagList - keys
	missing == set()
}

tags_contain_required(resource_checks) = resources {
	resources := [resource |
		resource := resource_checks[_]
		not missingTags(resource, required_tags)
	]
}

required_tags = {"owner"}

deny[msg] {
	resources := tags_contain_required(resource_group_created)
	resources != []
	msg := sprintf("The following resources are missing required tags: %s", [resources[_].address])
}
