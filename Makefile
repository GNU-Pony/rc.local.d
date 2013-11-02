# Copying and distribution of this file, with or without modification,
# are permitted in any medium without royalty provided the copyright
# notice and this notice are preserved.  This file is offered as-is,
# without any warranty.  [GNUAllPermissive]


PREFIX = /usr
DATA = /share
SYSCONF = /etc
LICENSES = $(DATA)/licenses
PKGNAME = rc.local.d


LATE = backlight-restore backlight binfmt run-lock syslinux-conf
SHUTDOWN = backlight-store



.PHONY: all
all: all-late all-shutdown

.PHONY: all-late
all-late: $(foreach S, $(LATE), rc.local.d/$(S))

.PHONY: all-shutdown
all-shutdown: $(foreach S, $(SHUTDOWN), rc.local.shutdown.d/$(S))


rc.local.d/%: rc.local.d/%.bash
	cp "$<" "$@"

rc.local.shutdown.d/%: rc.local.shutdown.d/%.bash
	cp "$<" "$@"


.PHONY: install
install:
	install -dm755 -- "$(DESTDIR)$(SYSCONF)/rc.local.d"
	install -m644 -- $(foreach S, $(LATE), rc.local.d/$(S)) "$(DESTDIR)$(SYSCONF)/rc.local.d"
	install -dm755 -- "$(DESTDIR)$(SYSCONF)/rc.local.shutdown.d"
	install -m644 -- $(foreach S, $(SHUTDOWN), rc.local.shutdown.d/$(S)) "$(DESTDIR)$(SYSCONF)/rc.local.shutdown.d"
	install -dm755 -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"
	install -m644 COPYING LICENSE -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"


.PHONY: uninstall
uninstall:
	-rm -- $(foreach S, $(LATE), "$(DESTDIR)$(SYSCONF)/rc.local.d/$(S)")
	-rm -d -- "$(DESTDIR)$(SYSCONF)/rc.local.d"
	-rm -- $(foreach S, $(SHUTDOWN), "$(DESTDIR)$(SYSCONF)/rc.local.shutdown.d/$(S)")
	-rm -d -- "$(DESTDIR)$(SYSCONF)/rc.local.shutdown.d"
	-rm -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)/COPYING"
	-rm -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)/LICENSE"
	-rm -d -- "$(DESTDIR)$(PREFIX)$(LICENSES)/$(PKGNAME)"


.PHONY: clean
clean:
	-rm $(foreach S, $(LATE), rc.local.d/$(S))
	-rm $(foreach S, $(SHUTDOWN), rc.local.shutdown.d/$(S))

