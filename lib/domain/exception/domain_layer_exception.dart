class DomainLayerException implements Exception {
  String cause; 

  DomainLayerException(this.cause); // Construtor que recebe a mensagem de erro.

  @override 
  String toString(){
    return cause; // Retorna a mensagem de erro ao exibir a exceção.
  }

}