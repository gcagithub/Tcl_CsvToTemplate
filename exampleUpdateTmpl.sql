update Notification set createddate = \
	[if { [getColumnValue 4] == "NULL" } {
			return "NULL"
		} else {
			return "TO_DATE('[getColumnValue 4]', 'YYYY-MM-DD HH24:MI:SS.SSSSS')"
	}] \
	where id = [getColumnValue 1];