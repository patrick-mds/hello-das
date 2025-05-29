@description('Array of strings to use as a prefix for resource names. Optional.')
param prefix array = []
@description('Array of strings to use as a suffix for resource names. Optional.')
param suffix array = []

// This function takes an array of strings and joins them together with a separator and converts the result to lowercase.
var prefix_join = toLower(prefix != [] ? join(prefix, '') : '')
var suffix_join = toLower(suffix != [] ? join(suffix, '') : '')
var prefix_dash = toLower(prefix != [] ? '${join(prefix, '-')}-' : '')
var suffix_dash = toLower(suffix != [] ? '-${join(suffix, '-')}' : '')

// This function takes a string joins the prefix and suffix and truncates it to a maximum length.
output resource_group string = take('${prefix_dash}rg${suffix_dash}', 90)
output application_insights string = take('${prefix_dash}appi${suffix_dash}', 260)
output app_service string = take('${prefix_dash}app${suffix_dash}', 60)
output service_plan string = take('${prefix_dash}plan${suffix_dash}', 40)
output storage_account string = take('${prefix_join}st${suffix_join}', 24)
output key_vault string = take('${prefix_dash}kv${suffix_dash}', 24)
output log_analytics_workspace string = take('${prefix_dash}log${suffix_dash}', 60)
output virtual_network string = take('${prefix_dash}vnet${suffix_dash}', 64)
output sql_server string = take('${prefix_dash}sql${suffix_dash}', 60)
output sql_database string = take('${prefix_dash}sqldb${suffix_dash}', 128)
