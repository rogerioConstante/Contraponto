//=========================================================================================\\
//  Contraponto v0.3                                                                       \\
//                                                                                         \\
//  Copyright (C)2018 Rogério Tavares Constante                                            \\
//                                                                                         \\
//  Este programa é um software livre: você pode redistribuir e/ou  modificar              \\
//  ele nos termos da GNU General Public License como publicada pela                       \\
//  Free Software Foundation, seja na versão 3 da licença, ou em qualquer outra posterior. \\
//                                                                                         \\
//  Este programa é distribuído com a intenção de que seja útil,                           \\
//  mas SEM NENHUMA GARANTIA; Veja a GNU para mais detalhes.                               \\
//                                                                                         \\
//  Uma cópia da GNU General Public License pode ser encontrada em                         \\
//  <http://www.gnu.org/licenses/>.                                                        \\
//                                                                                         \\
//=========================================================================================\\

import QtQuick 2.3
import QtQuick.Controls 1.3
import QtQuick.Dialogs 1.2
import QtQuick.Window 2.1
import MuseScore 1.1

MuseScore {
      menuPath: "Plugins.Contraponto"
      description: "Contraponto.\nPlugin de auxílio na correção de exercícios de contraponto por espécies."
      version: "0.31ms232"
      //pluginType: "dialog"

// ----------------------------- janela de configuração -----------------------
  ApplicationWindow {
    id: window
    visible: true
    title: "Contraponto"
      width: 667; height: 580
    color: "#000022"

    // ------------------------------ barra superior --------------------------
    Rectangle {
            id: menu
            width: 510; height: 30
            color: "#091a23"
            border.color: "#383d47"
            border.width: 1
            x: 1

          Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left; anchors.leftMargin: 3
            spacing: 3

         // CF
            Rectangle {
             id: botao27
             property string text: "C.F."
             signal clicked
             width: bLabel27.width + 20; height: bLabel27.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea27.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
            onClicked: { melodias.visible = true; bLabel27.color = "#002e77";
                     salvarCfg();
                     bLabel26.color = "#002e77"; bLabel28.color = "#000000";
            				 especie5.visible = false; bLabel25.color = "#000000";
            				 especie4.visible = false; bLabel24.color = "#000000";
            				 especie3.visible = false; bLabel23.color = "#000000";
            				 especie2.visible = false; bLabel2.color = "#000000";
            				 especie1.visible = false; bLabel1.color = "#000000";
            				 gerais.visible = false;
            				 priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = true;
                     carregarCfg();
            				 // ambInp.text = "12"; repPadQt.text = "0"; arpMelQt.text = "1"; varDirQt.text = "4";   //melodia
            				 // tritono1.checked = true; priviGC.checked = true;
            				 // terça.checked = false; quinta.checked = false; terçaF.checked = false; quintaF.checked = false;
            				}
            MouseArea {
                  id: mArea27
                   anchors.fill: parent
                   onClicked: botao27.clicked();
             }

            Text {
             id: bLabel27
             anchors.centerIn: botao27
             color: "#000000"
             text: botao27.text
                  }
            }
         // primeira espécie
            Rectangle {
             id: botao1
             property string text: "1ª esp."
             signal clicked
             width: bLabel1.width + 20; height: bLabel1.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
               GradientStop {
                  position: 0.0
                  color: {
                        if (mArea1.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
                   }
               GradientStop { position: 1.0; color: "#334455" }
             }
             onClicked: {melodias.visible = false;
                     salvarCfg();
                     bLabel27.color = "#000000"; bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                     especie5.visible = false; bLabel25.color = "#000000";
            				 especie4.visible = false; bLabel24.color = "#000000";
            				 especie3.visible = false; bLabel23.color = "#000000";
            				 especie2.visible = false; bLabel2.color = "#000000";
            				 especie1.visible = true; bLabel1.color = "#002e77";
            				 gerais.visible = true;
            				 priEsp = true; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false;
                     carregarCfg();
                     // ambInp.text = "12"; repPadQt.text = "0"; arpMelQt.text = "1"; varDirQt.text = "4";   //melodia
            				 // tritono1.checked = true; melPFi.checked = true; priviGC.checked = true;
            				 // terça.checked = true; quinta.checked = true; terçaF.checked = true; quintaF.checked = true;
            				 // // 1ª espécie
            				 // ultNotas.checked = true; cons.checked = true;
            				 // paralela5.checked = true; paralela8.checked = true; paralela4.checked = false;
            				 // paralela36.checked = true; oculta5.checked = true; oculta8.checked = true;
            				 // ocultSalto.checked = true; consecObli.checked = false;
										 // consecCont.checked = false; inter5.checked = true; inter8.checked = true;
										 // uniss.checked = true; cruzaVozes.checked = true; falsaR.checked = true;
										 // distancia.checked = true; distQt.text = "0";
										 // tF.checked = false; dissNP.checked = false; // 2ª espécie
										 // notaP.checked = false; cambi.checked = false; borda.checked = false; // 3ª espécie
										 // susp4.checked = false; // 4ª espécie
            				 }
             MouseArea {
                  id: mArea1
                   anchors.fill: parent
                   onClicked: botao1.clicked();
             }

             Text {
             id: bLabel1
             anchors.centerIn: botao1
             color: "#000000"
             text: botao1.text
             }
            }
             // segunda espécie
            Rectangle {
             id: botao2
             property string text: "2ª esp."
             signal clicked
             width: bLabel2.width + 20; height: bLabel2.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea2.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
             onClicked: {melodias.visible = false; bLabel27.color = "#000000";
                     salvarCfg();
                     bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                  	 especie5.visible = false; bLabel25.color = "#000000";
            				 especie4.visible = false; bLabel24.color = "#000000";
            				 especie3.visible = false; bLabel23.color = "#000000";
            				 especie2.visible = true; bLabel2.color = "#002e77";
            				 especie1.visible = false; bLabel1.color = "#000000";
            				 gerais.visible = true;
            				 priEsp = false; secEsp = true; terEsp = false; quaEsp = false; quiEsp = false; melodia = false;
                     carregarCfg();
                     // ambInp.text = "19"; repPadQt.text = "0"; arpMelQt.text = "3"; varDirQt.text = "6";  // melodia
            				 // tritono1.checked = false; melPFi.checked = false; priviGC.checked = false;
            				 // terça.checked = true; quinta.checked = true; terçaF.checked = true; quintaF.checked = true;
            				 // // 1ª espécie
            				 // ultNotas.checked = true; cons.checked = false;
            				 // paralela5.checked = true; paralela8.checked = true; paralela4.checked = false;
            				 // paralela36.checked = true; oculta5.checked = true; oculta8.checked = true;
            				 // ocultSalto.checked = true; consecObli.checked = false;
										 // consecCont.checked = false; inter5.checked = true; inter8.checked = true;
										 // uniss.checked = true; cruzaVozes.checked = true; falsaR.checked = true;
										 // distancia.checked = true; distQt.text = "3";
										 // tF.checked = true; dissNP.checked = true; // 2ª espécie
										 // notaP.checked = false; cambi.checked = false; borda.checked = false; // 3ª espécie
										 // susp4.checked = false; // 4ª espécie
            				 }
            MouseArea {
                  id: mArea2
                   anchors.fill: parent
                   onClicked: botao2.clicked();
             }

            Text {
             id: bLabel2
             anchors.centerIn: botao2
             color: "#000000"
             text: botao2.text
             }
            }
             // terceira especie
            Rectangle {
             id: botao23
             property string text: "3ª esp."
             signal clicked
             width: bLabel23.width + 20; height: bLabel23.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea23.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
             onClicked: {melodias.visible = false; bLabel27.color = "#000000";
                     salvarCfg();
                     bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                  	 especie5.visible = false; bLabel25.color = "#000000";
            				 especie4.visible = false; bLabel24.color = "#000000";
            				 especie3.visible = true; bLabel23.color = "#002e77";
            				 especie2.visible = false; bLabel2.color = "#000000";
            				 especie1.visible = false; bLabel1.color = "#000000";
            				 gerais.visible = true;
            				 priEsp = false; secEsp = false; terEsp = true; quaEsp = false; quiEsp = false; melodia = false;
                     carregarCfg();
                     // ambInp.text = "19"; repPadQt.text = "1"; arpMelQt.text = "3"; varDirQt.text = "8";  // melodia
            				 // tritono1.checked = false; melPFi.checked = false; priviGC.checked = false;
            				 // terça.checked = true; quinta.checked = true; terçaF.checked = true; quintaF.checked = true;
            				 // // 1ª espécie
            				 // ultNotas.checked = true; cons.checked = false;
            				 // paralela5.checked = true; paralela8.checked = true; paralela4.checked = false;
            				 // paralela36.checked = true; oculta5.checked = true; oculta8.checked = true;
            				 // ocultSalto.checked = true; consecObli.checked = false;
										 // consecCont.checked = false; inter5.checked = true; inter8.checked = true;
										 // uniss.checked = false; cruzaVozes.checked = true; falsaR.checked = true;
										 // distancia.checked = true; distQt.text = "4";
										 // tF.checked = false; dissNP.checked = false; // 2ª espécie
										 // notaP.checked = true; cambi.checked = true; borda.checked = true; // 3ª espécie
										 // susp4.checked = false; // 4ª espécie
            				}
            MouseArea {
                  id: mArea23
                   anchors.fill: parent
                   onClicked: botao23.clicked();
             }

            Text {
             id: bLabel23
             anchors.centerIn: botao23
             color: "#000000"
             text: botao23.text
                  }
            }
             // quarta espécie
            Rectangle {
              id: botao24
              property string text: "4ª esp."
              signal clicked
              width: bLabel24.width + 20; height: bLabel24.height + 7
              border { width: 1; color: "#555555" }
              smooth: true
              radius: 2
              gradient: Gradient {
               GradientStop {
                   position: 0.0
                   color: {
                         if (mArea24.pressed)
                             return "#888d96"
                            else
                            return "#a0a8af"
                      }
               }
               GradientStop { position: 1.0; color: "#334455" }
             }
              onClicked: {melodias.visible = false; bLabel27.color = "#000000";
                     salvarCfg();
                     bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                     especie5.visible = false; bLabel25.color = "#000000";
             				 especie4.visible = true; bLabel24.color = "#002e77";
             				 especie3.visible = false; bLabel23.color = "#000000";
             				 especie2.visible = false; bLabel2.color = "#000000";
             				 especie1.visible = false; bLabel1.color = "#000000";
             				 gerais.visible = true;
             				 priEsp = false; secEsp = false; terEsp = false; quaEsp = true; quiEsp = false; melodia = false;
                     carregarCfg();
                     // ambInp.text = "19"; repPadQt.text = "0"; arpMelQt.text = "3"; varDirQt.text = "6";  // melodia
             				 // tritono1.checked = false; melPFi.checked = false; priviGC.checked = false;
             				 // terça.checked = true; quinta.checked = true; terçaF.checked = true; quintaF.checked = true;
             				 // // 1ª espécie
             				 // ultNotas.checked = true; cons.checked = false;
             				 // paralela5.checked = true; paralela8.checked = true; paralela4.checked = false;
             				 // paralela36.checked = true; oculta5.checked = true; oculta8.checked = true;
             				 // ocultSalto.checked = true; consecObli.checked = false;
 										 // consecCont.checked = false; inter5.checked = true; inter8.checked = true;
 										 // uniss.checked = false; cruzaVozes.checked = true; falsaR.checked = true;
 										 // distancia.checked = true; distQt.text = "3";
 										 // tF.checked = false; dissNP.checked = true; // 2ª espécie
 										 // notaP.checked = false; cambi.checked = false; borda.checked = false; // 3ª espécie
 										 // susp4.checked = true; // 4ª espécie
             				}
             MouseArea {
                   id: mArea24
                    anchors.fill: parent
                    onClicked: botao24.clicked();
              }
             Text {
              id: bLabel24
              anchors.centerIn: botao24
              color: "#000000"
              text: botao24.text
                   }
              }
             // quinta espécie
            Rectangle {
             id: botao25
             property string text: "5ª esp."
             signal clicked
             width: bLabel25.width + 20; height: bLabel25.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea25.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
            onClicked: { melodias.visible = false; bLabel27.color = "#000000";
                     salvarCfg();
                     bLabel26.color = "#002e77"; bLabel28.color = "#000000";
                     especie5.visible = true; bLabel25.color = "#002e77";
            				 especie4.visible = false; bLabel24.color = "#000000";
            				 especie3.visible = false; bLabel23.color = "#000000";
            				 especie2.visible = false; bLabel2.color = "#000000";
            				 especie1.visible = false; bLabel1.color = "#000000";
            				 gerais.visible = true;
            				 priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = true; melodia = false;
                     carregarCfg();

            				}
            MouseArea {
                  id: mArea25
                   anchors.fill: parent
                   onClicked: botao25.clicked();
             }

            Text {
             id: bLabel25
             anchors.centerIn: botao25
             color: "#000000"
             text: botao25.text
                  }
            }
          }
        } // botões das espécies

    Rectangle {
     	      id: menu2
            width: 124; height: 30
            color: "#002b72"
            border.color: "#383838"
            border.width: 1
            x: 525

          Row {
            anchors.verticalCenter: parent.verticalCenter
            anchors.left: parent.left; anchors.leftMargin: 3
            spacing: 3
            // gerais
            Rectangle {
             id: botao26
             property string text: "pág.1"
             signal clicked
             width: bLabel26.width + 20; height: bLabel26.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea26.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
            onClicked: {
                     melodias.visible = false; bLabel26.color = "#002e77";
                     bLabel28.color = "#000000";
            				 if (bLabel27.color == "#002e77") { melodias.visible = true } else { gerais.visible = true }
            				}
            MouseArea {
                  id: mArea26
                   anchors.fill: parent
                   onClicked: botao26.clicked();
             }
            Text {
             id: bLabel26
             anchors.centerIn: botao26
             color: "#000000"
             text: botao26.text
                  }
            }
            // melodia
            Rectangle {
             id: botao28
             property string text: "pág.2"
             signal clicked
             width: bLabel28.width + 20; height: bLabel28.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea28.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }
            onClicked: {
                  if (bLabel27.color == "#000000") {
            				 melodias.visible = true; bLabel28.color = "#002e77";
                     bLabel26.color = "#000000";
            				 gerais.visible = false; }
            				}
            MouseArea {
                  id: mArea28
                   anchors.fill: parent
                   onClicked: botao28.clicked();
             }
            Text {
             id: bLabel28
             anchors.centerIn: botao28
             color: "#000000"
             text: botao28.text
                  }
            }
       }
    } // botões para seleção de páginas

    // ------------------------------ barra inferior --------------------------
    Rectangle {
            id: barraInferior
            y: 550
            width: 664; height: 30
            color: "#091a23"
            border.color: "#383d47"
            border.width: 1
            x: 1

        Text { x: 6; y: 4; font.pointSize: 7; color: "#aaa31e"; text: "criado por" }
        Text { x: 5; y: 13; font.pointSize: 9; color: "#aaa31e"; text: "Rogério Tavares Constante" }
        Text { x: 633; y: 10; font.pointSize: 9; color: "#aaa31e"; text: "2019" }

       Rectangle {
             id: btVerifica
             property string text: "Verificar"
             signal clicked
             anchors.verticalCenter: parent.verticalCenter
             anchors.right: parent.horizontalCenter //; anchors.leftMargin: 3
             width: bLabel3.width + 20; height: bLabel3.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea3.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }

            MouseArea {
                  id: mArea3
                   anchors.fill: parent
                   onClicked: { msgResult.close(); window.lower(); verificar(); }
             }

            Text {
             id: bLabel3
             anchors.centerIn: btVerifica
             color: "#000000"
             text: btVerifica.text
                  }
            } // botão verificar

       Rectangle {
             id: btFechar
             property string text: "Fechar"
             signal clicked
             anchors.verticalCenter: parent.verticalCenter
             anchors.left: parent.horizontalCenter; anchors.leftMargin: 3
             width: bLabel4.width + 20; height: bLabel4.height + 7
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea4.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#334455" }
            }

            MouseArea {
                  id: mArea4
                   anchors.fill: parent
                   onClicked: { Qt.quit(); window.close(); msgResult.close(); }
             }

            Text {
             id: bLabel4
             anchors.centerIn: btFechar
             color: "#000000"
             text: btFechar.text
                  }
            } // botão fechar
        }
    // ------------------------------ Apresentação ---------------------------
 Item { id: apresenta; visible: true

    Text { x: 175; y: 250; font.pointSize: 19; color: "#aaa31e"; text: "Contraponto 0.3" }
    Text { x: 196; y: 278; font.pointSize: 9; color: "#aaa31e"; text: "Extensão para MuseScore" }

  }
    // ------------------------------ configurações gerais --------------------------
 Item { id: configura; visible: true;

    Rectangle { x: 513; y: 35; width: 150; height: 512;	color: "#3d0909"; radius: 2

      Text { x: 3; y: 5; color: "#d1d10a"; text: "Configurações Gerais" }

      Rectangle { id: tonalidade;
                  x: 5; y: 35; width: 140; height: 125; color: "#260000"; radius: 2

         Text { x: 5; y: 5; color: "#f9ff8c"; font.pixelSize: 15; text: "Tônica/finalis:" }

          Button {
	       	id: btTonica
	         text: "Dó"
	         width: 60
	         menu: menuTonica
	         x: 5; y: 30
	         Text { x: 65; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Tônica" }
          }


	       Button {
	       	id: btAcid
	         text: ""
	         width: 50
	         menu: menuAcid
	         x: 5; y: 60
	         Text { x: 55; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Acidente" }
	       }

	       Button {
	       	id: btModo
	         text: "Maior"
	         width: 90
	         menu: menuModo
	         x: 5; y: 90
	         Text { x: 95; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: "Modo" }
	       }

	       Menu {
	       	id: menuTonica
	       	property int value: 1
	    		    MenuItem { text: "Dó"; onTriggered: { menuTonica.value = 1; btTonica.text = "Dó" } }
				    	MenuItem { text: "Ré"; onTriggered: { menuTonica.value = 2; btTonica.text = "Ré" } }
				    	MenuItem { text: "Mi"; onTriggered: { menuTonica.value = 3; btTonica.text = "Mi" } }
				    	MenuItem { text: "Fá"; onTriggered: { menuTonica.value = 4; btTonica.text = "Fá" } }
				    	MenuItem { text: "Sol"; onTriggered: { menuTonica.value = 5; btTonica.text = "Sol" } }
				    	MenuItem { text: "Lá"; onTriggered: { menuTonica.value = 6; btTonica.text = "Lá" } }
				    	MenuItem { text: "Si"; onTriggered: { menuTonica.value = 7; btTonica.text = "Si" } }
				 }

		   Menu {
	       	id: menuAcid
	       	property string value: ""
	    		    MenuItem { text: "Natural"; onTriggered: { menuAcid.value = 1; btAcid.text = "" } }
				    	MenuItem { text: "#"; onTriggered: { menuAcid.value = 2; btAcid.text = "#" } }
				    	MenuItem { text: "b"; onTriggered: { menuAcid.value = 3; btAcid.text = "b" } }
				 }

			Menu {
	       	id: menuModo
          property int value: 1
	    		    MenuItem { text: "Maior"; onTriggered: { menuModo.value = 1; btModo.text = "Maior" } }
				    	MenuItem { text: "Menor"; onTriggered: { menuModo.value = 2; btModo.text = "Menor" } }
				    	MenuItem { text: "Jônico"; onTriggered: { menuModo.value = 3; btModo.text = "Jônico" } }
				    	MenuItem { text: "Dórico"; onTriggered: { menuModo.value = 4; btModo.text = "Dórico" } }
				    	MenuItem { text: "Frígio"; onTriggered: { menuModo.value = 5; btModo.text = "Frígio" } }
				    	MenuItem { text: "Lídio"; onTriggered: { menuModo.value = 6; btModo.text = "Lídio" } }
				    	MenuItem { text: "Mixolídio"; onTriggered: { menuModo.value = 7; btModo.text = "Mixolídio" } }
				    	MenuItem { text: "Eólio"; onTriggered: { menuModo.value = 8; btModo.text = "Eólio" } }
				    	MenuItem { text: "Lócrio"; onTriggered: { menuModo.value = 9; btModo.text = "Lócrio" } }
				 }
      }

      Rectangle { x: 5; y: 170; width: 140; height: 29; color: "#260000"; radius: 2  // voz do CF
	       Text { x: 6; y: 5; color: "#f9ff8c"; font.pixelSize: 15; text: "Voz do C.F. :"
	         Rectangle { anchors.left: parent.right; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter;
	                     width: 25; height: 22; color: "#9c9c9c"; radius: 2
             Rectangle { x: 1; y: 1; width: 23; height: 20; color: "#0c0000"; radius: 2
	            TextInput { id: vozCantusFirmus; anchors.horizontalCenter: parent.horizontalCenter;
	                        anchors.verticalCenter: parent.verticalCenter; text: "1"; font.pixelSize: 15; color: "yellow";
	                        validator: IntValidator{bottom: 1; top: 8; } }
		         }
		       }
		     }
      }

      Rectangle { id: preConfigurações; x: 5; y: 209; width: 140; height: 170; color: "#260000"; radius: 2

          Text { x: 5; y: 5; color: "#f9ff8c"; font.pixelSize: 15; text: "Pré-configurações:" }

        Rectangle { x: 4; y: 30; width: 132; height: 22; color: "#9c9c9c"; radius: 2
         Rectangle { x: 1; y: 1; width: 130; height: 20; color: "#0c0000"; radius: 2
          Text { id: nomePre; x: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12; color: "#d1d10a"; text: "sem nome" }
         }
        }
            Rectangle {
             id: salvarCnfiguração
             property string text: "Salvar"
             signal clicked
             x: 5; y: 70; width: 130; height: 40
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea41.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#5b2b2b" }
            }

            MouseArea {
                  id: mArea41
                   anchors.fill: parent
                   onClicked: { saveFileDialog.open(); }
             }

            Text {
             id: bLabel41
             anchors.centerIn: salvarCnfiguração
             color: "#101010"
             font.pointSize: 13
             text: salvarCnfiguração.text
                  }
            }

            Rectangle {
             id: carregarCnfiguração
             property string text: "Carregar"
             signal clicked
             x: 5; y: 120; width: 130; height: 40
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea42.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#5b2b2b" }
            }

            MouseArea {
                  id: mArea42
                   anchors.fill: parent
                   onClicked: { openFileDialog.open(); }
             }

            Text {
             id: bLabel42
             anchors.centerIn: carregarCnfiguração
             color: "#101010"
             font.pointSize: 13
             text: carregarCnfiguração.text
                  }
            }
      }
    }
  }
// ------------------------------ verificações -----------------------------------

 Item { id: gerais; visible: false;

   Rectangle { x: 2; y: 149; width: 508; height: 398;	color: "#3a3a3a"; radius: 2
     // primeiro intervalo
     Rectangle { id: item; x: 3; y: 3; width: 502; height: 57;	color: "#282828"; radius: 2
       CheckBox { id: primInt; checked: true; x: 3; y: 2;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "início diferente de unís./8ªJ" }
	      CheckBox { id: ex5Ji; checked: true; x: 20; y: 18;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 5ªJ, se CF voz inf." } }
	      CheckBox { id: ex3i; checked: true; x: 20; y: 35;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 3ª, se CF voz inf." } }
	    } // ultimo intervalo
	    CheckBox { id: ultInt; checked: true; x: 260; y: 2;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "final diferente de unís./8ªJ" }
	      CheckBox { id: ex5Jf; checked: true; x: 20; y: 18;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 5ªJ, se CF voz inf." } }
	      CheckBox { id: ex3f; checked: true; x: 20; y: 35;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 3ª, se CF voz inf." } }
	    }
	  }
	  // últimas notas de cada voz alcançadas por grau conjunto descendente e ascendente
	  Rectangle { id: item1a; x: 3; y: 63; width: 502; height: 47;	color: "#282828"; radius: 2
       CheckBox { id: ultNotas; checked: true; x: 5; y: 3;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter ; color: "#e0dfc3"; font.pixelSize: 14; text: "Não alcançar último intervalo por grau conj. e mov. contrário" }
	      CheckBox { id: quartaJi; checked: true; x: -3; y: 22;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 4ªJ asc / 5ªJ desc, voz inf." } }
         CheckBox { id: quartaJs; checked: true; x: 240; y: 22;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "exceto 4ªJ asc / 5ªJ desc, voz sup." } }
	    }
	  }

     // paralelas
	  Rectangle { id: item1; x: 3; y: 113; width: 502; height: 83; color: "#1c1c1c"; radius: 2

	     CheckBox { id: paralela8; checked: true; x: 5; y: 3;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "8ª paralela" }
	       Text { id: par8RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
		     TextInput { id: par8Rep; anchors.left: par8RepTxt.right; anchors.leftMargin: 5; y: par8RepTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
		      Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "paralela(s)" }
		     }
		   }

	     CheckBox { id: paralela5; checked: true; x: 5; y: 44;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª paralela" }
	       Text { id: par5RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
		     TextInput { id: par5Rep; anchors.left: par5RepTxt.right; anchors.leftMargin: 5; y: par5RepTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	         Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "paralela(s)" }
	        }
	       }

	     CheckBox { id: paralela4; checked: false; x: 245; y: 3;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "4ªJ paralela" }
	      Text { id: par4RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
	       TextInput { id: par4Rep; anchors.left: par4RepTxt.right; anchors.leftMargin: 5; y: par4RepTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
           Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "paralela(s)" }
	       }
	      }

	     CheckBox { id: paralela36; checked: true; x: 245; y: 44;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "3ª e 6ª paralela" }
	      Text { id: par36RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se ocorrer" }
	       TextInput { id: par36Rep; anchors.left: par36RepTxt.right; anchors.leftMargin: 5; y: par36RepTxt.y; font.underline: true; text: "4"; font.pixelSize: 12;  color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	        Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "paralela(s)" }
	       }
	      }
	  }

	   // ocultas
	   Rectangle { id: item2; x: 3; y: 199; width: 502; height: 50; color: "#1c1c1c"; radius: 2

	     CheckBox { id: oculta8; checked: true; x: 5; y: 3;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultAsc.checked = false; ocultExt.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "8ª oculta/direta" }
	      }

	     CheckBox { id: oculta5; checked: true; x: 5; y: 26;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultAsc.checked = false; ocultExt.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª oculta/direta" }
	      }
		 	  CheckBox { id: ocultEx; checked: true; x: 190; y: 6;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto no final" }
		 		}

		 	  CheckBox { id: ocultSalto; checked: true; x: 190; y: 24;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Somente se salto na voz superior" }
		 		}
		  }

	     // consecutivas por movimento contrário e oblíquo
	   Rectangle { id: item3; x: 3; y: 252; width: 267; height: 50;	color: "#1c1c1c"; radius: 2

	     CheckBox { id: consecObli; checked: false; x: 5; y: 3;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª e 8ª consecutivas oblíquo" }
	      }

			CheckBox { id: consecCont; checked: false; x: 5; y: 26;
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª e 8ª consecutivas contrário" }
		 		}

		 }
		  // 5ªs e 8ªs intermitentes
		 Rectangle { id: item3a; x: 275; y: 252; width: 230; height: 50; color: "#1c1c1c"; radius: 2

	     CheckBox { id: inter8; checked: true; x: 5; y: 5;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "8ª intermitente" }
		   }
		   CheckBox { id: inter5; checked: true; x: 5; y: 25;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "5ª intermitente" }
		   }
		  }
		  // uníssono
		 Rectangle { id: item3b; x: 3; y: 305; width: 263; height: 45; color: "#282828"; radius: 2

	     CheckBox { id: uniss; checked: true; x: 3; y: 5;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Uníssono" }
	       CheckBox { id: unissIF; checked: true; x: 105; y: 0
		       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "Exceto Início/Final" }}
	       Text { id: unissTxt; x: 5; y: 22; color: "#e0dfc3"; font.pixelSize: 12; text: "- se a quantidade for maior do que" }
		      TextInput { id: unissQt; anchors.left: unissTxt.right; anchors.leftMargin: 5; y: unissTxt.y; font.underline: true; text: "0"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 20;}}
		   }
		  }
		 // cruzamento de vozes

	   Rectangle { id: item4; x: 270; y: 305; width: 235; height: 45; color: "#282828"; radius: 2

			CheckBox { id: cruzaVozes; checked: true; x: 5; y: 3
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Cruzamento de vozes" }
		   }

		   CheckBox { id: falsaR; checked: true; x: 5; y: 23
		     Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Falsa relação" }
		   }
		 }
		  // distância
		 Rectangle { id: item4a; x: 3; y: 353; width: 502; height: 42; color: "#282828"; radius: 2

	     CheckBox { id: distancia; checked: true; x: 5; y: 3;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: "Distância entre as vozes" }
	       Text { id: distTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: "- se uma sequencia maior do que" }
		     TextInput { id: distQt; anchors.left: distTxt.right; anchors.leftMargin: 5; y: distTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 20;}
		      Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: "intervalo(s) maior(es) do que a décima" }
		     }
		    }
		   }
    }
  }
 Item { id: especie1; visible: false;

   Rectangle { x: 2; y: 35; width: 508; height: 111;	color: "#003f87"; radius: 2
      // consonancias
	  Rectangle { id: item1b; x: 3; y: 3; width: 502; height: 105;	color: "#b2b2b2"; radius: 2
      CheckBox { id: cons; checked: true; x: 5; y: 5;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter ; font.pixelSize: 14; text: "Dissonâncias" } }
	    CheckBox { id: maiorCons; checked: true; x: 5; y: 30;
	      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Se a maioria dos intervalos não for consonância imperfeita" } }
	  }
   }
 }
 Item { id: especie2; visible: false;

   Rectangle { x: 2; y: 35; width: 508; height: 111;	color: "#003f87"; radius: 2
     // tempos fortes
     Rectangle { id: item6; x: 3; y: 3; width: 502; height: 105; color: "#b2b2b2"; radius: 2

	     CheckBox { id: tF; checked: true; x: 5; y: 5;
	       Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Tempos fortes, quando não for consonância" }
		  }

	  // tempos fracos
	     CheckBox { id: dissNP; checked: true; x: 5; y: 30;
	        Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Dissonâncias, exceto se for Nota de passagem" }
		 	}
	   }
    }
  }
 Item { id: especie3; visible: false;

   Rectangle { x: 2; y: 35; width: 508; height: 111;	color: "#003f87"; radius: 2

    Rectangle { id: item8; x: 3; y: 3; width: 502; height: 105; color: "#b2b2b2"; radius: 2

	  Text { x: 5; y: 5; font.pixelSize: 14; text: "Dissonâncias:" }

	  CheckBox { id: notaP; checked: true; x: 5; y: 25;
		Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Exceto se for Nota de Passagem" }
	  }

	  CheckBox { id: cambi; checked: true; x: 5; y: 50;
		Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Exceto se for Cambiata" }
	  }

	  CheckBox { id: borda; checked: true; x: 5; y: 75;
		Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Exceto se for Bordadura" }
	  }
    }
   }
  }
 Item { id: especie4; visible: false;
   Rectangle { x: 2; y: 35; width: 508; height: 111;	color: "#003f87"; radius: 2
     Rectangle { id: item9; x: 3; y: 3; width: 502; height: 105; color: "#b2b2b2"; radius: 2

      CheckBox { id: susp4; checked: true; x: 5; y: 5;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 14; text: "Dissonâncias, exceto se for Suspensão" }
	   }
	  }
   }
 }
 Item { id: especie5; visible: false;
   Rectangle { x: 2; y: 35; width: 508; height: 111;	color: "#003f87"; radius: 2
    Rectangle { id: item10; x: 3; y: 3; width: 502; height: 105; color: "#b2b2b2"; radius: 2

		 Text { x: 3; y: 3; font.pixelSize: 14; text: "Dissonâncias:" }

		 CheckBox { id: nP5; checked: true; x: 93; y: 3;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13;
		   text: "Exceto se for Nota de Passagem" }
		 }

		 CheckBox { id: bord5; checked: true; x: 93; y: 23;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13;
		   text: "Exceto se for Bordadura" }
		 }

		 CheckBox { id: cambi5; checked: true; x: 93; y: 43;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13;
		   text: "Exceto se for Cambiata" }
		 }

		 CheckBox { id: susp5; checked: true; x: 93; y: 63;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13;
		   text: "Exceto se for Suspensão/Retardo" }
		 }

		 CheckBox { id: sRI5; checked: true; x: 93; y: 83;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13;
		   text: "Exceto se for Suspensão/Retardo com resolução interrompida" }
		 }
     }
   }
 }
 Item { id: melodias; visible: false;
   Rectangle { x: 2; y: 35; width: 508; height: 512;	color: "#5b5b5b"; radius: 2
    Rectangle { x: 3; y: 5; width: 502; height: 80; color: "#303030"; radius: 2
		 CheckBox { id: peNota; checked: true; x: 5; y: 5;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12; color: "#e0dfc3";
              text: "Penúltima nota:"
        Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11; color: "#e0dfc3";
              text: "se não pertencer ao V ou vii grau (quando tonal), \nou não conduzir por grau conjunto para a finalis (quando modal)" }
       }
		 }

		 CheckBox { id: ambito; checked: true; x: 5; y: 32;
		   Text { id: ambTxt1; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Âmbito melódico: se maior do que" }
		   TextInput { id: ambInp; anchors.left: ambTxt1.right; anchors.leftMargin: 5; y: ambTxt1.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "12"; validator: IntValidator{bottom: 0; top: 99;}}
		   Text { anchors.left: ambInp.right; anchors.leftMargin: 5; y: ambInp.y; font.pixelSize: 12; color: "#e0dfc3"; text: "semitons" }
		 }

		 CheckBox { id: priviGC; checked: true; x: 5; y: 55;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Se não privilegiar graus conjuntos"
		      CheckBox { id: priviGCEx; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: "e terças" } } }
		 }
	  }

	  Rectangle { x: 3; y: 88; width: 502; height: 118; color: "#303030"; radius: 2
		 Text { x: 5; y: 3;  font.pixelSize: 13; color: "#e0dfc3"; text: "Intervalos melódicos:"
			 CheckBox { id: salt7; checked: true; x: 0; y: 16;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Sétimas maiores e menores" }
			 }
			 CheckBox { id: salt6M; checked: true; x: 0; y: 35;
		      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		      color: "#e0dfc3"; text: "Sextas maiores"
		      CheckBox { id: salt6MEx; checked: true;  anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: "Exceto se ascendente" } } }
		    }
        CheckBox { id: salt6m; checked: true; x: 0; y: 54;
 		      Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
 		      color: "#e0dfc3"; text: "Sextas menores"
 		      CheckBox { id: salt6mEx; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter
 	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
 	          color: "#e0dfc3"; text: "Exceto se ascendente" } } }
 		    }
		    CheckBox { id: saltAum; checked: true; x: 0; y: 73;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Aumentados e diminutos" }
			 }
			 CheckBox { id: saltM8; checked: true; x: 0; y: 92;
			   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: "Maiores do que a oitava" }
			 }
	    }
	  }

	  Rectangle { x: 3; y: 210; width: 502; height: 100; color: "#303030"; radius: 2
	    CheckBox { id: tritono2; checked: true; x: 5; y: 4;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Trítono nas duas extremidades de movimentos melódicos" }
		 }

		 CheckBox { id: tritono1; checked: false; x: 5; y: 24;
		   Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Trítono em uma extremidade de movimentos melódicos" }
		 }

		 CheckBox { id: dissoC; checked: true; x: 5; y: 44;
		  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Dissonância composta" }
	    }

	    CheckBox { id: saltM5; checked: true; x: 5; y: 70;
		  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Salto maior do que 5ªJ deve ser compensado \ncom direcionamento contrário" }
		   CheckBox { id: saltM5Ex1; checked: true; x: 300; y: -7;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: "por grau conjunto" } }
	      CheckBox { id: saltM5Ex2; checked: true; x: 300; y: 9;
	          Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: "por salto < 5ª" } }
	    }
    }

    Rectangle { x: 3; y: 314; width: 502; height: 88; color: "#303030"; radius: 2
     CheckBox { id: varDir; checked: true; x: 5; y: 4;
		Text { id: varDirTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Variedade de direcionamentos: se >" }
		TextInput { id: varDirQt; anchors.left: varDirTxt.right; anchors.leftMargin: 5; y: varDirTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "4"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: varDirQt.right; anchors.leftMargin: 5; y: varDirQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "movimento(s) na mesma direção" }
	  }

	  CheckBox { id: repNota; checked: true; x: 5; y: 24;
		 Text { id: repNotaTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3";text: "Repetição de notas: se >" }
		 TextInput { id: repNotaQt; anchors.left: repNotaTxt.right; anchors.leftMargin: 5; y: repNotaTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
		 Text { anchors.left: repNotaQt.right; anchors.leftMargin: 5; y: repNotaQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "repetição(ões)" }
     CheckBox { id: repeteNoutra; checked: true; x: 260; y: 0;
 	  	Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
 	   	color: "#e0dfc3";text: "sem mudar nota noutra voz" }
 	   }
    }

	  CheckBox { id: repPad; checked: true; x: 5; y: 44;
		Text { id: repPadTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Repetição de padrões: se >" }
		TextInput { id: repPadQt; anchors.left: repPadTxt.right; anchors.leftMargin: 5; y: repPadTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "0"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: repPadQt.right; anchors.leftMargin: 5; y: repPadQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "repetição(ões)" }
	  }

	  CheckBox { id: arpMel; checked: true; x: 5; y: 64;
		  Text { id: arpMelTxt; anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: "Arpejo de acordes na linha melódica: se mais do que" }
      TextInput { id: arpMelQt; anchors.left: arpMelTxt.right; anchors.leftMargin: 5; y: arpMelTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: arpMelQt.right; anchors.leftMargin: 5; y: arpMelQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: "arpejo(s)" }
	    }
    }

    Rectangle { x: 3; y: 406; width: 150; height: 50; color: "#303030"; radius: 2
      CheckBox { id: melPFs; checked: true; x: 5; y: 5;
		Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Ponto focal agudo" }
	  }

	  CheckBox { id: melPFi; checked: true; x: 5; y: 25;
		Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: "Ponto focal grave" }
	  }
   }

	  Rectangle { x: 160; y: 406; width: 345; height: 50; color: "#303030"; radius: 2
      CheckBox { id: neutA; checked: true; x: 5; y: 5;
				Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: "Se não conduzir 6° e 7° alterados" }
				CheckBox { id: neutAim; checked: false; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: "imediatamente" }}
	  	}
	  	CheckBox { id: neutN; checked: true; x: 5; y: 25;
				Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: "Se não neutralizar 6° e 7° naturais" }
				CheckBox { id: neutNim; checked: false; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: "imediatamente" }}
	  	}
	 }

   Rectangle { x: 3; y: 459; width: 502; height: 50; color: "#303030"; radius: 2
     CheckBox { id: tonic; checked: true; x: 5; y:5;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "Nota inicial diferente de tônica/finalis," }

	   CheckBox { id: terça; checked: false; x: 255;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "terça," }
	   }
	   CheckBox { id: quinta; checked: false; x: 340;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "ou quinta" }
	   }
	  }
	  CheckBox { id: tonicF; checked: true; x: 5; y:25;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "Nota final diferente de tônica/finalis," }
	   CheckBox { id: terçaF; checked: false; x: 250;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "terça," }
	   }
	   CheckBox { id: quintaF; checked: false; x: 335;
		 Text { anchors.left: parent.right; anchors.leftMargin: -5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: "ou quinta" }
	   }
	  }
   }
  }
 }
} // window

//--------------------------------------------------------------------------------
 // janela com as mensagens de resultado
	ApplicationWindow {
      id: msgResult
	    visible: false;
	    title: "Resultado"
	    width: 450; height: 40
	    color: "#343530"

	    Rectangle {
          id: btResult
          property alias text: lresult.text
          signal clicked
          visible: true
          width: 100; height: 25
          x: 110
          border { width: 1; color: "#555555" }
          smooth: true
          radius: 3
          gradient: Gradient {
              GradientStop { position: 0.0
                  color: {
                        if (mArea6.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#035b25" }
            }

         Text {
           id: lresult
           anchors.centerIn: parent
           text: "Fechar"
           color: "#aaf0e1"
         }

         MouseArea {
          id: mArea6
          anchors.fill: parent
          onClicked: { window.raise(); msgResult.close(); apagaCor(); return }
         } // mouseArea
       } // Rectangle btResult

      Rectangle {
          id: btAtualiza
          property alias text: latual.text
          signal clicked
          visible: true
          width: 100; height: 25
          x: 240
          border { width: 1; color: "#555555" }
          smooth: true
          radius: 3
          gradient: Gradient {
              GradientStop { position: 0.0
                  color: {
                        if (mArea61.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#035b25" }
            }

         Text {
           id: latual
           anchors.centerIn: parent
           text: "Atualizar"
           color: "#aaf0e1"
         }

         MouseArea {
          id: mArea61
          anchors.fill: parent
          onClicked: { msgResult.close(); apagaCor(); verificar(); }
         } // mouseArea
       } // Rectangle btAtualiza

	  Component {
	    id: component
	    Rectangle {
          id: msg
          property alias text: lResul.text
          property int value: 0
          signal clicked
          visible: true
          width: 450; height: 21
          border { width: 1; color: "#000000" }
          smooth: true
          radius: 3
          color: "#6c6d6d"

         Text {
           id: lResul
           anchors.left: parent.left; anchors.leftMargin: 3
           anchors.verticalCenter: parent.verticalCenter
           text: "-"
           color: "#aaf0e1"
         }

         MouseArea {
          id: msgClick
          anchors.fill: parent
          onClicked: { colorir(parent.value); }
          }
       } // retângulo msg
	  } // componente
 } // msgResult
// ----------------------------------------------------------------------------------------------------------------
   MessageDialog {
      id: msgErros
      title: "Erros!"
      text: "-"
      property bool estado: false
      onAccepted: {
            window.raise();
            msgErros.visible=false;
      }
      visible: false;
} // msgErros
// -----------------------------------------------------------------------------------------------------------------
// -----------------------------------------------------------------------------------------------------------------
  // ---- variáveis globais ----

      property bool processaTudo: false;
      property var vozes: [];
      property var resultado: [];
      property var mensagem: [];
      property var verificados: 0;
      property var acordeGrau: [];
      property var vozCF: null;
      property bool priEsp: false;
      property bool secEsp: false;
      property bool terEsp: false;
      property bool quaEsp: false;
      property bool quiEsp: false;
      property bool melodia: false;
      property bool finaliza: false;
      property var config: [];

// ----------- funções ---------
function salvarCfg() {
   var i;
   var j = 0;

   if (melodia) { i = 0; } else
   if (priEsp) { i = 1; } else
   if (secEsp) { i = 2; } else
   if (terEsp) { i = 3; } else
   if (quaEsp) { i = 4; } else
   if (quiEsp) { i = 5; };


   config[i] = [];
 // -------------- melodia -------------
   if(peNota.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ambito.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = ambInp.text; j++;
   if(priviGC.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(priviGCEx.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(salt7.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(salt6M.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(salt6MEx.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(salt6m.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(salt6mEx.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(saltAum.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(saltM8.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(tritono2.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(tritono1.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(dissoC.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(saltM5.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(saltM5Ex1.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(saltM5Ex2.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(varDir.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = varDirQt.text; j++;
   if(repNota.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = repNotaQt.text; j++;
   if(repeteNoutra.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(repPad.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = repPadQt.text; j++;
   if(arpMel.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = arpMelQt.text; j++;
   if(melPFs.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(melPFi.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(neutA.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(neutAim.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(neutN.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(neutNim.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(tonic.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(terça.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(quinta.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(tonicF.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(terçaF.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(quintaF.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
 // ---------------- gerais -----------
   if(primInt.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ex5Ji.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ex3i.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ultInt.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ex5Jf.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ex3f.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ultNotas.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(quartaJi.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(quartaJs.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(paralela8.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = par8Rep.text; j++;
   if(paralela5.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = par5Rep.text; j++;
   if(paralela4.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = par4Rep.text; j++;
   if(paralela36.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = par36Rep.text; j++;
   if(oculta8.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(oculta5.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ocultEx.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(ocultSalto.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(consecObli.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(consecCont.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(inter8.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(inter5.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(uniss.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(unissIF.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = unissQt.text; j++;
   if(cruzaVozes.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(falsaR.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   if(distancia.checked){ config[i][j] = true; } else { config[i][j] = false; }; j++;
   config[i][j] = distQt.text;
}

function carregarCfg() {
  var i;
  var j = 0;

  if (melodia) { i = 0; } else
  if (priEsp) { i = 1; } else
  if (secEsp) { i = 2; } else
  if (terEsp) { i = 3; } else
  if (quaEsp) { i = 4; } else
  if (quiEsp) { i = 5; };


//  config[i] = [];

  peNota.checked = config[i][j]; j++;
  ambito.checked = config[i][j]; j++;
  ambInp.text = config[i][j]; j++;
  priviGC.checked = config[i][j]; j++;
  priviGCEx.checked = config[i][j]; j++;
  salt7.checked = config[i][j]; j++;
  salt6M.checked = config[i][j]; j++;
  salt6MEx.checked = config[i][j]; j++;
  salt6m.checked = config[i][j]; j++;
  salt6mEx.checked = config[i][j]; j++;
  saltAum.checked = config[i][j]; j++;
  saltM8.checked = config[i][j]; j++;
  tritono2.checked = config[i][j]; j++;
  tritono1.checked = config[i][j]; j++;
  dissoC.checked = config[i][j]; j++;
  saltM5.checked = config[i][j]; j++;
  saltM5Ex1.checked = config[i][j]; j++;
  saltM5Ex2.checked = config[i][j]; j++;
  varDir.checked = config[i][j]; j++;
  varDirQt.text = config[i][j]; j++;
  repNota.checked = config[i][j]; j++;
  repNotaQt.text = config[i][j]; j++;
  repeteNoutra.checked = config[i][j]; j++;
  repPad.checked = config[i][j]; j++;
  repPadQt.text = config[i][j]; j++;
  arpMel.checked = config[i][j]; j++;
  arpMelQt.text = config[i][j]; j++;
  melPFs.checked = config[i][j]; j++;
  melPFi.checked = config[i][j]; j++;
  neutA.checked = config[i][j]; j++;
  neutAim.checked = config[i][j]; j++;
  neutN.checked = config[i][j]; j++;
  neutNim.checked = config[i][j]; j++;
  tonic.checked = config[i][j]; j++;
  terça.checked = config[i][j]; j++;
  quinta.checked = config[i][j]; j++;
  tonicF.checked = config[i][j]; j++;
  terçaF.checked = config[i][j]; j++;
  quintaF.checked = config[i][j]; j++;
// ---------------- gerais -----------
  primInt.checked = config[i][j]; j++;
  ex5Ji.checked = config[i][j]; j++;
  ex3i.checked = config[i][j]; j++;
  ultInt.checked = config[i][j]; j++;
  ex5Jf.checked = config[i][j]; j++;
  ex3f.checked = config[i][j]; j++;
  ultNotas.checked = config[i][j]; j++;
  quartaJi.checked = config[i][j]; j++;
  quartaJs.checked = config[i][j]; j++;
  paralela8.checked = config[i][j]; j++;
  par8Rep.text = config[i][j]; j++;
  paralela5.checked = config[i][j]; j++;
  par5Rep.text = config[i][j]; j++;
  paralela4.checked = config[i][j]; j++;
  par4Rep.text = config[i][j]; j++;
  paralela36.checked = config[i][j]; j++;
  par36Rep.text = config[i][j]; j++;
  oculta8.checked = config[i][j]; j++;
  oculta5.checked = config[i][j]; j++;
  ocultEx.checked = config[i][j]; j++;
  ocultSalto.checked = config[i][j]; j++;
  consecObli.checked = config[i][j]; j++;
  consecCont.checked = config[i][j]; j++;
  inter8.checked = config[i][j]; j++;
  inter5.checked = config[i][j]; j++;
  uniss.checked = config[i][j]; j++;
  unissIF.checked = config[i][j]; j++;
  unissQt.text = config[i][j]; j++;
  cruzaVozes.checked = config[i][j]; j++;
  falsaR.checked = config[i][j]; j++;
  distancia.checked = config[i][j]; j++;
  distQt.text = config[i][j];
}

function openFile(fileUrl) {
    var request = new XMLHttpRequest();
    request.open("GET", fileUrl, false);
    request.send(null);
    var preSet = request.responseText.split("\n");

    nomePre.text = fileUrl;
    var nomeSplit = nomePre.text.split('/');
    nomePre.text = nomeSplit[nomeSplit.length-1];
//console.log(preSet.length)
    for (var i=0;i<preSet.length;i++) {

      if (preSet[i] == "true") { preSet[i] = true; } else
      if (preSet[i] == "false") { preSet[i] = false; };

    };

    var n = 0;

    cons.checked = preSet[n]; n++; // 1ª espécie
    maiorCons.checked = preSet[n]; n++;
    tF.checked = preSet[n]; n++;  // 2ª espécie
    dissNP.checked = preSet[n]; n++;
    notaP.checked = preSet[n]; n++; // 3ª espécie
    cambi.checked = preSet[n]; n++;
    borda.checked = preSet[n]; n++;
    susp4.checked = preSet[n]; n++; // 4ª espécie
    nP5.checked = preSet[n]; n++;   // 5ª espécie
    bord5.checked = preSet[n]; n++;
	  cambi5.checked = preSet[n]; n++;
	  susp5.checked = preSet[n]; n++;
	  sRI5.checked  = preSet[n]; n++;

for (var i = 0; i < 6; i++) {      // gerais e melodia em cada espécie
  for (var j = 0; j < 71; j++) {
    config[i][j] = preSet[n]; n++;
  };
};
carregarCfg();
    //return request.responseText;
}

function saveFile(fileUrl, text) {
    var request = new XMLHttpRequest();
    request.open("PUT", fileUrl, false);
    var conteudoArquivo = "";


// ---------------- 1ª espécie ----------------------
    if(cons.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(maiorCons.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
// ---------------- 2ª espécie ----------------------
    if(tF.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(dissNP.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
// ---------------- 3ª espécie ----------------------
    if(notaP.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(cambi.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(borda.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
// ---------------- 4ª espécie ----------------------
    if(susp4.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
// ---------------- 5ª espécie ----------------------
    if(nP5.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(bord5.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(cambi5.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(susp5.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
    if(sRI5.checked){conteudoArquivo+="true\n";}else{conteudoArquivo+="false\n";};
// ---------------- gerais e melodia ---------------------
for (var i = 0; i < 6; i++) {
  for (var j = 0; j < 71; j++) {
    conteudoArquivo+=config[i][j]+"\n";
  };
};
    request.send(conteudoArquivo);
    return request.status;
}

FileDialog {
    id: openFileDialog
    nameFilters: ["All files (*)"]
    onAccepted: openFile(openFileDialog.fileUrl)
}

FileDialog {
    id: saveFileDialog
    selectExisting: false
    nameFilters: ["Text files (*.txt)", "All files (*)"]
    onAccepted: saveFile(saveFileDialog.fileUrl, "")
}

function colorir(valor) {

     curScore.startCmd();

      apagaCor();

      mensagem[valor-1].color = "#6b6746";

      for (var z=1;z<resultado[valor].length;z++) {
            if (resultado[valor][z]) { resultado[valor][z].color = "red"; };
         };

      curScore.endCmd();

      msgResult.raise();
   }

function apagaCor() {

      for (var x=1;x<=verificados;x++) { // apaga seleções anteriores e botões

	         mensagem[x-1].color = "#6c6d6d";

	      for (var z=1;z<resultado[x].length;z++) {
            if (resultado[x][z]) { resultado[x][z].color = "black"; };
         };

	    };

   }

function destroirMsg() {
    for (var i=0;i<verificados;i++) {

     if (mensagem[i]) {
     	mensagem[i].destroy();
     };
	 };

   }

function removeRepetição(tpc) {

  var acordeX = [];

  for (var i = 0;i < tpc.length; i++){
        if(acordeX.indexOf(tpc[i]) == -1){
            acordeX.push(tpc[i]);
        };
  };

  return acordeX;

}

function verificaGrauMelodico(nota,tom) {
 	var x = nota - tom;
 	var modo = btModo.text;

  switch(modo) {
  	case "Maior":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case 4: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case 3: return 6; break;
  	 	case 5: return 7; break;
  	 }; break;
  	case "Menor":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case -3: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case -4: return 6; break;
  	 	case 3: return "6+"; break;
  	 	case -2: return 7; break;
  	 	case 5: return "7+"; break;
  	 }; break;
  	case "Jônico":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case 4: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case 3: return 6; break;
  	 	case 5: return 7; break;
  	 }; break;
  	case "Dórico":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case -3: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case 3: return 6; break;
  	 	case -2: return 7; break;
  	 }; break;
  	case "Frígio":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case -5: return 2; break;
  	 	case -3: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case -4: return 6; break;
  	 	case -2: return 7; break;
  	 }; break;
  	case "Lídio":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case 4: return 3; break;
  	 	case 6: return 4; break;
  	 	case 1: return 5; break;
  	 	case 3: return 6; break;
  	 	case 5: return 7; break;
  	 }; break;
  	case "Mixolídio":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case 4: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case 3: return 6; break;
  	 	case -2: return 7; break;
  	 }; break;
  	case "Eólio":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case 2: return 2; break;
  	 	case -3: return 3; break;
  	 	case -1: return 4; break;
  	 	case 1: return 5; break;
  	 	case -4: return 6; break;
  	 	case -2: return 7; break;
  	 }; break;
  	case "Lócrio":
  	 switch (x) {
  	 	case 0: return 1; break;
  	 	case -5: return 2; break;
  	 	case -3: return 3; break;
  	 	case -1: return 4; break;
  	 	case -6: return 5; break;
  	 	case -4: return 6; break;
  	 	case -2: return 7; break;
  	 }; break;

  }
 }

function verificaTempoForte(tempo,metrica) {
  if (tempo%1 > 0) { return "c" };
   switch(metrica) {
    case 1:
    case 2:
    case 3: if (tempo == 1) { return "F"; } else { return "f"; };
      break;
    case 4: if (tempo == 1 || tempo == 3) { return "F"; } else { return "f"; };
      break;
    case 6: if (tempo == 1 || tempo == 4) { return "F"; } else { return "f"; };
      break;
    case 8: if (tempo == 1 || tempo == 3 || tempo == 5 || tempo == 7) { return "F"; } else { return "f"; };
      break;
    case 9: if (tempo == 1 || tempo == 4 || tempo == 7) { return "F"; } else { return "f"; };
      break;
    case 12: if (tempo == 1 || tempo == 4 || tempo == 7 || tempo == 10) { return "F"; } else { return "f"; };
      break;
   };

}

function verificaConsonancia(x) {
  var int1 = x % 12;
  if (int1 == 0 || int1 == 7) { return "CP"; } else
  if (int1 == 3 || int1 == 4 || int1 == 8 || int1 == 9) { return "CI"; } else { return "D" };
}

function direção(x) {
            if (x > 0) return(1); //  ascendente
            else if (x == 0) return(0); // sem direção
            else return(-1); // descendente
      }

function tonicaTPC(nome,acidente) {

   var tonica = nome+acidente

   switch (tonica) {
     case "Dó": return 14; break;
     case "Dó#": return 21; break;
     case "Dób": return 7; break;
     case "Ré": return 16; break;
     case "Ré#": return 23; break;
     case "Réb": return 9; break;
     case "Mi": return 18; break;
     case "Mi#": return 25; break;
     case "Mib": return 11; break;
     case "Fá": return 13; break;
     case "Fá#": return 20; break;
     case "Fáb": return 6; break;
     case "Sol": return 15; break;
     case "Sol#": return 22; break;
     case "Solb": return 8; break;
     case "Lá": return 17; break;
     case "Lá#": return 24; break;
     case "Láb": return 10; break;
     case "Si": return 19; break;
     case "Si#": return 26; break;
     case "Sib": return 12; break;
   }

}

function n2m(texto) {
  if (texto.length > 3 || texto.length < 2) { msgErros.text += "Índice inválido para o cálculo da extensão das vozes!\n";
                                              msgErros.estado = true; return null; } else
  if (texto.length == 2) {var nota = texto.substr(0,1);} else { var nota = texto.substr(0,2); };

  nota = nota.toUpperCase();

  switch(nota.substr(0,1)) {
   case "C": var midi = 0; break;
   case "D": var midi = 2; break;
   case "E": var midi = 4; break;
   case "F": var midi = 5; break;
   case "G": var midi = 7; break;
   case "A": var midi = 9; break;
   case "B": var midi = 11; break;
  };

  if (nota.length == 2) {
   switch(nota.substr(1,1)) {
    case "#": midi = midi + 1; break;
    case "B": midi = midi - 1; break;
   };
  };

  var oitava = parseInt(texto.substr(-1,1));
  if (oitava > 5 || oitava < 1) { msgErros.text += "Índice inválido para o cálculo da extensão das vozes!\n";
                                  msgErros.estado = true; return null; };

  switch(oitava) {
  	case 1: midi = midi + 36; break;
  	case 2: midi = midi + 48; break;
  	case 3: midi = midi + 60; break;
  	case 4: midi = midi + 72; break;
  	case 5: midi = midi + 84; break;
  };

  return midi;

}

function semi2Int(st) { // converte qt de semitons para intervalos
  switch(st){
   case 0: return "U";
   case 1:
   case 2: return 2;
   case 3:
   case 4: return 3;
   case 5: return 4;
   case 6: return "trit";
   case 7: return 5;
   case 8:
   case 9: return 6;
   case 10:
   case 11: return 7;
   case 12: return 8;
   case 13:
   case 14: return 9;
   case 15:
   case 16: return 10;
   case 17: return 11;
   case 18: return "trit+";
   case 19: return 12
   case 20:
   case 21: return 13;
   case 22:
   case 23: return 14;
   case 24: return 15;
  };
}

function tpc2Int(st) { // converte intervalo tpc para intervalos
  switch(st){
   case -7: return "Ud"
   case 0: return "UJ";
   case 7: return "Ua";
   case -12: return "2d";
   case -5: return "2m";
   case 2: return "2M";
   case 9: return "2a";
   case -10: return "3d";
   case -3: return "3m";
   case 4: return "3M";
   case 11: return "3a";
   case -8: return "4d";
   case -1: return "4J";
   case 6: return "4a";
   case -6: return "5d";
   case 1: return "5J";
   case 8: return "5a";
   case -11: return "6d";
   case -4: return "6m";
   case 3: return "6M";
   case 10: return "6a";
   case -9: return "7d";
   case -2: return "7m";
   case 5: return "7M";
   case 12: return "7a";
  };
}
//-----------------------------------------------
function verificar() {
 vozCF = null;
 finaliza = false;
 msgErros.text = "";
 msgErros.estado = false;
 msgResult.height = 40;

 if (!priEsp && !secEsp && !terEsp && !quaEsp && !quiEsp && !melodia) {
          msgErros.text += "Erro! \n Nenhuma opção selecionada!\n Verifique a barra superior.";
                       msgErros.visible=true; return; };

 destroirMsg();
 resultado = [];

 carregarNotas();
 vCantusFirmus();

 if (finaliza) { return; };

 // --------------- melodia --------------------
 if (peNota.checked) { penultimaNota(); };
 if (ambito.checked) { ambitoMelodico(); };
 if (priviGC.checked) { privilegiaConj(); };
 if (salt7.checked) { melodia7(); };
 if (salt6M.checked || salt6m.checked) { melodia6(); };
 if (saltAum.checked) { melodiaAum(); };
 if (saltM8.checked) { melodia8(); };
 if (tritono2.checked) { tritono2Ext(); };
 if (tritono1.checked) { tritono1Ext(); };
 if (dissoC.checked) { melodiaDC(); };
 if (saltM5.checked) { melodia5(); };
 if (varDir.checked) { variedadeDirecionamento(); };
 if (repNota.checked) { repetiçãoNotas(); };
 if (repPad.checked) { repetePadrão(); };
 if (arpMel.checked) { melodiaArpejo(); };
 if (melPFs.checked || melPFi.checked) { melodiaPF(); };
 if (btModo.text != "Maior" && (neutA.checked || neutN.checked)) { neutralterações(); };
 if (tonic.checked || tonicF.checked) { notaIniFin(); };
 // --------------- primeira espécie ------------
 if (!melodia && (primInt.checked || ultInt.checked)) { primUltIntervalo(); };
 if (!melodia && ultNotas.checked) { alcançarMovContra(); };
 if (!melodia && priEsp && cons.checked) { consonancias(); };
 if (!melodia && (paralela5.checked || paralela8.checked)) { quintasOitavas(); };
 if (!melodia && paralela4.checked) { quartas(); };
 if (!melodia && paralela36.checked) { terçasSextas(); };
 if (!melodia && (oculta5.checked || oculta8.checked)) { ocultas(); };
 if (!melodia && (consecObli.checked || consecCont.checked)) { consecutivas(); };
 if (!melodia && (inter5.checked || inter8.checked)) { intermitentes(); };
 if (!melodia && uniss.checked) { unissono(); };
 if (!melodia && cruzaVozes.checked) { cruzamento(); };
 if (!melodia && falsaR.checked) { falsaRelação(); };
 if (!melodia && distancia.checked) { espaçamento(); };
 // --------------- segunda espécie --------------
 if (secEsp && tF.checked) { tempoForte(); };
 if (secEsp && dissNP.checked) { notaPassagem(); };
 // --------------- terceira espécie -------------
 if (terEsp && (notaP.checked || cambi.checked || borda.checked)) { dissonancias3(); };
 // --------------- quarta espécie ---------------
 if (quaEsp && susp4.checked) { suspensao4() };
 // --------------- quinta espécie ---------------
 if (quiEsp) { dissonancias5(); };
 // ----------------------------------------------

  for (var i=0;i<verificados;i++) {

  	mensagem[i] = component.createObject(msgResult);
  	mensagem[i].y = i*25 + 40;
  	mensagem[i].text = resultado[i+1][0];
  	mensagem[i].value = i+1;
  	msgResult.height = i*25 + 70;
  };

  msgResult.visible = true;

  if (msgErros.estado) { msgErros.visible = true; };
}
//---------------------------------------
function carregarNotas() {

  console.log("Contraponto .............................................. Rogério Tavares Constante - 2019(c)")

  if (typeof curScore == 'undefined' || curScore == null) { // verifica se há partitura
     console.log("nenhuma partitura encontrada");
     msgErros.text = "Erro! \n Nenhuma partitura encontrada!";
                       msgErros.visible=true; finaliza = true; return; };

  //procura por uma seleção

  var pautaInicial;
  var pautaFinal;
  var posFinal;
  var posInicial;
  processaTudo = false;
  vozes = [];
  var cursor = curScore.newCursor();

  cursor.rewind(1);

    if (!cursor.segment) {
       // no selection
       console.log("nenhuma seleção: processando toda partitura");
       processaTudo = true;
       pautaInicial = 0;
       pautaFinal = curScore.nstaves;

     } else {
       pautaInicial = cursor.staffIdx;
       posInicial = cursor.tick;
       cursor.rewind(2);
       pautaFinal = cursor.staffIdx + 1;
       posFinal = cursor.tick;
          if(posFinal == 0) {  // se seleção vai até o final da partitura, a posição do fim da seleção (rewind(2)) é 0.
          							// para poder calcular o tamanho do segmento, pega a última posição da partitura (lastSegment.tick) e adiciona 1.
          posFinal = curScore.lastSegment.tick + 1;
          }
       cursor.rewind(1);
    };

  // ------------------ inicializa variáveis de dados

            var seg = 0;
            var carregou;
            verificados = 0;
            var trilha;
            var trilhaInicial = pautaInicial * 4;
            var trilhaFinal = pautaFinal * 4;
            var compasso = 0;
            var compassoAtual = null;
            var tiqueComp = 0;

          if (!processaTudo) {
            cursor.rewind(0);
            while (cursor.segment && cursor.segment.tick < posInicial) {
     	       if (cursor.measure != compassoAtual) {
           	   compasso++;
           	   compassoAtual = cursor.measure;
           	 };
           	 cursor.next();
            };
          };

            // lê as informações da seleção (ou do documento inteiro, caso não haja seleção)

            if(processaTudo) { // posiciona o cursor no início
                  cursor.rewind(0);
            } else {
                  cursor.rewind(1);
            };

            var segmento = cursor.segment;

            var pausa = false;

           while (segmento && (processaTudo || segmento.tick < posFinal)) {

           	var denominador = cursor.timeSignature.denominator;
            var numerador = cursor.timeSignature.numerator;

           	carregou = false;

           	 if (cursor.measure != compassoAtual) {
           	   compasso++;
           	   compassoAtual = cursor.measure;
           	   tiqueComp = segmento.tick;
           	 };

             var tempo = ((segmento.tick - tiqueComp) / (1920 / denominador)) + 1;
             var voz = 0;

	          vozes[seg] = { nota: [], tonal: [], posição: [], duração: [], trilha: [], objeto: [], ligadura: [], tempo: [] };

             // Passo 1: ler as notas e guardar em "vozes"
               for (trilha = trilhaInicial; trilha < trilhaFinal; trilha++) {
               	cursor.track = trilha;

            	  if (segmento.elementAt(trilha)) {

            	  	 if (segmento.elementAt(trilha).type == Element.REST) {
            	  	 	 if (trilha == trilhaInicial) { pausa = true;
            	  	    } else {  cursor.next(); segmento = cursor.segment; trilha--;
            	  	              continue; };

            	  	 } else if (segmento.elementAt(trilha).type == Element.CHORD) {
                     var duração = segmento.elementAt(trilha).duration.ticks;
                     var notas = segmento.elementAt(trilha).notes;

                     for (var j=notas.length-1; j>=0;j--) {

                       vozes[seg].nota[voz] = notas[j].pitch;
                       vozes[seg].tonal[voz] = notas[j].tpc
                       vozes[seg].trilha[voz] = trilha;
                       vozes[seg].posição[voz] = segmento.tick;
                       vozes[seg].duração[voz] = duração;
                       vozes[seg].compasso = compasso;
                       vozes[seg].formula = [numerador, denominador];
                       vozes[seg].objeto[voz] = notas[j];
                       if (notas[j].tieBack) { vozes[seg].ligadura[voz] = true; } else { vozes[seg].ligadura[voz] = false; }
                       vozes[seg].tempo[voz] = tempo;

                       voz++;
                       carregou = true;

                     };
                   };
                 } else {

                   if (vozes[seg-1]) {

					     for (var y=0; y<vozes[seg-1].nota.length;y++) {
						    if (trilha == vozes[seg-1].trilha[y]) {
						    	if ((vozes[seg-1].duração[y] + vozes[seg-1].posição[y]) > segmento.tick) { var prolonga = true; } else { var prolonga = false; };
						    if (prolonga)  {
						        vozes[seg].nota[voz] = vozes[seg-1].nota[y];
	                       vozes[seg].tonal[voz] = vozes[seg-1].tonal[y];
	                       vozes[seg].trilha[voz] = vozes[seg-1].trilha[y];
	                       vozes[seg].posição[voz] = segmento.tick;
	                       vozes[seg].duração[voz] = vozes[seg-1].duração[y] - (segmento.tick - vozes[seg-1].posição[y]);
	                       vozes[seg].compasso = compasso;
	                       vozes[seg].formula = [numerador, denominador];
	                       vozes[seg].objeto[voz] = vozes[seg-1].objeto[y];
								  vozes[seg].ligadura[voz] = true;
								  vozes[seg].tempo[voz] = tempo;

						        voz++;
						        carregou = true;
							   };
							   break;
						    };
					     };
					  };
                };
              };

              if (carregou) {
                cursor.track = trilhaInicial;
                 for (var i=1;i<vozes[seg].nota.length;i++) {
                 	 if (vozes[seg].duração[i] < vozes[seg].duração[i-1]) { cursor.track = vozes[seg].trilha[i]; };
                 };
                 seg++;
              };

        		  cursor.next(); segmento = cursor.segment;

           };
    if (pausa && !melodia) { vozes.splice(0, 1); pausa = false; };

   if (seg == 0) { msgErros.text += "Nenhum acorde carregado!!\n";
                        msgErros.estado=true; Qt.quit(); };

}
// --------------------------------------
function vCantusFirmus() {

	if (melodia) { vozCF = 0 } else { vozCF = parseInt(vozCantusFirmus.text) - 1; };

  if (vozCF >= vozes[vozes.length-1].nota.length) {
          msgErros.text = "Erro! \n voz do Cantus Firmus não detectado! \n Por favor, insira um valor válido na aba de Configurações Gerais.";
                       msgErros.visible=true; finaliza = true; return; };
}
//------------------- melodia -----------
function penultimaNota() {
 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação da penúltima nota!\n";
                        msgErros.estado = true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);

   if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

   var x = vozes.length - 1;

   var g1 = parseInt(verificaGrauMelodico(vozes[x-1].tonal[voz], tom));
//console.log("----",parseInt(menuModo.value))
   if (parseInt(menuModo.value) < 3) {
	   if (g1 != 5 && g1 != 7 && g1 != 2 && g1 != 4) {
	      verificados++;
	      criaResultado(verificados, x-1, voz, voz, "penúltima nota não pertence ao V ou viiº", 1, 1);
	    }; } else {
      if (g1 != 2 && g1 != 7) {
	      verificados++;
	      criaResultado(verificados, x-1, voz, voz, "não conduz para finalis por grau conj.", 1, 1);
       };
   };
}

function ambitoMelodico() {

  if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

   var agudo = 0, grave = 128;
   var pos1, pos2, posI, posF;

   for (var i=0;i<vozes.length;i++) { // detecta as extremidades da melodia
     var nota = vozes[i].nota[voz];
     if (nota > agudo) { agudo = nota; pos1 = i; };
     if (nota < grave) { grave = nota; pos2 = i; };

   };

   if (pos1 > pos2) { posI = pos2; posF = pos1; } else { posI = pos1; posF = pos2; };

   var extensao = agudo - grave;
   var numAcordes = (posF - posI)+1;
   var extQt = parseInt(ambInp.text);

   if (extensao > extQt) {
     verificados++;
     criaResultado(verificados, posF, voz, voz, "Âmbito melódico", numAcordes, 1);
   };
}

function privilegiaConj() {
  if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de privilegiar grau conjunto!\n";
                        msgErros.estado = true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };
  var numAcordes = vozes.length;
  var conj = 0, disj = 0;

  for (var x=1;x<vozes.length;x++) { // percorre acordes

   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   if (!vozes[x].ligadura[voz]) { var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
    if (priviGCEx.checked) { if (intervalo > 4) { disj++; } else { conj++ };
    } else if (intervalo > 2) { disj++; } else { conj++ };
   };
  };
   if (priviGCEx.checked) { var nome = "Não privilegia graus conj. e 3ªs"; } else { var nome = "Não privilegia grau conjunto"; }
   if (conj <= disj) {
      verificados++;
      criaResultado(verificados, x-1, voz, voz, nome, numAcordes, 1);
    };
}

function melodia7() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sétima!\n";
                        msgErros.estado=true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

   if (intervalo == 10 || intervalo == 11) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 7ª", 2, 1);
    };
  };
}

function melodia6() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sexta!\n";
                        msgErros.estado=true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {return;};

   var intervalo = vozes[x].nota[voz] - vozes[x-1].nota[voz];

   if (intervalo == 9 || intervalo == -9) {
     if (salt6MEx.checked && intervalo > 0) { continue; };
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 6ªM", 2, 1);
    } else
   if (intervalo == 8 || intervalo == -8) {
    if (salt6mEx.checked && intervalo > 0) { continue; };
     verificados++;
     criaResultado(verificados, x, voz, voz, "intervalo melódico de 6ªm", 2, 1);
   };
  };
}

function melodiaAum() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo melódico aumentado!\n";
                        msgErros.estado = true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var g1 = parseInt(verificaGrauMelodico(vozes[x-1].tonal[voz], tom));
   var g2 = parseInt(verificaGrauMelodico(vozes[x].tonal[voz], tom));

   if (intervalo == 6 || (intervalo == 3 && (g1 == 6 || g1 == 7) && (g2 == 6 || g2 == 7))) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico aumentado", 2, 1);
    };
  };
}

function melodia8() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a oitava!\n ";
                        msgErros.estado=true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  for (var x=1;x<vozes.length;x++) { // percorre acorde
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

   if (intervalo > 12) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico > 8ª", 2, 1);
    };
  };
}

function tritono2Ext() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação de trítono!\n";
                        msgErros.estado = true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var novaVoz = [], mov = [], qtM = 0, posI = 0;

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes extremidade 1

   qtM++;

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   mov[x-1] = dir1;

   if (x>=2 && mov[x-1] != mov[x-2] && dir1 != 0) {

    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[x-1].nota);
      var pIni = (novaVoz[x-1].pos - novaVoz[posI].pos); var pFinal = novaVoz[x-1].pos;
      listaVerifica(intervalo);
    };
   posI = x-1; qtM = 0; };

    if (qtM > 0 && x == novaVoz.length-1) {
      var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[x].nota);
      var pIni = novaVoz[x].pos - novaVoz[posI].pos; var pFinal = novaVoz[x].pos;
       listaVerifica(intervalo);
      };
   };

 function listaVerifica(intervalo) {
  if ((intervalo == 6 || intervalo == 18) && pIni > 1) {
   verificados++;
   criaResultado(verificados, pFinal , voz, voz, "trítono nas 2 extremidades", pIni + 1, 1); };

 };

}

function tritono1Ext() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação de trítono!\n";
                        msgErros.estado = true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var novaVoz = [], mov = [], qtM = 0, posI = 0;

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes extremidade 1

   qtM++;

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
  // console.log("x:", x, "mov:", dir1)

   if (dir1 == 0) { mov[x-1] = mov[x-2]} else { mov[x-1] = dir1; };

   if (x>=2 && mov[x-1] != mov[x-2]) {
    for (var i = posI+1; i < x-2; i++) { //   console.log("voz:", voz, " | ", novaVoz[i].nota, novaVoz[x-1].nota);
	    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[i].nota - novaVoz[x-1].nota);
	      var pIni = (novaVoz[x-1].pos - novaVoz[i].pos); var pFinal = novaVoz[x-1].pos;
	      listaVerifica(intervalo);
	    };
	  };
	 for (var i = posI+1; i < x-1; i++) { //console.log("voz:", voz, " x: ", " | ", novaVoz[posI].nota, novaVoz[i].nota)
	    if (qtM >= 2) { var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[i].nota);
	      var pIni = (novaVoz[i].pos - novaVoz[posI].pos); var pFinal = novaVoz[i].pos;
	      listaVerifica(intervalo);
	    };
	  };

   posI = x-1; qtM = 0; };

   if (qtM > 0 && x == novaVoz.length-1) {
     for (var i = posI+1; i < x-2; i++) {  //console.log("voz:", voz, " | ", novaVoz[i].nota, novaVoz[x].nota);
      var intervalo = Math.abs(novaVoz[i].nota - novaVoz[x].nota);
      var pIni = novaVoz[x].pos - novaVoz[i].pos; var pFinal = novaVoz[x].pos;
       listaVerifica(intervalo);
      };
     for (var i = posI+1; i < x; i++) { //console.log("voz:", voz, " | ", novaVoz[posI].nota, novaVoz[i].nota)
      var intervalo = Math.abs(novaVoz[posI].nota - novaVoz[i].nota);
      var pIni = novaVoz[i].pos - novaVoz[posI].pos; var pFinal = novaVoz[i].pos;
       listaVerifica(intervalo);
      };
    };
   };

 function listaVerifica(intervalo) {
  if ((intervalo == 6 || intervalo == 18) && pIni > 1) {
   verificados++;
   criaResultado(verificados, pFinal , voz, voz, "trítono em 1 extremidade", pIni + 1, 1); };

 };
}

function melodiaDC() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Dissonância composta!\n";
                       msgErros.estado=true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

 var novaVoz = [];

  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=2;x<novaVoz.length;x++) { // percorre acordes

   var int1 = Math.abs(novaVoz[x].nota - novaVoz[x-2].nota);
   var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   if ((int1 == 10 || int1 == 11 || int1 == 13 || int1 == 14 || int1 == 18)  && dir1 == dir2 && dir1 != 0) {
     var numNotas = (novaVoz[x].pos - novaVoz[x-2].pos) + 1;
      verificados++;
      criaResultado(verificados,  novaVoz[x].pos, voz, voz, "dissonância composta", numNotas, 1);
   };
  };
}

function melodia5() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a quarta justa!\n";
                       msgErros.estado=true; return; };

 var cond1 = false, cond2 = false, cond3 = false;

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var novaVoz = [];
   for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };
  for (var x=2;x<novaVoz.length;x++) { // percorre acordes
   if (!novaVoz[x].nota || !novaVoz[x-1].nota) {continue;};

   var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);

   var dir2 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir3 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   var compensa = 13;
   if (saltM5Ex1.checked) { compensa = 3; };
   if (saltM5Ex2.checked) { compensa = 6; };

   if (int1 > 7) {
     if (dir3 != dir2 && dir3 != 0 && int2 < compensa) { continue; } else {
      verificados++;
      criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "intervalo melódico > 5ªJ", 2, 1);
     };
   };
  };
}

function variedadeDirecionamento() {

 var qtMov = parseInt(varDirQt.text);

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var asc = [], desc = [], mov = [], novaVoz = [];
  var qtA = 0, qtD = 0, qtN = 0, pos1 = 0;

   for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes

   var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
   if (x < novaVoz.length-1) { var posIni = (novaVoz[x-1].pos - novaVoz[pos1].pos) + 1; }
     else { var posIni = (novaVoz[x].pos - novaVoz[pos1].pos) + 1; };

   mov[x-1] = dir1;

   switch(mov[x-2]) {
    case 0:
      if (x>=3 && mov[x-1] != mov[x-3]) { testaQt(qtN); pos1 = x-1; asc = []; qtA = 0; desc = []; qtD = 0; };
      break;
    case -1:
    case 1:
      if (x>=2 && mov[x-1] != mov[x-2] && mov[x-1] != 0) { testaQt(qtN); pos1 = x-1; asc = []; qtA = 0; desc = []; qtD = 0; };
      break;
   };

   if (dir1 == 1) { asc[qtA] = dir1; qtA++; qtN = asc.length; } else
   if (dir1 == -1) { desc[qtD] = dir1; qtD++; qtN = desc.length; };

  };
  testaQt(qtN);

 function testaQt(qt) {

   if (qt > qtMov) {
           verificados++;
           criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "movimentos na mesma direção", posIni, 1); };
 };

}

function repetiçãoNotas() {

	var qtRep = parseInt(repNotaQt.text);

  if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var novaVoz = []; var qt = 0, pos1 = 0;

   for (var x=0;x<vozes.length;x++) {
     //console.log(x,")",vozes[x].nota[voz], vozes[x].ligadura[voz])
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
    } else if (novaVoz.length > 1) { novaVoz[novaVoz.length-1].pos = x; };
   };

  for (var x=1;x<novaVoz.length;x++) { // percorre acordes

   if (x < novaVoz.length) { var posIni = novaVoz[x-1].pos - novaVoz[pos1].pos; };

   if (novaVoz[x].nota == novaVoz[x-1].nota) {
    if (repeteNoutra.checked) {
     for (var i=0;i<vozes[1].nota.length; i++) {
       if (i == voz) { continue; };
       if (vozes[novaVoz[x].pos].nota[i] == vozes[novaVoz[x-1].pos].nota[i]) {
         qt++;
         break;
       };
      };
     } else { qt++; };
   } else { pos1 = x-1; testaRep(); qt = 0; };

  };
  var posIni = (novaVoz[novaVoz.length-1].pos - novaVoz[pos1].pos);
  testaRep();

 function testaRep() {
	if (qt > qtRep) {
		 verificados++;
       criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "repetição de notas", posIni, 1); };
 };
}

function repetePadrão() {

 if (vozes.length<4) {msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de repetição de padrão melódico!\n";
                       msgErros.estado=true; return; }
 var qtRep = parseInt(repPadQt.text);

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

   var novaVoz = [];

   for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=3;x<novaVoz.length;x++) { // percorre acordes

   if (novaVoz[x].nota == novaVoz[x-2].nota && novaVoz[x-1].nota == novaVoz[x-3].nota
       && novaVoz[x].nota != novaVoz[x-1].nota) { verRepPad(4,2); };
   if (x >=5 && novaVoz[x].nota == novaVoz[x-2].nota && novaVoz[x-1].nota == novaVoz[x-3].nota &&
       novaVoz[x].nota == novaVoz[x-4].nota && novaVoz[x-1].nota == novaVoz[x-5].nota &&
       novaVoz[x].nota != novaVoz[x-1].nota) { verRepPad(6,2); };

   if (x >= 6 && novaVoz[x].nota == novaVoz[x-3].nota && novaVoz[x-1].nota == novaVoz[x-4].nota
       && novaVoz[x-2].nota == novaVoz[x-5].nota && (novaVoz[x].nota != novaVoz[x-1].nota ||
       novaVoz[x].nota != novaVoz[x-2].nota)) { verRepPad(6,3); };
   if (x >= 9 && novaVoz[x].nota == novaVoz[x-3].nota && novaVoz[x-1].nota == novaVoz[x-4].nota
       && novaVoz[x-2].nota == novaVoz[x-5].nota && novaVoz[x].nota == novaVoz[x-6].nota &&
       novaVoz[x-1].nota == novaVoz[x-7].nota && novaVoz[x-2].nota == novaVoz[x-8].nota
       && (novaVoz[x].nota != novaVoz[x-1].nota || novaVoz[x].nota != novaVoz[x-2].nota)) { verRepPad(9,3); };
  };

 function verRepPad(a,b) {

 	var numAcordes = (novaVoz[x].pos - novaVoz[x-(a-1)].pos) + 1;

 	var rep = (a/b) - 1;

 	if (rep > qtRep) {
	 verificados++;
    criaResultado(verificados, novaVoz[x].pos, voz, voz, "repetição de padrão mel.", numAcordes, 1); };
 };
}

function melodiaArpejo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos na mesma direção!\n";
                       msgErros.estado=true; return; };

 var qtArp = parseInt(arpMelQt.text);
 var arp = 0;

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var novaVoz = [];
  for (var x=0;x<vozes.length;x++) {
    if (!vozes[x].ligadura[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
     };
   };

  for (var x=2;x<novaVoz.length;x++) { // percorre acordes
   if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

   var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
   var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
   var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

   if (int1 > 2 && int2 > 2 && dir1 == dir2 && dir1 != 0 && ((int1 == 3 && int2 == 3) ||
     	(int1 == 3 && int2 == 4) || (int1 == 4 && int2 == 3) || (int1 == 4 && int2 == 4) ||
     	(int1 == 3 && int2 == 6) || (int1 == 4 && int2 == 5) || (int1 == 3 && int2 == 5) ||
     	(int1 == 6 && int2 == 3) || (int1 == 5 && int2 == 3) || (int1 == 5 && int2 == 4))) {
     arp++;
     if (arp > qtArp) {
      var posIni = (novaVoz[x].pos - novaVoz[x-2].pos) + 1
      verificados++;
      criaResultado(verificados, novaVoz[x].pos, voz, voz, "arpejo de acorde", posIni, 1); };
   };
  };
}

function melodiaPF() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Ponto focal!\n";
                       msgErros.estado=true; return; };

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

  var vozSup = [];
  var pfSs = 0, pfSi = 127;  // ponto focal da voz Superior/Inferior, inferior/superior
  var pfSsc = 0, pfSic = 0; // var para contagem dos pontos focais;

 for (var x=0;x<vozes.length;x++) { // percorre acordes para encontrar pontos focais

   vozSup[x] = vozes[x].nota[voz];

   if (vozSup[x] > pfSs) { pfSs = vozSup[x]; };
   if (vozSup[x] < pfSi) { pfSi = vozSup[x]; };

 };

 for (var x=1;x<vozes.length-1;x++) { // percorre acordes

   if (vozSup[x] == pfSs) { pfSsc++; // contagem dos pontos focais voz superior;
     if ((vozSup[x-1] == pfSs) || (x == vozes.length-1 && vozSup[0] == pfSs)) { pfSsc--; } else
     if (melPFs.checked && pfSsc > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal superior", 1, 1); }; };
   if (vozSup[x] == pfSi) { pfSic++;
     if ((vozSup[x-1] == pfSi) || (x == vozes.length-1 && vozSup[0] == pfSi)) { pfSic--; } else
     if (melPFi.checked && pfSic > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal inferior", 1, 1); }; };
 };
}

function neutralterações() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de neutralização de alterações!\n";
                       msgErros.estado=true; return; };

var tom = tonicaTPC(btTonica.text, btAcid.text);

for (var voz=0;voz<vozes[1].nota.length;voz++) { // percorre vozes
 var novaVoz = []; var int1, int2, int3, int4;
  for (var x=0;x<vozes.length;x++) {
   if (x > 0) {
    if (vozes[x].nota[voz] != vozes[x-1].nota[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}) ;
    }; } else { novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}); };
   };

  for (var x=0;x<novaVoz.length-1;x++) { // verifica tratamento de alterações do 6 e 7
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, tom);
    alt1 = alt1.toString();
    var alt2 = verificaGrauMelodico(novaVoz[x+1].tonal, tom);
    alt2 = alt2.toString();
    if (x < novaVoz.length-2) {
      var alt3 = verificaGrauMelodico(novaVoz[x+2].tonal, tom);
      alt3 = alt3.toString();
    };

    if (alt1.slice(-1) == "+") {
     if (neutAim.checked) {
       if (alt1.slice(0, 1) == "6") {
         if (x < novaVoz.length-2 && (alt2 != "7+" || alt3 != "1")) { var a = x + 1; verificaAlter(); };
       } else
       if (alt1.slice(0, 1) == "7") {
         if (alt2 != "1") { var a = x + 1; verificaAlter(); };
       };
     } else {
       for (var a=x+1;a<novaVoz.length;a++) {
         var tam = a - x;
         if (x < novaVoz.length-2 && tam > 3) { verificaAlter(); x += 4; break; };
         var procuraT = verificaGrauMelodico(novaVoz[a].tonal, tom);
         procuraT = procuraT.toString();
         if (procuraT == "1") {
           if (x < novaVoz.length-2 && tam == 3) {
             if (alt1 == "6+" && alt2 != "7+") {
               if ((alt2 == "2" || alt2 == "5" || alt2 == "1")  && alt3 == "7+") { x += 3; break;}
                 else { verificaAlter(); x += 3; break; }
             } else if (alt1 == "7+") {
               if ((alt2 == "2" && alt3 == "5") || (alt2 == "6+" && alt3 == "7+")) { x += 3; break;}
                 else { verificaAlter(); x += 3; break; }
             };
           } else if (tam == 2) {
             if (alt1 == "7+") {
               if (alt2 == "2" || alt2 == "5") { x += 2; break;}
                 else { verificaAlter(); x += 2; break; };
             } else if (alt1 == "6+" && alt2 != "7+") { verificaAlter(); x += 2; break; };
           } else if (tam == 1) {
             if (alt1 == "7+") { x += 1; break; } else { verificaAlter(); x += 1; break; };
           };
         };
       };
     };
   };

 };

  for (var x=0;x<novaVoz.length;x++) { // verifica neutralizações do 6 e 7
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, tom);
    alt1 = alt1.toString();

    if (alt1.slice(-1) == "+") {
      for (var a=x-1;a>=0;a--) {
        var alt2 = verificaGrauMelodico(novaVoz[a].tonal, tom);
        alt2 = alt2.toString();
        if (alt2 == alt1) { break; };
        var alt3 = verificaGrauMelodico(novaVoz[a+1].tonal, tom);
        alt3 = alt3.toString();
        if (a+2 > x) { var alt4 = verificaGrauMelodico(novaVoz[x].tonal, tom); }
                else { var alt4 = verificaGrauMelodico(novaVoz[a+2].tonal, tom); };
        alt4 = alt4.toString();
        if (alt1.slice(0, 1) == alt2 ) {
         switch (alt2) {
           case "6": if (alt3 == "5") { a = -1; } else { verificaNeutr(); a = -1; }; break;
           case "7": if (alt3.slice(0, 1) == "6" && alt4 != "7+") { a = -1; } else { verificaNeutr(); a = -1; }; break;
         };
       };
      };
    };
  };
 };
 function verificaAlter() {
   var posIni = (novaVoz[a].pos - novaVoz[x].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[a].pos, voz, voz, "alteração 6º e/ou 7º", posIni, 1);
 };
 function verificaNeutr() {
   var posIni = (novaVoz[x].pos - novaVoz[a].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[x].pos, voz, voz, "neutralização 6º e/ou 7º", posIni, 1);
 };
}

function notaIniFin() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de nota inicial e final!\n";
                       msgErros.estado=true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);

 if (melodia) { var voz = vozCF; } else { var voz = 1 - vozCF; };

   var test1 = false, test2 = false, test3 = false, test4 = false, test5 = false, test6 = false;
   var nI = parseInt(verificaGrauMelodico(vozes[0].tonal[voz], tom));
   var nF = parseInt(verificaGrauMelodico(vozes[vozes.length-1].tonal[voz], tom));

   if (tonic.checked && nI == 1) { test1 = true; };
   if (terça.checked && nI == 3) { test2 = true; };
   if (quinta.checked && nI == 5) { test3 = true; };
   if (tonicF.checked && nF == 1) { test4 = true; };
   if (terçaF.checked && nF == 3) { test5 = true; };
   if (quintaF.checked && nF == 5) { test6 = true; };

   var nomeI = "Nota inicial não é ";
   if (tonic.checked) { nomeI += "1º"; };
   if (terça.checked) { nomeI += "/3º"; };
   if (quinta.checked) { nomeI += "/5º"; };
   nomeI += " grau";

   var nomeF = "Nota final não é ";
   if (tonicF.checked) { nomeF += "1º"; };
   if (terçaF.checked) { nomeF += "/3º"; };
   if (quintaF.checked) { nomeF += "/5º"; };
   nomeF += " grau";

   if (!test1 && !test2 && !test3) {
	      verificados++;
	      criaResultado(verificados, 0, voz, voz, nomeI, 1, 1);
       };
   if (!test4 && !test5 && !test6) {
	      verificados++;
	      criaResultado(verificados, vozes.length-1, voz, voz, nomeF, 1, 1);
       };
}

// --------------------- 1ª espécie ------------
function primUltIntervalo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo inicial e final!\n";
                       msgErros.estado=true; return; };

 var intI = (Math.abs(vozes[0].nota[0] - vozes[0].nota[1])) % 12;
 var intF = (Math.abs(vozes[vozes.length-1].nota[0] - vozes[vozes.length-1].nota[1])) % 12;
 var inicio = false, finale = false;

 if (intI != 0) {

   if (intI == 7 && ex5Ji.checked) { inicio = true; } else
   if ((intI == 3 || intI == 4) && ex3i.checked) { inicio = true; };

   if (!inicio) {
   	verificados++;
	  criaResultado(verificados, 0, 0, 1, "intervalo inicial", 1, 2);
   };
 };

 if (intF != 0) {

   if (intF == 7 && ex5Jf.checked) { finale = true; } else
   if ((intF == 3 || intF == 4) && ex3f.checked) { finale = true; };

   if (!finale) {
    verificados++;
    criaResultado(verificados, vozes.length-1, 0, 1, "intervalo final", 1, 2);
   };
 };
}

function alcançarMovContra() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de alcançar intervalo final!\n";
                       msgErros.estado=true; return; };

 var intS = vozes[vozes.length-1].nota[0] - vozes[vozes.length-2].nota[0]
 var intI = vozes[vozes.length-1].nota[1] - vozes[vozes.length-2].nota[1];

 var dir1 = direção(vozes[vozes.length-1].nota[0] - vozes[vozes.length-2].nota[0]);
 var dir2 = direção(vozes[vozes.length-1].nota[1] - vozes[vozes.length-2].nota[1]);

 if (intS > 2 || intI > 2 || intS < -2 || intI < -2 || dir1 == dir2 || dir1 == 0 || dir2 == 0) {

   if ((quartaJi.checked && (intI == 5 || intI == -7)) || (quartaJs.checked && (intS == 5 || intS == -7))) { return; };
	      verificados++;
	      criaResultado(verificados, vozes.length-2, 0, 1, "alcança intervalo final", 1, 2);
       };
}

function consonancias() {

  var cP = 0, cI = 0;

  for (var x=0;x<vozes.length;x++) { // percorre acordes

   var int1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));

   if (int1 == "CP") { cP++; } else if (int1 == "CI") { cI++; }
    else {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "dissonância", 1, 2);
   };
  };

  if (cP > cI && maiorCons.checked) {
  	 verificados++;
	 criaResultado(verificados, vozes.length-1, 0, 1, "consonância imperfeita não é maioria", vozes.length, "null");
  };
}

function quintasOitavas() {
   var par5Status = true, par8Status = true;
   var acorAnt = 1;
   var qtdpar8Rep = parseInt(par8Rep.text), qtdpar5Rep = parseInt(par5Rep.text);

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < 10; i++) { //  percorre outras vozes
   		 var vozAtual = i;
   		 var par5 = 0, par8 = 0;

	       for (var x=1;x<=vozes.length;x++) { // percorre acordes
	         if (x==vozes.length) { verificou58(); continue ; };
	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { continue ; };

         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
         var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

         var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
         var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if (Math.abs(intAtual%12) == 7 && intAtual == intAnt && paralela5.checked) { //testa 5ª paralela

                 if (vozAnt == voz) { var qtdPar5 = par5 + 1; }

                  if (par5 == 0) { par5 = 2; } else { par5++; };
                  par5Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par8 = 0, par8Status = false;

              } else if (par5Status) { verificou58(); };

               if (Math.abs(intAtual%12) == 0 && intAtual == intAnt && paralela8.checked) {  // testa 8ª paralela

                 if (vozAnt == voz) { var qtdPar8 = par8 + 1;}

                  if (par8 == 0) { par8 = 2; } else { par8++; };
                  par8Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par5 = 0, par5Status = false;

              } else if (par8Status) { verificou58(); };

           } else { verificou58(); };
         };
       };
     };

     function verificou58() {

       if (par8Status && par8 > qtdpar8Rep && paralela8.checked) {
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "8ª paralela", qtdPar8+1 , 2);};

       if (par5Status && par5 > qtdpar5Rep && paralela5.checked) {
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "5ª paralela", qtdPar5+1 , 2);};

      par8Status = false; par8 = 0;
      par5Status = false; par5 = 0;
    };
 }

function quartas() {

   var par4Status = true;
   var acorAnt = 1;
   var qtdpar4Rep = parseInt(par4Rep.text);

  // console.log("par4Rep : "+ qtdpar4Rep)

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;
       for (var i=voz+1; i < 10; i++) { // percorre outras vozes
         var vozAtual = i;
         var par4 = 0;
	       for (var x=1;x<vozes.length;x++) { // percorre acordes

	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { verificou4(); continue; };

	         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            if (Math.abs(intAtual%12) == 5 && intAtual == intAnt && dir1 == dir2 && dir1 != 0) { //testa por 4ª paralela

                 if (vozAnt == voz) { var qtdPar4 = par4 + 1;}

                  if (par4 == 0) { par4 = 2; } else { par4++; };
                  par4Status = true;
                  acorAnt = x;
                  vozAnt = voz, vozAtual = i;;

              } else { verificou4(); };
         };
       };
    };

    function verificou4() {

      if (par4Status && par4 > qtdpar4Rep) {
            verificados++;
            criaResultado(verificados, acorAnt, vozAnt, vozAtual, "4ª paralela", qtdPar4 , 2);
      };

      par4Status = false; par4 = 0;

    };
}

function terçasSextas() {

   var par3Status = true, par6Status = true;
   var acorAnt = 1;
   var qtdpar36Rep = parseInt(par36Rep.text);

     for (var voz=0; voz < 10; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < 10; i++) { // percorre outras vozes
   		 var vozAtual = i;
   		 var par3 = 0, par6 = 0;

	       for (var x=1;x<vozes.length;x++) { // percorre acordes

	         if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) {

	            if (x==vozes.length-1) {verificou36();};

	         continue;

	         };

	         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if ((Math.abs(intAtual%12) == 3 || Math.abs(intAtual%12) == 4) &&   //testa por 3ª paralela --
                  (Math.abs(intAnt%12) == 3 || Math.abs(intAnt%12) == 4)) {

                 if (vozAnt == voz) { var qtdPar3 = par3 + 1; }

                  if (par3 == 0) { par3 = 2; } else { par3++; };
                  par3Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par6 = 0, par6Status = false;

              } else if (par3Status) { verificou36(); };

               if ((Math.abs(intAtual%12) == 8 || Math.abs(intAtual%12) == 9) &&   //testa por 6ª paralela --
                  (Math.abs(intAnt%12) == 8 || Math.abs(intAnt%12) == 9)) {

                 if (vozAnt == voz) { var qtdPar6 = par6 + 1;}

                  if (par6 == 0) { par6 = 2; } else { par6++; };
                  par6Status = true;
                  vozAnt = voz, vozAtual = i;
                  acorAnt = x;
                  par3 = 0, par3Status = false;

              } else if (par6Status) { verificou36(); };

           } else { verificou36(); };

         };
      };
    };

    function verificou36() {

     if (par3Status && par3 > qtdpar36Rep) { //console.log("Else da NÃO 3ª. acorAnt = " + acorAnt)
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "3ª paralela", qtdPar3 , 2);};
     if (par6Status && par6 > qtdpar36Rep) { //console.log("Else da NÃO 6ª. acorAnt = " + acorAnt)
         verificados++;
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "6ª paralela", qtdPar6 , 2);};

      par6Status = false; par6 = 0;
      par3Status = false; par3 = 0;
    };

}

function ocultas() {

	for (var x=1;x<vozes.length;x++) { // percorre acordes

    for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

      var i;
      var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

      for (i=voz+1; i < vozes[x].nota.length; i++) { // percorre outras vozes

         var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

         var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
         var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

           if (Math.abs(intAtual%12) == 7 && intAtual != intAnt && oculta5.checked) {             // testa ocultas
             // testa condições
             if (!ocultEx.checked || (ocultEx.checked && x != vozes.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozes[x-1].nota[0] - vozes[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "5ª oculta", 2, 2);
               };
             };
           };

           if (Math.abs(intAtual%12) == 0 && intAtual != intAnt && oculta8.checked) { // testa ocultas
             // testa consições
             if (!ocultEx.checked || (ocultEx.checked && x != vozes.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozes[x-1].nota[0] - vozes[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "8ª oculta", 2, 2);
               };
             };
           };
         };
      };
    };
  };
}

function consecutivas() {

     for (var x=1;x<vozes.length;x++) { // percorre acordes

       for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

         var i;
         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

         for (i=voz+1; i < vozes[x].nota.length; i++) { // percorre outras vozes

            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);

            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];

            // consecutivas

             if ((Math.abs(intAtual%12) == 7 || Math.abs(intAtual%12) == 0) &&
                 (Math.abs(intAnt%12) == 7 || Math.abs(intAnt%12) == 0))  {

               if ((consecObli.checked && (dir1 == 0 || dir2 == 0)) || (consecCont.checked && (dir1 != 0 && dir2 != 0 && dir1 != dir2))) {
                   verificados++;
                   criaResultado(verificados, x, voz, i, "5ª ou 8ª consecutivas", 2, 2);
               };
             };
         };
       };
     };
 }

function intermitentes() {
 if (priEsp) {
  for (var x=2;x<vozes.length;x++) { // percorre acordes
   var int1 = Math.abs(vozes[x-2].nota[0] - vozes[x-2].nota[1]);
   var int2 = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]);

   if (int1%12 == 7 && int1 == int2 && inter5.checked) {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "5ª intermitente", 1, 2); } else
   if (int1%12 == 0 && int1 == int2 && inter8.checked) {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "8ª intermitente", 1, 2);
   };
  };
 } else {
   for (var x=0;x<vozes.length-1;x++) { // percorre acordes
    for (var y=1;y<vozes.length;y++) { // percorre acordes
      var int1 = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]);
      var int2 = Math.abs(vozes[y].nota[0] - vozes[y].nota[1]);
     if (vozes[x].compasso+1 == vozes[y].compasso && vozes[x].tempo[0] == vozes[y].tempo[0]) {
       if (int1%12 == 7 && int1 == int2 && inter5.checked) {
	      verificados++;
		   criaResultado(verificados, y, 0, 1, "5ª intermitente", 1, 2); } else
	    if (int1%12 == 0 && int1 == int2 && inter8.checked) {
	      verificados++;
		   criaResultado(verificados, y, 0, 1, "8ª intermitente", 1, 2);
       };
     } else if (y-x == 2) {
       if (int1%12 == 7 && int1 == int2 && inter5.checked) {
	      verificados++;
		   criaResultado(verificados, y, 0, 1, "5ª intermitente", 1, 2); } else
	    if (int1%12 == 0 && int1 == int2 && inter8.checked) {
	      verificados++;
		   criaResultado(verificados, y, 0, 1, "8ª intermitente", 1, 2);
       };
      };
     };
    };
  };
}

function unissono() {

  var unissono = parseInt(unissQt.text)
  var uni = 0;

  if (unissIF.checked) { var a1 = 1, a2 = vozes.length-1; }
    else { var a1 = 0, a2 = vozes.length; } ;

  for (var x=a1;x<a2;x++) { // percorre acordes

    for (var voz=1;voz<vozes[x].nota.length;voz++) {

      var int1 = vozes[x].nota[voz-1] - vozes[x].nota[voz];

      if (int1 == 0) { uni++; };

      if (int1 == 0 && uni > unissono) {
        verificados++;
    	  criaResultado(verificados, x, voz-1, voz, "uníssono", 1, 2); };
    };
  };
}

function cruzamento() {

  for (var x=1;x<vozes.length;x++) { // percorre acordes

	 for (var voz=0; voz < vozes[x].nota.length - 1; voz++) { // percorre vozes

       if (vozes[x].nota[voz] < vozes[x].nota[voz+1]) {
	          verificados++;
	          criaResultado(verificados, x, voz, voz+1, "cruzamento", 1, 2);
       };
    };
  }; // acordes
}

function falsaRelação() {
  for (var x=1;x<vozes.length;x++) { // percorre acordes

    for (var voz=0; voz < vozes[x].nota.length; voz++) { // percorre vozes

      var int1 = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);
      if (int1 == 7) { continue; };

      for (var i=0; i < vozes[x].nota.length; i++) { // percorre outras vozes
         if (i == voz) { continue; };

         var int2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x].tonal[i]);

         if (int2 == 7)  {  // testa falsa relação
               	verificados++;
               	criaResultado(verificados, x, voz, i, "falsa relação", 2, "fr"); };

      };
    };
  };
}

function espaçamento() {

  var qt = parseInt(distQt.text);
  var int1, conta = 0;

  for (var x=0;x<vozes.length;x++) { // percorre acordes

    for (var voz=1;voz<vozes[x].nota.length;voz++) {

      int1 = Math.abs(vozes[x].nota[voz-1] - vozes[x].nota[voz]);

      if (int1 > 16) {
       conta++;
       if (conta > qt) {
	    verificados++;
	    criaResultado(verificados, x, voz-1, voz, "espaçamento máximo", 1, 2); };
      } else { conta = 0; };
    };
  };
}
// ------------------------2ª espécie ------------
function tempoForte() {
  var voz = 1 - vozCF;
  for (var x=0;x<vozes.length;x++) { // percorre acordes

   var pMetric = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
   var int1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));

   if (int1 == "D" && pMetric == "F") {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "dissonância em tempo forte", 1, 2);
   };
  };
}

function notaPassagem() {
 var voz = 1 - vozCF;
 //console.log("voz:",voz)
  for (var x=1;x<vozes.length-1;x++) { // percorre acordes

   var int1 = verificaConsonancia(Math.abs(vozes[x-1].nota[0] - vozes[x-1].nota[1]));

   var pMetric2 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
   var int2 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));


   var int3 = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]));

   var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var dir2 = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);

   var intM1 = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intM2 = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);

   if (dir1 == dir2 && dir1 != 0 && intM1 < 3 && intM2 < 3) { var contorno = true; } else { var contorno = false; };

   if (int1.substr(0, 1) == "C" && int2 == "D" && int3.substr(0, 1) == "C") { var intervalos = true; } else { var intervalos = false; };

   if (int2 == "D" && pMetric2 != "F" && (!intervalos || !contorno)) {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2);
   };
  };
}
// ----------------------- 3ª espécie --------------
function dissonancias3() {
 if (vozes.length<5) { msgErros.text += "Não possui a quantidade mínima de notas para \na verificação de dissonâncias na 3ª espécie!\n";
                        msgErros.estado = true; return; };

 var voz = 1 - vozCF, intHarm = [], intMelo = [], pMetric = [], movDir = [], loopCompleto = false;

 for (var x=1;x<vozes.length-3;x++) { // percorre acordes

   intHarm[0] = verificaConsonancia(Math.abs(vozes[x-1].nota[0] - vozes[x-1].nota[1])); // analisa contraponto (5 notas)
   intHarm[1] = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
   intHarm[2] = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]));
   intHarm[3] = verificaConsonancia(Math.abs(vozes[x+2].nota[0] - vozes[x+2].nota[1]));
   intHarm[4] = verificaConsonancia(Math.abs(vozes[x+3].nota[0] - vozes[x+3].nota[1]));

   intMelo[0] = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   intMelo[1] = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
   intMelo[2] = Math.abs(vozes[x+2].nota[voz] - vozes[x+1].nota[voz]);
   intMelo[3] = Math.abs(vozes[x+3].nota[voz] - vozes[x+2].nota[voz]);

   pMetric[0] = verificaTempoForte(vozes[x-1].tempo[voz],vozes[x-1].formula[0]);
   pMetric[1] = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
   pMetric[2] = verificaTempoForte(vozes[x+1].tempo[voz],vozes[x+1].formula[0]);
   pMetric[3] = verificaTempoForte(vozes[x+2].tempo[voz],vozes[x+2].formula[0]);
   pMetric[4] = verificaTempoForte(vozes[x+3].tempo[voz],vozes[x+3].formula[0]);

   movDir[0] = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   movDir[1] = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
   movDir[2] = direção(vozes[x+2].nota[voz] - vozes[x+1].nota[voz]);
   movDir[3] = direção(vozes[x+3].nota[voz] - vozes[x+2].nota[voz]);

   if (!intHarm.every(notaConsonante)) {

    if (cambi.checked && intHarm[0] != "D" && intHarm[4] != "D") { // verifica cambiata
     if (movDir[0] == movDir[1] && movDir[1] != 0 && movDir[2] == movDir[1]*-1 && movDir[3] == movDir[2] &&
         intMelo[0] < 3 && (intMelo[1] == 3 || intMelo[1] == 4) && intMelo[2] < 3 && intMelo[3] < 3) {
                           var desenhoCambi = true; } else { var desenhoCambi = false; };
     if (pMetric[0] == "F" && pMetric[4] == "F") { var tForteCambi = true; } else { var tForteCambi = false; };
     var dCounter = 0;
     for (var i=0;i<5;i++) { if (intHarm[i] == "D") { dCounter++; }; };
     if (dCounter < 3) { var qDissCambi = true; } else { var qDissCambi = false; };
     if (desenhoCambi && tForteCambi && qDissCambi) { x+=2; if (x>=vozes.length-4) { loopCompleto = true; }; continue;  };
    };
    if (borda.checked && intHarm[0] != "D" && intHarm[1] == "D" && intHarm[2] != "D") { // verifica bordadura
      if (movDir[0] != movDir[1] && movDir[1] != 0 && intMelo[0] < 3 && intMelo[1] < 3) { continue; };
    };
    if (notaP.checked && intHarm[0] != "D" && intHarm[1] == "D" && intHarm[2] != "D") { // verifica nota de passagem
      if (movDir[0] == movDir[1] && movDir[1] != 0 && intMelo[0] < 3 && intMelo[1] < 3) { continue; };
    };
   };

   if (intHarm[1] == "D") {
      verificados++;
	   criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2);};
 };
 var i=0;
 for (var x=vozes.length-3;x<vozes.length-1;x++) {
 	if (intHarm[i] != "D" && intHarm[i+1] == "D" && intHarm[i+2] != "D") {
	  if (borda.checked) { // verifica bordadura
	      if (movDir[i] != movDir[i+1] && movDir[i+1] != 0 && intMelo[i] < 3 && intMelo[i+1] < 3) { continue; };
	    };
	    if (notaP.checked) { // verifica nota de passagem
	      if (movDir[i] == movDir[i+1] && movDir[i+1] != 0 && intMelo[i] < 3 && intMelo[i+1] < 3) { continue; };
	    };
	 };
	if (intHarm[i+1] == "D"  && !loopCompleto) {
	 verificados++;
	 criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2); };
	i++;
 };

  function notaConsonante(interv) {
    return interv != "D";
  };

}
//------------------------ 4ª espécie -------------
function suspensao4() {

  notaPassagem();

  var voz = 1 - vozCF;

  for (var x=1;x<vozes.length-1;x++) { // percorre acordes

   var int1 = verificaConsonancia(Math.abs(vozes[x-1].nota[0] - vozes[x-1].nota[1]));
   var int2 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
   var int3 = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]));

   var pMetric2 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);

   var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var dir2 = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);

   var intM1 = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intM2 = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);

    if (pMetric2 == "F" && int2 == "D") {
	   if (dir1 == 0 && dir2 == -1 && intM2 < 3) { var contorno = true; } else { var contorno = false; };

	   if (int1.substr(0, 1) == "C" && int2 == "D" && int3.substr(0, 1) == "C") { var intervalos = true; } else { var intervalos = false; };

	   if (!intervalos || !contorno) {
	      verificados++;
		   criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2);
	   };
	 };
  };
}
// ----------------------- 5ª espécie ---------------
function dissonancias5() {
	if (vozes.length<5) { msgErros.text += "Não possui a quantidade mínima de notas para \na verificação de dissonâncias na 3ª espécie!\n";
                        msgErros.estado = true; return; };

 var voz = 1 - vozCF, intHarm = [], intMelo = [], pMetric = [], movDir = [], loopCompleto = false;

 for (var x=1;x<vozes.length-3;x++) { // percorre acordes

   intHarm[0] = verificaConsonancia(Math.abs(vozes[x-1].nota[0] - vozes[x-1].nota[1])); // analisa contraponto (5 notas)
   intHarm[1] = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]));
   intHarm[2] = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]));
   intHarm[3] = verificaConsonancia(Math.abs(vozes[x+2].nota[0] - vozes[x+2].nota[1]));
   intHarm[4] = verificaConsonancia(Math.abs(vozes[x+3].nota[0] - vozes[x+3].nota[1]));

   intMelo[0] = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   intMelo[1] = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
   intMelo[2] = Math.abs(vozes[x+2].nota[voz] - vozes[x+1].nota[voz]);
   intMelo[3] = Math.abs(vozes[x+3].nota[voz] - vozes[x+2].nota[voz]);
   intMelo[4] = Math.abs(vozes[x+3].nota[voz] - vozes[x].nota[voz]); // entre a 2ª e a 5ª notas

   pMetric[0] = verificaTempoForte(vozes[x-1].tempo[voz],vozes[x-1].formula[0]);
   pMetric[1] = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
   pMetric[2] = verificaTempoForte(vozes[x+1].tempo[voz],vozes[x+1].formula[0]);
   pMetric[3] = verificaTempoForte(vozes[x+2].tempo[voz],vozes[x+2].formula[0]);
   pMetric[4] = verificaTempoForte(vozes[x+3].tempo[voz],vozes[x+3].formula[0]);

   movDir[0] = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   movDir[1] = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
   movDir[2] = direção(vozes[x+2].nota[voz] - vozes[x+1].nota[voz]);
   movDir[3] = direção(vozes[x+3].nota[voz] - vozes[x+2].nota[voz]);
   movDir[4] = direção(vozes[x+3].nota[voz] - vozes[x].nota[voz]); // entre a 2ª e a 5ª notas

   if (!intHarm.every(notaConsonante)) {

    if (cambi5.checked && intHarm[0] != "D" && intHarm[4] != "D") { // verifica cambiata
     if (movDir[0] == movDir[1] && movDir[1] != 0 && movDir[2] == movDir[1]*-1 && movDir[3] == movDir[2] &&
         intMelo[0] < 3 && (intMelo[1] == 3 || intMelo[1] == 4) && intMelo[2] < 3 && intMelo[3] < 3) {
                           var desenhoCambi = true; } else { var desenhoCambi = false; };
     if (pMetric[0] = "F" && pMetric[4] == "F") { var tForteCambi = true; } else { var tForteCambi = false; };
     var dCounter = 0;
     for (var i=0;i<5;i++) { if (intHarm[i] == "D") { dCounter++; }; };
     if (dCounter < 3) { var qDissCambi = true; } else { var qDissCambi = false; };
     if (desenhoCambi && tForteCambi && qDissCambi) { x+=2; if (x>=vozes.length-4) { loopCompleto = true; }; continue; };
    };
    if (pMetric[1] =="F" && intHarm[1] == "D") { // verifica suspensão com resolução interrompida 5 notas
    	if (movDir[0] == 0 && movDir[1] != 0 && movDir[2] != 0 && movDir[3] != 0 && movDir[4] != 0 && intMelo[1] <= 7 &&
    	    intMelo[2] < 3 && intMelo[3] < 3 && intHarm[0].substr(0, 1) == "C" && intHarm[2].substr(0, 1) == "C" &&
    	    intHarm[4].substr(0, 1) == "C" && pMetric[4] != "c") { x+=2; if (x>=vozes.length-4) { loopCompleto = true; }; continue; };
    };
    if (pMetric[1] =="F" && intHarm[1] == "D") { // verifica suspensão com resolução interrompida 4 notas
    	if (movDir[0] == 0 && movDir[1] != 0 && movDir[2] != movDir[1] && movDir[2] != 0 && intMelo[1] <= 7 &&
    	    intMelo[2] <= 7 && intHarm[0].substr(0, 1) == "C" && intHarm[2].substr(0, 1) == "C" &&
    	    intHarm[3].substr(0, 1) == "C" && pMetric[3] != "c") { x+=1; if (x>=vozes.length-4) { loopCompleto = true; }; continue; };
    };
    if (bord5.checked && intHarm[0] != "D" && intHarm[1] == "D" && intHarm[2] != "D") { // verifica bordadura
      if (movDir[0] != movDir[1] && movDir[1] != 0 && intMelo[0] < 3 && intMelo[1] < 3) { continue; };
    };
    if (nP5.checked && intHarm[0] != "D" && intHarm[1] == "D" && intHarm[2] != "D") { // verifica nota de passagem
      if (movDir[0] == movDir[1] && movDir[1] != 0 && intMelo[0] < 3 && intMelo[1] < 3) { continue; };
    };
    if (susp5.checked && pMetric[1] == "F" && intHarm[1] == "D") { // verifica suspensão
    	if (movDir[0] == 0 && movDir[1] != 0 && intMelo[1] < 3 && intHarm[0].substr(0, 1) == "C" &&
    	    intHarm[2].substr(0, 1) == "C") { continue; };
    };
   };

   if (intHarm[1] == "D") { //console.log("antes")
      verificados++;
	   criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2);};
 };
 var i=1;
 for (var x=vozes.length-3;x<vozes.length-1;x++) {
 	if (intHarm[i] != "D" && intHarm[i+1] == "D" && intHarm[i+2] != "D") {
	  if (bord5.checked) { // verifica bordadura
	      if (movDir[i] != movDir[i+1] && movDir[i+1] != 0 && intMelo[i] < 3 && intMelo[i+1] < 3) { continue; };
	    };
	  if (nP5.checked) { // verifica nota de passagem
	      if (movDir[i] == movDir[i+1] && movDir[i+1] != 0 && intMelo[i] < 3 && intMelo[i+1] < 3) { continue; };
	    };
	  if (susp5.checked && pMetric[1] == "F") { // verifica suspensão
    	if (movDir[i] == 0 && movDir[i+1] != 0 && intMelo[i+1] < 3) { continue; };
      };
	 };
	if (intHarm[i+1] == "D" && !loopCompleto) {
	 verificados++;
	 criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2); };
	i++;
 };

  function notaConsonante(interv) {
    return interv != "D";
  };

}



//------------------------------------------------------------------------------
function criaResultado(verificados, x, voz, i, tipo, numAcordes, numVozes) {

 	var primAcorde = x - (numAcordes-1);
 	var compAnt = Math.floor(vozes[primAcorde].compasso);
 	var compAtual = Math.floor(vozes[x].compasso);
 	var qtdVozes = vozes[x].nota.length;

 	if (compAnt != compAtual && numAcordes > 1) { var compasso = compAnt+" ao "+compAtual;}
 														  else { var compasso = compAtual; };

 	switch (numVozes) {         // cria mensagem de texto
 	   case 1: var qualVoz = ", na voz "+ (voz+1); break;
 	   case "fr":
 	   case 2: var qualVoz = ", entre as vozes "+(voz+1)+" e "+(i+1); break;
 	   case "null":
 	   case qtdVozes: var qualVoz = ""; break;
 	};

   var texto = verificados+") "+tipo+": compasso "+ compasso + qualVoz;

   resultado[verificados] = [texto];

   for (var y=primAcorde;y<=x;y++) {  // cria array de objetos para colorir

   	switch (numVozes) {
   		case 1: resultado[verificados].push(vozes[y].objeto[voz]); break;
   		case 2: resultado[verificados].push(vozes[y].objeto[voz], vozes[y].objeto[i]); break;
   		case "null":
   		case qtdVozes: for (var k=0;k<qtdVozes;k++) {
   							  resultado[verificados].push(vozes[y].objeto[k]);
   		               }; break;
   		case "fr": if (y == primAcorde) { resultado[verificados].push(vozes[y].objeto[voz]); }
   						else { resultado[verificados].push(vozes[y].objeto[i]); }; break;

        };
   };
 }
//---------------------------------------------------------

  onRun: {

    inicializaVariáveis();

    function inicializaVariáveis() {
      var preSet = "true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-12-true-true-true-true-true-true-false-true-true-true-true-true-true-true-true-true-4-true-1-true-true-0-true-1-true-true-true-true-true-true-true-false-false-true-false-false-false-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-16-true-true-true-true-true-true-false-true-true-true-false-true-true-true-true-true-4-true-1-true-true-1-true-1-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-0-true-0-false-3-false-3-true-true-true-true-true-false-true-true-true-true-1-true-true-true-1-true-true-16-true-true-true-true-true-true-false-true-true-true-false-true-true-true-true-true-4-true-1-true-true-1-true-2-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-0-true-0-false-3-false-3-true-true-true-true-true-false-true-true-true-true-1-true-true-true-3-true-false-19-true-true-true-true-true-true-false-true-true-true-false-true-true-true-true-true-6-true-2-true-true-1-true-3-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-0-true-0-false-3-false-3-true-true-true-true-true-false-true-true-true-true-1-true-true-true-4-true-true-19-true-true-true-true-true-true-false-true-true-true-false-true-true-true-true-true-4-true-2-true-true-1-true-2-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-0-true-0-false-3-false-3-true-true-true-true-true-false-true-true-true-true-1-true-true-true-3-true-true-19-true-true-true-true-true-true-false-true-true-true-false-true-true-true-true-true-6-true-2-true-true-2-true-3-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-true-0-true-0-false-3-false-3-true-true-true-true-true-false-true-true-true-true-1-true-true-true-4-"
        preSet = preSet.split("-");
        //console.log(preSet.length);
        for (var i=0;i<preSet.length;i++) {
          if (preSet[i] == "true") { preSet[i] = true; } else
          if (preSet[i] == "false") { preSet[i] = false; };
        };

        var n = 0;

        cons.checked = preSet[n]; n++; // 1ª espécie
        maiorCons.checked = preSet[n]; n++;
        tF.checked = preSet[n]; n++;  // 2ª espécie
        dissNP.checked = preSet[n]; n++;
        notaP.checked = preSet[n]; n++; // 3ª espécie
        cambi.checked = preSet[n]; n++;
        borda.checked = preSet[n]; n++;
        susp4.checked = preSet[n]; n++; // 4ª espécie
        nP5.checked = preSet[n]; n++;   // 5ª espécie
        bord5.checked = preSet[n]; n++;
        cambi5.checked = preSet[n]; n++;
        susp5.checked = preSet[n]; n++;
        sRI5.checked  = preSet[n]; n++;

    for (var i = 0; i < 6; i++) {      // gerais e melodia em cada espécie
      config[i] = [];
      for (var j = 0; j < 71; j++) {
        config[i][j] = preSet[n]; n++;
        //console.log(config[i][j])
      };
    };
  };

    window.visible = true;
    window.raise();

  } // fecha onRun

} // fecha função Musescore
