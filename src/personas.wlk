import enfermedades.*

class Persona {

	const enfermedades = #{}
	var temperatura
	var celulas
	var diasEnfermo = 0

	method contraerEnfermedades(conj) {
		conj.forEach({ enf => enfermedades.add(enf)})
	}

	method enfermedades() {
		return enfermedades
	}

	method cantDeCelulasAfec(enfermedad) {
		const listaEnfermedades = enfermedades.asList()
		return listaEnfermedades.findOrDefault({ enf => enf == enfermedad }, "no contrae la enfermedad").cantCelulasAmenazadas()
	}

	method temperatura() {
		return temperatura
	}

	method tomarTemperatura() {
		const enfermedadesFebriles = enfermedades.filter({ enf => enf.febril() })
		enfermedadesFebriles.forEach({ enf => enf.aumetarTemperatura(self)})
		if (temperatura == 37) {
			return "temperatura nomal"
		} else if (temperatura <= 44) {
			return "fiebre!"
		} else {
			return "Coma!"
		}
	}

	method sumarTemperatura(tempAumenta) {
		temperatura += tempAumenta
	}
	method restarTemperatura(tempRest){
		temperatura -= tempRest
	}

	method celulasMuertas(cantCelulas) {
		celulas -= cantCelulas
	}

	method celulasAfectadas() {
		return enfermedades.sum({ enf => enf.cantCelulasAmenazadas() })
	}

	method celulas() {
		return celulas
	}

	method diasEnfermo() {
		return diasEnfermo
	}

	method pasarDia() {
		diasEnfermo += 1
	}

	method cantDeCelulasAfectadasPorAgresivas() {
		const enferAgresivas = enfermedades.filter({ enf => enf.esAgresiva(self) })
		return enferAgresivas.sum({ enf => enf.cantCelulasAmenazadas() })
	}

	method recibirDosis(cantDosis) {
		enfermedades.forEach({ enf => enf.SetcantCelulasAmenazadas(cantDosis)})
		const enfermedadesCuradas = enfermedades.filter({ enf => enf.cantCelulasAmenazadas() <= 0 })
		enfermedadesCuradas.forEach({ enf => enfermedades.remove(enf)})
	}

}

class Medico inherits Persona {

	var cantDosis
	method cantDosis(){
		return cantDosis
	}
	method atenderPersona(persona, dosis) {
		persona.recibirDosis(dosis)
		cantDosis -= dosis
	}

}
class JefeDepartamento inherits Medico {
	const subordinados = #{}
	method subordinados(){
		return subordinados
	}
	method setSubordinados(subo){
		subo.forEach({sub => subordinados.add(sub)})
	}
	override method atenderPersona(persona, dosis){
		const subordinado = subordinados.find({med => med.cantDosis() >= dosis})
		subordinado.atenderPersona(persona,dosis)
	}
}

