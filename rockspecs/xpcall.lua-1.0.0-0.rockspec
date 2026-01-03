rockspec_format = "3.0"
package = "xpcall.lua"
version = "1.0.0-0"
source = {
   url = "git://github.com/BlackMATov/xpcall.lua",
   tag = "v1.0.0",
}
description = {
   homepage = "https://github.com/BlackMATov/xpcall.lua",
   summary = "A pure Lua implementation of xpcall with support for passing arguments",
   license = "MIT",
}
dependencies = {
   "lua >= 5.1",
}
build = {
   type = "builtin",
   modules = {
      xpcall = "xpcall.lua",
   }
}
