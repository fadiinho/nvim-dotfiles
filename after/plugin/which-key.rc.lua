local status, wk = pcall(require, "which-key")
if not status then
  return
end

wk.setup {
  plugins = {
    presets = {
      windows = true,
    },
  },
}
