class Oficinas {
  String  valor;
  String name;
 
  Oficinas( this.name,this.valor);
 
  static List<Oficinas> getCompanies() {
    return <Oficinas>[
      
      Oficinas("30,30",'Apple'),
    ];
  }

}