package terraform.required_tags

# Required tags
required_tags := {"Name", "Environment", "Owner"}

# Deny rule: triggered if any target resource is missing tags
deny[msg] {
    some i
    resource := input.resource_changes[i]

    # Only check aws_vpc and aws_subnet
    resource_is_target(resource)

    tags := resource.change.after.tags

    # Compute missing tags
    missing := {tag | tag := required_tags[_]; not tags[tag]}

    count(missing) > 0

    msg := sprintf(
        "Resource %v (%v) is missing tags: %v",
        [resource.name, resource.type, missing]
    )
}

# Helper rule for target resources
resource_is_target(r) {
    r.type == "aws_vpc"
}

resource_is_target(r) {
    r.type == "aws_subnet"
}
