local M = {}

local function write_file(path, content)
  local dir = vim.fn.fnamemodify(path, ":h")
  vim.fn.mkdir(dir, "p")
  vim.fn.writefile(vim.split(content, "\n", { plain = true }), path)
end

local function setup_fixtures(root)
  local fixtures = {
    {
      name = "python",
      path = root .. "/python/main.py",
      filetype = "python",
      expected_clients = { "pyright", "ruff" },
      files = {
        [root .. "/python/pyproject.toml"] = "[project]\nname = 'smoke-python'\nversion = '0.1.0'",
        [root .. "/python/main.py"] = "def greet(name: str) -> str:\n    return f'hello, {name}'\n\nprint(greet('world'))",
      },
    },
    {
      name = "go",
      path = root .. "/go/main.go",
      filetype = "go",
      expected_clients = { "gopls" },
      files = {
        [root .. "/go/go.mod"] = "module smoke/go\n\ngo 1.24",
        [root .. "/go/main.go"] = "package main\n\nimport \"fmt\"\n\nfunc main() {\n\tfmt.Println(\"hello\")\n}",
      },
    },
    {
      name = "javascript",
      path = root .. "/web/app.js",
      filetype = "javascript",
      expected_clients = { "ts_ls" },
      files = {
        [root .. "/web/package.json"] = '{"name":"smoke-web","private":true}',
        [root .. "/web/app.js"] = "const answer = 42\nconsole.log(answer)",
      },
    },
    {
      name = "typescript",
      path = root .. "/web/app.ts",
      filetype = "typescript",
      expected_clients = { "ts_ls" },
      files = {
        [root .. "/web/tsconfig.json"] = '{"compilerOptions":{"target":"ES2022"}}',
        [root .. "/web/app.ts"] = "const answer: number = 42\nconsole.log(answer)",
      },
    },
    {
      name = "svelte",
      path = root .. "/web/App.svelte",
      filetype = "svelte",
      expected_clients = { "svelte" },
      files = {
        [root .. "/web/svelte.config.js"] = "export default {}",
        [root .. "/web/App.svelte"] = "<script>\n  let name = 'world'\n</script>\n\n<h1>Hello {name}</h1>",
      },
    },
    {
      name = "html",
      path = root .. "/web/index.html",
      filetype = "html",
      expected_clients = { "html" },
      files = {
        [root .. "/web/index.html"] = "<!doctype html><html><body><h1>hello</h1></body></html>",
      },
    },
    {
      name = "css",
      path = root .. "/web/styles.css",
      filetype = "css",
      expected_clients = { "cssls" },
      files = {
        [root .. "/web/styles.css"] = "body { color: #222; }",
      },
    },
  }

  for _, fixture in ipairs(fixtures) do
    for path, content in pairs(fixture.files) do
      write_file(path, content)
    end
  end

  return fixtures
end

local function sorted_client_names(bufnr)
  local names = {}

  for _, client in ipairs(vim.lsp.get_clients { bufnr = bufnr }) do
    table.insert(names, client.name)
  end

  table.sort(names)
  return names
end

local function contains_all(haystack, needles)
  local seen = {}

  for _, item in ipairs(haystack) do
    seen[item] = true
  end

  for _, item in ipairs(needles) do
    if not seen[item] then
      return false, item
    end
  end

  return true, nil
end

function M.run()
  local root = vim.env.NVIM_SMOKE_ROOT
  if not root or root == "" then
    error("NVIM_SMOKE_ROOT is not set")
  end

  local fixtures = setup_fixtures(root)
  local failures = {}

  vim.cmd "silent! Lazy load nvim-lspconfig mason.nvim"

  for _, fixture in ipairs(fixtures) do
    vim.cmd("silent! edit " .. vim.fn.fnameescape(fixture.path))

    local bufnr = vim.api.nvim_get_current_buf()
    vim.wait(5000, function()
      local clients = sorted_client_names(bufnr)
      local ok = contains_all(clients, fixture.expected_clients)
      return ok
    end, 100)

    local actual_ft = vim.bo[bufnr].filetype
    local clients = sorted_client_names(bufnr)
    local ok_clients, missing = contains_all(clients, fixture.expected_clients)
    local ok_ft = actual_ft == fixture.filetype

    local status = ok_ft and ok_clients and "PASS" or "FAIL"
    print(string.format(
      "%s name=%s filetype=%s clients=%s",
      status,
      fixture.name,
      actual_ft,
      #clients > 0 and table.concat(clients, ",") or "(none)"
    ))

    if not ok_ft then
      table.insert(failures, string.format("%s: expected filetype %s, got %s", fixture.name, fixture.filetype, actual_ft))
    end

    if not ok_clients then
      table.insert(failures, string.format("%s: missing client %s", fixture.name, missing))
    end
  end

  if #failures > 0 then
    error(table.concat(failures, "\n"))
  end
end

return M
