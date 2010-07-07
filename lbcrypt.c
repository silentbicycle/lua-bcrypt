#include <pwd.h>
#include <unistd.h>
#include <lua.h>
#include <lauxlib.h>

static int lbcrypt_gensalt(lua_State *L) {
        int log_rounds = luaL_checkint(L, 1);
        char* salt = bcrypt_gensalt(log_rounds);
        lua_pushstring(L, salt);
        return 1;
}


static int lbcrypt(lua_State *L) {
        const char *key = luaL_checkstring(L, 1);
        const char *salt = luaL_checkstring(L, 2);
        char* res = bcrypt(key, salt);
        lua_pushstring(L, res);
        return 1;
}


static const struct luaL_Reg lbcrypt_lib[] = {
        { "gensalt", lbcrypt_gensalt },
        { "bcrypt", lbcrypt },
        { NULL, NULL },
};

int luaopen_bcryptc(lua_State *L) {
        luaL_register(L, "bcryptc", lbcrypt_lib);
        return 1;
}
