# Makefile for Lua libraries written in C.

all:	$(LIBFILE)

clean:
	rm -f *.so $(ARCHNAME)*.tar.gz $(ARCHNAME)*.zip *.core

$(LIBFILE): $(LIBPREFIX)$(LIBNAME).c
	$(CC) -o $@ $> $(CFLAGS) $(LUA_FLAGS) $(INC) $(LIB_PATHS) $(LIBS)

test: $(LIBFILE)
	$(LUA) $(TESTSUITE)

lint: $(LIBPREFIX)$(LIBNAME).c
	$(LINT) $(INC) $(LUA_INC) $>

tar:
	git archive --format=tar --prefix=$(ARCHNAME)-$(LIBVER)/ HEAD^{tree) \
		| gzip > $(ARCHNAME)-$(LIBVER).tar.gz

zip:
	git archive --format=zip --prefix=$(ARCHNAME)-$(LIBVER)/ HEAD^{tree) \
		> $(ARCHNAME)-$(LIBVER).zip

gdb:
	gdb `which lua` lua.core

install: $(LIBFILE)
	cp $(INST_LIB) $(LUA_DEST_LIB)
	cp $(INST_LUA) $(LUA_DEST_LUA)

uninstall: 
	rm -f $(LUA_DEST_LIB)$(LIBFILE)$(LIBEXT)*
	rm -f $(LUA_DEST_LUA)$(INST_LUA)
