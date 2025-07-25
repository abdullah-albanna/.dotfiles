local M = {
  {
    "nvim-java/nvim-java",
    dependencies = {
      "nvim-java/lua-async-await",
      "nvim-java/nvim-java-core",
      "nvim-java/nvim-java-test",
      "nvim-java/nvim-java-dap",
    },
    config = function()
      require("java").setup()
    end,
    root_markers = {
      "pom.xml",
      "mvnw",
      "gradlew",
      ".git",
    },
  },
}

return M
