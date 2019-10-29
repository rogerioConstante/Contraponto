# o plugin Contraponto

O plugin "Contraponto" analisa diversos aspectos musicais relevantes para o estudo da contraponto, especialmente do contraponto estrito (por espécies). Estes aspectos estão relacionados à condução de vozes, ao tratamento de dissonâncias, à construção melódica, e à homogeneidade da textura.

## 1. Introdução

Este texto apresenta as instruções para a instalação e utilização da extensão/plugin “Contraponto”, para o software MuseScore nas suas versões 2 ou 3. Portanto, antes de mais nada, é necessário que o mesmo esteja instalado para possibilitar o uso da extensão. O MuseScore é um software livre, gratuito e pode ser baixado em https://musescore.org/pt-br/download.

As extensões ou plugins são pequenos programas que adicionam uma funcionalidade específica ao MuseScore. Ao habilitar uma determinada extensão, uma nova opção será incluída ao menu ‘Extensões’ no MuseScore para realizar alguma ação na partitura ou em parte dela.

Algumas extensões vêm pré-instaladas com o MuseScore. Você pode encontrar muitas outras no site do programa. Os arquivos de código das extensões para o MuseScore 2 e 3 possuem a terminação “.qml”.
Instalação da extensão “Contraponto”

Baixe o arquivo (ex.: “contraponto_v0.31ms323.qml”) e coloque ele em um dos diretórios listados abaixo (mudando o que deve ser mudado para a linguagem do sistema operacional do seu computador e versão do MuseScore).

#### Windows
O MuseScore procura por extensões em: %HOME%\Documents\MuseScore2\Plugins

#### macOS e Linux
O MuseScore procura por extensões em: ~/Documents/MuseScore2/Plugins

### Habilitando/desabilitando extensões

Para ser possível acessar uma extensão instalada a partir do menu ‘Extensões’, ela precisa estar habilitada no “Gerenciador de extensões”. Uma vez habilitada, a extensão ficará disponível para uso através do menu Extensões. image

## 2. Utilização

A extensão Contraponto executa diversas verificações de aspectos musicais relevantes para o estudo do contraponto. Antes de explicar o uso da extensão em detalhe, é importante ter ciência de que o procedimento inicial será o de escrever/realizar o exercício (ou parte dele) na partitura do MuseScore para, em seguida, abrir a extensão e escolher as verificações correspondentes. Assim, é presumido que você possua um conhecimento básico de escrita musical no MuseScore. Como sugestão, indicamos uma lista de tópicos para serem estudados e/ou revisados a partir do Manual Online do programa:

• Criando uma nova partitura (https://musescore.org/pt-br/handbook/criando-uma-nova-partitura)

• Entrada de notas – básico (https://musescore.org/pt-br/handbook/entrada-de-notas)

• Vozes (https://musescore.org/pt-br/node/36056)


## 3. A extensão “Contraponto”

Esta seção apresenta os métodos de utilização da extensão “Contraponto”. Como referido anteriormente, o primeiro passo é a criação da partitura contendo o trecho musical que será analisado e verificado pela extensão, com vistas a identificar os diversos aspectos musicais de acordo com as configurações escolhidas no próprio uso da extensão.

### 3.1 Verificações

As verificações podem ser realizadas em toda a partitura ou apenas em um excerto selecionado. Se não houver nenhuma parte selecionada na partitura, a extensão realizará as verificações desde o primeiro compasso até o fim. Se houver uma seleção de trechos e/ou vozes, a verificação será somente nestes.
![image](https://user-images.githubusercontent.com/19985432/64991784-e8011080-d8a8-11e9-98fb-ba1bcb9fc446.png)

  Neste exemplo, se fosse realizada a verificação com a extensão “Contraponto”, somente as três vozes superiores e no trecho compreendido entre o terceiro tempo do segundo compasso e o início do quarto compasso, seriam analisadas. 
Se não houver nenhum trecho selecionado, a extensão fará a verificação em toda a partitura.

### 3.2 A interface

Para abrir a extensão vá ao Menu superior, selecione a alternativa “Extensões” e depois “Contraponto”. Ao abrir a extensão, aparece a sua janela principal:
![interface](https://user-images.githubusercontent.com/19985432/64991872-154dbe80-d8a9-11e9-9504-63d4acc2ed29.png)
 
Ela é dividida em duas áreas principais: a de seleção das verificações, à esquerda; a de configurações gerais, à direita. Existem outras duas áreas secundárias: a barra superior, com os botões para escolher os tipos de verificações; a barra inferior, com os botões para iniciar a verificação e para encerrar a extensão.

## 3.3 Configurações gerais

### 3.3.1 Tonalidade
Alguns tipos de verificações somente são possíveis se a tonalidade do trecho analisado for informada (ex.: resolução da sensível). Para informar, basta selecionar através dos menus de tônica, acidente e modo, clicando nas setas:
![Tonalidade](https://user-images.githubusercontent.com/19985432/64992127-a9b82100-d8a9-11e9-98f3-e1372c63e818.png)
				  
### 3.3.3 Voz do cantus firmus

### 3.3.3 Pré-configuração de verificações

Após configurar a tonalidade e a voz do cantus firmus, você pode escolher realizar a verificação com as configurações padronizadas ou criar uma nova configuração, de acordo com o seu interesse.
A extensão possui uma série de pré-configurações que podem ser selecionadas clicando nos respectivos botões (em implementação...):

Para salvar uma nova pré-configuração, após configurar as verificações (ver. 3.4), aperte no botão “Salvar”. Escolha o nome e o local onde o arquivo com a configuração ficará salvo e clique em OK. As informações que serão gravadas não incluem a configuração de tonalidade (3.3.1) e voz do cantus firmus (3.3.2).

Para utilizar uma configuração previamente criada aperte no botão “Carregar”.
![presets](https://user-images.githubusercontent.com/19985432/64995602-0d464c80-d8b2-11e9-9eba-6bf80d965c3d.png)
