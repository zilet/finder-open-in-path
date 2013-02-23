--
--  SublimeInPathAppDelegate.applescript
--  SublimeInPath
--
--  Created by Milos Zikic on 3/10/12.
--

script SublimeInPathAppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
		tell application "Finder"
            try
                set mySelected to get selection as list
                if (count of mySelected) is not 0 then
                    set myItem to first item of mySelected
                    if class of myItem is alias file then
                        set myItem to original item of myItem
                    end if
                    else if the (count of window) is not 0 then
                    set myItem to folder of the front window
                    else
                    set myItem to path to desktop folder
                end if
                set myPath to quoted form of POSIX path of (myItem as string)
                
                set theCommand to "open -a 'Sublime Text 2'  " & myPath
                do shell script theCommand
                on error errStr number errorNumber
                display dialog "Whooa.. something went wrong. Please select a file or folder"
            end try
        end tell
        quit
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
	
end script