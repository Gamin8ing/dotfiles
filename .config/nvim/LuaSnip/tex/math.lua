-- Abbreviations used in this article and the LuaSnip docs
local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local rep = require("luasnip.extras").rep

return {
	-- a snippet for creating snippets
	s({ trig = ";sn", snippetType = "autosnippet" }, {
		t("require('luasnip').snippet({trig=\""),
		i(1),
		t('", dscr="'),
		i(2),
		t('", snippetType="'),
		i(3),
		t('",'),
		t("}, {"),
		i(4),
		t("})"),
	}),

	require("luasnip").snippet({
		trig = "hi",
		dscr = "an autotriggering snippet expanding 'hi' to 'Hello World",
		regTrig = false,
		priority = 100,
		-- snippetType = "autosnippet",
	}, {
		t("Hello World"),
	}),
	-- ;a to alpha
	s({ trig = ";a", snippetType = "autosnippet" }, { t("\\alpha") }),
	-- ;b to beta
	s({ trig = ";b", snippetType = "autosnippet" }, { t("\\beta") }),
	-- ;g to gamma
	s({ trig = ";g", snippetType = "autosnippet" }, { t("\\gamma") }),

	--------------------- TEXT STYLING --------------------------------
	-- ;tt to \texttt{}
	s({ trig = ";tt", snippetType = "autosnippet" }, { t("\\texttt{"), i(1), t("}") }),
	-- ;ii to \textit{}
	s({ trig = ";i", snippetType = "autosnippet" }, { t("\\textit{"), i(1), t("}") }),
	-- bb to \textbf{}
	s({ trig = "bb", snippetType = "autosnippet" }, { t("\\textbf{"), i(1), t("}") }),
	-- ;u to \underline{}
	s({ trig = ";u", snippetType = "autosnippet" }, { t("\\underline{"), i(1), t("}") }),

	---------------------- MATH  _______________________________________
	-- ;f for fractions
	s({ trig = ";f", snippetType = "autosnippet", dscr = "Expands ;f to fractions in LaTeX" }, {
		t("\\frac{"),
		i(1),
		t("}{"),
		i(2),
		t("}"),
	}),

	-- $ should pair the other dollar signature
	s({ trig = "$", regTrig = true, dscr = "Expands $ to $ $ in LaTeX", snippetType = "autosnippet" }, {
		t("$"),
		i(1),
		t("$"),
	}),

	-- \[ to start the math environments
	s({ trig = "\\[", regTrig = true, dscr = "Expands \\[ to \\[ \\] in LaTeX", snippetType = "autosnippet" }, {
		t("\\["),
		i(1),
		t("\\]"),
	}),
}
