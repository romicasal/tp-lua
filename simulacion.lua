-----------------------------------------------------------------------------------------
--
-- simulacion.lua
--
-----------------------------------------------------------------------------------------

--[[  Simula el movimiento de varios personajes en paralelo.
El personaje principal arranca a los 10 metros y hay 10 Personajes secundarios que tratan de alcanzarla
Cada Secundario se mueve de manera aleatoria entre 0 y 1 metro.
El personaje principal se mueve hacia adelante entre 0 y 0.9 metros aleatoriamente
Si el personaje principal no es alcanzado antes de las maxiter iteraciones entonces gana ]]

local target = 10
local ganador = 0
local maxiter = 100

function moverSecundario()
    local recorrido = 0
    while true do
        local stepsize = math.random()
        recorrido = recorrido + stepsize
        coroutine.yield(recorrido)
    end
end

function moverPrincipal()
    local recorrido = 10.0
    while true do
        local stepsize = math.random()*0.9
        recorrido = recorrido + stepsize
        target = recorrido
        coroutine.yield(target)
    end
end

-- Crea 10 diferentes corrutinas para cada personaje

personajes = {coroutine.create(moverPrincipal)}
for k = 1, 10 do
    local per = coroutine.create(moverSecundario)
    personajes[#personajes+1] = per
end

math.randomseed(os.time())

-- Ejecuta el movimiento de los personajes

for iteracion = 1, maxiter do
    for person = 1,#personajes do
        s, at = coroutine.resume(personajes[person])
        io.write (string.format("%6.2f ",at))
        if at > target then
            ganador = 1
            break
        else
            ganador = 0
        end
    end
    if ganador == 1 then
        break
    end
    io.write("\n")
end

if ganador == 0 then
    io.write(" Escapo\n")
else
    io.write(" Atrapado\n")
end
