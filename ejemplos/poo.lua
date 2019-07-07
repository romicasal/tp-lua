-----------------------------------------------------------------------------------------
--
-- poo.lua
--
-----------------------------------------------------------------------------------------

Cuenta = {_saldo=0}
function Cuenta:new(o)
  o = o or {} -- si no se provee un objeto asigna uno con los valores default
  setmetatable(o, self)
  self.__index = self
  self.__tostring = self.tostring
  return o
end

function Cuenta:tostring()
  return 'Saldo: ' .. self._saldo
end

function Cuenta:saldo()
  return self._saldo
end
function Cuenta:extraer(v)
  print('Extraigo '.. v)
  if v > self._saldo then error"fondos insuficientes" end
    self._saldo = self._saldo - v
end
function Cuenta:depositar(v)
  print('Deposito '.. v)
  self._saldo = self._saldo + v
end


CuentaEspecial = Cuenta:new()

function CuentaEspecial:extraer (v)
  if v - self._saldo >= self:getLimit() then
    error ("fondos insuficientes.. El saldo negativo supera el limite de " .. tostring(self:getLimit()))
  end
  self._saldo = self._saldo - v
end

function CuentaEspecial:getLimit ()
  return self.limit or 0
end

local status, err =  pcall(function()
c = Cuenta:new()
c:depositar(100.00)
print(c)
c:extraer(200.00)
end) 

print(err)

print('++++++++++++++++++++++++++++++++++')

s = CuentaEspecial:new{limit=1000.00}
print(s)
s:depositar(100.00)
print(s)
s:extraer(500.00)
print(s)
s:extraer(500.00)
print(s)
