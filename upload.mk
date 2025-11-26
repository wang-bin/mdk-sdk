all: apple_txz apple_zip mac_txz ios_txz tvos_txz visionos_txz upload_win_ltl upload_win upload_win64 upload_uwp upload_nupkg

apple_txz:
	[ -f mdk-sdk-apple.tar.xz ] && sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-apple.tar.xz
mac_txz:
	[ -f mdk-sdk-macOS.tar.xz ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-macOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-macOS.tar.xz
apple_zip:
	[ -f mdk-sdk-apple.zip ] && sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.zip $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-apple.zip
ios_txz:
	[ -f mdk-sdk-iOS.tar.xz ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-iOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-iOS.tar.xz
tvos_txz:
	[ -f mdk-sdk-tvOS.tar.xz ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-tvOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-tvOS.tar.xz
visionos_txz:
	[ -f mdk-sdk-visionOS.tar.xz ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-visionOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-visionOS.tar.xz
upload_win_ltl:
	[ -f mdk-sdk-windows-desktop-vs2022-ltl.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-ltl.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/mdk-sdk-windows-ltl.7z || echo no mdk-sdk-windows-desktop-vs2022-ltl.7z
	[ -f mdk-sdk-windows-desktop-vs2022-ltl.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-ltl.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022-ltl.7z
upload_win:
	[ -f mdk-sdk-windows-desktop-vs2022.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/mdk-sdk-windows.7z || echo no mdk-sdk-windows-desktop-vs2022.7z
	[ -f mdk-sdk-windows-desktop-vs2022.7z.md5 ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022.7z.md5 $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/mdk-sdk-windows.7z.md5 || echo no mdk-sdk-windows-desktop-vs2022.7z.md5
	[ -f mdk-sdk-windows-desktop-vs2022.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022.7z* $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022.7z
upload_win64:
	[ -f mdk-sdk-windows-desktop-vs2022-x64.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-x64.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/mdk-sdk-windows-x64.7z || echo no mdk-sdk-windows-desktop-vs2022-x64.7z
	[ -f mdk-sdk-windows-desktop-vs2022-x64.7z.md5 ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-x64.7z.md5 $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/mdk-sdk-windows-x64.7z.md5 || echo no mdk-sdk-windows-desktop-vs2022-x64.7z.md5
	[ -f mdk-sdk-windows-desktop-vs2022-x64.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-x64.7z* $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022-x64.7z
upload_uwp:
	[ -f mdk-sdk-uwp.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-uwp.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-uwp.7z
upload_nupkg:
	[ -f mdk-vs2022.nupkg ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-vs2022.nupkg $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-vs2022.nupkg

.PHONY: all
