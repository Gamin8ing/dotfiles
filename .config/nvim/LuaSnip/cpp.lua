-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	require("luasnip").snippet(
		{ trig = ";im", snippetType = "autosnippet" },
		fmt(
			[[
      #include <iostream>
      :;
      int main(int argc, char** argv) {
        :;
      }
      ]],
			{
				i(1),
				i(0),
			},
			{ delimiters = ":;" }
		)
	),
	-- cout to std::cout, usefull
	s({ trig = "cout", snippetType = "autosnippet" }, {
		t("std::cout"),
	}),
	-- endl to std::'\n'
	s({ trig = "endl", snippetType = "autosnippet" }, {
		t("'\n'"),
	}),
}
