rockspec_format = "3.0"
package = "xpcall.lua"
version = "scm-0"
source = {
   url = "git://github.com/BlackMATov/xpcall.lua",
   branch = "main",
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
