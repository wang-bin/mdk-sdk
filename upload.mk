all: apple_txz mac_txz
apple_txz:
	sshpass -p $$SF_PW scp -o StrictHostKeyChecking=no mdk-sdk-apple.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
mac_txz:
	sshpass -p $${SF_PW} scp -o StrictHostKeyChecking=no mdk-sdk-macOS.tar.xz $${SF_USER}@frs.sourceforge.net:/home/frs/project/mdk-sdk/nightly/
.PHONY: all
