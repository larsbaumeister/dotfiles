return {
  "mfussenegger/nvim-dap",
  optional = true,
  opts = function()
    local dap = require "dap"
    dap.configurations.java = {
      {
        type = "java",
        request = "attach",
        name = "Debug (Attach) - Remote",
        hostName = "127.0.0.1",
        port = 5005,
      },
    }
  end,
  dependencies = {
    {
      "williamboman/mason.nvim",
      opts = { ensure_installed = { "java-debug-adapter", "java-test" } },
    },
  },
}
