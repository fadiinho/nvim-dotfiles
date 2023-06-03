return {
  "fadiinho/interface-generator",
  dev = true,
  event = "WinEnter",
  init = function()
    require("interface-generator").setup()
  end,
}
