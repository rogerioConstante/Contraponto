# a extensão Contraponto

A extensão "Contraponto" analisa diversos aspectos musicais em exercícios de contraponto estrito (por espécies) ou livre, verifica se as características do contraponto são compatíveis com àquelas configuradas pelo usuário e apresenta uma lista estes aspectos (ver. 3.5). Até a versão 0.4, a extensão é capaz de analisar somente contraponto a 2 vozes, tonais e modais. 
Estes aspectos analisados estão relacionados à condução de vozes, ao tratamento de dissonâncias, à construção melódica, e à homogeneidade da textura.

## 1. Introdução

Este texto apresenta as instruções para a instalação e utilização da extensão/plugin “Contraponto”, para o software MuseScore nas suas versões 2.3.2 ou 3.2.3. Portanto, antes de mais nada, é necessário que o mesmo esteja instalado para possibilitar o uso da extensão. O MuseScore é um software livre, gratuito e pode ser baixado em https://musescore.org/pt-br/download.

As extensões (ou plugins) são pequenos programas que adicionam uma funcionalidade específica ao MuseScore. Ao habilitar uma determinada extensão, uma nova opção será incluída ao menu ‘Extensões’ no MuseScore para realizar alguma ação na partitura ou em parte dela.

Algumas extensões vêm pré-instaladas com o MuseScore. Você pode encontrar muitas outras no site do programa. Os arquivos de código das extensões para o MuseScore 2 e 3 possuem a terminação “.qml”.

### Instalação da extensão “Contraponto”

Baixe o arquivo (ex.: “contraponto_v0.31ms323.qml”, para MuseScore 3.2.3 ou “contraponto_v0.31ms232.qml”, para MuseScore 2.3.2) e coloque ele em um dos diretórios listados abaixo (mudando o que deve ser mudado para a linguagem do sistema operacional do seu computador e versão do MuseScore).

#### Windows
O MuseScore procura por extensões em: %HOME%\Documents\MuseScore2\Plugins

#### macOS e Linux
O MuseScore procura por extensões em: ~/Documents/MuseScore2/Plugins

### Habilitando/desabilitando extensões

Para ser possível acessar uma extensão instalada a partir do menu ‘Extensões’, ela precisa estar habilitada no “Gerenciador de extensão”.

![gerenciador](https://user-images.githubusercontent.com/19985432/67818601-9abfb380-fa90-11e9-936d-f6b37a269158.png)

Uma vez habilitada, a extensão ficará disponível para uso através do menu Extensões.

## 2. Utilização

A extensão Contraponto executa diversas verificações de aspectos musicais relevantes para o estudo do contraponto. Antes de explicar o uso da extensão em detalhe, é importante ter ciência de que o procedimento inicial será o de escrever/realizar o exercício (ou parte dele) na partitura do MuseScore para, em seguida, utilizar a extensão. Assim, é presumido que você possua um conhecimento básico de escrita musical no MuseScore. Como sugestão, indicamos uma lista de tópicos para serem estudados e/ou revisados a partir do Manual Online do programa:

• Criando uma nova partitura (https://musescore.org/pt-br/handbook/criando-uma-nova-partitura)

• Entrada de notas – básico (https://musescore.org/pt-br/handbook/entrada-de-notas)

• Vozes (https://musescore.org/pt-br/node/36056)


## 3. A extensão “Contraponto”

Esta seção apresenta os métodos de utilização da extensão “Contraponto”. Como referido anteriormente, o primeiro passo é a criação da partitura contendo o trecho musical que será analisado e verificado pela extensão, com vistas a identificar os diversos aspectos musicais de acordo com as configurações escolhidas no próprio uso da extensão.

### 3.1 Verificações

As verificações podem ser realizadas em toda a partitura ou apenas em um excerto selecionado. Se não houver nenhuma parte selecionada na partitura, a extensão realizará as verificações desde o primeiro compasso até o fim. Se houver uma seleção de trechos e/ou vozes, a verificação será somente nestes.

![seleção](https://user-images.githubusercontent.com/19985432/67819718-20ddf900-fa95-11e9-83bf-ee495fd1ad8f.png)

  Neste exemplo, se fosse realizada a verificação com a extensão “Contraponto”, somente o trecho do 1º ao 9º compasso, seriam analisados. 
Se não houver nenhum trecho selecionado, a extensão fará a verificação em toda a partitura.
Para que a extensão realize as verificações é necessário selecionar o tipo de material musical que será analisado: cantus firmus, uma das 5 espécies ou contraponto livre. Esta seleção é feita através dos botões da barra superior.

![botóesSuperior](https://user-images.githubusercontent.com/19985432/67821892-5edf1b00-fa9d-11e9-9aae-28f129310ed2.png)

### 3.2 A interface

Para abrir a extensão vá ao Menu superior, selecione a alternativa “Extensões” e depois “Contraponto”. Ao abrir a extensão, aparece a sua janela principal:

![interface](https://user-images.githubusercontent.com/19985432/67820917-e7f45300-fa99-11e9-8409-701919aefe74.png)
 
Ela é dividida em duas áreas principais: a de seleção das verificações, à esquerda; a de configurações gerais, à direita. Existem outras duas áreas secundárias: a barra superior, com os botões para escolher os tipos de verificações; a barra inferior, com os botões para iniciar a verificação e para fechar a extensão.

## 3.3 Configurações gerais

### 3.3.1 Tônica ou Finalis
Alguns tipos de verificações somente são possíveis se a tônica ou finalis do contraponto analisado for informada (ex.: resolução da sensível). Para informar, basta selecionar através dos menus de tônica/finalis, acidente e modo, clicando nas setas:

![TonicaFinalis](https://user-images.githubusercontent.com/19985432/67821159-c6e03200-fa9a-11e9-9b88-6bf8cf2ef48d.png)
				  
### 3.3.2 Voz do Cantus Firmus (CF)
Também é necessário informar em qual voz está escrito o cantus firmus (exceto para a opção contraponto livre - versão 0.4+ - ou para opção cantus firmus). A voz superior é a 1; a inferior é a 2.

![VozCF](https://user-images.githubusercontent.com/19985432/67821413-a369b700-fa9b-11e9-8721-cbb9070d99cd.png)

### 3.3.3 Pré-configuração de verificações

Após configurar a tônica/finalis e a voz do cantus firmus, você pode escolher realizar a verificação com as configurações padronizadas ou criar uma nova configuração, de acordo com o seu interesse.
A extensão possui uma série de pré-configurações que podem ser selecionadas clicando nos respectivos botões (em implementação...):

Para salvar uma nova pré-configuração, após configurar as verificações (ver. 3.4), aperte no botão “Salvar”. Escolha o nome e o local onde o arquivo com a configuração ficará salvo e clique em OK. As informações que serão gravadas não incluem a configuração de tonalidade (3.3.1) e voz do cantus firmus (3.3.2).

Para utilizar uma configuração previamente criada aperte no botão “Carregar”.

![presets](https://user-images.githubusercontent.com/19985432/64995602-0d464c80-d8b2-11e9-9eba-6bf80d965c3d.png)

## 3.4 Configuração de verificações

Na barra superior é feita a seleção do tipo de verificação (Cantus Firmus, contraponto nas 5 espécies ou livre) a ser realizada pela extensão. Uma vez selecionado o tipo, os vários aspectos musicais analisáveis são apresentados, sendo possível configurar quais serão verificados nos exercícios de contraponto.
Quando marcamos um aspecto nesta janela de configurações, estamos dizendo para a extensão qual aspecto deve ser analisado e verificado. 
Cada tipo de verificação possui duas páginas com aspectos analisáveis: uma com os aspectos melodicos gerais outra com os demais aspectos específicos de cada tipo. A escolha da página é feita através dos botões do canto superior direito ![botõesPáginas](https://user-images.githubusercontent.com/19985432/67910597-19385600-fb62-11e9-9e73-41143f1c5489.png).

### 3.4.1 Cantus Firmus (C.F.)

Para a análise do Cantus Firmus, somente a pauta correspondente deve ser selecionada.

![CF_seleção](https://user-images.githubusercontent.com/19985432/67822128-1116e280-fa9e-11e9-8554-b7d0630e3f60.png)

Para configurar as verificações relativas ao Cantus Firmus, clica-se no botão "C.F." e aparece a janela com os vários aspectos melódicos analisáveis pela extensão.

![tela_CF](https://user-images.githubusercontent.com/19985432/67908320-e4280580-fb59-11e9-82c6-522a0ce21a00.png)

### 3.4.2 Primeira espécie (1ª esp.)




