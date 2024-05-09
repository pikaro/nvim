(
    (block_mapping_pair
        key: (flow_node) @identifier.ansible.name.key (
                        #any-of?
                        @identifier.ansible.name.key
                            "name"
                            "path"
                            "dest"
        )
        value: (_) @identifier.ansible.name.value
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.directive.ansible.state.key (
                        #eq?
                        @keyword.directive.ansible.state.key
                            "state"
        )
        value: (_) @keyword.directive.ansible.state.other.value
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.directive.ansible.state.key (
                        #eq?
                        @keyword.directive.ansible.state.key
                            "state"
        )
        value: (flow_node) @keyword.directive.ansible.state.create.value (
                       #eq?
                       @keyword.directive.ansible.state.create.value
                           "present"
        )
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.directive.ansible.state.key (
                        #eq?
                        @keyword.directive.ansible.state.key
                            "state"
        )
        value: (flow_node) @keyword.directive.ansible.state.delete.value (
                       #eq?
                       @keyword.directive.ansible.state.delete.value
                           "absent"
        )
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.repeat.ansible.key (
                        #any-of?
                        @keyword.repeat.ansible.key
                            "loop"
                            "with_items"
                            "with_dict"
                            "with_fileglob"
                            "with_first_found"
                            "with_lines"
                            "with_nested"
                            "with_sequence"
                            "with_subelements"
                            "with_together"
                            "with_flattened"
                            "with_inventory_hostnames"
                            "with_inventory_hostnames_all"
                            "with_inventory_groups"
        )
        value: (_) @keyword.repeat.ansible.value
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.conditional.ansible.key (
                        #eq?
                        @keyword.conditional.ansible.key
                            "when"
        )
        value: (_) @keyword.conditional.ansible.value
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.assignment.ansible.key (
                        #any-of?
                        @keyword.assignment.ansible.key
                            "register"
                            "vars"
        )
        value: (_) @keyword.assignment.ansible.value
        (#set! "priority" 999)
    )
)

(
    (block_mapping_pair
        key: (flow_node) @keyword.directive.ignore.ansible (
                        #any-of?
                        @keyword.directive.ignore.ansible
                            "failed_when"
                            "ignore_errors"
        )
        (#set! "priority" 999)
    )
)

(
    (double_quote_scalar) @variable.ansible
    (#lua-match? @variable.ansible "{{ ?(.*) ?}}")
    (#vim-match-offset! @variable.ansible "\\{\\{ ?\\zs.*\\ze ?\\}\\}" "m")
    (#set! "priority" 999)
 )
