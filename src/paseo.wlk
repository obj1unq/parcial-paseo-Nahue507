

class Familia {
	
	var ninios= #{}
	
	method familiaLista(){
		return ninios.all({ninio=>ninio.estaListoParaSalir()})
	}
	method prendasInfaltables(){
		return ninios.map({ninio=>ninio.laDeMasCalidad()})
	}
	method niniosChiquitos(){
		return ninios.filter({ninio=>ninio.edad()<4})
	}
	method salirDePaseo(){
		if(self.familiaLista()){
			ninios.foreach({ninio=>ninio.usarRopa()})
		}
		else{
			self.error("No son aptos")
		}
	}
}


class Ninio{
	var prendas=#{}
	var talle
	var edad
	method usarRopa(){
		prendas.foreach({prenda=>prenda.usar()})
	}
	method edad(){
		return edad
	}
	method talle(){
		return talle
	}
	method laDeMasCalidad(){
		return prendas.max({prenda=>prenda.nivelDeCalidad()})
	}
	method nuevaPrenda(prenda){
		prendas.add(prenda)
	}
	method noSeUsa(prenda){
		prendas.remove(prenda)
	}
	method promedioCalidadPrendas(){
		
		return prendas.sum({prenda=>prenda.nivelDeCalidad()})/prendas.size()
	}
	method tieneLasPrendas()=5<=prendas.size()
	method estaListoParaSalir(){
		return self.tieneLasPrendas() and prendas.any({prenda=>prenda.nivelDeAbrigo()>=3})
		and self.promedioCalidadPrendas()>8
	}
}


class NinioProblematico inherits Ninio{
	var juguete
	method tieneLaEdadAdecuada(){
		return edad.between(juguete.min(),juguete.max())
	}
	override method tieneLasPrendas()=4<=prendas.size()
	override method estaListoParaSalir(){
		return self.tieneLaEdadAdecuada()and super()
	}
}

class Juguete{
	var min
	var max
	method min(){
		return min
	}
	method max(){
		return max
	}
	
}



class Prenda{
	var talle 
	var desgaste=0
	var comodidad=0
	var quienLoUsa
    var abrigo=1
    
    method usar(){
    	desgaste=desgaste+1
    }
	method nivelDeCalidad(){
		return self.nivelDeAbrigo()+self.nivelDeComodidad()
	}
	method talle(){
		return talle
	}
	method talleComodo(){
		if(quienLoUsa.talle()==talle){
			comodidad=comodidad+8
		}
	}
	method nivelDeComodidad(){
		self.talleComodo()
		return if(desgaste<3){
			comodidad-desgaste
		}
		else{
			comodidad-3
		}
	}
	method nivelDeDesgaste()=desgaste
	method nivelDeAbrigo()=abrigo

	
}



class PrendasPares inherits Prenda{
	
	var izq
	var der
	 
	
	method izquierda(prenda){
		izq=prenda
	}
	method derecha(prenda){
		der=prenda
	}
	method izq(){
		return izq
	}
	method der(){
		return der
	}
	override method usar(){
		izq.usar()
		der.usar()
	}
	method intercambiar(prenda2){
		if(self.talle()==prenda2.talle()){
		self.derecha(prenda2.der())
		prenda2.derecha(self.der())
	}
	else{
		self.error("Los talles no son iguales")
	}
	}
	override method nivelDeComodidad(){
		if(quienLoUsa.edad()<4){
			comodidad=comodidad-1
			}
			return super()
	}
	override method nivelDeDesgaste(){
		return ((izq.desgaste()+der.desgaste())/2)
	}
	override method nivelDeAbrigo(){
		return izq.abrigo()+der.abrigo()
	}
}
class PrendaIzquierda inherits Prenda{
	var abrigoo
	override method usar(){
		desgaste=desgaste+0.8
	}
	method abrigo(){
		return abrigoo
	}
}
class PrendaDerecha inherits PrendaIzquierda{
	override method usar(){
		desgaste=desgaste+1.20
	}
}


class RopaLiviana inherits Prenda{
	var abrigoLiviano=1 //se que podria usar el de la clase madre pero no se si puedo "sobreescribir" variables
	override method nivelDeComodidad(){
		comodidad=comodidad+2
		return super()
	}
	method cambiarAbrigo(n){
		abrigoLiviano=n
	}
	override method nivelDeAbrigo(){
		return abrigoLiviano
	}
	
}



class RopaPesada inherits Prenda{
		var abrigoPesado=3//se que podria usar el de la clase madre pero no se si puedo "sobreescribir" variables
		override method nivelDeAbrigo(){
		return abrigoPesado
	}
}


//Objetos usados para los talles
object xs {
}

object s {
}
object m {
	
}
object l{
	
}
object xl{
	
}