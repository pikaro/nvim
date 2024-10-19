(
    (double_quote_scalar) @variable.jinja
    (#lua-match? @variable.jinja "{{ ?(.*) ?}}")
    (#vim-match-offset! @variable.jinja "\\{\\{ ?\\zs.*\\ze ?\\}\\}" "m")
    (#set! "priority" 999)
 )
