SHELL = /bin/sh

# root for installation
prefix      = /usr/local
exec_prefix = ${prefix}

# executables
bindir     = ${exec_prefix}/bin
sbindir    = ${exec_prefix}/sbin
libexecdir = ${exec_prefix}/libexec

# data
datarootdir    = ${prefix}/share
datadir        = ${datarootdir}
sysconfdir     = ${prefix}/etc
sharedstatedir = ${prefix}/com
localstatedir  = ${prefix}/var

# misc
includedir    = ${prefix}/include
oldincludedir = /usr/include
docdir        = ${datarootdir}/doc/${PACKAGE_TARNAME}
infodir       = ${datarootdir}/info
libdir        = ${exec_prefix}/lib
localedir     = ${datarootdir}/locale
mandir        = ${datarootdir}/man
man1dir       = $(mandir)/man1
man2dir       = $(mandir)/man2
man3dir       = $(mandir)/man3
man4dir       = $(mandir)/man4
man5dir       = $(mandir)/man5
man6dir       = $(mandir)/man6
man7dir       = $(mandir)/man7
man8dir       = $(mandir)/man8
man9dir       = $(mandir)/man9
manext        = .1
srcdir        = .

INSTALL         = /usr/bin/install -c
INSTALL_PROGRAM = ${INSTALL}
INSTALL_DATA    = ${INSTALL} -m 644

PACKAGE   = blargup
PROG      = blargup
#VERSION   = 0.0.0
BUGREPORT = https://github.com/DMBuce/blargup/issues
URL       = https://github.com/DMBuce/blargup

CONFDIR          = $(sysconfdir)/$(PROG)
BINFILES         = bin/$(PROG)
ETCFILES         = $(wildcard etc/examples/* etc/conf.d/* etc/systems.d/*)
CLEANFILES       = bin/$(PROG)

ETCFILES_INSTALL = $(ETCFILES:etc/%=$(DESTDIR)$(CONFDIR)/%)
BINFILES_INSTALL = $(BINFILES:bin/%=$(DESTDIR)$(bindir)/%)
INSTALL_FILES    = $(BINFILES_INSTALL) $(ETCFILES_INSTALL)
INSTALL_DIRS     = $(DESTDIR)$(bindir) $(DESTDIR)$(CONFDIR)/examples $(DESTDIR)$(CONFDIR)/conf.d $(DESTDIR)$(CONFDIR)/systems.d

.PHONY: all
all: $(BINFILES) $(ETCFILES)

.PHONY: clean
clean:
	rm -f $(CLEANFILES)

.PHONY: install
install: all installdirs $(INSTALL_FILES)

.PHONY: uninstall
uninstall:
	rm -f $(INSTALL_FILES)

.PHONY: installdirs
installdirs: $(INSTALL_DIRS)

$(INSTALL_DIRS):
	$(INSTALL) -d $@

$(DESTDIR)$(bindir)/%: bin/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(CONFDIR)/examples/%: etc/examples/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(CONFDIR)/conf.d/%: etc/conf.d/%
	$(INSTALL_PROGRAM) $< $@

$(DESTDIR)$(CONFDIR)/systems.d/%: etc/systems.d/%
	$(INSTALL_PROGRAM) $< $@

bin/blargup: bin/blargup.in
	cp $< $@
	sed -i '/prog=/  s?@PROG@?$(PROG)?'   $@
	sed -i '/confdir=/ s?@CONFDIR@?$(CONFDIR)?' $@

# vim: set ft=make:
