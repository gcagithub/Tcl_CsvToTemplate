[if { [lsearch {35960 36038 36217 36279} [getColumnValue 1]] >= 0 } {
	return "update address set description = '[getColumnValue 3]' where ID = [getColumnValue 1];"
}]
[if { [expr {$_ROW % 1000}] == 0 || $_IS_ROWEND} {
	return "commit;"
}]
