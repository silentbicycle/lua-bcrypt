require "bcrypt"
pcall(require, "socket")        --use for timing, if available

local now, t
if socket then now = socket.gettime end

for cost=4,14 do
   print("\nCost: ", cost)
   local t; if now then t = now() end
   local salt = bcrypt.gensalt(cost)
   local pwd = "my password" .. cost
   local bad_pwd = "not my password" .. cost
   local hash = bcrypt.create(pwd, salt)

   print("matching password accepted: ",
         assert(bcrypt.equal(pwd, hash)), pwd)

   print("differing password rejected: ",
         assert(not bcrypt.equal(bad_pwd, hash)), bad_pwd)

   if t then print(" -- Elapsed: ", now() - t) end
end
