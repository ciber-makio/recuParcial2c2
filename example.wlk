class Persona {
  var property efectivo  
  const property cuentasBancarias = []
  const property tarjetasCredit = []
  const property tarjetasDebit= []
  const property compras = []
  var property pagoPreferido
  var mesActual
  var saldoSinPagar = 0
  var property salario
  method recibirCompra(objeto) {
    compras.add(objeto)
  }
  
  method cobrarSalario(cobro){
    mesActual = mesActual + 1
    salario = salario + cobro
    saldoSinPagar = saldoSinPagar - salario
    efectivo = efectivo + salario
    }
  method comprar(objeto){
    pagoPreferido.comprar(objeto)
  }
  method nuevoBanco(banco){
    cuentasBancarias.add(banco)
  }
  method nuevaCredito(tarjeta){
    tarjetasCredit.add(tarjeta)
  }
  method nuevaDebito(tarjeta) {
    tarjetasDebit.add(tarjeta)
  }
  method actualizarsaldoSinPagar() { 
    saldoSinPagar = saldoSinPagar + tarjetasCredit.sum({p => p.monto()}) }
  


  
  

}

class Banco {
  var property monto
  method asignarMonto(persona){
    monto = persona.salario()
  }
  
}
class Efectivo {
  method comprar(persona, objeto){
    if(persona.efectivo() > objeto.valor()){
      0.max(persona.efectivo() - objeto.valor())
      persona.recibirCompra(objeto)
    }
  }
}
class TarjetaDebito inherits Efectivo {
  const property banco 
  override method comprar(persona, objeto){
    if(banco.monto() > objeto.valor()){
      banco.monto() - objeto.valor()
      persona.recibirCompra(objeto)
    }
  }
}
class TarjetaCredito inherits TarjetaDebito {
  const property cantCuotas
  var monto
  var mesActual
  method interes() = mesActual + 1
  override method comprar(persona, objeto){
    if(banco.monto() > objeto.valor()){
      monto = monto + ( objeto.valor() / cantCuotas + objeto.valor() / self.interes() )
      persona.recibirCompra(objeto)  
    }
  }
}

class Objeto{
  var property valor  
}
