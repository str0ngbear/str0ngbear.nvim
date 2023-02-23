local c = require('str0ngbear.colors')
local cfg = vim.g.str0ngbear_config
local util = require("str0ngbear.util")

local M = {}
local hl = {langs = {}, plugins = {}}

local function vim_highlights(highlights)
    for group_name, group_settings in pairs(highlights) do
        vim.api.nvim_command(string.format("highlight %s guifg=%s guibg=%s guisp=%s gui=%s", group_name,
            group_settings.fg or "none",
            group_settings.bg or "none",
            group_settings.sp or "none",
            group_settings.fmt or "none"))
    end
end

local colors = {
    Fg = {fg = c.fg},
    LightGrey = {fg = c.light_grey},
    Grey = {fg = c.grey},
    cerise = {fg = c.cerise},
    sunny = {fg = c.sunny},
    gold = {fg = c.gold},
    lime = {fg = c.lime},
    frost = {fg = c.frost},
    lilac = {fg = c.lilac},
    pink = {fg = c.pink},
}
hl.common = {
    Normal = {fg = c.text, bg = cfg.transparent and c.none or c.text_bg},
    Terminal = {fg = c.text, bg = cfg.transparent and c.none or c.text_bg},
    EndOfBuffer = {fg = cfg.ending_tildes and c.bg2 or c.bg0, bg = cfg.transparent and c.none or c.bg0},
    FoldColumn = {fg = c.fg, bg = cfg.transparent and c.none or c.bg1},
    Folded = {fg = c.fg, bg = cfg.transparent and c.none or c.bg1},
    SignColumn = {fg = c.fg, bg = cfg.transparent and c.none or c.bg0},
    ToolbarLine = {fg = c.fg},
    Cursor = {fmt = "reverse"},
    vCursor = {fmt = "reverse"},
    iCursor = {fmt = "reverse"},
    lCursor = {fmt = "reverse"},
    CursorIM = {fmt = "reverse"},
    CursorColumn = {bg = c.bg1},
    CursorLine = {bg = c.bg1},
    ColorColumn = {bg = c.bg1},
    CursorLineNr = {fg = c.fg},
    LineNr = {fg = c.grey},
    Conceal = {fg = c.grey, bg = c.bg1},
    DiffAdd = {fg = c.none, bg = c.diff_add},
    DiffChange = {fg = c.none, bg = c.diff_change},
    DiffDelete = {fg = c.none, bg = c.diff_delete},
    DiffText = {fg = c.none, bg= c.diff_text},
    DiffAdded = c.moss,
    DiffRemoved = c.auburn,
    DiffFile = c.frost,
    DiffIndexLine = c.grey,
    Directory = {fg = c.frost },
    ErrorMsg = {fg = c.cerise, fmt = "bold"},
    WarningMsg = {fg = c.sunny, fmt = "bold"},
    MoreMsg = {fg = c.frost, fmt = "bold"},
    IncSearch = {fg = c.bg0, bg = c.gold},
    Search = {fg = c.bg0, bg = c.sunny},
    Substitute = {fg = c.bg0, bg = c.lime},
    MatchParen = {fg = c.none, bg = c.grey},
    NonText = {fg = c.grey},
    Whitespace = {fg = c.grey},
    SpecialKey = {fg = c.grey},
    Pmenu = {fg = c.fg, bg = c.bg1},
    PmenuSbar = {fg = c.none, bg = c.bg1},
    PmenuSel = {fg = c.bg0, bg = c.frost},
    WildMenu = {fg = c.bg0, bg = c.frost},
    PmenuThumb = {fg = c.none, bg = c.grey},
    Question = {fg = c.sunny},
    SpellBad = {fg = c.cerise, fmt = "underline", sp = c.cerise},
    SpellCap = {fg = c.sunny, fmt = "underline", sp = c.sunny},
    SpellLocal = {fg = c.frost, fmt = "underline", sp = c.frost},
    SpellRare = {fg = c.lilac, fmt = "underline", sp = c.lilac},
    StatusLine = {fg = c.fg, bg = c.bg2},
    StatusLineTerm = {fg = c.fg, bg = c.bg2},
    StatusLineNC = {fg = c.grey, bg = c.bg1},
    StatusLineTermNC = {fg = c.grey, bg = c.bg1},
    TabLine = {fg = c.fg, bg = c.bg1},
    TabLineFill = {fg = c.grey, bg = c.bg1},
    TabLineSel =  {fg = c.bg0, bg = c.fg},
    VertSplit = {fg = c.bg3},
    Visual = {bg = c.bg3},
    VisualNOS = {fg = c.none, bg = c.bg2, fmt = "underline"},
    QuickFixLine = {fg = c.frost, fmt = "underline"},
    Debug = {fg = c.sunny},
    debugPC = {fg = c.bg0, bg = c.lime},
    debugBreakpoint = {fg = c.bg0, bg = c.cerise},
    ToolbarButton = {fg = c.bg0, bg = c.frost},
    FloatBorder = {fg = c.grey, bg = c.bg1},
    NormalFloat = {fg = c.fg, bg = c.bg1},
}

hl.syntax = {
    String = {fg = c.text_fg, fmt = cfg.code_style.strings},
    Character = colors.gold,
    Number = colors.gold,
    Float = colors.gold,
    Boolean = colors.gold,
    Type = colors.sunny,
    Structure = colors.sunny,
    StorageClass = colors.sunny,
    Identifier = {fg = c.cerise, fmt = cfg.code_style.variables},
    Constant = colors.moss,
    PreProc = colors.lilac,
    PreCondit = colors.lilac,
    Include = colors.lilac,
    Keyword = {fg = c.lilac, fmt = cfg.code_style.keywords},
    Define = colors.lilac,
    Typedef = colors.lilac,
    Exception = colors.lilac,
    Conditional = {fg = c.lilac, fmt = cfg.code_style.keywords},
    Repeat = {fg = c.lilac, fmt = cfg.code_style.keywords},
    Statement = colors.lilac,
    Macro = colors.cerise,
    Error = colors.lilac,
    Label = colors.lilac,
    Special = colors.cerise,
    SpecialChar = colors.cerise,
    Function = {fg = c.frost, fmt = cfg.code_style.functions},
    Operator = colors.lilac,
    Title = colors.moss,
    Tag = colors.pink,
    Delimiter = colors.LightGrey,
    Comment = {fg = c.grey, fmt = cfg.code_style.comments},
    SpecialComment = {fg = c.grey, fmt = cfg.code_style.comments},
    Todo = {fg = c.cerise, fmt = cfg.code_style.comments}
}

if vim.api.nvim_call_function("has", { "nvim-0.8" }) == 1 then
    hl.treesitter = {
        ["@annotation"] = colors.Fg,
        ["@attribute"] = colors.lime,
        ["@boolean"] = colors.gold,
        ["@character"] = colors.gold,
        ["@comment"] = {fg = c.grey, fmt = cfg.code_style.comments},
        ["@conditional"] = {fg = c.lilac, fmt = cfg.code_style.keywords},
        ["@constant"] = colors.gold,
        ["@constant.builtin"] = colors.gold,
        ["@constant.macro"] = colors.gold,
        ["@constructor"] = {fg = c.sunny, fmt = "bold"},
        ["@error"] = colors.Fg,
        ["@exception"] = colors.lilac,
        ["@field"] = colors.pink,
        ["@float"] = colors.gold,
        ["@function"] = {fg = c.frost, fmt = cfg.code_style.functions},
        ["@function.builtin"] = {fg = c.lime, fmt = cfg.code_style.functions},
        ["@function.macro"] = {fg = c.lime, fmt = cfg.code_style.functions},
        ["@include"] = colors.lilac,
        ["@keyword"] = {fg = c.lilac, fmt = cfg.code_style.keywords},
        ["@keyword.function"] = {fg = c.lime, fmt = cfg.code_style.functions},
        ["@keyword.operator"] =  {fg = c.lilac, fmt = cfg.code_style.keywords},
        ["@label"] = colors.cerise,
        ["@method"] = colors.frost,
        ["@namespace"] = colors.sunny,
        ["@none"] = colors.Fg,
        ["@number"] = colors.gold,
        ["@operator"] = colors.Fg,
        ["@parameter"] = colors.lime,
        ["@parameter.reference"] = colors.Fg,
        ["@property"] = colors.pink,
        ["@punctuation.delimiter"] = colors.LightGrey,
        ["@punctuation.bracket"] = colors.LightGrey,
        ["@punctuation.special"] = colors.cerise,
        ["@repeat"] = {fg = c.lilac, fmt = cfg.code_style.keywords},
        ["@string"] = {fg = c.text_fg, fmt = cfg.code_style.strings},
        ["@string.regex"] = {fg = c.gold, fmt = cfg.code_style.strings},
        ["@string.escape"] = {fg = c.cerise, fmt = cfg.code_style.strings},
        ["@symbol"] = colors.pink,
        ["@tag"] = colors.lilac,
        ["@tag.attribute"] = colors.sunny,
        ["@tag.delimiter"] = colors.lilac,
        ["@text"] = colors.Fg,
        ["@text.strong"] = {fg = c.fg, fmt = 'bold'},
        ["@text.emphasis"] = {fg = c.fg, fmt = 'italic'},
        ["@text.underline"] = {fg = c.fg, fmt = 'underline'},
        ["@text.strike"] = {fg = c.fg, fmt = 'strikethrough'},
        ["@text.title"] = {fg = c.gold, fmt = 'bold'},
        ["@text.literal"] = colors.pink,
        ["@text.uri"] = {fg = c.pink, fmt = 'underline'},
        ["@text.todo"] = {fg = c.cerise, fmt = cfg.code_style.comments},
        ["@text.math"] = colors.Fg,
        ["@text.reference"] = colors.frost,
        ["@text.environment"] = colors.Fg,
        ["@text.environment.name"] = colors.Fg,
        ["@text.diff.add"] = colors.lime,
        ["@text.diff.delete"] = colors.cerise,
        ["@note"] = colors.Fg,
        ["@warning"] = colors.Fg,
        ["@danger"] = colors.Fg,
        ["@type"] = colors.sunny,
        ["@type.builtin"] = colors.gold,
        ["@variable"] = {fg = c.fg, fmt = cfg.code_style.variables},
        ["@variable.builtin"] = {fg = c.cerise, fmt = cfg.code_style.variables},
    }
else
    hl.treesitter = {
        TSAnnotation = colors.Fg,
        TSAttribute = colors.lime,
        TSBoolean = colors.gold,
        TSCharacter = colors.gold,
        TSComment = {fg = c.grey, fmt = cfg.code_style.comments},
        TSConditional = {fg = c.lilac, fmt = cfg.code_style.keywords},
        TSConstant = colors.gold,
        TSConstBuiltin = colors.gold,
        TSConstMacro = colors.gold,
        TSConstructor = {fg = c.sunny, fmt = "bold"},
        TSError = colors.Fg,
        TSException = colors.lilac,
        TSField = colors.pink,
        TSFloat = colors.gold,
        TSFunction = {fg = c.frost, fmt = cfg.code_style.functions},
        TSFuncBuiltin = {fg = c.lime, fmt = cfg.code_style.functions},
        TSFuncMacro = {fg = c.lime, fmt = cfg.code_style.functions},
        TSInclude = colors.lilac,
        TSKeyword = {fg = c.lilac, fmt = cfg.code_style.keywords},
        TSKeywordFunction = {fg = c.lilac, fmt = cfg.code_style.functions},
        TSKeywordOperator =  {fg = c.lilac, fmt = cfg.code_style.keywords},
        TSLabel = colors.cerise,
        TSMethod = colors.frost,
        TSNamespace = colors.sunny,
        TSNone = colors.Fg,
        TSNumber = colors.gold,
        TSOperator = colors.Fg,
        TSParameter = colors.lime,
        TSParameterReference = colors.Fg,
        TSProperty = colors.pink,
        TSPunctDelimiter = colors.LightGrey,
        TSPunctBracket = colors.LightGrey,
        TSPunctSpecial = colors.cerise,
        TSRepeat = {fg = c.lilac, fmt = cfg.code_style.keywords},
        TSString = {fg = c.pink, fmt = cfg.code_style.strings},
        TSStringRegex = {fg = c.gold, fmt = cfg.code_style.strings},
        TSStringEscape = {fg = c.cerise, fmt = cfg.code_style.strings},
        TSSymbol = colors.pink,
        TSTag = colors.lilac,
        TSTagDelimiter = colors.lilac,
        TSText = colors.Fg,
        TSStrong = {fg = c.fg, fmt = 'bold'},
        TSEmphasis = {fg = c.fg, fmt = 'italic'},
        TSUnderline = {fg = c.fg, fmt = 'underline'},
        TSStrike = {fg = c.fg, fmt = 'strikethrough'},
        TSTitle = {fg = c.gold, fmt = 'bold'},
        TSLiteral = colors.pink,
        TSURI = {fg = c.lime, fmt = 'underline'},
        TSMath = colors.Fg,
        TSTextReference = colors.frost,
        TSEnviroment = colors.Fg,
        TSEnviromentName = colors.Fg,
        TSNote = colors.Fg,
        TSWarning = colors.Fg,
        TSDanger = colors.Fg,
        TSType = colors.sunny,
        TSTypeBuiltin = colors.gold,
        TSVariable = {fg = c.fg, fmt = cfg.code_style.variables},
        TSVariableBuiltin = {fg = c.cerise, fmt = cfg.code_style.variables},
    }
end

local diagnostics_error_color = cfg.diagnostics.darker and c.dark_cerise or c.cerise
local diagnostics_hint_color = cfg.diagnostics.darker and c.dark_lilac or c.lilac
local diagnostics_warn_color = cfg.diagnostics.darker and c.dark_sunny or c.sunny
local diagnostics_info_color = cfg.diagnostics.darker and c.moss or c.lime
hl.plugins.lsp = {
    LspCxxHlGroupEnumConstant = colors.gold,
    LspCxxHlGroupMemberVariable = colors.gold,
    LspCxxHlGroupNamespace = colors.frost,
    LspCxxHlSkippedRegion = colors.Grey,
    LspCxxHlSkippedRegionBeginEnd = colors.cerise,

    DiagnosticError = {fg = c.cerise},
    DiagnosticHint = {fg = c.lilac},
    DiagnosticInfo = {fg = c.lime},
    DiagnosticWarn = {fg = c.sunny},

    DiagnosticVirtualTextError = { bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, c.bg0) or c.none,
                                   fg = diagnostics_error_color },
    DiagnosticVirtualTextWarn = { bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, c.bg0) or c.none,
                                  fg = diagnostics_warn_color },
    DiagnosticVirtualTextInfo = { bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, c.bg0) or c.none,
                                  fg = diagnostics_info_color },
    DiagnosticVirtualTextHint = { bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, c.bg0) or c.none,
                                  fg = diagnostics_hint_color },

    DiagnosticUnderlineError = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.cerise},
    DiagnosticUnderlineHint = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.lilac},
    DiagnosticUnderlineInfo = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.frost},
    DiagnosticUnderlineWarn = {fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.sunny},

    LspReferenceText = { bg = c.bg2 },
    LspReferenceWrite = { bg = c.bg2 },
    LspReferenceRead = { bg = c.bg2 },

    LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
    LspCodeLensSeparator = { fg = c.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
    ALEErrorSign = hl.plugins.lsp.DiagnosticError,
    ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
    ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
    BufferCurrent = { fmt = "bold" },
    BufferCurrentMod = { fg = c.gold, fmt = "bold,italic" },
    BufferCurrentSign = { fg = c.lilac },
    BufferInactiveMod = { fg = c.light_grey, bg = c.bg1, fmt = "italic" },
    BufferVisible = { fg = c.light_grey, bg = c.bg0 },
    BufferVisibleMod = { fg = c.sunny, bg = c.bg0, fmt = "italic" },
    BufferVisibleIndex = { fg = c.light_grey, bg = c.bg0 },
    BufferVisibleSign = { fg = c.light_grey, bg = c.bg0 },
    BufferVisibleTarget = { fg = c.light_grey, bg = c.bg0 },
}

hl.plugins.cmp = {
    CmpItemAbbr = colors.Fg,
    CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = "strikethrough" },
    CmpItemAbbrMatch = colors.lime,
    CmpItemAbbrMatchFuzzy = { fg = c.lime, fmt = "underline" },
    CmpItemMenu = colors.LightGrey,
    CmpItemKind = { fg = c.lilac, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
    CocErrorSign = hl.plugins.lsp.DiagnosticError,
    CocHintSign = hl.plugins.lsp.DiagnosticHint,
    CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
    CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
    WhichKey = colors.cerise,
    WhichKeyDesc = colors.frost,
    WhichKeyGroup = colors.gold,
    WhichKeySeperator = colors.lime
}

hl.plugins.gitgutter = {
    GitGutterAdd = {fg = c.lime},
    GitGutterChange = {fg = c.frost},
    GitGutterDelete = {fg = c.cerise},
}

hl.plugins.hop = {
    HopNextKey = {fg = c.cerise, fmt = "bold"},
    HopNextKey1 = {fg = c.lime, fmt = "bold"},
    HopNextKey2 = {fg = util.darken(c.frost, 0.7)},
    HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
    DiffviewFilePanelTitle = {fg = c.frost, fmt = "bold"},
    DiffviewFilePanelCounter = {fg = c.lilac, fmt = "bold"},
    DiffviewFilePanelFileName = colors.Fg,
    DiffviewNormal = hl.common.Normal,
    DiffviewCursorLine = hl.common.CursorLine,
    DiffviewVertSplit = hl.common.VertSplit,
    DiffviewSignColumn = hl.common.SignColumn,
    DiffviewStatusLine = hl.common.StatusLine,
    DiffviewStatusLineNC = hl.common.StatusLineNC,
    DiffviewEndOfBuffer = hl.common.EndOfBuffer,
    DiffviewFilePanelRootPath = colors.Grey,
    DiffviewFilePanelPath = colors.Grey,
    DiffviewFilePanelInsertions = colors.lime,
    DiffviewFilePanelDeletions = colors.cerise,
    DiffviewStatusAdded = colors.lime,
    DiffviewStatusUntracked = colors.frost,
    DiffviewStatusModified = colors.frost,
    DiffviewStatusRenamed = colors.frost,
    DiffviewStatusCopied = colors.frost,
    DiffviewStatusTypeChange = colors.frost,
    DiffviewStatusUnmerged = colors.frost,
    DiffviewStatusUnknown = colors.cerise,
    DiffviewStatusDeleted = colors.cerise,
    DiffviewStatusBroken = colors.cerise
}

hl.plugins.gitsigns = {
    GitSignsAdd = colors.lime,
    GitSignsAddLn = colors.lime,
    GitSignsAddNr = colors.lime,
    GitSignsChange = colors.frost,
    GitSignsChangeLn = colors.frost,
    GitSignsChangeNr = colors.frost,
    GitSignsDelete = colors.cerise,
    GitSignsDeleteLn = colors.cerise,
    GitSignsDeleteNr = colors.cerise
}

hl.plugins.neo_tree = {
    NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
    NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
    NeoTreeVertSplit = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
    NeoTreeWinSeparator = { fg = c.bg1, bg = cfg.transparent and c.none or c.bg1 },
    NeoTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
    NeoTreeRootName = { fg = c.gold, fmt = "bold" },
    NeoTreeGitAdded = colors.lime,
    NeoTreeGitDeleted = colors.cerise,
    NeoTreeGitModified = colors.sunny,
    NeoTreeGitConflict = { fg = c.cerise, fmt = "bold,italic" },
    NeoTreeGitUntracked = { fg = c.cerise, fmt = "italic" },
    NeoTreeIndentMarker = colors.Grey,
    NeoTreeSymbolicLinkTarget = colors.lilac,
}

hl.plugins.neotest = {
    NeotestAdapterName = { fg = c.lilac, fmt = "bold" },
    NeotestDir = colors.lime,
    NeotestExpandMarker = colors.Grey,
    NeotestFailed = colors.cerise,
    NeotestFile = colors.lime,
    NeotestFocused = { fmt = "bold,italic" },
    NeotestIndent = colors.Grey,
    NeotestMarked = { fg = c.gold, fmt = "bold" },
    NeotestNamespace = colors.frost,
    NeotestPassed = colors.lime,
    NeotestRunning = colors.sunny,
    NeotestWinSelect = { fg = c.lime, fmt = "bold" },
    NeotestSkipped = colors.LightGrey,
    NeotestTarget = colors.lilac,
    NeotestTest = colors.Fg,
    NeotestUnknown = colors.LightGrey,
}

hl.plugins.nvim_tree = {
    NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
    NvimTreeVertSplit = { fg = c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
    NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg_d, bg = cfg.transparent and c.none or c.bg_d },
    NvimTreeRootFolder = { fg = c.gold, fmt = "bold" },
    NvimTreeGitDirty = colors.sunny,
    NvimTreeGitNew = colors.lime,
    NvimTreeGitDeleted = colors.cerise,
    NvimTreeSpecialFile = { fg = c.sunny, fmt = "underline" },
    NvimTreeIndentMarker = colors.Fg,
    NvimTreeImageFile = { fg = c.dark_lilac },
    NvimTreeSymlink = colors.lilac,
    NvimTreeFolderName = colors.frost,
}
hl.plugins.telescope = {
    TelescopeBorder = colors.cerise,
    TelescopePromptBorder = colors.lime,
    TelescopeResultsBorder = colors.lime,
    TelescopePreviewBorder = colors.lime,
    TelescopeMatching = { fg = c.gold, fmt = "bold" },
    TelescopePromptPrefix = colors.lime,
    TelescopeSelection =  { bg =c.bg2 },
    TelescopeSelectionCaret = colors.sunny
}

hl.plugins.dashboard = {
    DashboardShortCut = colors.frost,
    DashboardHeader = colors.sunny,
    DashboardCenter = colors.lime,
    DashboardFooter = { fg = c.dark_cerise, fmt = "italic"}
}

hl.plugins.outline = {
    FocusedSymbol = { fg = c.lilac, bg = c.bg2, fmt = "bold" },
    AerialLine = { fg = c.lilac, bg = c.bg2, fmt = "bold" },
}

hl.plugins.navic = {
    NavicText = { fg = c.fg },
    NavicSeparator = { fg = c.light_grey },
}

hl.plugins.ts_rainbow = {
    rainbowcol1 = colors.Grey,
    rainbowcol2 = colors.sunny,
    rainbowcol3 = colors.frost,
    rainbowcol4 = colors.gold,
    rainbowcol5 = colors.lilac,
    rainbowcol6 = colors.lime,
    rainbowcol7 = colors.cerise
}

hl.plugins.indent_blankline = {
    IndentBlanklineIndent1 = colors.frost,
    IndentBlanklineIndent2 = colors.lime,
    IndentBlanklineIndent3 = colors.pink,
    IndentBlanklineIndent4 = colors.light_grey,
    IndentBlanklineIndent5 = colors.lilac,
    IndentBlanklineIndent6 = colors.cerise,
    IndentBlanklineChar = { fg = c.bg1, gui = "nocombine" },
    IndentBlanklineContext = { fg = c.gold, bg = c.bg3, bold = true },
    IndentBlanklineContextChar = { fg = c.bg1, gui = "nocombine" },
    IndentBlanklineContextStart = { sp = c.bg1, gui = "underline" },
    IndentBlanklineContextSpaceChar = { gui = "nocombine" },
}

hl.plugins.mini = {
    MiniCompletionActiveParameter = { fmt = "underline" },

    MiniCursorword = { fmt = "underline" },
    MiniCursorwordCurrent = { fmt = "underline" },

    MiniIndentscopeSymbol = { fg = c.grey },
    MiniIndentscopePrefix = { fmt = "nocombine" }, -- Make it invisible

    MiniJump = { fg = c.lilac, fmt = "underline", sp = c.lilac },

    MiniJump2dSpot = { fg = c.cerise, fmt = "bold,nocombine" },

    MiniStarterCurrent = { fmt = "nocombine" },
    MiniStarterFooter = { fg = c.dark_cerise, fmt = "italic" },
    MiniStarterHeader = colors.sunny,
    MiniStarterInactive = { fg = c.grey, fmt = cfg.code_style.comments },
    MiniStarterItem = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
    MiniStarterItemBullet = { fg = c.grey },
    MiniStarterItemPrefix = { fg = c.sunny },
    MiniStarterSection = colors.LightGrey,
    MiniStarterQuery = { fg = c.lime },

    MiniStatuslineDevinfo = { fg = c.fg, bg = c.bg2 },
    MiniStatuslineFileinfo = { fg = c.fg, bg = c.bg2 },
    MiniStatuslineFilename = { fg = c.grey, bg = c.bg1 },
    MiniStatuslineInactive = { fg = c.grey, bg = c.bg0 },
    MiniStatuslineModeCommand = { fg = c.bg0, bg = c.sunny, fmt = "bold" },
    MiniStatuslineModeInsert = { fg = c.bg0, bg = c.frost, fmt = "bold" },
    MiniStatuslineModeNormal = { fg = c.bg0, bg = c.lime, fmt = "bold" },
    MiniStatuslineModeOther = { fg = c.bg0, bg = c.lime, fmt = "bold" },
    MiniStatuslineModeReplace = { fg = c.bg0, bg = c.cerise, fmt = "bold" },
    MiniStatuslineModeVisual = { fg = c.bg0, bg = c.lilac, fmt = "bold" },

    MiniSurround = { fg = c.bg0, bg = c.gold },

    MiniTablineCurrent = { fmt = "bold" },
    MiniTablineFill = { fg = c.grey, bg = c.bg1 },
    MiniTablineHidden = { fg = c.fg, bg = c.bg1 },
    MiniTablineModifiedCurrent = { fg = c.gold, fmt = "bold,italic" },
    MiniTablineModifiedHidden = { fg = c.light_grey, bg = c.bg1, fmt = "italic" },
    MiniTablineModifiedVisible = { fg = c.sunny, bg = c.bg0, fmt = "italic" },
    MiniTablineTabpagesection = { fg = c.bg0, bg = c.sunny },
    MiniTablineVisible = { fg = c.light_grey, bg = c.bg0 },

    MiniTestEmphasis = { fmt = "bold" },
    MiniTestFail = { fg = c.cerise, fmt = "bold" },
    MiniTestPass = { fg = c.lime, fmt = "bold" },

    MiniTrailspace = { bg = c.cerise },
}

hl.langs.c = {
    cInclude = colors.frost,
    cStorageClass = colors.lilac,
    cTypedef = colors.lilac,
    cDefine = colors.pink,
    cTSInclude = colors.frost,
    cTSConstant = colors.lime,
    cTSConstMacro = colors.lilac,
    cTSOperator = colors.lilac,
}

hl.langs.cpp = {
    cppStatement = { fg = c.lilac, fmt = "bold" },
    cppTSInclude = colors.frost,
    cppTSConstant = colors.lime,
    cppTSConstMacro = colors.lilac,
    cppTSOperator = colors.lilac,
}

hl.langs.markdown = {
    markdownBlockquote = colors.Grey,
    markdownBold = {fg = c.none, fmt = "bold"},
    markdownBoldDelimiter = colors.Grey,
    markdownCode = colors.lime,
    markdownCodeBlock = colors.lime,
    markdownCodeDelimiter = colors.sunny,
    markdownH1 = {fg = c.cerise, fmt = "bold"},
    markdownH2 = {fg = c.lilac, fmt = "bold"},
    markdownH3 = {fg = c.gold, fmt = "bold"},
    markdownH4 = {fg = c.cerise, fmt = "bold"},
    markdownH5 = {fg = c.lilac, fmt = "bold"},
    markdownH6 = {fg = c.gold, fmt = "bold"},
    markdownHeadingDelimiter = colors.Grey,
    markdownHeadingRule = colors.Grey,
    markdownId = colors.sunny,
    markdownIdDeclaration = colors.cerise,
    markdownItalic = {fg = c.none, fmt = "italic"},
    markdownItalicDelimiter = {fg = c.grey, fmt = "italic"},
    markdownLinkDelimiter = colors.Grey,
    markdownLinkText = colors.cerise,
    markdownLinkTextDelimiter = colors.Grey,
    markdownListMarker = colors.cerise,
    markdownOrdeceriseListMarker = colors.cerise,
    markdownRule = colors.lilac,
    markdownUrl = {fg = c.frost, fmt = "underline"},
    markdownUrlDelimiter = colors.Grey,
    markdownUrlTitleDelimiter = colors.lime
}

hl.langs.php = {
    phpFunctions = {fg = c.fg, fmt = cfg.code_style.functions},
    phpMethods = colors.lime,
    phpStructure = colors.lilac,
    phpOperator = colors.lilac,
    phpMemberSelector = colors.Fg,
    phpVarSelector = {fg = c.gold, fmt = cfg.code_style.variables},
    phpIdentifier = {fg = c.gold, fmt = cfg.code_style.variables},
    phpBoolean = colors.lime,
    phpNumber = colors.gold,
    phpHeceriseoc = colors.lime,
    phpNowDoc = colors.lime,
    phpSCKeyword = {fg = c.lilac, fmt = cfg.code_style.keywords},
    phpFCKeyword = {fg = c.lilac, fmt = cfg.code_style.keywords},
    phpRegion = colors.frost
}

hl.langs.scala = {
    scalaNameDefinition = colors.Fg,
    scalaInterpolationBoundary = colors.lilac,
    scalaInterpolation = colors.lilac,
    scalaTypeOperator = colors.cerise,
    scalaOperator = colors.cerise,
    scalaKeywordModifier = {fg = c.cerise, fmt = cfg.code_style.keywords},
}

hl.langs.tex = {
    latexTSInclude = colors.frost,
    latexTSFuncMacro = {fg = c.fg, fmt = cfg.code_style.functions},
    latexTSEnvironment = { fg = c.pink, fmt = "bold" },
    latexTSEnvironmentName = colors.sunny,
    texCmdEnv = colors.lime,
    texEnvArgName = colors.sunny,
    latexTSTitle = colors.lime,
    latexTSType = colors.frost,
    latexTSMath   = colors.gold,
    texMathZoneX  = colors.gold,
    texMathZoneXX = colors.gold,
    texMathDelimZone = colors.LightGrey,
    texMathDelim = colors.lilac,
    texMathOper = colors.cerise,
    texCmd = colors.lilac,
    texCmdPart = colors.frost,
    texCmdPackage = colors.frost,
    texPgfType = colors.sunny,
}

hl.langs.vim = {
    vimOption = colors.cerise,
    vimSetEqual = colors.sunny,
    vimMap = colors.lilac,
    vimMapModKey = colors.gold,
    vimNotation = colors.cerise,
    vimMapLhs = colors.Fg,
    vimMapRhs = colors.frost,
    vimVar = {fg = c.fg, fmt = cfg.code_style.variables},
    vimCommentTitle = {fg = c.light_grey, fmt = cfg.code_style.comments},
}

local lsp_kind_icons_color = {
    Default = c.lilac,
    Array = c.sunny,
    Boolean = c.gold,
    Class = c.sunny,
    Color = c.pink,
    Constant = c.gold,
    Constructor = c.frost,
    Enum = c.lilac,
    EnumMember = c.sunny,
    Event = c.sunny,
    Field = c.lilac,
    File = c.frost,
    Folder = c.gold,
    Function = c.frost,
    Interface = c.lime,
    Key = c.lime,
    Keyword = c.lime,
    Method = c.frost,
    Module = c.gold,
    Namespace = c.cerise,
    Null = c.grey,
    Number = c.gold,
    Object = c.cerise,
    Operator = c.cerise,
    Package = c.sunny,
    Property = c.lime,
    Reference = c.gold,
    Snippet = c.cerise,
    String = c.pink,
    Struct = c.lilac,
    Text = c.light_grey,
    TypeParameter = c.cerise,
    Unit = c.lime,
    Value = c.gold,
    Variable = c.lilac,
}

function M.setup()
    -- define cmp and aerial kind highlights with lsp_kind_icons_color
    for kind, color in pairs(lsp_kind_icons_color) do
        hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
        hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
        hl.plugins.navic["NavicIcons" .. kind] = { fg = color }
    end

    vim_highlights(hl.common)
    vim_highlights(hl.syntax)
    vim_highlights(hl.treesitter)
    for _, group in pairs(hl.langs) do vim_highlights(group) end
    for _, group in pairs(hl.plugins) do vim_highlights(group) end

    -- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
    local function replace_color(prefix, color_name)
        if not color_name then return "" end
        if color_name:sub(1, 1) == '$' then
            local name = color_name:sub(2, -1)
            color_name = c[name]
            if not color_name then
                vim.schedule(function()
                    vim.notify('str0ngbear.nvim: unknown color "' .. name .. '"', vim.log.levels.ERROR, { title = "onedark.nvim" })
                end)
                return ""
            end
        end
        return prefix .. "=" .. color_name
    end

    for group_name, group_settings in pairs(vim.g.str0ngbear_config.highlights) do
        vim.api.nvim_command(string.format("highlight %s %s %s %s %s", group_name,
            replace_color("guifg", group_settings.fg),
            replace_color("guibg", group_settings.bg),
            replace_color("guisp", group_settings.sp),
            replace_color("gui", group_settings.fmt)))
    end
end

return M
