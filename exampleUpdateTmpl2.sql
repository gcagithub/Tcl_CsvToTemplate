update TORIS_GIS.ADV_POINT set OID = [getColumnValue 2]	where OID = [getColumnValue 1];
[
	if { [expr {$_INDEX % 1000}] == 0 || $_INDEX == $_COUNT} {
		return "commit;"
	}
]
