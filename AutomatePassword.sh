#!/bin/sh
apptitle="DropEFI"
version="1.0"
# Set Icon directory and file 
iconfile="/System/Library/CoreServices/Finder.app/Contents/Resources/Finder.icns"

# Automate Password if Yes
response=$(osascript -e 'tell app "System Events" to display dialog "This will Automate the task without having to enter your password for your application\n" buttons {"Automate Password"} default button 1 with title "'"$apptitle"' '"$version"'" with icon POSIX file "'"$iconfile"'"  ')

action=$(echo $response | cut -d ':' -f2)


if [ "$action" == "Automate Password" ] ; then
     echo " "
     echo "Welcome $USER *** Automate Password ***"
     Sleep 3
     cd $HOME/Drop-EFI
     cp -Rp ./AutomatePasword /Private/tmp

read -r -d '' CodeMenu <<'EOF'
   set iconfile to alias "System:Library:CoreServices:Finder.app:Contents:Resources:Finder.icns"
   set Box to text returned of (display dialog "
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

⬇ ︎Type: Your your password to include it in the applications

Then press the OK button
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

                
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -" default answer "" buttons {"OK"} default button {"OK"} with icon iconfile)
return Box
EOF

Box=$(osascript -e "$CodeMenu");
echo " "

OLD="12345"
MYPATH="/Private/tmp/AutomatePasword/main.txt"
TFILE="/Private/tmp/out.tmp"
for f in $MYPATH
do
  if [ -f $f -a -r $f ]; then
   sed "s/$OLD/$Box/g" "$f" > $TFILE && mv $TFILE "$f"
  else
   echo "Error: Cannot read $f"
  fi

OLD="12345"
MYPATH="/Private/tmp/AutomatePasword/DropEFI.txt"
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
  textutil -convert rtf /Private/tmp/AutomatePasword/main.txt -output $HOME/Drop-EFI/MountEFI/Scripts/main.recover.rtf
  Sleep 1
  mv /Private/tmp/AutomatePasword/main.txt /Private/tmp/AutomatePasword/main.scpt
  mv /Private/tmp/AutomatePasword/DropEFI.txt /Private/tmp/AutomatePasword/DropEFI.applescript
  Sleep 1
  rm -rf $HOME/Drop-EFI/DropEFI.applescript
  rm -rf $HOME/Drop-EFI/MountEFI/DropEFI.applescript
  cp -Rp /Private/tmp/AutomatePasword/main.scpt $HOME/Drop-EFI/MountEFI/DropEFI.applescript
  cp -Rp /Private/tmp/AutomatePasword/DropEFI.applescript $HOME/Drop-EFI
  echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
  echo "DropEFI.app use Automate Password."
  echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

  Sleep 1
  cd $HOME/Drop-EFI
  echo "Make Build"
  Sleep 3
  make
  rm -rf /Private/tmp/AutomatePasword
fi