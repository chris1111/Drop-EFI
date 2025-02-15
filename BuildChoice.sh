#!/bin/sh
apptitle="DropEFI"
version="1.0"
# Set Icon directory and file 
iconfile="/System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns"

# BuildChoice
response=$(osascript -e 'tell app "System Events" to display dialog "Automate Password: This will Automate the task without having to enter your password for your application

Build Regular: You will need to enter your password each time you use it.\n\nCancel for Quit" buttons {"Cancell","Build Regular","Automate Password"} default button 3 with title "'"$apptitle"' '"$version"'" with icon POSIX file "'"$iconfile"'"  ')

action=$(echo $response | cut -d ':' -f2)


# Exit if Canceled
if [ "$action" == "Cancell" ] ; then
     osascript -e 'display notification "Drop EFI quit" with title "'"$apptitle"'" subtitle "User cancel"'
     echo "User cancel DropEFI quit in 3 sec"
     Sleep 3    
     osascript -e 'quit app "Terminal"'
fi


if [ "$action" == "Build Regular" ] ; then
     echo " "
     cd $HOME/Drop-EFI
     echo "Make Build"
     Sleep 3
     make
fi


if [ "$action" == "Automate Password" ] ; then
     echo " "
     echo "Welcome $USER *** Automate Password ***"
     Sleep 3
     cd $HOME/Drop-EFI
     cp -Rp ./AutomatePassword /Private/tmp

read -r -d '' CodeMenu <<'EOF'
   set iconfile to alias "System:Library:CoreServices:Finder.app:Contents:Resources:Finder.icns"
   set Box to text returned of (display dialog "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

⬇ ︎Type: Your your password to include it in the applications

Then press the OK button
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

                
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" default answer "" buttons {"OK"} default button {"OK"} with hidden answer with icon iconfile)
return Box
EOF

Box=$(osascript -e "$CodeMenu");
echo " "

OLD="12345"
MYPATH="/Private/tmp/AutomatePassword/main.txt"
TFILE="/Private/tmp/out.tmp"
for f in $MYPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$Box/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi

OLD="12345"
MYPATH="/Private/tmp/AutomatePassword/DropEFI.txt"
TFILE="/Private/tmp/out.tmp"
for f in $MYPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$Box/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi
done
done
  Sleep 1
  rm -rf $HOME/Drop-EFI/MountEFI/Scripts/main.recover.rtf
  textutil -convert rtf /Private/tmp/AutomatePassword/main.txt -output $HOME/Drop-EFI/MountEFI/Scripts/main.recover.rtf
  Sleep 1
  mv /Private/tmp/AutomatePassword/main.txt /Private/tmp/AutomatePassword/main.scpt
  mv /Private/tmp/AutomatePassword/DropEFI.txt /Private/tmp/AutomatePassword/DropEFI.applescript
  Sleep 1
  rm -rf $HOME/Drop-EFI/DropEFI.applescript
  rm -rf $HOME/Drop-EFI/MountEFI/DropEFI.applescript
  cp -Rp /Private/tmp/AutomatePassword/main.scpt $HOME/Drop-EFI/MountEFI/DropEFI.applescript
  cp -Rp /Private/tmp/AutomatePassword/DropEFI.applescript $HOME/Drop-EFI
  echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
  echo "DropEFI.app use Automate Password."
  echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

  Sleep 1
  cd $HOME/Drop-EFI
  echo "Make Build"
  Sleep 3
  make
  rm -rf /Private/tmp/AutomatePassword
fi