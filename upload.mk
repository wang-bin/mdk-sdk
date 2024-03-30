all: apple_txz mac_txz upload_win_ltl upload_win upload_win64 upload_uwp upload_nupkg

apple_txz:
	[ -f mdk-sdk-apple.tar.xz ] && sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-apple.tar.xz
mac_txz:
	[ -f mdk-sdk-macOS.tar.xz ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-macOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-macOS.tar.xz
apple_zip:
	[ -f mdk-sdk-apple.zip ] && sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.zip $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-apple.zip
upload_win_ltl:
	[ -f mdk-sdk-windows-desktop-vs2022-ltl.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-ltl.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022-ltl.7z
upload_win:
	[ -f mdk-sdk-windows-desktop-vs2022.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022.7z
upload_win64:
	[ -f mdk-sdk-windows-desktop-vs2022-x64.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-windows-desktop-vs2022-x64.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-windows-desktop-vs2022-x64.7z
upload_uwp:
	[ -f mdk-sdk-uwp-vs2022.7z ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-uwp-vs2022.7z $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-sdk-uwp-vs2022.7z
upload_nupkg:
	[ -f mdk-vs2022.nupkg ] && sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-vs2022.nupkg $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/ || echo no mdk-vs2022.nupkg

.PHONY: all
