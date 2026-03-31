; extends
(
  (call
    function: (identifier) @injection.language
    arguments: (argument_list
      (string
        (string_content) @injection.content)))
  (#lua-match? @injection.language "^tsinject_(.*)$")
  (#gsub! @injection.language "^tsinject_(.*)$" "%1")
)
