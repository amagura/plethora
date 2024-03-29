## Process this file with automake to produce Makefile.in

bin_PROGRAMS = plethora

plethora_SOURCES = optpsr.c optpsr.h main.pyx
# plethora_SOURCES = text.c main.c acpi.c power.c concat.c
# plethora_SOURCES = main_gui.pyx main.c acpi.c power.c concat.c
# noinst_HEADERS = main.h acpi.h power.h compat.h

# iconsdir = $(pkgdatadir)/icons
# scaledir = $(iconsdir)/scalable/apps
# pngdir = $(iconsdir)/16x16/apps

AM_CFLAGS =
AM_LDFLAGS =
AM_CPPFLAGS =

AM_CFLAGS += -Wall -Wextra
# I probably don't need to define HAVE_CONFIG_H, but I'm not sure what else to do.
AM_CPPFLAGS += -DNO_COMMON_H -DHAVE_CONFIG_H=1 -I$(top_srcdir)

if TEST
AM_CPPFLAGS += -DPL_ACPI_ROOT=\"$(top_srcdir)/test\"
endif

if DEBUG
AM_CFLAGS += -g -ggdb -O0
AM_CPPFLAGS += -DPL_DEBUG=1
else
AM_CFLAGS += -O2
endif

if !DEBUG
if NO_DEBUG
AM_CPPFLAGS += -DPL_DEBUG=0
endif
endif

if NATIVE
if !GENERIC
AM_CFLAGS += -march=native -mtune=native
endif
endif

if GENERIC
if CPU_KNOWN
AM_CFLAGS += -mtune=generic-$(CPUTYPE)
else
AM_CFLAGS += -mtune=generic
endif
endif

plethora_CFLAGS = $(AM_CFLAGS)
plethora_CPPFLAGS = -DPL_PROGNAME=\"plethora\" $(AM_CPPFLAGS)
plethora_LDFLAGS = $(AM_LDFLAGS)
plethora_PYFLAGS =

# if X
# plethora_PYFLAGS += -EPNGDIR=\"$(pngdir)\" -EDATADIR=\"$(pkgdatadir)\" -EPL_PROGNAME=\"plethora\"
# plethora_CPPFLAGS += -DUSE_PYTHON=1
# plethora_CFLAGS += @GTK3_CFLAGS@ @PYTHON_CFLAGS@
# plethora_LDFLAGS += @GTK3_LIBS@ @PYTHON_LIBS@
# bin_PROGRAMS += plethora
# endif

.PHONY: valgrind lint
all-local:

tui: plethora

gui: plethora

move-local: $(bin_PROGRAMS)
	for file in $?; do mv "$$file" ../../; done

clean-local: tidy-local

lint:
	for f in $(plethora_SOURCES); do cppcheck --enable=all $$f; echo; done

valgrind: clean $(bin_PROGRAMS)
	for f in $(bin_PROGRAMS); do \
		test "$$f" = "plethora" || \
		$@ --leak-check=full --show-leak-kinds=all --track-origins=yes ./"$$f"; \
		echo; \
		echo; \
	done

vvalgrind: clean $(bin_PROGRAMS)
	for f in $(bin_PROGRAMS); do \
		test "$$f" = "plethora" || \
		valgrind -v --leak-check=full --show-leak-kinds=all --track-origins=yes ./"$$f"; \
		echo; \
		echo; \
	done

mtrace: $(bin_PROGRAMS)
	for f in $^; do MALLOC_TRACE=./mtrace.txt ./$$f; mtrace ./$$f ./mtrace.txt; echo; cat mtrace.txt; echo; echo; done

expand:
	$(CC) $(AM_CFLAGS) $(AM_CPPFLAGS) -E $(plethora_SOURCES)

check-local: $(bin_PROGRAMS) refresh-check
	cd test; \
	./configure

refresh-check:
	cd test; \
	autoconf

asm: $(plethora_SOURCES:.c=.s) $(bin_PROGRAMS)
	for f in $(plethora_SOURCES:.c=.o); do objdump --file-start-context -slS "$$f" > "$${f//.*/.od}"; done

.c.s:
	$(CC) $(AM_CFLAGS) $(AM_CPPFLAGS) -S $<

.pyx.c:
	ln -sf $(top_srcdir)/config.h
	$(CYTHON) $(plethora_PYFLAGS) --embed -p -3 -Wextra -o $@ $< --gdb

tidy-local:
	$(RM) *.o
	$(RM) *.od
	$(RM) *.py
	$(RM) *.pyc
	$(RM) main_gui.c
	$(RM) main_gui.co
	$(RM) no_common.h
	$(RM) config.h

anew: clean all
ready: clean all tidy-local
null: clean all clean
void: null

drone:
	cd /sys/class/power_supply; ls -R; ls -R /sys/class/power_supply

akpi:
	$(CC) $(AM_CFLAGS) $(AM_CPPFLAGS) $(AM_LDFLAGS) -o acpi acpi.c main.c

# test-setup:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-clean:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-onac:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-noac:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-lowbat:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-empty:
# 	cd "$(top_srcdir)"; $(MAKE) $@
#
# test-nosup:
# 	cd "$(top_srcdir)"; $(MAKE) $@

prod:
	cd "$(top_srcdir)"; \
	autoconf && \
	./configure --disable-debug --disable-testdir --enable-static --disable-native --enable-generic && \
	$(MAKE)

no-debug:
	cd "$(top_srcdir)"; \
	autoconf && \
	./configure --disable-debug --enable-generic --disable-native && \
	$(MAKE)

check-configure: refresh-check
	cd test && \
	cat configure | less

check-all: $(bin_PROGRAMS) plethora refresh-check
	cd test && \
	./configure --with-gtk2

debug:
	cd "$(top_srcdir)"; \
	autoconf && \
	./configure --enable-debug --enable-testdir --enable-generic --disable-native && \
	$(MAKE)
