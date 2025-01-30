# variable "vault_addr" {
#   description = "vault address"
#   type        = string
# }

# variable "vault_token" {
#   description = "vault token"
#   type        = string
# }

variable "vault_child_namespaces" {
  type = set(string)
  default = [
    "terraformtitans",
    "vaultvillagers",
    "consulcreepers",
    "nomadnethers",
    "boundaryblazes",
    "waypointwithers",
    "packerpiglins",
    "diamonddevops",
    "redstonerunners",
    "vagrantvexes",
    "obsidianoperators",
    "endermanengineers",
    "cloudguards",
    "cloudcrafters",
    "pipelinepillagers", 
    "terraformtowers",
    "statestorrageslimes",
    "moduleminers",
    "sentinelshulkers",
    "resourceravagers",
    "configzombies",
    "secretskeletons",
    "registryraiders",
    "clustercrystals",
    "chaincraft",
    "netherdrakes",
    "stackspiders",
    "swiftaxols",
    "provisionphantoms",
    "platformpandas",
    "networknetherite",
    "securitystriders",
    "orchaminers",
    "containercopper",
    "databasedrowned",
    "servicesilverfish",
    "policyparrots",
    "meshmagma",
    "dockerdolphins",
    "pipelinepiglins"
  ]
}