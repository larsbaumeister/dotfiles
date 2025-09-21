return {
  {
    "mfussenegger/nvim-jdtls",
    lazy = true,
    opts = {
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = "JavaSE-24",
                path = "/home/lars/.sdkman/candidates/java/24-tem",
              },
            },
          },
          -- Compiler configuration to include -parameters
          compiler = {
            compilerArgs = { "-parameters", "-g" }, -- Retain parameter names; add -g for full debug info
            sourceFile = { -- Or use compilerArgs directly if sourceFile doesn't apply
              compilerArgs = { "-parameters", "-g" }, -- Retain parameter names; add -g for full debug info
            },
          },
          -- Additional Eclipse JDT.LS options (optional but recommended for Spring Boot)
          eclipse = {
            downloadSources = true, -- Download source jars for dependencies
          },
          maven = {
            downloadSources = true,
          },
          implementationsCodeLens = {
            enabled = true, -- Shows "Implementations" in code lens
          },
          referencesCodeLens = {
            enabled = true, -- Shows "References" in code lens
          },
          references = {
            includeDecompiledSources = true, -- For better navigation in deps
          },
        },
      },
    },
  }, -- load jdtls on module
}
