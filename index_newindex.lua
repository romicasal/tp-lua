-----------------------------------------------------------------------------------------
--
-- index_newindex.lua
--
-----------------------------------------------------------------------------------------

-----------------------------------------------------------------------------------------
-- TRAKING VERSION 1
-----------------------------------------------------------------------------------------

t1 = {}  -- tabla original creada en algun lugar x

-- acceso privado a la tabla orignal 
local _t = t1

-- proxy
t = {}

-- create metatable
local mt = {
  __index = function (t,k)
    print("*ACCEDO AL ELEMENTO " .. tostring(k))
    return _t[k]   -- accedo  la tabla original
  end,

  __newindex = function (t,k,v)
    print("*ACTUALIZO EL ELEMENTO " .. tostring(k) ..
                         " A " .. tostring(v))
    _t[k] = v   -- actualizo la tabla original
  end
}
setmetatable(t, mt)

t[1] = 'hola'
print(t[1])
print(t[2])

--print(rawget(t,1))
--print(rawget(t1,1))
--rawset(t, 1, 'chau')
--print(rawget(t,1))
--print(t[1])

-----------------------------------------------------------------------------------------
-- TRAKING VERSION 2
-----------------------------------------------------------------------------------------


local index = {}

function track (t)
  local proxy = {}
  proxy[index] = t
  setmetatable(proxy, {
    __index = function (t,k)
      print("*ACCEDO AL ALEMENTO " .. tostring(k))
      return t[index][k]
    end,

    __newindex = function (t,k,v)
      print("*ACTUALIZO EL ELEMENTO " .. tostring(k) ..
                         " A " .. tostring(v))
      t[index][k] = v
    end
  })
  return proxy
end

--[[
t1 = {} 
t1 = track(t1)


t2 = {} 
t2 = track(t2)

t1[1] = 'TABLA1: ELEM UNO'
print(t1[1])

t2[1] = 'TABLA2: ELEM UNO'
print(t2[1])

t1[2] = 'TABLA1: ELEM DOS'
print(t1[2])

t2[2] = 'TABLA2: ELEM DOS'
print(t2[2])
]]


-----------------------------------------------------------------------------------------
-- READONLY
-----------------------------------------------------------------------------------------

function readOnly (t)
  local proxy = {}
  local mt = {
    __index = t,
    __newindex = function (t,k,v)
      error("intento de modificar una tabla de solo lectura", 2)
    end
  }
  setmetatable(proxy, mt)
  return proxy
end

dias = readOnly{"Domingo", "Lunes", "Martes", "Miercoles",
         "Jueves", "Viernes", "Sabado"}

--[[
print(dias[1])
dias[2] = "Monday"
]]
