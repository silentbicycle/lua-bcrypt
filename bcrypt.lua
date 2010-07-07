local assert, print, require, string, tonumber, type =
   assert, print, require, string, tonumber, type

module("bcrypt")

local bc = require "bcryptc"

local _bcrypt, _gensalt = bc.bcrypt, bc.gensalt

-- Generate a salt, with a given cost.
function gensalt(cost)
   return _gensalt(cost or 8)
end

-- Read version, cost, and salt from bcrypt hash string.
function parse(hash)
   assert(type(hash) == "string")
   local version, cost = hash:match("^%$(..)%$(..)%$")
   if not version then return false end
   local salt = string.sub(hash, 8, 29)
   return version, tonumber(cost, 16), salt
end

-- Create a new password with a given salt.
function create(password, salt)
   local hash = bc.bcrypt(password, salt)
   local v, c, s = parse(hash)
   local p = { raw=hash, version=v, cost=c, salt=s }
   return p
end

-- Does a password encrypt to match the saved hash (using its salt and cost)?
function equal(password, hash)
   local ver, cost, salt, raw
   if type(hash) == "table" then
      ver, cost, salt = hash.version, hash.cost, hash.salt
      raw = hash.raw
   elseif type(hash) == "string" then
      raw = hash
      ver, cost, salt = parse(hash)
      if not ver then return false, "Not a valid bcrypt password entry" end
   end
   local np = create(password, raw)
   return np.raw == raw
end
