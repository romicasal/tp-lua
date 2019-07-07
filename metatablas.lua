-----------------------------------------------------------------------------------------
--
-- metatablas.lua
--
-----------------------------------------------------------------------------------------

Set = {}
    
function Set.new (t)
  local set = {}
  setmetatable(set, Set.mt)
  for _, v in ipairs(t) do set[v] = true end
  return set
end

function Set.union (a,b)
  local res = Set.new{}
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.union2 (a,b)
  if getmetatable(a) ~= Set.mt or
      getmetatable(b) ~= Set.mt then
      error({code=200, msg= "Intenta unir un elemento table>Set con otro tipo de elemento (type(a)=".. type(a) .. ", type(b)=" ..type(b)..")"})
  end
  local res = Set.new{}
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.intersection (a,b)
  local res = Set.new{}
  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

function Set.sumall(a, b)
  local sum = 0
  for k in pairs(a) do
    sum = sum + k
  end
  for k in pairs(b) do
    sum = sum + k
  end
  return sum
end

function Set.tostring (set)
  local s = "{"
  local sep = ""
  for e in pairs(set) do
    s = s .. sep .. e
    sep = ", "
  end
  return s .. "}"
end

function Set.print (s)
  print(Set.tostring(s))
end

Set.mt = {} 
Set.mt.__add = Set.union
Set.mt.__mul = Set.intersection
Set.mt.__tostring = Set.tostring
Set.mt.__call = Set.sumall
--Set.mt.__metatable = "prohibido modificar"

Set.mt.__le = function (a,b)    
  for k in pairs(a) do
    if not b[k] then return false end
  end
  return true
end

Set.mt.__lt = function (a,b)
  return a <= b and not (b <= a)
end

Set.mt.__eq = function (a,b)
  return a <= b and b <= a
end
     
--------------------------------------------------------------
-- arithmetic metamethods & tostring
--------------------------------------------------------------

s1 = Set.new{10, 20, 30, 50}
s2 = Set.new{30, 1}

print(getmetatable(s1))          
print(getmetatable(s2)) 

-- UNION
s3 = s1 + s2
print(s3)  --> {1, 10, 20, 30, 50}

--INTERSECCION
print((s1 + s2)*s1)     --> {10, 20, 30, 50}

--------------------------------------------------------------
-- relational metamethods
--------------------------------------------------------------
--[[
s1 = Set.new{2, 4}
s2 = Set.new{4, 10, 2}
print(s1 <= s2)       --> true
print(s1 < s2)        --> true
print(s1 >= s1)       --> true
print(s1 > s1)        --> false
print(s1 == s2 * s1)  --> true
--]]

--------------------------------------------------------------
-- call
--------------------------------------------------------------

--[[
s1 = Set.new{10}
s2 = Set.new{10,20,30}

print(s1(s2))       --> 70
--]]

--------------------------------------------------------------
-- proteger ln 72
--------------------------------------------------------------

--[[
s1 = Set.new{10, 20, 30, 50}

print(getmetatable(s1))          
setmetatable(s1, {})
--]]

--------------------------------------------------------------
-- error handling (pcall protected call)
--------------------------------------------------------------

--[[
s = Set.new{1,2,3}
Set.mt.__add = Set.union
s = s + 8 
--]]

--[[
local status, err =  pcall(function()
s = Set.new{1,2,3}
Set.mt.__add = Set.union2
s = s + 8 
end) 

if not err then
  print('TODO BIEN')
else
  print('OCURRIO UN ERROR COD:' .. err.code .. ' "' .. err.msg .. '"')
end
--]]
