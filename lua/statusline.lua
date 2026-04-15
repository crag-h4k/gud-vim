local M = {}

local function trunc(s, max)
  if not s or s == "" then
    return ""
  end
  if #s <= max then
    return s
  end
  return s:sub(1, max - 1) .. "…"
end

function M.diag_counts()
  local bufnr = 0
  local e = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.ERROR })
  local w = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.WARN })
  local i = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.INFO })
  local h = #vim.diagnostic.get(bufnr, { severity = vim.diagnostic.severity.HINT })

  local parts = {}
  if e > 0 then
    table.insert(parts, ("☠ %d"):format(e))
  end
  if w > 0 then
    table.insert(parts, ("⛧ %d"):format(w))
  end
  if i > 0 then
    table.insert(parts, ("ℹ %d"):format(i))
  end
  if h > 0 then
    table.insert(parts, ("☦ %d"):format(h))
  end
  return table.concat(parts, " ")
end

function M.diag_message()
  local lnum = (vim.api.nvim_win_get_cursor(0)[1] or 1) - 1
  local diags = vim.diagnostic.get(0, { lnum = lnum })
  if not diags or #diags == 0 then
    return ""
  end

  table.sort(diags, function(a, b)
    return (a.severity or 999) < (b.severity or 999)
  end)

  local d = diags[1]
  local icon = ({
    [vim.diagnostic.severity.ERROR] = "☠",
    [vim.diagnostic.severity.WARN] = "⛧",
    [vim.diagnostic.severity.INFO] = "ℹ",
    [vim.diagnostic.severity.HINT] = "☦",
  })[d.severity] or "!"

  return trunc(("%s %s"):format(icon, (d.message or ""):gsub("%s+", " ")), 120)
end

vim.cmd([[
function! LightlineDiagCounts() abort
  return v:lua.require('statusline').diag_counts()
endfunction

function! LightlineDiagMessage() abort
  return v:lua.require('statusline').diag_message()
endfunction
]])

vim.g.lightline = {
  colorscheme = "darcula",
  active = {
    left = { { "mode", "paste" }, { "readonly", "filename", "modified" }, { "diag_msg" } },
    right = { { "diag_counts" }, { "lineinfo" }, { "percent" }, { "fileformat", "fileencoding", "filetype" } },
  },
  component_expand = {
    diag_counts = "LightlineDiagCounts",
    diag_msg = "LightlineDiagMessage",
  },
  component_type = {
    diag_counts = "error",
    diag_msg = "warning",
  },
}

vim.opt.laststatus = 2

local group = vim.api.nvim_create_augroup("UserLightlineDiagnostics", { clear = true })
vim.api.nvim_create_autocmd({ "DiagnosticChanged", "CursorMoved", "CursorMovedI", "BufEnter" }, {
  group = group,
  callback = function()
    if vim.fn.exists("*lightline#update") == 1 then
      vim.fn["lightline#update"]()
    else
      vim.cmd("redrawstatus")
    end
  end,
})

return M

