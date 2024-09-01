# (c) Copyright 2024 chris1111 
# This will create App Bundle Drop EFI
# Dependencies: osacompile
PARENTDIR=$(dirname "$0")
cd "$PARENTDIR"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Create Drop EFI Bundle"
echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
xcodebuild -project "Drop-EFI.xcodeproj" -alltargets -configuration Release
Sleep 1
mkdir -p ./build/Release/Drop-EFI.app
cp -Rp ./PackageRoot/App/Contents ./build/Release/Drop-EFI.app
Sleep 1
mkdir -p ./build/Release/Drop-EFI.app/Contents/Resources/DropEFI.app
cp -Rp ./PackageRoot/InsideApp/Contents ./build/Release/Drop-EFI.app/Contents/Resources/DropEFI.app
Sleep 1
chmod +x ./build/Release/Drop-EFI.app/Contents/MacOS
chmod +x ./build/Release/Drop-EFI.app/Contents/Resources/DropEFI.app/Contents/MacOS
Sleep 1
xattr -c ./build/Release/Drop-EFI.app/Contents/Resources/DropEFI.app
Sleep 1
cp -Rp ./build/Release/Drop-EFI.app /Applications/Drop-EFI.app
osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/Drop-EFI.app", hidden:false}'
Sleep 1
Open -a /Applications/"Drop-EFI.app"

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
echo "Create /Applications/Drop-EFI.app Done.
App is ready on Status Bar"

echo "= = = = = = = = = = = = = = = = = = = = = = = = =  "
