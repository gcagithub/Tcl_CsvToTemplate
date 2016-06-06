# # # # # # # # # # # # # # # #
# Tcl
# 
# Script runs throught the csv file and substitutes
# placeholders in pattern by cell values.
#
#    @args: 'csv_file' 'template_file' 'output_fileName' ?csv line counts? ?csv delim?
#    @return: 'output_fileName'
#


# set argv [list "test_notificationN3.csv" \
# 				"updateTmpl.sql" \
# 				"out2.sql"]

if {[llength $argv] < 3} {
	puts "You may use 5 parameters. "
	puts "Please, set CSV file, Template file, exported file and number of lines"
	puts "Ex: 'csvFile.csv' 'tmplFile.sql' 'outPut.sql' ?csv delim? ?csv line counts?"
	exit
} else {
	set _CSV_FILE [lindex $argv 0]
	set _TMPL_FILE [lindex $argv 1]
	set _OUT_FILE [lindex $argv 2]
	set _DELIM [lindex $argv 3]
	set _COUNT [lindex $argv 4]
	puts "Csv file = $_CSV_FILE"
	puts "Template file = $_TMPL_FILE"
	puts "Export file = $_OUT_FILE"
}

set _DELIM [expr {$_DELIM != "" ? $_DELIM  : ";"}]

# if {$_DELIM == ""} {set _DELIM ";"}

### Gets template from file ###
set tmplFileId [open $_TMPL_FILE r]
     set tmplFileData [read $tmplFileId]
     close $tmplFileId

puts "Template:\n$tmplFileData"
puts "CSV delimiter - '$_DELIM'"


### Counts number of lines in file ###
proc linecount {file} {
    set i 0
    set fid [open $file r]
    while {[gets $fid line] > -1} {incr i}
    close $fid
    return $i
}

if {[linecount $_TMPL_FILE] > 40} {
	puts "Lines of template should not be greater 40 !!!"
	exit
}

puts "Counting lines in $_CSV_FILE ..."
	if {$_COUNT != ""} {
		puts "Process only $_COUNT lines"
	} else {
		set _COUNT [linecount $_CSV_FILE]
	}
puts "Total lines = $_COUNT"

### Gets value from cell in csv row  ###
proc getColumnValue { index } {
	upvar 1 csvLine csv
	upvar 1 _DELIM delim

	set csvList [split $csv $delim]
	set result [lindex $csvList [expr {$index - 1}]]
#	if {$result == ""} {
#		set result "null"
#	}
	return $result
}

### Reads rows from csv file and writes to output file ###
set input [open $_CSV_FILE r]
set output [open $_OUT_FILE a]
while {[gets $input csvLine] >= 0} {
	set _INDEX [incr i]
	puts $output [subst $tmplFileData]
	puts -nonewline "\rProgress... $_INDEX|$_COUNT"
	if {$_INDEX == $_COUNT} {
		break;
	}
}
  close $input
  close $output