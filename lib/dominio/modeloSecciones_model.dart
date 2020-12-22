class Secciones {
  String  valor;
  String name;
 
  Secciones( this.name,this.valor);
 
  static List<Secciones> getCompanies() {
    return <Secciones>[
      
      Secciones("30,30",'Apple'),
    ];
  }

}