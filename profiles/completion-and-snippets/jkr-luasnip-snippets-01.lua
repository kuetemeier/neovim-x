local ls = require("luasnip")
-- some shorthands...
local snip = ls.snippet
-- local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
-- local choice = ls.choice_node
-- local dynamicn = ls.dynamic_node

local date = function() return { os.date('%Y-%m-%d') } end
local year = function() return { os.date('%Y') } end

ls.add_snippets(nil, {
all = {

snip({
trig = "date",
namr = "Date",
dscr = "Date in the form of YYYY-MM-DD",
}, {
func(date, {}),
}),

snip({
trig = "#mpl",
namr = "JKR-MPL-2.0",
dscr = "# Copyright JKR - License MPL-2.0"
}, {
text({ "#  " }), insert(1, "filename"),
text({ "", "#  " }), insert(2, "description"),
text({ "", "#",
"#",
"#        //_/  Jörg Kütemeier <https://kuetemeier.de>",
"#     ._// )   (c) Copyright " .. "2023" .. " - License: MPL-2.0",
"#",
"#",
"# {{{ MPL-2.0",
"#",
"#  This Source Code Form is subject to the terms of the Mozilla Public",
"#  License, v. 2.0. If a copy of the MPL was not distributed with this",
"#  file, You can obtain one at https://mozilla.org/MPL/2.0/.",
"#",
"# }}}",
"" }),
insert(0)
}),

snip({
trig = "#spdx",
namr = "SPDX Copyright Tags",
dscr = "# SPDX Copyright Tgas and Vim /NeoVim Modeline - License MPL-2.0"
}, {
text({ "",
"# {{{ SPDX Copyright Tags and Vim / NeoVim Modeline",
"#",
"# SPDX-FileCopyrightText: 2023 Jörg Kütemeier <https://kuetemeier.de/>",
"# SPDX-License-Identifier: MPL-2.0",
"#",
"# vim: set sw=2 ts=2 sts=2 et tw=79 foldmethod=marker foldlevel=0",
"# }}}",
"" }),
}),

},
})
