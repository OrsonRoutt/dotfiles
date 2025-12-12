local M = {}

local function create_highlights(vars)
  return {
    default = {
      -- NeoVim
      ColorColumn = { fg = "NONE", bg = vars.ui.bg_alt },
      Conceal = { fg = vars.ui.dark, bg = "NONE" },
      CurSearch = { fg = vars.vim.cur_search_fg, bg = vars.vim.cur_search },
      Cursor = { fg = vars.vim.cursor_fg, bg = vars.vim.cursor_bg },
      lCursor = { link = "Cursor" },
      CursorIM = { link = "Cursor" },
      CursorColumn = { fg = "NONE", bg = vars.vim.cursor_line },
      CursorLine = { fg = "NONE", bg = vars.vim.cursor_line },
      Directory = { fg = vars.ui.special, bg = "NONE" },
      DiffAdd = { fg = vars.diff.fg, bg = vars.diff.add },
      DiffChange = { fg = vars.diff.fg, bg = vars.diff.change },
      DiffDelete = { fg = vars.diff.fg, bg = vars.diff.delete },
      DiffText = { fg = vars.diff.fg, bg = vars.diff.text },
      TermCursor = { link = "Cursor" },
      ErrorMsg = { fg = vars.diag.error, bg = "NONE", bold=true },
      WinSeparator = { fg = vars.ui.sep, bg = "NONE" },
      Folded = { fg = vars.vim.folded, bg = vars.vim.folded_bg },
      FoldColumn = { fg = vars.ui.dark, bg = "NONE" },
      SignColumn = { link = "Normal" },
      IncSearch = { link = "Search" },
      Substitute = { link = "Search" },
      LineNr = { fg = vars.ui.dark, bg = "NONE" },
      LineNrAbove = { link = "LineNr" },
      LineNrBelow = { link = "LineNr" },
      CursorLineNr = { fg = vars.ui.light, bg = "NONE", bold=true },
      CursorLineFold = { link = "FoldColumn" },
      CursorLineSign = { link = "SignColumn" },
      MatchParen = { fg = vars.ui.special, bg = "NONE", underline=true },
      ModeMsg = { link = "Normal" },
      MsgArea = { link = "Normal" },
      MsgSeparator = { link = "Normal" },
      MoreMsg = { fg = vars.ui.prompt, bg = "NONE" },
      NonText = { fg = vars.ui.dark, bg = "NONE" },
      Normal = { fg = vars.ui.fg, bg = vars.ui.bg },
      NormalFloat = { fg = "NONE", bg = vars.ui.bg_alt },
      FloatBorder = { link = "NormalFloat", fg = vars.ui.sep, bg = "NONE" },
      FloatTitle = { link = "NormalFloat", fg = vars.ui.title, bg = "NONE", bold=true },
      FloatFooter = { link = "NormalFloat", fg = vars.ui.title, bg = "NONE", bold=true },
      NormalNC = { link = "Normal" },
      Pmenu = { fg = vars.ui.light, bg = vars.ui.bg_alt },
      PmenuSel = { link = "Cursor" },
      PmenuKind = { link = "Pmenu" },
      PmenuKindSel = { link = "PmenuSel" },
      PmenuExtra = { link = "Pmenu" },
      PmenuExtraSel = { link = "PmenuSel" },
      PmenuSbar = { link = "Pmenu" },
      PmenuThumb = { fg = "NONE", bg = vars.ui.dark },
      PmenuMatch = { bold=true },
      PmenuMatchSel = {},
      ComplMatchIns = { link = "Normal" },
      Question = { fg = vars.ui.prompt, bg = "NONE" },
      QuickFixLine = { link = "Search" },
      Search = { fg = vars.vim.search_fg, bg = vars.vim.search },
      SnippetTabstop = { link = "Visual" },
      SpecialKey = { fg = vars.vim.special, bg = "NONE", bold=true },
      SpellBad = { fg = "NONE", bg = "NONE", sp = vars.spell.bad, undercurl=true },
      SpellCap = { fg = "NONE", bg = "NONE", sp = vars.spell.cap, undercurl=true },
      SpellLocal = { fg = "NONE", bg = "NONE", sp = vars.spell.loc, undercurl=true },
      SpellRare = { fg = "NONE", bg = "NONE", sp = vars.spell.rare, undercurl=true },
      TabLine = { fg = vars.ui.fg, bg = vars.ui.bg },
      TabLineFill = { fg = vars.stl.bg, bg = vars.stl.bg },
      TabLineSel = { fg = vars.stl.fg, bg = vars.stl.bg_hi },
      TabLineSelInd = { fg = vars.stl.normal, bg = vars.stl.bg_hi }, -- Custom
      Title = { fg = vars.ui.title, bg = "NONE", bold=true },
      Visual = { fg = "NONE", bg = vars.vim.visual },
      VisualNOS = { link = "Visual" },
      WarningMsg = { fg = vars.diag.warn, bg = "NONE", bold=true },
      WildMenu = { link = "Search" },
      WinBar = { fg = "NONE", bg = vars.ui.black, bold=true },
      WinBarNC = { fg = "NONE", bg = vars.ui.black },
      -- Syntax
      Comment = { fg = vars.code.comment, bg = "NONE", italic=true },
      Constant = { fg = vars.code.literal, bg = "NONE" },
      String = { fg = vars.code.string, bg = "NONE" },
      Character = { fg = vars.code.literal, bg = "NONE" },
      Number = { fg = vars.code.literal, bg = "NONE" },
      Boolean = { fg = vars.code.literal, bg = "NONE" },
      Float = { fg = vars.code.literal, bg = "NONE" },
      Identifier = { fg = vars.code.variable, bg = "NONE" },
      Function = { fg = vars.code.func, bg = "NONE" },
      Statement = { fg = vars.code.keyword, bg = "NONE" },
      Conditional = { fg = vars.code.keyword, bg = "NONE" },
      Repeat = { fg = vars.code.keyword, bg = "NONE" },
      Label = { fg = vars.code.keyword, bg = "NONE" },
      Operator = { fg = vars.code.operator, bg = "NONE" },
      Keyword = { fg = vars.code.keyword, bg = "NONE" },
      Exception = { fg = vars.code.keyword, bg = "NONE" },
      PreProc = { fg = vars.code.keyword, bg = "NONE" },
      Include = { fg = vars.code.keyword, bg = "NONE" },
      Define = { fg = vars.code.keyword, bg = "NONE" },
      Macro = { fg = vars.code.keyword, bg = "NONE" },
      PreCondit = { fg = vars.code.keyword, bg = "NONE" },
      Type = { fg = vars.code.type, bg = "NONE" },
      StorageClass = { fg = vars.code.type, bg = "NONE" },
      Structure = { fg = vars.code.type, bg = "NONE" },
      Typedef = { fg = vars.code.type, bg = "NONE" },
      Special = { fg = vars.code.literal, bg = "NONE" },
      SpecialChar = { fg = vars.code.literal, bg = "NONE" },
      Tag = { fg = vars.code.variable, bg = "NONE" },
      Delimiter = { fg = vars.code.operator, bg = "NONE" },
      SpecialComment = { fg = vars.code.operator, bg = "NONE" },
      Debug = { fg = vars.code.variable, bg = "NONE" },
      Underlined = { fg = "NONE", bg = "NONE", underline=true },
      Ignore = { fg = vars.diag.hint, bg = "NONE", italic=true },
      Error = { fg = vars.diag.error, bg = "NONE", bold=true },
      Todo = { fg = vars.diag.ok, bg = "NONE", bold=true },
      Added = { fg = vars.diff.add, bg = "NONE" },
      Changed = { fg = vars.diff.change, bg = "NONE" },
      Removed = { fg = vars.diff.delete, bg = "NONE" },
      -- Diagnostic
      DiagnosticError = { fg = vars.diag.error, bg = "NONE" },
      DiagnosticWarn = { fg = vars.diag.warn, bg = "NONE" },
      DiagnosticInfo = { fg = vars.diag.info, bg = "NONE" },
      DiagnosticHint = { fg = vars.diag.hint, bg = "NONE" },
      DiagnosticOk = { fg = vars.diag.ok, bg = "NONE" },
      DiagnosticVirtualTextError = { fg = vars.diag.error, bg = vars.diag.error_bg },
      DiagnosticVirtualTextWarn = { fg = vars.diag.warn, bg = vars.diag.warn_bg },
      DiagnosticVirtualTextInfo = { fg = vars.diag.info, bg = vars.diag.info_bg },
      DiagnosticVirtualTextHint = { fg = vars.diag.hint, bg = vars.diag.hint_bg },
      DiagnosticVirtualTextOk = { fg = vars.diag.ok, bg = vars.diag.ok_bg },
      DiagnosticVirtualLinesError = { link = "DiagnosticVirtualTextError" },
      DiagnosticVirtualLinesWarn = { link = "DiagnosticVirtualTextWarn" },
      DiagnosticVirtualLinesInfo = { link = "DiagnosticVirtualTextInfo" },
      DiagnosticVirtualLinesHint = { link = "DiagnosticVirtualTextHint" },
      DiagnosticVirtualLinesOk = { link = "DiagnosticVirtualTextOk" },
      DiagnosticUnderlineError = { fg = "NONE", bg = "NONE", sp = vars.diag.error, undercurl=true },
      DiagnosticUnderlineWarn = { fg = "NONE", bg = "NONE", sp = vars.diag.warn, undercurl=true },
      DiagnosticUnderlineInfo = { fg = "NONE", bg = "NONE", sp = vars.diag.info, undercurl=true },
      DiagnosticUnderlineHint = { fg = "NONE", bg = "NONE", sp = vars.diag.hint, undercurl=true },
      DiagnosticUnderlineOk = { fg = "NONE", bg = "NONE", sp = vars.diag.ok, undercurl=true },
      DiagnosticFloatingError = { link = "DiagnosticError" },
      DiagnosticFloatingWarn = { link = "DiagnosticWarn" },
      DiagnosticFloatingInfo = { link = "DiagnosticInfo" },
      DiagnosticFloatingHint = { link = "DiagnosticHint" },
      DiagnosticFloatingOk = { link = "DiagnosticOk" },
      DiagnosticSignError = { link = "DiagnosticError" },
      DiagnosticSignWarn = { link = "DiagnosticWarn" },
      DiagnosticSignInfo = { link = "DiagnosticInfo" },
      DiagnosticSignHint = { link = "DiagnosticHint" },
      DiagnosticSignOk = { link = "DiagnosticOk" },
      DiagnosticDeprecated = { fg = "NONE", bg = "NONE", strikethrough=true },
      DiagnosticUnnecessary = { fg = vars.code.comment, bg = "NONE", italic=true, undercurl=true },
      -- Treesitter
      ["@variable"] = { link = "Identifier" },
      ["@variable.builtin"] = { link = "Special" },
      ["@variable.parameter"] = { link = "Identifier" },
      ["@variable.parameter.builtin"] = { link = "Special" },
      ["@variable.member"] = { link = "Identifier" },
      ["@constant"] = { link = "Constant" },
      ["@constant.builtin"] = { link = "Special" },
      ["@constant.macro"] = { link = "Special" },
      ["@module"] = { link = "Structure" },
      ["@module.builtin"] = { link = "Special" },
      ["@label"] = { link = "Label" },
      ["@string"] = { link = "String" },
      ["@string.documentation"] = { link = "String" },
      ["@string.regexp"] = { link = "String" },
      ["@string.escape"] = { link = "SpecialChar" },
      ["@string.special"] = { link = "String" },
      ["@string.special.symbol"] = { link = "SpecialChar" },
      ["@string.special.path"] = { link = "String" },
      ["@string.special.url"] = { fg = "NONE", bg = "NONE", underline=true },
      ["@character"] = { link = "String" },
      ["@character.special"] = { link = "SpecialChar" },
      ["@boolean"] = { link = "Boolean" },
      ["@number"] = { link = "Number" },
      ["@number.float"] = { link = "Float" },
      ["@type"] = { link = "Type" },
      ["@type.builtin"] = { link = "Special" },
      ["@type.definition"] = { link = "Typedef" },
      ["@attribute"] = { link = "Type" },
      ["@attribute.builtin"] = { link = "Special" },
      ["@property"] = { link = "Identifier" },
      ["@function"] = { link = "Function" },
      ["@function.builtin"] = { link = "Special" },
      ["@function.call"] = { link = "Function" },
      ["@function.macro"] = { link = "Function" },
      ["@function.method"] = { link = "Function" },
      ["@function.method.call"] = { link = "Function" },
      ["@constructor"] = { link = "Type" },
      ["@operator"] = { link = "Operator" },
      ["@keyword"] = { link = "Keyword" },
      ["@keyword.coroutine"] = { link = "Keyword" },
      ["@keyword.function"] = { link = "Keyword" },
      ["@keyword.operator"] = { link = "Keyword" },
      ["@keyword.import"] = { link = "Include" },
      ["@keyword.type"] = { link = "Keyword" },
      ["@keyword.modifier"] = { link = "Keyword" },
      ["@keyword.repeat"] = { link = "Repeat" },
      ["@keyword.return"] = { link = "Keyword" },
      ["@keyword.debug"] = { link = "Keyword" },
      ["@keyword.exception"] = { link = "Exception" },
      ["@keyword.conditional"] = { link = "Conditional" },
      ["@keyword.conditional.ternary"] = { link = "Operator" },
      ["@keyword.directive"] = { link = "PreProc" },
      ["@keyword.directive.define"] = { link = "Define" },
      ["@punctuation.delimiter"] = { link = "Operator" },
      ["@punctuation.bracket"] = { link = "Operator" },
      ["@punctuation.special"] = { link = "Operator" },
      ["@comment"] = { link = "Comment" },
      ["@comment.documentation"] = { link = "Comment" },
      ["@comment.error"] = { link = "DiagnosticError" },
      ["@comment.warning"] = { link = "DiagnosticWarn" },
      ["@comment.todo"] = { link = "Todo" },
      ["@comment.note"] = { link = "DiagnosticInfo" },
      ["@markup.strong"] = { fg = "NONE", bg = "NONE", bold=true },
      ["@markup.italic"] = { fg = "NONE", bg = "NONE", italic=true },
      ["@markup.strikethrough"] = { fg = "NONE", bg = "NONE", strikethrough=true },
      ["@markup.underline"] = { link = "Underlined" },
      ["@markup.heading"] = { link = "Title" },
      ["@markup.quote"] = { link = "String" },
      ["@markup.math"] = { link = "String" },
      ["@markup.link"] = { link = "Underlined" },
      ["@markup.link.label"] = { link = "Underlined" },
      ["@markup.link.url"] = { link = "Underlined" },
      ["@markup.link.vimdoc"] = { link = "Identifier", underline=true },
      ["@markup.raw"] = { link = "String" },
      ["@markup.raw.block"] = { link = "String" },
      ["@markup.list"] = { link = "Special" },
      ["@markup.list.checked"] = { link = "Special" },
      ["@markup.list.unchecked"] = { link = "Special" },
      ["@diff.plus"] = { link = "Added" },
      ["@diff.minus"] = { link = "Removed" },
      ["@diff.delta"] = { link = "Changed" },
      ["@tag"] = { link = "Tag" },
      ["@tag.builtin"] = { link = "Special" },
      ["@tag.attribute"] = { link = "Tag" },
      ["@tag.delimiter"] = { link = "Tag" },
      -- Treesitter Languages
      ["@attribute.gdscript"] = { link = "@attribute.builtin" }, -- All attributes in gdscript are builtin but they are not flagged as such.
      -- Statusline
      StatusLine = { fg = vars.stl.fg, bg = vars.stl.bg },
      StatusLineNC = { link = "StatusLine" },
      StatusLineTerm = { link = "StatusLine" },
      StatusLineTermNC = { link = "StatusLine" },
      Stl_Highlight = { fg = vars.stl.fg, bg = vars.stl.bg_hi },
      Stl_NormalMode = { fg = vars.stl.bg, bg = vars.stl.normal },
      Stl_VisualMode = { fg = vars.stl.bg, bg = vars.stl.visual },
      Stl_SelectMode = { fg = vars.stl.bg, bg = vars.stl.select },
      Stl_InsertMode = { fg = vars.stl.bg, bg = vars.stl.insert },
      Stl_ReplaceMode = { fg = vars.stl.bg, bg = vars.stl.replace },
      Stl_CommandMode = { fg = vars.stl.bg, bg = vars.stl.command },
      Stl_ConfirmMode = { fg = vars.stl.bg, bg = vars.stl.confirm },
      Stl_TerminalMode = { fg = vars.stl.bg, bg = vars.stl.terminal },
    },
    ibl = { -- Indent Blankline
      IblIndent = { link = "NonText" },
      IblScope = { link = "Normal" },
    },
    whichkey = { -- WhichKey
      WhichKeyNormal = { fg = vars.ui.fg, bg = vars.ui.bg_alt },
    },
    telescope = { -- Telescope
      TelescopeSelection = { fg = "NONE", bg = vars.vim.search },
      TelescopeSelectionCaret = { fg = vars.code.variable, bg = vars.vim.search },
      TelescopeMultiSelection = { link = "Special" },
      TelescopeMultiIcon = { link = "Identifier" },
      TelescopeNormal = { fg = vars.ui.light, bg = "NONE" },
      TelescopeBorder = { fg = vars.ui.sep, bg = "NONE" },
      TelescopeTitle = { fg = vars.code.literal, bg = "NONE" },
      TelescopePromptCounter = { link = "Identifier" },
      TelescopeMatching = { link = "Type" },
      TelescopePromptPrefix = { link = "Function" },
      TelescopePreviewLine = { link = "Visual" },
      TelescopePreviewMatch = { link = "Search" },
    },
  }
end

local background_hls = {
  default = {
    "Normal",
    "NormalFloat",
    "Folded",
    "Pmenu",
    "WinBar",
    "WinBarNC",
    "StatusLine",
    "StatusLineNC",
    "StatusLineTerm",
    "StatusLineTermNC",
  },
  whichkey = {
    "WhichKeyNormal",
  },
  telescope = {
    "TelescopeNormal",
    "TelescopePreviewNormal",
    "TelescopePromptNormal",
    "TelescopeResultsNormal",
  },
}

local sep_hls = {
  default = {
    "FloatBorder",
    "WinSeparator",
  },
  telescope = {
    "TelescopeBorder",
    "TelescopePromptBorder",
    "TelescopeResultsBorder",
    "TelescopePreviewBorder",
  },
}

M.load_theme = function()
  -- Load Theme File
  local s, theme = pcall(require, "themes." .. vim.g.theme)
  if not s then
    vim.notify("failed to load theme file: '"  .. vim.g.theme .. "'", vim.log.levels.ERROR)
    return false
  end

  -- Clear Theme Settings
  vim.cmd("hi clear")
  vim.cmd("colo default")
  vim.o.background = "dark"
  if vim.fn.exists("syntax_on") then vim.cmd("syntax reset") end
  vim.o.termguicolors = true

  -- Load Highlights
  local vars = theme.get_vars()
  local highlights = create_highlights(vars) -- Load from theme vars.
  highlights = vim.tbl_deep_extend("force", highlights, theme.get_highlights()) -- Extend with theme overrides.

  -- Handle Transparency
  if vim.g.transparent then
    for k, v in pairs(background_hls) do -- Remove background from background hls.
      if highlights[k] then
        for _, hl in ipairs(v) do
          if highlights[k][hl] then
            highlights[k][hl].bg = "NONE"
          end
        end
      end
    end
    for k, v in pairs(sep_hls) do -- Set separator hls such that they definitely display a border.
      if not highlights[k] then highlights[k] = {} end
      for _, hl in ipairs(v) do
        if highlights[k][hl] then
          highlights[k][hl].fg = vars.ui.sep
          highlights[k][hl].bg = "NONE"
        else highlights[k][hl] = { fg = vars.ui.sep, bg = "NONE" } end
      end
    end
  end

  -- Seperate default from other highlights.
  local default = highlights.default
  highlights.default = nil

  -- Populate Cache
  local loaded = {}
  local cache = vim.g.theme_cache
  if vim.g.theme_cache then -- Clear cache or initialise as empty.
    for k, v in pairs(cache) do
      if v ~= true then cache[k] = nil
      else table.insert(loaded, k) end
    end
  else cache = {} end
  for k, v in pairs(highlights) do -- Copy plugin highlights to cache if not loaded.
    if cache[k] ~= true then cache[k] = v end
  end
  vim.g.theme_cache = cache

  -- Load Highlights
  for k, v in pairs(default) do vim.api.nvim_set_hl(0, k, v) end -- Always load default.
  for _, n in ipairs(loaded) do -- Only load highlights from plugins that have already been loaded.
    for k, v in pairs(highlights[n]) do
      vim.api.nvim_set_hl(0, k, v)
    end
  end

  -- In case themes need to do more.
  theme.config()

  return true
end

M.load_plugin_hls = function(name)
  local cache = vim.g.theme_cache
  if cache and cache[name] and cache[name] ~= true then
    for k, v in pairs(cache[name]) do vim.api.nvim_set_hl(0, k, v) end
    cache[name] = true
    vim.g.theme_cache = cache
  end
end

M.save_theme_file = function()
  local res = require("scripts.fileio").save_file(vim.g.theme_file, { name = vim.g.theme, tr = vim.g.transparent })
  if not res then vim.notify("failed to save theme to file", vim.log.levels.ERROR)
  else vim.notify("saved theme to file", vim.log.levels.INFO) end
end

M.load_theme_file = function()
  local conf = require("scripts.fileio").load_file(vim.g.theme_file)
  if conf == nil then vim.notify("failed to load theme from file", vim.log.levels.ERROR)
  else
    vim.g.theme = conf.name
    vim.g.transparent = conf.tr
    M.load_theme()
  end
end

M.set_theme = function(name)
  local prev = vim.g.theme
  vim.g.theme = name
  if M.load_theme() then
    vim.schedule(function() vim.notify("set theme to '" .. name .. "'", vim.log.levels.INFO) end)
  else vim.g.theme = prev end
end

M.toggle_transparency = function()
  local tr = vim.g.transparent
  vim.g.transparent = not tr
  if M.load_theme() then
    vim.schedule(function() vim.notify("toggled transparency", vim.log.levels.INFO) end)
  else vim.g.transparent = tr end
end

return M
