Simple bcrypt wrapper for Lua.

**Basic usage:**

    require "bcrypt"
    -- Defaults to a cost of 8, higher will take (much, much...) longer.
    local salt = bcrypt.gensalt(8)
    local hash = bcrypt.bcrypt("my password", salt)

    -- Print the contents. You can just save hash.raw; bcrypt.equal
    -- can take the raw string or the derived table.
    for k,v in pairs(hash) do print("--> ", k,v) end
    --> raw	$2a$07$8BzFlUuprZN4FSBpDx3ZAuPWOu4CZ3uv8Awa4EjAZhNmnIY59nh2e
    --> salt	8BzFlUuprZN4FSBpDx3ZAu
    --> version	2a
    --> cost	7

    -- Later, somebady wants to log in, check if the password matches.
    if bcrypt.equal("my password", hash) then print "OK" end --> "OK"
    if not bcrypt.equal("not my password", hash) then print "REJECTED" end --> "REJECTED"
