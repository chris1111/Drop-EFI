
# DropEFI
# (c) Copyright 2024 chris1111, All Right Reserved.
# This will create a Apple Bundle App DropEFI
# Dependencies: osacompile
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
# Declare some VARS
find . -name '.DS_Store' -type f -delete
APP_NAME="DropEFI.app"
SOURCE_SCRIPT="./MountEFI/DropEFI.applescript"
rm -rf "$APP_NAME"

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "DropEFI"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "

# Create the dir structure
/usr/bin/osacompile -o "$APP_NAME" "$SOURCE_SCRIPT"

# Included files structure
cp -rp ./MountEFI/Info.plist "$APP_NAME"/Contents/

cp -rp ./MountEFI/MacOS "$APP_NAME"/Contents/

cp -rp ./MountEFI/PkgInfo "$APP_NAME"/Contents/

cp -rp ./MountEFI/Frameworks "$APP_NAME"/Contents/

cp -rp ./MountEFI/Base.lproj "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/Credits.html "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/Assets.car "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/description.rtfd "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/en.lproj "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/Scripts/Helper-EFI "$APP_NAME"/Contents/Resources/Scripts/

cp -rp ./MountEFI/Scripts/main.recover.rtf "$APP_NAME"/Contents/Resources/Scripts/

cp -rp ./MountEFI/DocumentIcon.png "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/Badge.tiff "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/droplet.tiff "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/applet.icns "$APP_NAME"/Contents/Resources/

cp -rp ./MountEFI/droplet.icns "$APP_NAME"/Contents/Resources/

# Zip app
Sleep 1
zip -r "$APP_NAME".zip "$APP_NAME"
Sleep 1
rm -rf "$APP_NAME"
unzip "$APP_NAME".zip
Sleep 1
# Remove app
rm -rf ./"$APP_NAME".zip
cp -rp "$APP_NAME" ./build/Release/"$APP_NAME"/Contents/Resources/
Sleep 1
rm -rf "$APP_NAME"