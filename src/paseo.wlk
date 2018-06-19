// Nota 6 (seis): Buen parcial, lo tira muy abajo el uso de efecto en lugares inadecuados. Importante corregir eso.

// 1) Mal. Usa efecto dentro de métodos que representan preguntas, deberían ser funciones puras.
// 2) MB. 
// 3) B-. No define variable global para prendas livianas.
// 4) MB
// 5) MB.
// 6) MB.
// 7) B. Falta abstracción para saber si un ninio pequenio sin repetir la lógica.
// 8) MB.

class Familia {

	var ninios = #{}

	// Innecesario el término "familia" en un método de la clase Familia	
	method familiaLista() {
		return ninios.all({ ninio => ninio.estaListoParaSalir() })
	}

	method prendasInfaltables() {
		return ninios.map({ ninio => ninio.laDeMasCalidad() })
	}

	method niniosChiquitos() {
		return ninios.filter({ ninio => ninio.edad() < 4 }) // Repite lógica para saber si un ninio es pequenio.
	}

	method salirDePaseo() {
		if (self.familiaLista()) {
			ninios.foreach({ ninio => ninio.usarRopa()})
		} else {
			self.error("No son aptos")
		}
	}

}

class Ninio {

	var prendas = #{}
	var talle
	var edad

	method usarRopa() {
		prendas.foreach({ prenda => prenda.usar()})
	}

	method edad() {
		return edad
	}

	method talle() {
		return talle
	}

	method laDeMasCalidad() {
		return prendas.max({ prenda => prenda.nivelDeCalidad() })
	}

	method nuevaPrenda(prenda) {
		prendas.add(prenda)
	}

	method noSeUsa(prenda) {
		prendas.remove(prenda)
	}

	method promedioCalidadPrendas() {
		return prendas.sum({ prenda => prenda.nivelDeCalidad() }) / prendas.size()
	}

	// Nombre poco descriptivo
	method tieneLasPrendas() = 5 <= prendas.size()

	method estaListoParaSalir() {
		return self.tieneLasPrendas() and prendas.any({ prenda => prenda.nivelDeAbrigo() >= 3 }) and self.promedioCalidadPrendas() > 8
	}

}

class NinioProblematico inherits Ninio {

	var juguete

	// Nombre poco descriptivo, debería mencionar al juguete, también se podría delegar en juguete.
	method tieneLaEdadAdecuada() {
		return edad.between(juguete.min(), juguete.max())
	}

	override method tieneLasPrendas() = 4 <= prendas.size()

	override method estaListoParaSalir() {
		return self.tieneLaEdadAdecuada() and super()
	}

}

class Juguete {

	var min
	var max

	method min() {
		return min
	}

	method max() {
		return max
	}

}

class Prenda {

	var talle
	var desgaste = 0
	var comodidad = 0
	var quienLoUsa
	var abrigo = 1

	method usar() {
		desgaste = desgaste + 1
	}

	method nivelDeCalidad() {
		return self.nivelDeAbrigo() + self.nivelDeComodidad()
	}

	method talle() {
		return talle
	}

	method talleComodo() {
		// Mal, es una pregunta, no debería tener efecto, cada vez que pregunte va a modificar la comodidad.
		if (quienLoUsa.talle() == talle) {
			comodidad = comodidad + 8
		}
	}

	method nivelDeComodidad() {
		self.talleComodo()
		return if (desgaste < 3) {
			comodidad - desgaste
		} else {
			comodidad - 3
		}
	}

	method nivelDeDesgaste() = desgaste

	method nivelDeAbrigo() = abrigo

}

class PrendasPares inherits Prenda {

	var izq
	var der

	method izquierda(prenda) {
		izq = prenda
	}

	method derecha(prenda) {
		der = prenda
	}

	method izq() {
		return izq
	}

	method der() {
		return der
	}

	override method usar() {
		izq.usar()
		der.usar()
	}

	method intercambiar(prenda2) {
		if (self.talle() == prenda2.talle()) {
			self.derecha(prenda2.der())
			prenda2.derecha(self.der())
		} else {
			self.error("Los talles no son iguales")
		}
	}

	override method nivelDeComodidad() {
		// Grave: no usar efecto dentro de preguntas.
		if (quienLoUsa.edad() < 4) {
			comodidad = comodidad - 1
		}
		return super()
	}

	override method nivelDeDesgaste() {
		return ((izq.desgaste() + der.desgaste()) / 2)
	}

	override method nivelDeAbrigo() {
		return izq.abrigo() + der.abrigo()
	}

}

class PrendaIzquierda inherits Prenda {
	// ¿Por qué repite la variable abrigo? ¿Por qué es diferente el abrigo para izquierda y derecha?
	var abrigoo

	override method usar() {
		desgaste = desgaste + 0.8
	}

	method abrigo() {
		return abrigoo
	}

}

class PrendaDerecha inherits PrendaIzquierda {

	override method usar() {
		desgaste = desgaste + 1.20
	}

}

class RopaLiviana inherits Prenda {
	// Debería ser único para todas las prendas livianas, no puede ser un atributo.
	var abrigoLiviano = 1 // se que podria usar el de la clase madre pero no se si puedo "sobreescribir" variables

	override method nivelDeComodidad() {
		// Efecto en una pregunta.
		comodidad = comodidad + 2
		return super()
	}

	method cambiarAbrigo(n) {
		abrigoLiviano = n
	}

	override method nivelDeAbrigo() {
		return abrigoLiviano
	}

}

class RopaPesada inherits Prenda {
	// Dudoso: Rompe el polimorfismo con la superclase al no permitir modificar el abrigo de la misma manera.
	var abrigoPesado = 3 // se que podria usar el de la clase madre pero no se si puedo "sobreescribir" variables

	override method nivelDeAbrigo() {
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

object l {

}

object xl {

}

