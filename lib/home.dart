import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  String _resultado = "resultado";
  TextEditingController cepController = TextEditingController();

  _recuperarCep() async {
    String cep = cepController.text;
    String url = "https://viacep.com.br/ws/$cep/json/";
    http.Response response;

    response = await http.get(Uri.parse(url));
    Map<String, dynamic> retorno = json.decode(response.body);

    String logradouro = retorno["logradouro"];
    String bairro = retorno["bairro"];
    String localidade = retorno["localidade"];
    String complemento = retorno["complemento"];

    setState(() {
      _resultado = "endereço: $logradouro\nnumero: $complemento\nbairro: $bairro\ncidade: $localidade";
    });

    //print("CodigoResposta: " + response.statusCode.toString());
    //print("Resposta: " + response.body);
    //print(retorno);
    print("endereço: $logradouro\ncomplemento:$complemento\nbairro: $bairro\ncidade: $localidade");



  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Consumo de serviço web"),
      ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            //Campo do CEP
            Padding(
              padding: const EdgeInsets.only(left: 50,right: 50),
              child: TextField(
                controller: cepController,
                keyboardType: TextInputType.number,
                maxLength: 8,
                style: TextStyle(
                  fontSize: 25,
                  color: Colors.blue.shade700,
                  fontWeight: FontWeight.w600,
                ),
                decoration: const InputDecoration(
                  counterText: "",
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                  ),
                  //labelText:"Adicione",
                  hintText: "CEP",
                  filled: true,
                  fillColor: Colors.white,
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 3.0,
                    ),
                    borderRadius: BorderRadius.all(
                      Radius.circular(18.0),
                    ),
                  ),
                ),

              ),
            ),
            //Texto resposta
            Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Text(
                    _resultado,
                    style: const TextStyle(
                      fontSize: 25,
                      color: Colors.deepOrange,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ),
            //Botao
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 30, 50, 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueAccent,
                ),
                  onPressed: _recuperarCep,
                  child: const Text(
                      "Clique aqui",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
