import 'package:flutter/material.dart';

void main() {
  runApp(myApp());
}

// StatelessWidget não muda estado
// StatefulWidget muda o estado

//class herdando de uma função
class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}

//classe herdando de um estado para criar o app, originando a lista dinamica da quiz, dessa forma enumerando as perguntas
class _myAppState extends State<myApp>{
  final List<Map<String, dynamic>> perguntas = [
  {
    'pergunta': 'Qual é o nome da personagem interpretada por Kate Hudson no filme?',
    'opcoes': ['a) Andie Anderson','b) Leslie Morrow','c) Cassandra Jones'],
    'respostaCorreta': 'a) Andie Anderson',
  },
  {
    'pergunta': 'Qual é a tarefa que Andie precisa realizar para o seu trabalho na revista?',
    'opcoes': ['a) Escrever um artigo sobre moda','b) Escrever um artigo sobre como perder um homem em 10 dias ','c)Escrever um artigo sobre como manter um relacionamento ','d) Escrever um artigo sobre como conquistar um homem'],
    'respostaCorreta': 'b) Escrever um artigo sobre como perder um homem em 10 dias ',
  },
  {
    'pergunta': 'Qual é o nome do personagem interpretado por Matthew McConaughey?',
    'opcoes': ['a) Ben Barry','b) Jake Tanner','c) Tim Miller','d) Ryan Brooks'],
    'respostaCorreta': 'a) Ben Barry',
  },
  {
    'pergunta': 'Em que tipo de situação Andie e Ben se encontram durante a aposta no filme?',
    'opcoes': ['a) Eles estão se apaixonando genuinamente, sem saber da aposta','b) Eles têm uma relação de amizade, mas Andie tenta afastá-lo','c) Eles estão tentando fazer o relacionamento funcionar sem conflitos','d) Eles tentam conquistar um ao outro, mas Ben já está comprometido'],
    'respostaCorreta': 'a) Eles estão se apaixonando genuinamente, sem saber da aposta',
  },
  {
    'pergunta': 'Qual é a principal estratégia de Andie para "perder" Ben em 10 dias?',
    'opcoes': ['a) Ignorar ele completamente','b) Se tornar excessivamente ciumenta e pegajosa','c) Criar uma série de desentendimentos e situações desconfortáveis','d) Fingir ser uma pessoa diferente da que realmente é'],
    'respostaCorreta': 'c) Criar uma série de desentendimentos e situações desconfortáveis',
  },

//método inicial da função do aplicativo, inicializando com 0
 ];
  int perguntaAtual = 0;
  int pontos = 0;
  String? mensagem;
  bool quizFinalizado = false;

  //função que verifica resposta
  void verificarResposta(String respostaEscolhida) {
      String respostaCorreta = perguntas[perguntaAtual]['respostaCorreta'];

    setState(() {
      if (respostaEscolhida == respostaCorreta) {
        pontos++;
        mensagem = 'Resposta certa! +1';
      } else {
        mensagem = 'Resposta errada!';  
      }
    });
     //espera 2 segundos e passa para a próxima pergunta
    Future.delayed(Duration(seconds: 2), () {
    setState(() {
      mensagem = null;
      if(perguntaAtual < perguntas.length - 1){
        perguntaAtual++;
      } else {
        quizFinalizado = true;
      }  
   });
 });
  }

 

 //metodo para reiniciar o quiz
 void reiniciarQuiz(){
  setState(() {
    perguntaAtual = 0;
    pontos = 0;
    quizFinalizado = false;
    mensagem = null; 
  });
 }  

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme:ThemeData.dark(),
      darkTheme: ThemeData.dark(),//modo escuro
      home: Scaffold(
        appBar: AppBar(title: Text('Meu Quiz')),//titulo
        body: Center(
          child: quizFinalizado ? Column(
            mainAxisAlignment: MainAxisAlignment.center,//alinhando na vertical
            children: [
              Text('Parabéns! Você terminou o quiz',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24)),//estilizando o texto 
              SizedBox(height: 20,),//espaço entre texto e caixa
              Text('Sua pontuação: $pontos/${perguntas.length}'),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: reiniciarQuiz, 
                child: Text('Recomeçar'))
            ],
          ): Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.network('https://br.web.img3.acsta.net/c_310_420/medias/nmedia/18/87/01/04/19871068.jpg', width: 316, height: 198,),
              SizedBox(height: 20,),
              Text(
                perguntas[perguntaAtual]['pergunta'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
              ...perguntas[perguntaAtual]['opcoes'].map<Widget>((opcao){
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: ElevatedButton(
                    onPressed: mensagem == null ? () => verificarResposta(opcao) : null, 
                    child: Text(opcao)
                    )
                );
              }).toList(),
              SizedBox(height: 20),
              if(mensagem != null)
                Text(mensagem!),
              SizedBox(height: 20),
              Text('Pontuação: $pontos')
            ],
          )
          ),
        ),
      );
  }
}  