return function()
  local cword = vim.fn.expand("<cword>")
  local value = vim.fn.input("LSP Rename: ", cword)
  if not value or #value == 0 or cword == value then return end
  local params = vim.lsp.util.make_position_params(0, "utf-8")

  -- Request rename.
  params = vim.tbl_extend("force", params, { newName = value })
  vim.lsp.buf_request(0, "textDocument/rename", params, function(err, res, ctx, _)
    if not res then
      vim.notify("could not perform rename", vim.log.levels.ERROR, {})
      return
    end

    -- Apply rename.
    vim.lsp.handlers["textDocument/rename"](err, res, ctx)

    -- Collect change data.
    local entries = {}
    local num_files = 0
    local num_changes = 0
    if (res.documentChanges) then
      for _, doc in pairs(res.documentChanges) do
        num_files = num_files + 1
        num_changes = num_changes + #doc.edits
        local bufnr = vim.uri_to_bufnr(doc.textDocument.uri)
        for _, edit in ipairs(doc.edits) do
          local start = edit.range.start.line + 1
          local line = vim.api.nvim_buf_get_lines(bufnr, start - 1, start, false)[1]
          table.insert(entries, {
            bufnr = bufnr,
            lnum = start,
            col = edit.range.start.character + 1,
            text = line,
          })
        end
      end
    end
    if (res.changes) then
      for uri, edits in pairs(res.changes) do
        num_files = num_files + 1
        num_changes = num_changes + #edits
        local bufnr = vim.uri_to_bufnr(uri)
        for _, edit in ipairs(edits) do
          local start = edit.range.start.line + 1
          local line = vim.api.nvim_buf_get_lines(bufnr, start - 1, start, false)[1]
          table.insert(entries, {
            bufnr = bufnr,
            lnum = start,
            col = edit.range.start.character + 1,
            text = line,
          })
        end
      end
    end

    -- Save changes to quickfix list.
    if num_files > 1 then vim.fn.setqflist(entries, "r") end

    vim.notify(string.format("renamed %s instance%s in %s file%s",
      num_changes,
      num_changes == 1 and '' or 's',
      num_files,
      num_files == 1 and ", run ':w' to save" or "s, Run ':cfdo w' to save"
    ))
  end)
end
