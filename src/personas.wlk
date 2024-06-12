import enfermedades.*
class Persona {
	const enfermedades = #{}
	var temperatura 
	var celulas
	var diasEnfermo = 0
	
	method contraerEnfermedades(conj){
		conj.forEach({enf => enfermedades.add(enf)})
	}
	method enfermedades(){
		return enfermedades
	}
	method cantDeCelulasAfec(enfermedad){
		const listaEnfermedades = enfermedades.asList()
		return listaEnfermedades.findOrDefault({enf => enf == enfermedad},"no contrae la enfermedad").cantCelulasAmenazadas()
	}
	method temperatura(){
		return temperatura
	}
	method tomarTemperatura(){
		const enfermedadesFebriles = enfermedades.filter({enf => enf.febril()})
		enfermedadesFebriles.forEach({enf => enf.aumetarTemperatura(self)})
		if(temperatura < 37){
			return "temperatura nomal"
		}
		else if(temperatura <= 44){
			return "fiebre!"
		}
		else{
			return "Coma!"
		}
	}
	method temperatura(tempAumenta){
		temperatura += tempAumenta
	}
	method celulasMuertas(cantCelulas){
		celulas -= cantCelulas
	}
	method celulasAfectadas(){
		return enfermedades.sum({enf => enf.cantCelulasAmenazadas()})
	}
	method celulas(){
		return celulas
	}
	method diasEnfermo(){
		return diasEnfermo
	}
	method pasarDia(){
		diasEnfermo += 1
	}
	method cantDeCelulasAfectadasPorAgresivas(){
		const enferAgresivas = enfermedades.filter({enf => enf.esAgresiva(self)})
		return enferAgresivas.sum({enf => enf.cantCelulasAmenazadas()})
	}
}
