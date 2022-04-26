locals {
  common_tags = merge(
    var.tags,
    map(
      "Environment", "Test"
      "OSFamily", "Linux",
      "Role", "Test App VM")
  )
}