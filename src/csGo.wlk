/** First Wollok example */
object wollok {
	method howAreYou() {
		return 'I am Wolloktastic!'
	}
}


/*
 Parcial Mateo Michini
 
 */
 
// ------------------------------------------------------------------ Enfrentamiento --------------------------------------------
 class Enfrentamiento {

var property partidas= []
var property jugadoresBandoBueno
var property jugadoresBandoMalo
 
//	 Diferenciar entrenamientos finalizados de aquellos que NO
method enfrentamientoCompleto()  = (self.partidasGanadas(bandoBueno)==16  or  self.partidasGanadas(bandoMaloo)==16) and (self.diferenciaDePuntos()>1)   
method diferenciaDePuntos() =   (self.partidasGanadas(bandoBueno) - self.partidasGanadas(bandoMalo) ).abs()
 
 //partidas ganadas por bandos
 method partidasGanadas(bando) = partidas.filter{ partida => partida.bandoGanador() == bando}.size()
 	
 //PUNTO 4
 method iniciarPartida(partida){
 self.verificarEntrenamientoNoCompleto()
 bandoBueno.forEach{jugador=>jugador.crearAvatar()}
 bandoMalo.forEach{jugador=>jugador.crearAvatar()}
 partidas.add(partida)
 }
 
 
 //Auxiliares
 method ultimaPartida() = partidas.head()
 

 method verificarEntrenamientoNoCompleto(){
 if( not( self.enfrentamientoCompleto()) ){
 				throw new EntrenaminetoYaCompleto(message = "Este entrenamineto ay termino y no se pueden agregar mas partidas")
 }
 }
 	
 	
//PUNTO 2
method mostValuablePlayer()  = self.todosLosJugadores().max{ jugador => jugador.eficienciaFinal() }

//auxiliar
method todosLosJugadores() =  jugadoresBandoBueno.union(jugadoresBandoMalo)
 }
 
 class Partida { 
 const property bandoGanador
 
 //Punto 5
//Se pasa un listado de COMPRAS(CLASE) ya inicializadas

 method conjuntoDeCompras(listadoCompras){
 listadoCompras.map{compra => compra.propietario().ultimoAvatar().comprarEquipamiento(compra.cosasCompradas())}
 }
 
 }
 
 class Compra {
 const property propietario
 const property costo
 const property cosasCompradas
 }
// ------------------------------------------------------------------ jugador y avatar --------------------------------------------
 class Jugador {
 //se pregunto a profesores y se dijo que los jugadores contiene los avatares de un SOLO ENTRENAMINETO, por eso se asocia ultimo avatar y ultima partida
var property avatares = []
var nickname
var property historialDeCompras

//Comportamiento para incializar la compra
method realizarCompra(items) ={
const ultimaCompra = new Compra(propietario = self,costo=self.ultimoAvatar().costoDePedido(items),cosasCompradas= items )
historialDeCompras.add(ultimaCompra)
}

//Comportamiento complementario de punto 4
method crearAvatar(){
if(avatares.isEmpty()){
const avatarNuevo = new Avatar(plata = 800,armas.add(armaReglamentaria))
avatares.add(avatarNuevo)
 }
else{
const avatarNuevo = new Avatar(plata = self.ultimoAvatar().plata() + self.calcularPremio( ),armas = self.calcularArmamento( )  )
avatares.add(avatarNuevo)
}
}

method   calcularPremio(ultimaPartida) =  3500.min(800.max(self.ultimoAvatar().eficieniaPartida() * 800))
method   calcularArmamento(partida) {
	if(self.ultimoAvatar().sobrevivio()	){
		return ultimoAvatar().armas()
	} else{
		return [armaReglamentaria]
	}
	

//Punto 6
method totalGastado()=historialDeCompras.sum{compra => compra.costo()}
 
}

method ultimoAvatar() = avatares.head()

//PUNTO 1
method killsTotales() = avatares.sum{avatar=> avatar.cantidadKillsPorPartida()}
method cantidadDeMuertesTotal() = avatares.sum{avatar=> avatar.muertesPorPartida()}
method eficienciaFinal() =  avatares.sum{avatar=> avatar.eficienciaPartida() }

 }
 
class Avatar {
const sobrevivio
var property plata
var property armas
var property Kills = []

method eficienciaPartida() = (cantidadKillsPorPartida() - self.muertesPorPartida()).abs()
method cantidadKillsPorPartida()= kills.size()
method muertesPorPartida(){
	if( sobrevivio){return 1}
	else{return 0}
	 }
	 
//Punto 3

method comprarEquipamiento(items) {
verificarPlataSuficiente(self.costoDePedido(items),plata)
plata -= self.costoDePedido(items)
armas.addAll(items)
}

method costoDePedido(items) = items.sum{item=>item.costoTotal()}

method verificarPlataSuficiente(costoPedido,plata){
	if(not(plata> costoPedido)){
		throw new FaltaPlataExcepcion(message = "No hay plata suficiente")
	}
}

 }
 
 class Bando { 
var property jugadores
 	
 }
 
// ------------------------------------------------------------------ Armamento --------------------------------------------
 class Armamento {
var  property costo
 method costoFinal()= costo
 }
 object armaReglamentaria inherits Armamento {
 	
 override method costoTotal() = 0
 }
 
// ------------------------------------------------------------------ Excepciones --------------------------------------------
 
 class EntrenaminetoYaCompleto inherits Excepcion{ }
 class FaltaPlataExcepcion inherits Excepcion{ }
 
 //_--------------------------
 
 /*
Aclaracion:
* 
* Primero se realiza la compra y se guarda en el historial
* Pero luego con el comportamiento del punto 5 se asigna el armamento con ayuda del comportamiento del punto 3 que le asigna las cosas al avatar.
* Ademas, se creo una clase"compra" para marcar el defasaje desde que se compran las cosas hasta que se las dan al avatar.  
 


*/