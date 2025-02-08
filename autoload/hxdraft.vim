" autoload/hxdraft.vim

" Helper function to check the script directory
function! hxdraft#GetScriptPath(script_name)
  " Check if user has defined their own script directory
  if exists('g:scripts_dir') && g:scripts_dir != ''
    let script_path = g:scripts_dir . a:script_name
    if filereadable(script_path)
      return script_path
    endif
  endif

  let plugin_dir = expand('<sfile>:p:h')
  let script_path = plugin_dir . '/scripts/' . a:script_name
  " Check if the script exists in the default directory
  if filereadable(script_path)
    return script_path
  endif

  echo "Error (".script_path."): Script not found in either user-defined or default directory."
  return ''
endfunction



" Send the content of the current buffer to a shell script
function! hxdraft#SendToScript()
  let script_path = hxdraft#GetScriptPath('alert.sh')
  if script_path == ''
    return
  endif

  " Write the current buffer content to a temporary file
  let temp_file = tempname()
  execute 'write ' . temp_file

  " Call the script with the temp file as an argument
  execute '!sh ' . script_path . ' ' . temp_file

  " Optionally, delete the temporary file after the script runs
  call delete(temp_file)
endfunction
