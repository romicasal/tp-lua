# tp-lua 

Material para la presentación y el informe del tp sobre el lenguaje [Lua](https://www.lua.org/) para la materia Teoria del Lenguaje de la [FIUBA](http://www.fi.uba.ar/) 

## Ejemplos

Se incluyen ejemplos de las características avanzadas del lenguaje:
- Meta tablas y meta métodos
- POO - Objetos - Clases - Herencia
- Corrutinas

## Demo Globos

Es un ejemplo desarrollado con el framework [Corona](http://www.coronalabs.com). El mismo consiste en un globo que cae y rebota con el suelo y que cuando se lo toca se desplaza hacia arriba como si fuese empujado por una fuerza ejercida en dirección contraria a su movimiento. Utiliza la biblioteca physics.

## Demo Galaxy

Es un ejemplo desarrollado con el framework [Corona](http://www.coronalabs.com) obtenido del siguiente [Tutorial](https://docs.coronalabs.com/guide/programming/index.html). 

El tutorial consiste el la construcción de un juego de una nave que debe destruir una serie de asteroides que me mueven hacia ella. 
Se puede mover de derecha izquierda para esquivarlos y puede disparar un rayo laser que los destruye.

Para la presentación se hicieron algunas modificaciones a funcionalidades que provee el tutorial:
* Se agregaron bonus que caen y si son atrapados aumentan el score del jugador
* Se agregaron vidas que como los bonus caen y si son atrapadas aumentan la cantidad de vidas del jugador
* Cuando se llega a una cantidad de puntos se obtiene una vida
* Se cambiaron algunas de las imagenes
* Se agrega el archivo .apk del juego
