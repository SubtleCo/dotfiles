# Welcome to the party, pal

## Running and debugging applications and tests

It turns out that we owe a shit ton of thanks to the microsoft and vscode teams for building something called the [Debug Adaptor Protocol](https://microsoft.github.io/debug-adapter-protocol/), which is essentially what modern IDE debugging is based off of. If you've used vscode, you'll be familiar with the `launch.json` file. Even though we're using neovim, we'll be using the same protocol, and the end result will feel familiar to debugging in vscode.

## Base Requirements
[neovim >= 0.7](https://neovim.io) -- Well, yeah. You'll need that one. 
[packer](https://github.com/wbthomason/packer.nvim) -- neovim package management 
[nvim-lspconfig](https://github.com/neovim/nvim-lspconfig) -- Quickstart configs for nvim LSP 
[mason](https://github.com/williamboman/mason.nvim) -- LSP package manager, etc 
[mason-lspconfig](https://github.com/williamboman/mason-lspconfig.nvim) -- Bridges the gap between lspconfig and mason 
[nvim-dap](https://github.com/mfussenegger/nvim-dap) -- Debug Adaptor Protocol implementation for Neovim 
[nvim-dap-ui](https://github.com/rcarriga/nvim-dap-ui) -- A nice and familiar looking UI for debugging 
[jester](https://github.com/David-Kunz/jester) -- run end debug jest tests 
[vscode-js-debug](https://github.com/microsoft/vscode-js-debug) -- Microsoft's JS debugger 
[nvim-dap-vscode-js](https://github.com/mxsdev/nvim-dap-vscode-js) -- adapt vscode-js-debug for nvim-dap 


### Python

