class Enfermedad {
	var  cantCelulasAmenazadas
	method cantCelulasAmenazadas(){
		return cantCelulasAmenazadas
	}
}

class Infecciosa inherits Enfermedad {
	const property febril = true
	method aumetarTemperatura(persona){
		persona.temperatura(cantCelulasAmenazadas * 0.01)
	}
	method reproducirse(){
		cantCelulasAmenazadas *= 2
	}
	method esAgresiva(persona){
		return cantCelulasAmenazadas > persona.celulas() * 0.1
	}
}

class Autoinmune inherits Enfermedad {
	const property febril = false
	method destruirCelulas(persona){
		persona.celulasMuertas(cantCelulasAmenazadas)
	}
	method esAgresiva(persona){
		return persona.diasEnfermo() >= 30
	}
}