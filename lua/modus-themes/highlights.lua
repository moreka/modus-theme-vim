local M = {}
local cmd = vim.cmd
local g = vim.g
local o = vim.o
local fn = vim.fn

local settings = {
	modus_faint_syntax = 0,
	modus_moody_enable = 0,
	modus_yellow_comments = 0,
	modus_green_strings = 0,
	modus_termtrans_enable = 0,
	modus_cursorline_intense = 0,
	modus_italic_strings = 0,
	modus_dim_inactive_window = 1,
}

for key, val in pairs(settings) do
	if g[key] == nil then
		g[key] = val
	end
end

cmd("hi clear")

if fn.exists("syntax_on") then
	cmd("syntax reset")
end

function M.core_highlights(colors)
	-- this will apply the highlights
	local highlighter = function(group, color)
		color.bg = color.bg or { "none", "none" }
		vim.api.nvim_set_hl(
			0,
			group,
			{
				fg = color.fg[1],
				bg = color.bg[1],
				bold = color.bold or false,
				italic = color.italic or false,
				underline = color.underline or false,
			}
		)
		-- cmd(
		-- 	string.format(
		-- 		"hi %s guifg=%s guibg=%s gui=%s ctermfg=%s ctermbg=%s cterm=%s",
		-- 		group,
		-- 		g_foreground,
		-- 		g_background,
		-- 		style,
		-- 		c_foreground,
		-- 		c_background,
		-- 		style
		-- 	)
		-- )
	end

	local syntax = {}
	-- ui
	syntax["Normal"] = { fg = colors.fg_main, bg = colors.bg_main }
	syntax["Folded"] = { fg = colors.fg_special_mild, bg = colors.bg_special_mild }
	syntax["LineNr"] = { fg = colors.fg_alt, bg = colors.bg_dim }
	syntax["CursorLineNr"] = { fg = colors.fg_active, bg = colors.bg_active, bold = true }
	syntax["SignColumn"] = { fg = colors.bg_main, bg = colors.bg_inactive }
	syntax["CursorLine"] = { fg = colors.none, bg = colors.bg_hl_line }
	syntax["NonText"] = { fg = colors.fg_alt }
	syntax["NormalNC"] = { fg = colors.fg_inactive, bg = colors.bg_main }
	syntax["ErrorMsg"] = { fg = colors.fg_main, bg = colors.red_intense_bg }
	syntax["Conceal"] = { fg = colors.fg_special_warm, bg = colors.bg_dim }
	syntax["Cursor"] = { fg = colors.bg_main, bg = colors.fg_main }
	syntax["lCursor"] = syntax["Cursor"]
	syntax["CursorIM"] = syntax["Cursor"]
	syntax["ColorColumn"] = { fg = colors.fg_main, bg = colors.bg_active }
	syntax["FoldColumn"] = { fg = colors.fg_active, bg = colors.bg_active }
	syntax["IncSearch"] = syntax["Search"]
	syntax["Substitute"] = syntax["Search"]
	-- syntax['ModeMsg'] = {}
	-- syntax['MsgArea'] = {}
	-- syntax['MsgSeparator'] = {}
	-- syntax['MoreMsg'] = {}
	-- syntax['NormalFloat'] = {}
	-- syntax['Question'] = {}
	syntax["QuickFixLine"] = { fg = colors.fg_main, bg = colors.bg_main }
	-- syntax['SpecialKey'] = {}
	syntax["Menu"] = syntax["Pmenu"]
	syntax["Scrollbar"] = syntax["PmenuSbar"]
	-- syntax['Tooltip'] = {}
	syntax["Directory"] = { fg = colors.blue }
	syntax["Title"] = { fg = colors.fg_special_cold, bold = true }
	syntax["Visual"] = { fg = colors.fg_main, bg = colors.magenta_intense_bg }
	syntax["Whitespace"] = syntax["NonText"]
	syntax["TabLine"] = { fg = colors.fg_main, bg = colors.bg_tab_inactive }
	syntax["TabLineSel"] = { fg = colors.fg_tab_accent, bg = colors.bg_tab_active }
	syntax["TabLineFill"] = { fg = colors.bg_main, bg = colors.bg_tab_bar }
	syntax["Search"] = { fg = colors.fg_main, bg = colors.green_intense_bg }
	syntax["EndOfBuffer"] = { fg = colors.fg_inactive }
	syntax["MatchParen"] = { fg = colors.fg_main, bg = colors.bg_paren_match }
	syntax["Pmenu"] = { fg = colors.fg_active, bg = colors.bg_active }
	syntax["PmenuSel"] = { fg = colors.fg_dim, bg = colors.bg_dim }
	syntax["PmenuSbar"] = { fg = colors.bg_main, bg = colors.bg_inactive }
	syntax["PmenuThumb"] = syntax["Cursor"]
	syntax["StatusLine"] = { fg = colors.fg_active, bg = colors.bg_active }
	syntax["StatusLineNC"] = { fg = colors.fg_inactive, bg = colors.bg_inactive }
	syntax["VertSplit"] = syntax["Normal"]
	syntax["DiffAdd"] = { fg = colors.fg_diff_added, bg = colors.bg_diff_added }
	syntax["DiffChange"] = { fg = colors.fg_diff_changed, bg = colors.bg_diff_changed }
	syntax["DiffDelete"] = { fg = colors.fg_diff_removed, bg = colors.bg_diff_removed }
	syntax["DiffText"] = { fg = colors.fg_diff_changed, bg = colors.bg_diff_changed }
	syntax["SpellBad"] = { fg = colors.fg_lang_error }
	syntax["SpellCap"] = { fg = colors.fg_lang_error }
	-- syntax['SpellLocal'] = {}
	-- syntax['SpellRare'] = {}
	syntax["WarningMsg"] = { fg = colors.yellow_alt }

	-- syntax
	syntax["Comment"] = { fg = colors.fg_alt, italic = true }
	syntax["String"] = { fg = colors.blue_alt }
	syntax["Boolean"] = { fg = colors.blue, bold = true }
	syntax["Character"] = { fg = colors.blue_alt }
	syntax["Conditional"] = { fg = colors.magenta_alt_other }
	syntax["Constant"] = { fg = colors.blue_alt_other }
	syntax["Function"] = { fg = colors.magenta }
	syntax["Identifier"] = { fg = colors.cyan }
	syntax["Include"] = { fg = colors.red_alt_other }
	syntax["Label"] = { fg = colors.cyan }
	syntax["Todo"] = { fg = colors.magenta, bold = true }
	syntax["Type"] = { fg = colors.cyan_alt_other }
	syntax["Number"] = { fg = colors.blue_alt_other_faint }
	syntax["Operator"] = { fg = colors.magenta_alt_other }

	syntax["Float"] = syntax["Number"]
	syntax["PreCondit"] = syntax["Include"]
	syntax["Statement"] = syntax["Conditional"]
	syntax["Repeat"] = syntax["Conditional"]
	syntax["Keyword"] = syntax["Conditional"]
	syntax["Exception"] = syntax["Conditional"]
	syntax["PreProc"] = syntax["Include"]
	syntax["Define"] = syntax["Include"]
	syntax["Macro"] = syntax["Include"]
	syntax["StorageClass"] = syntax["Conditional"]
	syntax["Structure"] = syntax["Conditional"]
	syntax["Typedef"] = syntax["Type"]
	-- syntax['Special'] = {}
	-- syntax['SpecialChar'] = {}
	syntax["Tag"] = { fg = colors.magenta_active }
	syntax["Delimiter"] = { fg = colors.fg_main }
	-- syntax['SpecialComment'] = {}
	-- syntax['Debug'] = {}
	syntax["Underlined"] = { fg = colors.fg_main, underline = true }
	-- syntax['Ignore'] = {}
	syntax["Error"] = syntax["ErrorMsg"]

	-- languages
	-- latex
	syntax["@text.math.latex"] = { fg = colors.fg_alt }
	syntax["@text.environment.latex"] = { fg = colors.green_alt }
	syntax["@punctuation.special.latex"] = { fg = colors.yellow_intense }
	syntax["@function.latex"] = { fg = colors.cyan, bold = true }
	syntax["@text.environment.name.latex"] = { fg = colors.cyan_alt_other }
	syntax["@text.title.latex"] = { fg = colors.fg_main, bold = true }

	-- lua
	syntax["luaTableConstructor"] = { fg = colors.magenta_alt }
	syntax["luaConstant"] = { fg = colors.blue_alt_other, bold = true }
	syntax["luaComment"] = syntax["Comment"]
	syntax["luaStatement"] = syntax["Statement"]
	syntax["luafunctioncall"] = syntax["Function"]
	syntax["luaemmyfluff"] = syntax["NonText"]
	syntax["luaTodo"] = syntax["Todo"]
	syntax["luaVarName"] = syntax["Label"]
	syntax["luaFunc"] = syntax["Function"]

	-- python
	syntax["pythonoperator"] = { fg = colors.fg_main }

	-- css
	syntax["cssVendor"] = syntax["Statement"]

	-- vim
	syntax["nvimidentifier"] = syntax["Identifier"]
	syntax["nvimmap"] = syntax["Conditional"]
	syntax["nvimplainassignment"] = syntax["Type"]
	syntax["vimBracket"] = { fg = colors.fg_main }
	syntax["vimCommentString"] = syntax["Comment"]
	syntax["vimCommentTitle"] = syntax["Include"]
	syntax["vimFuncSID"] = { fg = colors.fg_main }
	syntax["vimFuncVar"] = syntax["Constant"]
	syntax["vimIsCommand"] = { fg = colors.fg_main }
	syntax["vimLet"] = syntax["Conditional"]
	syntax["vimMapLhs"] = { fg = colors.fg_main }
	syntax["vimMapModKey"] = { fg = colors.fg_main }
	syntax["vimNotation"] = { fg = colors.fg_main }
	syntax["vimcommand"] = syntax["Conditional"]
	syntax["vimmap"] = syntax["Conditional"]
	syntax["vimnotfunc"] = syntax["Conditional"]
	syntax["vimvar"] = syntax["Label"]

	-- TODO some options to highlight headers
	-- markdown
	syntax["markdownblockquote"] = { fg = colors.magenta_faint, bold = true }
	syntax["markdownbold"] = { fg = colors.fg_main, bold = true }
	syntax["markdownbolditalic"] = { fg = colors.fg_main, bold = true }
	syntax["markdowncode"] = { fg = colors.fg_special_mild, bg = colors.bg_dim }
	syntax["markdowncodeblock"] = { fg = colors.fg_special_mild, bg = colors.bg_dim }
	syntax["markdowncodedelimiter"] = { fg = colors.green_alt_other, bold = true }
	syntax["markdownfootnote"] = { fg = colors.cyan_alt_faint, italic = true }
	syntax["markdownfootnotedefinition"] = { fg = colors.fg_main, italic = true }
	syntax["markdownh1"] = { fg = colors.fg_main, bg = colors.magenta_nuanced_bg, bold = true }
	syntax["markdownh2"] = { fg = colors.fg_special_warm, bg = colors.red_nuanced_bg, bold = true }
	syntax["markdownh3"] = { fg = colors.fg_special_cold, bg = colors.blue_nuanced_bg, bold = true }
	syntax["markdownh4"] = { fg = colors.fg_special_mild, bg = colors.cyan_nuanced_bg, bold = true }
	syntax["markdownh5"] = { fg = colors.fg_special_calm, bold = true }
	syntax["markdownh6"] = { fg = colors.yellow_nuanced_fg, bold = true }
	syntax["markdownitalic"] = { fg = colors.fg_special_cold, italic = true }
	syntax["markdownlinebreak"] = { fg = colors.cyan_refine_fg, bg = colors.cyan_refine_bg, underline = true }
	syntax["markdownlinktext"] = { fg = colors.blue_faint, italic = true }
	syntax["markdownlistmarker"] = { fg = colors.fg_alt, bold = true }
	syntax["markdownrule"] = { fg = colors.fg_special_warm, bold = true }
	syntax["markdownurl"] = { fg = colors.blue_faint }

	-- Specific green for Diagnostichint
	syntax["diagnostichint"] = { fg = colors.green_alt }
	syntax["diagnosticinfo"] = { fg = colors.blue_alt }
	syntax["diagnosticwarn"] = { fg = colors.yellow_alt }

	-- plugins
	-- lsp
	syntax["lspdiagnosticssignerror"] = { fg = colors.red_active, bg = colors.bg_active, bold = true }
	syntax["lspdiagnosticssignhint"] = { fg = colors.green_active, bg = colors.bg_active, bold = true }
	syntax["lspdiagnosticssigninformation"] = { fg = colors.green_active, bg = colors.bg_active, bold = true }
	syntax["lspdiagnosticssignwarning"] = { fg = colors.yellow_active, bg = colors.bg_active, bold = true }
	syntax["lspdiagnosticsunderlineerror"] = { fg = colors.red_active, underline = true }
	syntax["lspdiagnosticsunderlineinformation"] = { fg = colors.green_active, underline = true }
	syntax["lspdiagnosticsunderlinewarning"] = { fg = colors.yellow_active, underline = true }
	syntax["lspdiagnosticsvirtualtexterror"] = { fg = colors.red_active, bold = true }
	syntax["lspdiagnosticsvirtualtexthint"] = { fg = colors.green_active, bg = colors.bg_active, bold = true }
	syntax["lspdiagnosticsvirtualtextwarning"] = { fg = colors.yellow_active, bold = true }
	syntax["lspdiagnosticsfloatingerror"] = { fg = colors.red_active, bg = colors.bg_active }
	syntax["lspdiagnosticsfloatingwarning"] = { fg = colors.yellow_active, bg = colors.bg_active }
	syntax["lspdiagnosticsfloatinginformation"] = { fg = colors.green_active, bg = colors.bg_active }
	syntax["lspdiagnosticsfloatinghint"] = { fg = colors.green_active, bg = colors.bg_active }

	-- treesitter
	syntax["tsliteral"] = { fg = colors.blue_alt, bold = true }
	syntax["tsannotation"] = { fg = colors.blue_nuanced_bg }
	syntax["tsboolean"] = syntax["Boolean"]
	syntax["tscharacter"] = syntax["Character"]
	syntax["tscomment"] = syntax["Comment"]
	syntax["tsconditional"] = syntax["Conditional"]
	syntax["tsconstant"] = syntax["Constant"]
	syntax["tsconstbuiltin"] = syntax["Constant"]
	syntax["tsconstmacro"] = syntax["Macro"]
	syntax["tserror"] = { fg = colors.fg_main, bg = colors.none, bold = true }
	syntax["tsexception"] = syntax["Conditional"]
	syntax["tsfield"] = syntax["Identifier"]
	syntax["tsfloat"] = syntax["Float"]
	syntax["tsfunction"] = syntax["Function"]
	syntax["tsfuncbuiltin"] = syntax["Function"]
	syntax["tsfuncmacro"] = syntax["Function"]
	syntax["tsinclude"] = syntax["Include"]
	syntax["tskeyword"] = syntax["Keyword"]
	syntax["tslabel"] = syntax["Label"]
	syntax["tsmethod"] = syntax["Function"]
	syntax["tsnamespace"] = syntax["Conditional"]
	syntax["tsnumber"] = syntax["Number"]
	syntax["tsoperator"] = syntax["Operator"]
	syntax["tsparameterreference"] = syntax["Constant"]
	syntax["tsproperty"] = syntax["tsfield"]
	syntax["tspunctdelimiter"] = { fg = colors.fg_main }
	syntax["tspunctbracket"] = { fg = colors.fg_main }
	syntax["tspunctspecial"] = { fg = colors.fg_main }
	syntax["tsrepeat"] = syntax["Conditional"]
	syntax["tsstring"] = syntax["String"]
	syntax["tsstringregex"] = { fg = colors.fg_escape_char_construct }
	syntax["tsstringescape"] = { fg = colors.fg_escape_char_backslash }
	syntax["tsstrong"] = { fg = colors.fg_main, bold = true }
	syntax["tsconstructor"] = syntax["Type"]
	syntax["tskeywordfunction"] = syntax["Type"]
	syntax["tsparameter"] = syntax["Label"]
	syntax["luaTSVariable"] = { fg = colors.fg_main }
	-- syntax['tsvariable'] = syntax['Identifier']
	syntax["tsvariablebuiltin"] = syntax["Conditional"]
	syntax["tstag"] = syntax["Label"]
	syntax["tstagdelimiter"] = syntax["Label"]
	syntax["tstitle"] = { fg = colors.cyan_nuanced_fg }
	syntax["tstype"] = syntax["Type"]
	syntax["tstypebuiltin"] = syntax["Type"]
	syntax["tsemphasis"] = { fg = colors.fg_main, italic = true }
	syntax["telescopematching"] = { fg = colors.fg_main, bg = colors.green_intense_bg, bold = true }

	-- gitsigns
	syntax["GitSignsAdd"] = syntax["DiffAdd"]
	syntax["GitSignsChange"] = syntax["DiffChange"]
	syntax["GitSignsDelete"] = syntax["DiffDelete"]

	if g.modus_termtrans_enable == 1 then
		syntax.Normal.bg = colors.none
		syntax.Folded.bg = colors.none
		syntax.LineNr.bg = colors.none
		syntax.CursorLineNr.bg = colors.none
		syntax.SignColumn.bg = colors.none
	end

	if g.modus_cursorline_intense == 1 then
		syntax.CursorLine.bg = colors.bg_hl_line_intense
	end

	if g.modus_faint_syntax == 1 then
		syntax.Boolean.fg = colors.blue_faint
		syntax.Character.fg = colors.blue_alt_faint
		syntax.Conditional.fg = colors.magenta_alt_other_faint
		syntax.Constant.fg = colors.blue_alt_other_faint
		syntax.Function.fg = colors.blue_alt_other_faint
		syntax.Identifier.fg = colors.cyan_faint
		syntax.Include.fg = colors.red_alt_other_faint
		syntax.Label.fg = colors.cyan_faint
		syntax.Todo.fg = colors.magenta_faint
		syntax.Type.fg = colors.magenta_alt_faint
		syntax.Number.fg = colors.blue_alt_other_faint
		syntax.Operator.fg = colors.magenta_alt_other_faint
		syntax.luaTableConstructor.fg = colors.magenta_alt_faint
		syntax.tsliteral.fg = colors.blue_alt_faint
	end

	if g.modus_yellow_comments == 1 then
		syntax.Comment.fg = colors.fg_comment_yellow
	end

	if g.modus_green_strings == 1 then
		syntax.String.fg = colors.green_alt
	end

	if g.modus_italic_strings == 1 then
		syntax.String.italic = true
	end

	if g.modus_dim_inactive_window == 1 then
		syntax.NormalNC.bg = colors.bg_inactive
	end

	for group, highlights in pairs(syntax) do
		highlighter(group, highlights)
	end
end

function M.set_terminal(colors)
	g.terminal_color_0 = "#555555"
	g.terminal_color_8 = "#222222"
	g.terminal_color_1 = colors.red_faint[1]
	g.terminal_color_9 = colors.red_intense[1]
	g.terminal_color_2 = colors.green_faint[1]
	g.terminal_color_10 = colors.green_intense[1]
	g.terminal_color_3 = colors.yellow_faint[1]
	g.terminal_color_11 = colors.yellow_intense[1]
	g.terminal_color_4 = colors.blue_faint[1]
	g.terminal_color_12 = colors.blue_intense[1]
	g.terminal_color_5 = colors.magenta_faint[1]
	g.terminal_color_13 = colors.magenta_intense[1]
	g.terminal_color_6 = colors.cyan_faint[1]
	g.terminal_color_14 = colors.cyan_intense[1]
	g.terminal_color_7 = "#ffffff"
	g.terminal_color_15 = "#dddddd"
end

return M
