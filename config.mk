# Lua-specific paths and libraries
LUA_VER=	5.1
LUA=		/usr/local/bin/lua
LUA_LIBPATH=	-L/usr/local/lib/
LUA_LIBS=	-llua -lm
LUA_INC=	-I/usr/local/include/
LUA_FLAGS=	$(LUA_INC) $(LUA_LIBPATH) $(LUA_LIBS)


# Where compiled libraries and .lua sources install.
LUA_DEST_LIB=	/usr/local/lib/lua/$(LUA_VER)/
LUA_DEST_LUA=	/usr/local/share/lua/$(LUA_VER)/


# Additional C settings
CC=		cc
LIB_PATHS=	
LIBS=		
INC=		
CFLAGS=		-Wall -shared -fPIC
LIBEXT=		.so


# Other tools, optional
LINT=		lint
ARCHNAME= 	lua-$(LIBNAME)
TESTSUITE=	test.lua


# Build targets
LIBNAME=	bcrypt
LIBPREFIX=	l
LIBSUFFIX=	c
LIBFILE=	$(LIBNAME)$(LIBSUFFIX)$(LIBEXT)
INST_LIB=	$(LIBFILE)
INST_LUA=	$(LIBNAME).lua
