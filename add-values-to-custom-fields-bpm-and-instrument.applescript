tell application "DEVONthink"
	set theRecords to selection
	if (count of theRecords) is 0 then
		display dialog "Please select at least one record" buttons {"OK"} default button "OK"
		return
	end if
	
	-- Set the list of fields
	set fieldNames to {"Instrument", "BPM"}
	
	-- Select field and enter value
	try
		set chosenField to (choose from list fieldNames with prompt "Select a field to edit:" default items "Instrument")
		if chosenField is false then return
		set chosenField to item 1 of chosenField
		
		set newValue to text returned of (display dialog "Enter new value for field " & chosenField default answer "")
		
		repeat with currentRecord in theRecords
			try
				add custom meta data newValue for chosenField to currentRecord
			end try
		end repeat
		
		display dialog "Value updated in " & (count of theRecords) & " records" buttons {"OK"}
	on error errMsg
		display dialog "Error: " & errMsg buttons {"OK"}
	end try
end tell
