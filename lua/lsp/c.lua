local lspconfig = require("lspconfig")

return {
	lsp = lspconfig.clangd,

	cmd = {
		-- WARNING: Need custom-compiled clangd
		--          git clone https://github.com/espressif/llvm-project.git
		--          cd llvm-project
		--          cmake -S llvm -B build -G Ninja -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra"
		--          cmake --build build
		"/Users/david.reis/src/misc/llvm-project/build/bin/clangd",
		-- WARNING: Need platformio toolchain
		--          pio project init --board arduino_nano_esp32 --ide vim
		"--query-driver=/Users/david.reis/.platformio/packages/toolchain-xtensa-esp-elf/bin/xtensa-esp32s3-elf-gcc*,/Users/david.reis/.platformio/packages/toolchain-xtensa-esp-elf/bin/xtensa-esp32s3-elf-g++*,xtensa-esp32s3-elf-gcc*,xtensa-esp32s3-elf-g++*",
		"--background-index",
		"--suggest-missing-includes",
		"--clang-tidy",
		"--header-insertion=iwyu",
		"--header-insertion-decorators",
		"--cross-file-rename",
		"--compile-commands-dir=build",
		"--pch-storage=memory",
		"--completion-style=detailed",
		"--log=verbose",
	},

	options = {
		single_file_support = true,
	},

	capabilities = {
		offsetEncoding = "utf-8",
	},

	filetypes = { "c", "cpp", "arduino" },

	root_dir = function(fname)
		return lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git")(fname)
			or lspconfig.util.path.dirname(fname)
	end,
}
