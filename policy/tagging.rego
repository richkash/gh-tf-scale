package terraform.required_tags

# Define the required tags for VPCs
required_tags := {"Name", "Environment", "Owner"}

# Deny rule triggered if any required tag is missing
deny[msg] {
  resource := input.resource_changes[_]

  # Only check aws_vpc and aws_subnet resources
  resource.type == "aws_vpc" 
    or resource.type == "aws_subnet"

  # The tags after the change
  tags := resource.change.after.tags

  # Compute missing tags
  missing := required_tags - object.keys(tags)

  # If there are missing tags, deny with a message
  count(missing) > 0
  msg := sprintf("Resource %v (%v) is missing tags: %v", 
                 [resource.name, resource.type, missing])
}

