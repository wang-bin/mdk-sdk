all: apple_txz apple_zip mac_txz mac_zip
apple_txz:
	sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
apple_zip:
	sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.zip $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
mac_txz:
	sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-macOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
mac_zip:
	sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-macOS.zip $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
.PHONY: all
