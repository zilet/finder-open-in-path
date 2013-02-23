--
--  VimInPathAppDelegate.applescript
--  OpenVimInPath
--
--  Created by Milos Zikic on 3/10/12.
--  http://miloszikic.com
--

script VimInPathAppDelegate
	property parent : class "NSObject"
	
	on applicationWillFinishLaunching_(aNotification)
		tell application "Finder"
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
            my open_iTerm(myItem)
        end tell
        quit
	end applicationWillFinishLaunching_
	
	on applicationShouldTerminate_(sender)
		return current application's NSTerminateNow
	end applicationShouldTerminate_
    
    on open these_items
        my open_iTerm(first item of these_items)
    end open
    
    on open_iTerm(myItem)
        set myPath to quoted form of POSIX path of (myItem as string)
        
        tell application "iTerm"
            activate
            if the (count of terminal) is 0 then
                set myTerm to make new terminal
                else
                set myTerm to the current terminal
            end if
            tell myTerm
                launch session "Default Session"
                set _session to current session
                tell _session to write text "vim " & myPath
            end tell
        end tell
    end open_iTerm
	
end script