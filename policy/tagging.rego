package terraform.required_tags

# Define the required tags for VPCs
required_tags := {"Name", "Environment", "Owner"}

# Deny rule triggered if any required tag is missing
deny[msg] {
  resource := input.resource_changes[_]

  # Only check aws_vpc and aws_subnet
  resource_is_target(resource)

  tags := resource.change.after.tags
  missing := required_tags - object.keys(tags)
  count(missing) > 0
  msg := sprintf("Resource %v (%v) is missing tags: %v", 
                 [resource.name, resource.type, missing])
}

# helper rule for target resources
resource_is_target(r) {
  r.type == "aws_vpc"
}
resource_is_target(r) {
  r.type == "aws_subnet"
}

