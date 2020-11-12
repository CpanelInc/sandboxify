all:
	${MAKE} clean
	${MAKE} sandboxify

clean:
	/bin/rm -f sandboxify

sandboxifyd/VERSION:
	echo INSTALLER_VERSION=development-`git describe --tags --abbrev=0` > sandboxifyd/VERSION
	echo REVISION=`git log -1 --pretty='format:%H'` >> sandboxifyd/VERSION

sandboxify: utils/*
	perl -cw -Mstrict sandboxifyd/bootstrap
	utils/makeself sandboxifyd sandboxify 'cPanel & WHM sandboxifyer' './bootstrap'

test:
	/usr/local/cpanel/3rdparty/bin/prove -w t/*.t
