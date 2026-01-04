# xpcall.lua

> A pure Lua implementation of `xpcall` with support for passing arguments

[xpcall]: https://github.com/BlackMATov/xpcall.lua
[license]: https://en.wikipedia.org/wiki/MIT_License

- [Introduction](#introduction)
- [Installation](#installation)
- [Quick Start](#quick-start)
- [Changelog](#changelog)
  - [v1.0.1](#v101)
  - [v1.0.0](#v100)
- [License](#license)

## Introduction

The standard `xpcall` function in Lua lets you run a function in protected mode, catching any errors that occur during execution. It also allows you to provide an error handler that is invoked before the stack is unwound when an error occurs.

Lua 5.1 has a limitation: the built-in `xpcall` does not support passing arguments to the protected function. This mini-library addresses that by providing a pure Lua implementation of `xpcall` that accepts arguments, while remaining compatible with later Lua versions that already support this feature.

The library is also designed to keep overhead minimal. Unlike naive implementations that capture arguments in closures, it uses a more efficient approach that avoids creating unnecessary closures. This reduces memory usage, improves performance (about 2–3× faster than naive implementations), and avoids per-call GC pressure.

Enjoy! :feelsgood:

## Installation

`xpcall.lua` is a single-file pure Lua library and does not require any external dependencies. It is designed to work with [Lua 5.1](https://www.lua.org/) and later, [LuaJIT](https://luajit.org/), and [Luau](https://luau.org/) (Roblox).

All you need to start using the library is the [xpcall.lua](./xpcall.lua) source file. You can download it from the [releases](https://github.com/BlackMATov/xpcall.lua/releases) page or clone the [repository](https://github.com/BlackMATov/xpcall.lua) and copy the file to your project.

If you are using [LuaRocks](https://luarocks.org/), you can install the library using the following command:

```bash
luarocks install xpcall.lua
```

## Quick Start

To use `xpcall.lua` in your Lua project, just require the module and use the returned function as a replacement for the standard `xpcall`. Here's a simple example:

```lua
local xpcall = require 'xpcall'

do
    local success, result = xpcall(function(a, b)
        return a .. b
    end, debug.traceback, 'Hello', ' world!')

    assert(success) -- No error occurred
    print(result)   -- Print: Hello world!
end

do
    local success, err = xpcall(function(a, b)
        return a / b
    end, debug.traceback, 'Hello', ' world!')

    assert(not success) -- An error occurred
    print(err)          -- Print the traceback of the error
end
```

If the current Lua environment already provides `xpcall` with argument support, the library simply returns the built-in `xpcall` function without any overhead. If the built-in `xpcall` does not support passing arguments to the protected function, the library provides its own implementation.

## Changelog

### v1.0.1

- Fixed GC issue with holding references to arguments after the `xpcall` call

### v1.0.0

- Initial release

## License

`xpcall.lua` is licensed under the [MIT License][license]. For more details, see the [LICENSE.md](./LICENSE.md) file in the repository.
