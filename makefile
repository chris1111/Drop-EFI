DropEFI:
	@echo "Xcode Building DropEFI..."
	@$/chmod 755 CreateBuild.sh
	@$/xcodebuild -project "DropEFI.xcodeproj" -alltargets -configuration Release


.PHONY: DropEFI clean

