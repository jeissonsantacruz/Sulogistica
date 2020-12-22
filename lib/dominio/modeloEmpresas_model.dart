class Company {
  String  valor;
  String name;
 
  Company( this.name,this.valor);
 
  static List<Company> getCompanies() {
    return <Company>[
      
      Company("30,30",'Apple'),
    ];
  }

}