local function ensure_file(path)
  if vim.fn.filereadable(path) == 0 then
    vim.fn.writefile({}, path)
  end
end

local function compile_and_run()
  vim.cmd("write")

  local file = vim.fn.expand("%:p")
  local dir = vim.fn.expand("%:p:h")
  local stem = vim.fn.expand("%:t:r")

  local ft = vim.bo.filetype
  local compiler
  local stdflag

  if ft == "cpp" then
    compiler = "g++"
    stdflag = "-std=gnu++17"
  elseif ft == "c" then
    compiler = "gcc"
    stdflag = "-std=gnu17"
  else
    vim.notify("Not a C/C++ file", vim.log.levels.WARN)
    return
  end

  local exe = dir .. "/" .. stem
  local input = dir .. "/input.txt"
  local output = dir .. "/output.txt"
  local error_file = dir .. "/error.txt"

  ensure_file(input)
  vim.fn.writefile({}, output)
  vim.fn.writefile({}, error_file)

  local compile_cmd = string.format(
    '%s %s -O2 -Wall -Wextra -Wshadow -Wconversion -pedantic %s -o %s 2> %s',
    compiler,
    stdflag,
    vim.fn.shellescape(file),
    vim.fn.shellescape(exe),
    vim.fn.shellescape(error_file)
  )

  vim.fn.system(compile_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Compilation failed. Check error.txt", vim.log.levels.ERROR)
    return
  end

  local run_cmd = string.format(
    '%s < %s > %s 2>> %s',
    vim.fn.shellescape(exe),
    vim.fn.shellescape(input),
    vim.fn.shellescape(output),
    vim.fn.shellescape(error_file)
  )

  vim.fn.system(run_cmd)

  if vim.v.shell_error ~= 0 then
    vim.notify("Program exited with error. Check error.txt", vim.log.levels.ERROR)
  else
    vim.notify("Compiled and ran successfully!", vim.log.levels.INFO)
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "c", "cpp" },
  callback = function()
    vim.keymap.set("n", "<F5>", compile_and_run, {
      buffer = true,
      silent = true,
      desc = "Compile and run current C/C++ file",
    })
  end,
})
