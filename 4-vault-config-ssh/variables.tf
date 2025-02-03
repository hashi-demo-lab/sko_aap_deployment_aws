# variable "vault_addr" {
#   description = "vault address"
#   type        = string
# }

# variable "vault_token" {
#   description = "vault token"
#   type        = string
# }

variable "oraganizations" {
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
    "pipelinepiglins",
    "testorga",
    "testorgb",
    "testorgc",
  ]
}

variable "vault_password" {
  type = string
  default = "Hashicorp123!sko2025"
}