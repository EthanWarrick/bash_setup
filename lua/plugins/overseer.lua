---@type LazyPluginSpec
local Plugin = { "stevearc/overseer.nvim" }

Plugin.enabled = false

Plugin.cmd = {
  "OverseerBuild",
  "OverseerClearCache",
  "OverseerClose",
  "OverseerDeleteBundle",
  "OverseerInfo",
  "OverseerLoadBundle",
  "OverseerOpen",
  "OverseerQuickAction",
  "OverseerRun",
  "OverseerRunCmd",
  "OverseerSaveBundle",
  "OverseerTaskAction",
  "OverseerToggle",
}

Plugin.config = true

return Plugin
