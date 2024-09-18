//=========================================================================================\\
//  Analisador de Contrapontos v0.47                                                     \\
//                                                                                         \\
//  Copyright (C)2020 Rogério Tavares Constante                                            \\
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
import MuseScore 3.0

MuseScore {
      menuPath: qsTr("Plugins.Contraponto.Analisador")
      description: qsTr("Analisador de Contrapontos.\nPlugin de auxílio na correção de exercícios de contraponto.")
      version: "0.47"

       Component.onCompleted: {
        if (mscoreMajorVersion >= 4) {
            title = qsTr("Analisador de Contrapontos")
            thumbnailName = "interface042.png"
            categoryCode = "Contraponto"
        }
      }

// ----------------------------- janela principal -----------------------
  ApplicationWindow {
    id: window
    visible: true
    title: qsTr("Analisador de Contrapontos v0.46")
      width: 700; height: 630
    color: "#020202"


    // ------------------------------ barra inferior --------------------------
    Rectangle {
            id: barraInferior
            y: 600
            width: 697; height: 30
            color: "#090909"
            border.color: "#383838"
            border.width: 1
            x: 1

        Text { x: 6; y: 4; font.pointSize: 7; color: "#aaa31e"; text: "criado por" }
        Text { x: 5; y: 13; font.pointSize: 9; color: "#aaa31e"; text: "Rogério Tavares Constante" }
        Text { x: 665; y: 10; font.pointSize: 9; color: "#aaa31e"; text: "2019" }

       Rectangle {
             id: btVerifica
             property string text: qsTr("Verificar")
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
                   onClicked: { msgResult.close(); verificar(); }
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
             property string text: qsTr("Fechar")
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
                   onClicked: { (typeof(quit) === 'undefined' ? Qt.quit : quit)(); window.close(); msgResult.close(); msgRelatorio.close(); }
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

    Text { x: 90; y: 275; font.pointSize: 19; color: "#aaa31e"; text: qsTr("Analisador de Contrapontos 0.4") }
    Text { x: 196; y: 303; font.pointSize: 9; color: "#aaa31e"; text: qsTr("Extensão para MuseScore") }

  }
    // ------------------------------ configurações, barra lateral --------------------------
 Item { id: configura; visible: true;
    Rectangle { x: 536; y: 3; width: 161; height: 595;	color: "#222222"; radius: 2
      Text { x: 22; y: 5; color: "#d1d10a"; font.pixelSize: 18; text: qsTr("Configurações") }
      Rectangle { id: tonalidade;
                  x: 3; y: 28; width: 155; height: 110;
                  color: "#101010"; radius: 2
         Button {
	       	id: btTonica
	         text: "Dó"
	         width: 60
	         menu: menuTonica
	         x: 3; y: 3
	         Text { x: 62; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: qsTr("Tônica/finalis") }
          }
	       Button {
	       	id: btAcid
	         text: ""
	         width: 50
	         menu: menuAcid
	         x: 3; y: 28
	         Text { x: 52; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: qsTr("Acidente") }
	       }
	       Button {
	       	id: btModo
	         text: qsTr("Maior")
	         width: 90
	         menu: menuModo
	         x: 3; y: 53
	         Text { x: 92; color: "#fcffbc"; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 13; text: qsTr("Modo") }
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
	    		    MenuItem { text: qsTr("Maior"); onTriggered: { menuModo.value = 1; btModo.text = "Maior" } }
				    	MenuItem { text: qsTr("Menor"); onTriggered: { menuModo.value = 2; btModo.text = "Menor" } }
				    	MenuItem { text: qsTr("Jônico"); onTriggered: { menuModo.value = 3; btModo.text = "Jônico" } }
				    	MenuItem { text: qsTr("Dórico"); onTriggered: { menuModo.value = 4; btModo.text = "Dórico" } }
				    	MenuItem { text: qsTr("Frígio"); onTriggered: { menuModo.value = 5; btModo.text = "Frígio" } }
				    	MenuItem { text: qsTr("Lídio"); onTriggered: { menuModo.value = 6; btModo.text = "Lídio" } }
				    	MenuItem { text: qsTr("Mixolídio"); onTriggered: { menuModo.value = 7; btModo.text = "Mixolídio" } }
				    	MenuItem { text: qsTr("Eólio"); onTriggered: { menuModo.value = 8; btModo.text = "Eólio" } }
				    	MenuItem { text: qsTr("Lócrio"); onTriggered: { menuModo.value = 9; btModo.text = "Lócrio" } }
				 }

         Text { x: 6; y: 86; color: "#f9ff8c"; font.pixelSize: 14; text: qsTr("Voz do C.F. :")
	         Rectangle { anchors.left: parent.right; anchors.leftMargin: 8; anchors.verticalCenter: parent.verticalCenter;
	                     width: 25; height: 22; color: "#9c9c9c"; radius: 2
             Rectangle { x: 1; y: 1; width: 23; height: 20; color: "#050000"; radius: 2
	            TextInput { id: vozCantusFirmus; anchors.horizontalCenter: parent.horizontalCenter;
	                        anchors.verticalCenter: parent.verticalCenter; text: "1"; font.pixelSize: 15; color: "yellow";
	                        validator: IntValidator{bottom: 1; top: 8; } }
		         }
		       }
		     }
      }
      Rectangle { id: contraponto // botões para seleção de espécies
              x: 3; y: 142
              width: 155; height: 157; radius: 2
              color: "#101010"
              Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: qsTr("Tipo de contraponto:") }

        // CF
        Rectangle {
                   id: botao27
                   x: 2; y: 25
                   property string text: "Cantus Firmus"
                   signal clicked
                   width: 149; height: bLabel27.height + 7
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
                  onClicked: {
                           salvarCfg();
                           if (melodia) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; melodia = false; //bLabel291.color = "#000000";
                                          bLabel27.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabel26.color = "#000000"; bLabel28.color = "#002e77";
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000";
                           bLabel27.color = "#002e77"; bLabel29.color = "#000000";
                           bLabel26o.color = "#000000";// bLabel291.color = "#000000";
                           conduz.visible = false; dissonâncias.visible = false; outros.visible = false;
                           intervalosClasse.visible = false; melodias.visible = true;
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = false;
                           quiEsp = false; melodia = true; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
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
                   x: 3; y: 51
                   property string text: "1ª esp."
                   signal clicked
                   width: 74; height: bLabel1.height + 7
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
                   onClicked: {
                           salvarCfg();
                           if (priEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; priEsp = false; // bLabel291.color = "#000000";
                                          bLabel1.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#002e77";
                           bLabel27.color = "#000000"
                           priEsp = true; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
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
                   x: 78; y: 51
                   property string text: "2ª esp."
                   signal clicked
                   width: 74; height: bLabel2.height + 7
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
                   onClicked: {
                           salvarCfg();
                           if (secEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; secEsp = false; //bLabel291.color = "#000000";
                                          bLabel2.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#000000";
                           bLabel2.color = "#002e77"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = true; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
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
                   x: 3; y: 77
                   property string text: "3ª esp."
                   signal clicked
                   width: 74; height: bLabel23.height + 7
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
                   onClicked: {
                           salvarCfg();
                           if (terEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; terEsp = false;//bLabel291.color = "#000000";
                                          bLabel23.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#000000"; bLabel23.color = "#002e77";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = true; quaEsp = false; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
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
                    x: 78; y: 77
                    property string text: "4ª esp."
                    signal clicked
                    width: 74; height: bLabel24.height + 7
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
                    onClicked: {
                           salvarCfg();
                           if (quaEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; quaEsp = false;//bLabel291.color = "#000000";
                                          bLabel24.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000"; bLabel25.color = "#000000";
                           bLabel24.color = "#002e77"; bLabel23.color = "#000000";
                           bLabel2.color = "#000000"; bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = true; quiEsp = false; melodia = false; livreCP = false; }
                           atualizarTitulo();
                           carregarCfg();
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
                   x: 3; y: 103
                   property string text: "5ª esp."
                   signal clicked
                   width: 74; height: bLabel25.height + 7
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
                  onClicked: {
                           salvarCfg();
                           if (quiEsp) {  intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                          melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                          bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000";
                                          bLabel29.color = "#000000"; quiEsp = false;//bLabel291.color = "#000000";
                                          bLabel25.color = "#000000"; bLabel26o.color = "#000000";}
                            else  {
                           bLabLivre.color = "#000000";
                           bLabel25.color = "#002e77"; bLabel24.color = "#000000";
                           bLabel23.color = "#000000"; bLabel2.color = "#000000";
                           bLabel1.color = "#000000"; bLabel27.color = "#000000"
                           priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = true; melodia = false; livreCP = false; }
                           atualizarTitulo();
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
        // contraponto livre
        Rectangle {
                     id: livre
                     x: 3; y: 129
                     property string text: qsTr("Contraponto livre")
                     signal clicked
                     width: 149; height: bLabLivre.height + 7
                     border { width: 1; color: "#555555" }
                     smooth: true
                     radius: 2
                     gradient: Gradient {
                        GradientStop {
                            position: 0.0
                            color: {
                              if (mArLiv.pressed)
                                  return "#888d96"
                                  else
                                  return "#a0a8af"
                                       }
                                }
                        GradientStop { position: 1.0; color: "#334455" }
                      }
                      onClicked: {
                                 salvarCfg();
                                 if (livreCP) { intervalosClasse.visible = false; titulo1.text = ""; titulo2.text = ""; outros.visible = false;
                                                melodias.visible = false; dissonâncias.visible = false; conduz.visible = false;
                                                bLabLivre.color = "#000000"; bLabel26.color = "#000000"; bLabel28.color = "#000000"; //bLabel291.color = "#000000";
                                                bLabel29.color = "#000000";  livreCP = false; bLabel26o.color = "#000000"; }
                                  else  {
                                 bLabLivre.color = "#002e77"; bLabel25.color = "#000000";
                                 bLabel24.color = "#000000"; bLabel23.color = "#000000";
                                 bLabel2.color = "#000000"; bLabel1.color = "#000000";
                                 bLabel27.color = "#000000";
                                 priEsp = false; secEsp = false; terEsp = false; quaEsp = false; quiEsp = false; melodia = false; livreCP = true; }
                                 atualizarTitulo();
                                 carregarCfg();
                                  }
                      MouseArea {
                        id: mArLiv
                        anchors.fill: parent
                        onClicked: livre.clicked();
                      }

                      Text {
                       id: bLabLivre
                       anchors.centerIn: livre
                       color: "#000000"
                       text: livre.text
                      }
                    }

      }
      Rectangle { id: menu2 // botões para seleção de páginas
              x: 3; y: 303
              width: 155; height: 130; radius: 2
              color: "#101010"
              Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: qsTr("Aspectos:") }
              // conduz
              Rectangle {
               id: botao26
               x: 3; y: 25
               property string text: qsTr("Condução de vozes")
               signal clicked
               width: 149; height: bLabel26.height + 7
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
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
             				  if (conduz.visible) { conduz.visible = false; titulo1.text = ""; }
                         else if (!melodia) {
                           conduz.visible = true; melodias.visible = false; dissonâncias.visible = false; intervalosClasse.visible = false; outros.visible = false;
                                bLabel26.color = "#002e77"; bLabel28.color = "#000000"; bLabel26o.color = "#000000";
                                bLabel29.color = "#000000"; //bLabel291.color = "#000000";
                               };
                         atualizarTitulo();
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
              // dissonâncias
              Rectangle {
               id: botao29
               x: 3; y: 51
               property string text: qsTr("Dissonâncias")
               signal clicked
               width: 149; height: bLabel29.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea29.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
                       if (dissonâncias.visible) { dissonâncias.visible = false; titulo1.text = ""; }
              				   else if (!melodia) {
                            dissonâncias.visible = true; melodias.visible = false; conduz.visible = false; intervalosClasse.visible = false; outros.visible = false;
                         bLabel29.color = "#002e77"; bLabel28.color = "#000000"; bLabel26o.color = "#000000";
                         bLabel26.color = "#000000"; //bLabel291.color = "#000000";
                         }
                         atualizarTitulo();
                       }
              MouseArea {
                    id: mArea29
                     anchors.fill: parent
                     onClicked: botao29.clicked();
               }
              Text {
               id: bLabel29
               anchors.centerIn: botao29
               color: "#000000"
               text: botao29.text
                    }
              }
              // melodia
              Rectangle {
               id: botao28
               x: 3; y: 77
               property string text: qsTr("Melodia")
               signal clicked
               width: 149; height: bLabel28.height + 7
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
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
                    if (melodias.visible) { melodias.visible = false; titulo1.text = ""; }
                     else { melodias.visible = true; conduz.visible = false; dissonâncias.visible = false; intervalosClasse.visible = false; outros.visible = false;
                            bLabel28.color = "#002e77"; //bLabel291.color = "#000000";
                            bLabel26o.color = "#000000"; bLabel26.color = "#000000"; bLabel29.color = "#000000";
              				   }
                         atualizarTitulo();
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
              // outros aspectos
              Rectangle {
               id: botao26o
               x: 3; y: 103
               property string text: qsTr("Outros aspectos")
               signal clicked
               width: 149; height: bLabel26o.height + 7
               border { width: 1; color: "#555555" }
               smooth: true
               radius: 2
               gradient: Gradient {
                GradientStop {
                    position: 0.0
                    color: {
                          if (mArea26o.pressed)
                              return "#888d96"
                             else
                             return "#a0a8af"
                       }
                }
                GradientStop { position: 1.0; color: "#343434" }
              }
              onClicked: {
             				  if (outros.visible) { outros.visible = false; titulo1.text = ""; }
                         else {
                           conduz.visible = false; melodias.visible = false; dissonâncias.visible = false; intervalosClasse.visible = false; outros.visible = true;
                                bLabel26o.color = "#002e77"; bLabel28.color = "#000000"; bLabel26.color = "#000000";
                                bLabel29.color = "#000000"; //bLabel291.color = "#000000";
                               };
                         atualizarTitulo();
              				 }
              MouseArea {
                    id: mArea26o
                     anchors.fill: parent
                     onClicked: botao26o.clicked();
               }
              Text {
               id: bLabel26o
               anchors.centerIn: botao26o
               color: "#000000"
               text: botao26o.text
                    }
              }
      // classificação de intervalos
              // Rectangle {
              //  id: botao291
              //  x: 3; y: 103
              //  property string text: qsTr("Intervalos")
              //  signal clicked
              //  width: 149; height: bLabel291.height + 7
              //  border { width: 1; color: "#555555" }
              //  smooth: true
              //  radius: 2
              //  gradient: Gradient {
              //   GradientStop {
              //       position: 0.0
              //       color: {
              //             if (mArea291.pressed)
              //                 return "#888d96"
              //                else
              //                return "#a0a8af"
              //          }
              //   }
              //   GradientStop { position: 1.0; color: "#343434" }
              // }
              // onClicked: {
              //   if (intervalosClasse.visible) { intervalosClasse.visible = false; titulo1.text = ""; }
              //   // else if (!melodia) {
              //   //        intervalosClasse.visible = true; melodias.visible = false; conduz.visible = false; dissonâncias.visible = false;
              //   //        bLabel28.color = "#000000"; bLabel291.color = "#002e77";
              //   //        bLabel26o.color = "#000000"; bLabel29.color = "#000000";
              //   //     }
              //   //     atualizarTitulo();
              // 		}
              // MouseArea {
              //       id: mArea291
              //        anchors.fill: parent
              //        onClicked: botao291.clicked();
              //  }
              // Text {
              //  id: bLabel291
              //  anchors.centerIn: botao291
              //  color: "#000000"
              //  text: botao291.text
              //       }
              // }
      }
      Rectangle { id: preConfigurações;
                 x: 3; y: 437; width: 155; height: 106
                 color: "#101010"; radius: 2
        Text { x: 3; y: 5; color: "#f9ff8c"; font.pixelSize: 14; text: qsTr("Pré-configurações:") }
        Rectangle { x: 3; y: 25; width: 149; height: 22; color: "#9c9c9c"; radius: 2
         Rectangle { x: 1; y: 1; width: 147; height: 20; color: "#050000"; radius: 2
          Text { id: nomePre; x: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12; color: "#d1d10a"; text: qsTr("sem nome") }
         }
        }
            Rectangle {
             id: salvarCnfiguração
             property string text: qsTr("Salvar")
             signal clicked
             x: 3; y: 50; width: 149; height: 25
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
              GradientStop { position: 1.0; color: "#2b2b2b" }
            }
            MouseArea {
                  id: mArea41
                   anchors.fill: parent
                   onClicked: { salvarCfg(); saveFileDialog.open(); }
             }

            Text {
             id: bLabel41
             anchors.centerIn: salvarCnfiguração
             color: "#101010"
             font.pointSize: 10
             text: salvarCnfiguração.text
                  }} //botão salvar
            Rectangle {
             id: carregarCnfiguração
             property string text: qsTr("Carregar")
             signal clicked
             x: 3; y: 77; width: 149; height: 25
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
              GradientStop { position: 1.0; color: "#2b2b2b" }
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
             font.pointSize: 10
             text: carregarCnfiguração.text
                  }} //botão carregar
      }
      Rectangle { id: relatorio;
                 x: 3; y: 546; width: 155; height: 46
                 color: "#101010"; radius: 2
        Text { x: 3; y: 3; color: "#f9ff8c"; font.pixelSize: 14; text: qsTr("Relatório:") }
            Rectangle {
             id: geraRel
             property string text: qsTr("Gerar relatório")
             signal clicked
             x: 3; y: 18; width: 149; height: 25
             border { width: 1; color: "#555555" }
             smooth: true
             radius: 2
             gradient: Gradient {
              GradientStop {
                  position: 0.0
                  color: {
                        if (mArea412.pressed)
                            return "#888d96"
                           else
                           return "#a0a8af"
                     }
              }
              GradientStop { position: 1.0; color: "#2b2b2b" }
            }
              MouseArea {
                  id: mArea412
                   anchors.fill: parent
                   onClicked: { gerarRelatorio(); }
              }

              Text {
               id: bLabel412
               anchors.centerIn: geraRel
               color: "#101010"
               font.pointSize: 10
               text: geraRel.text
              }
          } //botão gerar Relatório

      }

    }
  }
// ------------------------------ verificações -----------------------------------
 Text { id: titulo2; x: 5; y: 2; color: "#e0dfc3"; font.pixelSize: 20; text: ""
 Text { id: titulo1; anchors.left: parent.right; anchors.leftMargin: 13; anchors.verticalCenter: parent.verticalCenter;
        color: "#e0dfc3"; font.pixelSize: 18; text: ""  }}
 Item { id: conduz; visible: false;
   Rectangle { x: 2; y: 28; width: 532; height: 570;	color: "#3a3a3a"; radius: 2
     // paralelas
	  Rectangle { x: 3; y: 3; width: 526; height: 83; color: "#1c1c1c"; radius: 2

	     CheckBox { id: paralela8; checked: true; x: 5; y: 3;
	       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("U/8ª paralela") }
	       Text { id: par8RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("- se ocorrer") }
		     TextInput { id: par8Rep; anchors.left: par8RepTxt.right; anchors.leftMargin: 5; y: par8RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
		      Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ou mais paralela(s)") }
		     }
		   }

	     CheckBox { id: paralela5; checked: true; x: 5; y: 44;
	       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("5ª paralela") }
	       Text { id: par5RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("- se ocorrer") }
		     TextInput { id: par5Rep; anchors.left: par5RepTxt.right; anchors.leftMargin: 5; y: par5RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	         Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ou mais paralela(s)") }
	        }
	       }

	     CheckBox { id: paralela4; checked: false; x: 245; y: 3;
	      Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("4ªJ paralela") }
	      Text { id: par4RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("- se ocorrer") }
	       TextInput { id: par4Rep; anchors.left: par4RepTxt.right; anchors.leftMargin: 5; y: par4RepTxt.y;
           font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
           Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ou mais paralela(s)") }
	       }
	      }

	     CheckBox { id: paralela36; checked: true; x: 245; y: 44;
	      Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
          color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("3ª e 6ª paralela") }
	      Text { id: par36RepTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("- se ocorrer") }
	       TextInput { id: par36Rep; anchors.left: par36RepTxt.right; anchors.leftMargin: 5; y: par36RepTxt.y;
           font.underline: true; text: "4"; font.pixelSize: 12;  color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}
	        Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
            color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ou mais paralela(s)") }
	       }
	      }
	  }
	   // ocultas
	   Rectangle { x: 3; y: 89; width: 526; height: 44; color: "#1c1c1c"; radius: 2

	     CheckBox { id: oculta8; checked: true; x: 5; y: 2;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultEx.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("8ª oculta/direta") }
	      }
	     CheckBox { id: oculta5; checked: true; x: 5; y: 20;
	       onClicked: {if (!oculta8.checked && !oculta5.checked) { ocultEx.checked = false; ocultSalto.checked = false;}}
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("5ª oculta/direta") }
	      }
		 	  CheckBox { id: ocultEx; checked: true; x: 190; y: 2;
		     Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto no final") }
		 		}
		 	  CheckBox { id: ocultSalto; checked: true; x: 190; y: 20;
		     Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Somente se salto na voz superior") }
		 		}
		  }
      // 5ªs e 8ªs intermitentes
     Rectangle { x: 3; y: 136; width: 526; height: 190; color: "#1c1c1c"; radius: 2;

       CheckBox { id: inter8; checked: true; x: 5; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("8ª/U e")
           CheckBox { id: inter5; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                    color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("5ª intermitente") }}
       }}
       CheckBox { id: interPM; checked: true; x: 30; y: 25;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Na mesma posição métrica") }}
       CheckBox { id: interSI; checked: true; x: 30; y: 45;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Separadas por um intervalo") }}
       CheckBox { id: interExS; checked: true; x: 30; y: 65
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
               color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto separadas por mais de")
          TextInput { id: interExSn; anchors.left: parent.right; anchors.leftMargin: 3; anchors.verticalCenter: parent.verticalCenter;
                     font.underline: true; text: "4"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 2; top: 99;}
           Text { anchors.left: parent.right; anchors.leftMargin: 3; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("intervalos") }
          }
         }
        }
       CheckBox { id: interExTf; checked: true; x: 30; y: 85;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
              color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto em tempo fraco e")
              CheckBox { id: interExTf3; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                      color: "#e0dfc3"; font.pixelSize: 11; text: qsTr("em tempo meio forte :") } }
            }
        CheckBox { id: interExTf1; checked: false; x: 60; y: 20;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                color: "#e0dfc3"; font.pixelSize: 11; text: qsTr("sincopada e")
         CheckBox { id: interExTf2; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                 color: "#e0dfc3"; font.pixelSize: 11; text: qsTr("alcançada por grau conjunto") }}
         }
        }
       }
       CheckBox { id: interExTF; checked: true; x: 30; y: 125;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto em tempo forte com ambas notas ligadas às anteriores") }
       }
       CheckBox { id: interExFim; checked: true; x: 30; y: 145;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto na cadência final") }
       }
       CheckBox { id: interExCF; checked: true; x: 30; y: 165;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto se CF não move") }
       }

     }
	     // consecutivas por movimento contrário e oblíquo
	   Rectangle { x: 3; y: 330; width: 276; height: 44;	color: "#1c1c1c"; radius: 2

	     CheckBox { id: consecObli; checked: false; x: 5; y: 2;
	        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("5ª e 8ª consecutivas mov. oblíquo") }
	      }

			CheckBox { id: consecCont; checked: false; x: 5; y: 20;
		     Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("5ª e 8ª consecutivas mov. contrário") }
		 		}
		 }
     // cruzamento de vozes
     Rectangle { x: 283; y: 330; width: 246; height: 44; color: "#1c1c1c"; radius: 2
      CheckBox { id: cruzaVozes; checked: true; x: 5; y: 2
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Cruzamento de vozes") }
       }
       CheckBox { id: falsaR; checked: true; x: 5; y: 20
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Falsa relação") }
       }
     }
      // uníssono
		 Rectangle { x: 3; y: 377; width: 526; height: 42; color: "#1c1c1c"; radius: 2
	     CheckBox { id: uniss; checked: true; x: 5; y: 2;
	       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: qsTr("Uníssono") }
	       CheckBox { id: unissIF; checked: true; x: 250; y: 0
		       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 12; text: qsTr("Exceto Início/Final") }}
         CheckBox { id: unissTF; checked: true; x: 250; y: 18
  		     Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 12; text: qsTr("Exceto tempo fraco")
              CheckBox { id: unissTmF; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
           		  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                       font.pixelSize: 12; text: qsTr("e meio forte") }}
                }}
         Text { id: unissTxt; x: 5; y: 22; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("se quantidade for maior do que") }
		      TextInput { id: unissQt; anchors.left: unissTxt.right; anchors.leftMargin: 5; y: unissTxt.y; font.underline: true; text: "0";
                      font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 99;}}
		   }
		  }
   }
  }
 Item { id: outros; visible: false;
    Rectangle { x: 2; y: 28; width: 532; height: 570;	color: "#3a3a3a"; radius: 2
     // primeiro intervalo
     Rectangle { x: 3; y: 3; width: 526; height: 58;	color: "#282828"; radius: 2
        CheckBox { id: primInt; checked: true; x: 3; y: 2;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("início diferente de unís./8ªJ") }
         CheckBox { id: ex5Ji; checked: true; x: 20; y: 18;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 5ªJ, com a Tônica na voz inf.") } }
         CheckBox { id: ex3i; checked: true; x: 20; y: 35;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 3ª, com a Tônica na voz inf.") } }
       } // ultimo intervalo
       CheckBox { id: ultInt; checked: true; x: 260; y: 2;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("final diferente de unís./8ªJ") }
         CheckBox { id: ex5Jf; checked: true; x: 20; y: 18;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 5ªJ, com a Tônica na voz inf.") } }
         CheckBox { id: ex3f; checked: true; x: 20; y: 35;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 3ª, com a Tônica na voz inf.") } }
       }
     }
     // últimas notas de cada voz alcançadas por grau conjunto descendente e ascendente
     Rectangle { x: 3; y: 64; width: 526; height: 44;	color: "#282828"; radius: 2
        CheckBox { id: ultNotas; checked: true; x: 5; y: 2;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter ;
                color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Se não alcançar último intervalo por grau conj. e mov. contrário") }
         CheckBox { id: quartaJi; checked: true; x: 18; y: 20;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 4ªJ asc / 5ªJ desc, voz inf.") } }
          CheckBox { id: quartaJs; checked: true; x: 260; y: 20;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("exceto 4ªJ asc / 5ªJ desc, voz sup.") } }
       }
     }
     // sensível na cadência final
     Rectangle { x: 3; y: 112; width: 526; height: 47; color: "#282828"; radius: 2
     CheckBox { id: sensCad; checked: true; x: 5; y: 2;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
         color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Se não usar a sensível na cadência final")
         CheckBox { id: sensCadR; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ou se a sensível não resolver") }}
         CheckBox { id: sensCadEx; checked: true; x: 0; y: 17;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                  color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto no modo Frígio") }}
       }}
     }
     // distância
     Rectangle { x: 3; y: 162; width: 526; height: 41; color: "#282828"; radius: 2

        CheckBox { id: distancia; checked: true; x: 5; y: 2;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Distância entre as vozes") }
          Text { id: distTxt; x: 5; y: 20; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("- se uma sequencia maior do que") }
          TextInput { id: distQt; anchors.left: distTxt.right; anchors.leftMargin: 5; y: distTxt.y; font.underline: true; text: "1"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 0; top: 20;}
           Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("intervalo(s) maior(es) do que a")
            TextInput { id: distInt;
              anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; font.underline: true; text: "10"; font.pixelSize: 12; color: "yellow"; validator: IntValidator{bottom: 8; top: 15;}
             Text { anchors.left: parent.right; anchors.leftMargin: 3; anchors.verticalCenter: parent.verticalCenter; color: "yellow"; font.pixelSize: 12; text: "ª" }}
           }
          }
         }
        }
     // consonâncias imperfeitas
     Rectangle { x: 3; y: 206; width: 526; height: 27; color: "#282828"; radius: 2
       CheckBox { id: consImp; checked: true; x: 5; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
           color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Prioridade para Consonâncias Imperfeitas") }
         }
       }
     // coerência harmônica
     Rectangle { x: 3; y: 236; width: 526; height: 53; color: "#282828"; radius: 2
       Text { x: 5; y: 0; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Coerência harmônica") }
       CheckBox { id: cHarmonia; checked: true; x: 5; y: 32;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("notas que não pertencem ao acorde")
           CheckBox { id: cHarmoniaEx; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                    color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("Exceto em tempo fraco")
                    CheckBox { id: cHarmoniaEx2; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
                      Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                             color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("e meio forte") }}
             }
           }
         }
       }
       CheckBox { id: cHarmoniaF; checked: true; x: 5; y: 15;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
                color: "#e0dfc3"; font.pixelSize: 12; text: qsTr("ausência da fundamental")}}

     }
    }
   }
 Item { id: dissonâncias; visible: false;
   Rectangle { x: 2; y: 28; width: 532; height: 564;	color: "#353535"; radius: 2
     Rectangle { x: 3; y: 3; width: 526; height: 45; color: "#292929"; radius: 2
      Rectangle { x: 3; y: 3; width: 520; height: 40; color: "#131313"; radius: 2 // Dissonâncias
       CheckBox { id: dissonanciasG; checked: true; x: 3; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: qsTr("Verificar dissonâncias") }}
     }
     }
     Rectangle { x: 3; y: 36; width: 526; height: 525; color: "#292929"; radius: 2
      Rectangle { x: 3; y: 3; width: 520; height: 45; color: "#131313"; radius: 2 // nota de passagem
       CheckBox { id: passagemL; checked: true; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: qsTr("Nota de passagem")
          CheckBox { id: passaLEx2; checked: false; anchors.left: parent.right; anchors.leftMargin: 15; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                              font.pixelSize: 14; text: qsTr("e Grupo de NP") }}
        }
        CheckBox { id: passaLEx; checked: false; x: 25; y: 20
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 11; text: qsTr("somente em tempo fraco")
           CheckBox { id: passaLExMF; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                        font.pixelSize: 11; text: qsTr("e em tempo meio forte") }}
        }}
       }
      }
      Rectangle { x: 3; y: 51; width: 520; height: 45; color: "#131313"; radius: 2 // bordadura
      Text {  x: 3; y: 3; color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Bordadura")
       CheckBox { id: bordaduraLI; checked: true; x: 80; anchors.verticalCenter: parent.verticalCenter;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 11; text: qsTr("inferior,")
         CheckBox { id: bordaduraLS; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("superior,")
            CheckBox { id: bordaLEx; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: qsTr("somente em tempo fraco")
                CheckBox { id: bordaLExMF; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
                  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                              font.pixelSize: 11; text: qsTr("e em tempo meio forte") }}
            }}
          }}
        }}
      }

    CheckBox { id: bordaduraD; checked: false; x: 3; y:22;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter;
              color: "#e0dfc3"; font.pixelSize: 14; text: qsTr("Bordadura dupla")
        CheckBox { id: bordaLEx1; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("somente em tempo fraco ou meio forte")
          // CheckBox { id: bordaLEx2; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
          //  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
          //        font.pixelSize: 11; text: qsTr("e notas principais em tempo forte") }}
        }}}
      }

      }
      Rectangle { x: 3; y: 98; width: 520; height: 128; color: "#131313"; radius: 2 // cambiata
       CheckBox { id: cambiataL; checked: true; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: qsTr("Cambiata");
         CheckBox { id: cambiLEx1; checked: true; x: 0; y: 20;
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("1ª e última nota em tempo forte")
           CheckBox { id: cambiLEx1MF; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10;
             Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                         font.pixelSize: 11; text: qsTr("ou meio forte") }}
          }
         }
         CheckBox { id: cambiLEx2; checked: false; x: 0; y: 40
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                  font.pixelSize: 11; text: qsTr("cambiata na mesma direção do CF") }
         }
         CheckBox { id: cambiLEx3; checked: false; x: 0; y: 60
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("dissonâncias somente em tempo fraco")
             CheckBox { id: cambiLEx3MF; checked: true; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10;
               Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                       font.pixelSize: 11; text: qsTr("ou meio forte") }}
          }
         }
         CheckBox { id: cambiLEx4; checked: false; x: 0; y: 80
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                    font.pixelSize: 11; text: qsTr("2ª nota deve ser dissonânte") }
         }
         CheckBox { id: cambiLEx5; checked: false; x: 0; y: 100
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                    font.pixelSize: 11; text: qsTr("2ª nota com duração igual ou mais curta do que a 1ª e a última") }
         }
        }
       }
      }
      Rectangle { x: 3; y: 229; width: 520; height: 87; color: "#131313"; radius: 2 // suspensão
       CheckBox { id: suspensãoL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
             font.pixelSize: 14; text: qsTr("Suspensão");
         CheckBox { id: suspeLEx1; checked: true; x: 0; y: 20
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("resolução interrompida")
              CheckBox { id: suspeLEx1a; checked: true; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 5;
                  Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                         font.pixelSize: 11; text: qsTr("somente por consonâncias") }}
          }
         }
         CheckBox { id: suspeLEx2; checked: true; x: 0; y: 40
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("também a resolução ascendente (retardo)") }
         }
         CheckBox { id: suspeLEx3; checked: false; x: 0; y: 60
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("resolução somente em consonância imperfeita") }
         }
        }
       }
      }
      Rectangle { x: 3; y: 318; width: 520; height: 67; color: "#131313"; radius: 2 // antecipação
       CheckBox { id: antecipaL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: qsTr("Antecipação");
           Text { x: 3; y: 20; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("introduzida por grau conjunto (")
           CheckBox { id: antecipaEx2; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0;
            Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("descendente,")
             CheckBox { id: antecipaEx3; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 5;
              Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                     font.pixelSize: 11; text: qsTr("ascendente )") }}}
           }
         }
         CheckBox { id: antecipaEx4; checked: false; x: 0; y: 37
          Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                font.pixelSize: 11; text: qsTr("somente na cadência final") }
         }
        }
       }
      }
      Rectangle { x: 3; y: 387; width: 520; height: 86; color: "#131313"; radius: 2 // apojatura
       CheckBox { id: apojaturaL; checked: false; x: 3; y: 3;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: qsTr("Apojatura");
          CheckBox { id: apojaEx1; checked: false; x: 0; y: 20
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("somente em tempo forte")
             CheckBox { id: apojaEx1MF; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10;
               Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                      font.pixelSize: 11; text: qsTr("ou meio forte") }}
          }}
          CheckBox { id: apojaEx2; checked: false; x: 0; y: 40
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("somente se alcançada por movimento ascendente") }}
          CheckBox { id: apojaEx3; checked: false; x: 0; y: 60
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("somente resolução descendente") }}

        }
       }
      }
      Rectangle { x: 3; y: 475; width: 257; height: 47; color: "#131313"; radius: 2 // escapada
       CheckBox { id: escapadaL; checked: false; x: 3; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: qsTr("Escapada");
          CheckBox { id: escapaEx1; checked: false; x: 0; y: 20
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: qsTr("somente em tempo fraco")
            CheckBox { id: escapaEx1MF; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10;
              Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                     font.pixelSize: 11; text: qsTr("ou mf") }}
          }}
         }
       }
      }
      Rectangle { x: 264; y: 475; width: 260; height: 47; color: "#131313"; radius: 2 // pedal
       CheckBox { id: pedal; checked: false; x: 3; y: 3;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: qsTr("Nota pedal");
          CheckBox { id: pedalEx1; checked: false; x: 0; y: 20
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: qsTr("início e final em tempo forte")
            CheckBox { id: pedalEx1MF; checked: false; anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 10;
              Text { anchors.left: parent.right; anchors.verticalCenter: parent.verticalCenter; anchors.leftMargin: 0; color: "#e0dfc3";
                     font.pixelSize: 11; text: qsTr("ou mf") }}
          }}
         }
       }
      }
     }
   }
 }
 Item { id: melodias; visible: false;
   Rectangle { x: 2; y: 28; width: 532; height: 570;	color: "#5b5b5b"; radius: 2
    Rectangle { x: 3; y: 3; width: 526; height: 80; color: "#303030"; radius: 2
		 CheckBox { id: peNota; checked: true; x: 5; y: 5;
		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Penúltima nota deve pertencer ao V ou vii grau (quando tonal), \nou conduzir por grau conjunto para a finalis (quando modal)") }
		 }

		 CheckBox { id: ambito; checked: true; x: 5; y: 32;
		   Text { id: ambTxt1; anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Âmbito melódico não deve ser maior do que") }
		   TextInput { id: ambInp; anchors.left: ambTxt1.right; anchors.leftMargin: 5; y: ambTxt1.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "12"; validator: IntValidator{bottom: 0; top: 99;}}
		   Text { anchors.left: ambInp.right; anchors.leftMargin: 5; y: ambInp.y; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("semitons") }
		 }

		 CheckBox { id: priviGC; checked: true; x: 5; y: 55;
		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Privilegiar graus conjuntos") }
		   CheckBox { id: priviGCEx; checked: true; x: 195; y: 0;
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: qsTr("e terças") } }
		 }
	  }

	  Rectangle { x: 3; y: 86; width: 526; height: 80; color: "#303030"; radius: 2
		 //Text { x: 5; y: 3;  font.pixelSize: 13; color: "#e0dfc3"; text: "Não usar os seguintes intervalos:"
			 CheckBox { id: salt7; checked: true; x: 5; y: 2;
			   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: qsTr("Sétimas maiores e menores") }
			 }
			 CheckBox { id: salt6; checked: true; x: 5; y: 21;
		      Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		      color: "#e0dfc3"; text: qsTr("Sextas maiores e menores") }
		      CheckBox { id: salt6Ex; checked: true; x: 180; y: 0;
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	          color: "#e0dfc3"; text: qsTr("Exceto se menor ascendente") } }
		    }
		    CheckBox { id: saltAum; checked: true; x: 5; y: 40;
			   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: qsTr("Aumentados e diminutos") }
			 }
			 CheckBox { id: saltM8; checked: true; x: 5; y: 59;
			   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
			   color: "#e0dfc3"; text: qsTr("Maiores do que a oitava") }
			 }
	    //}
	  }

	  Rectangle { x: 3; y: 170; width: 526; height: 195; color: "#303030"; radius: 2
	    CheckBox { id: tritono2; checked: true; x: 5; y: 2;
		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Trítono nas duas extremidades de movimentos melódicos") }
		 }

		 CheckBox { id: tritono1; checked: false; x: 5; y: 21;
		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Trítono em uma extremidade de movimentos melódicos") }
		 }

		 CheckBox { id: dissoC; checked: true; x: 5; y: 40;
		  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Dissonância composta") }
	    }

      CheckBox { id: doisSaltC; checked: true; x: 5; y: 60;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
        color: "#e0dfc3"; text: qsTr("Dois saltos em mov. contrário") }
       CheckBox { id: doisSaltCEx1; checked: true; x: 195; y: -7;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
          color: "#e0dfc3"; text: qsTr("Exceto se precedidos e seguidos por mov. contrário") } }
       CheckBox { id: doisSaltCEx2; checked: false; x: 195; y: 9
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
             color: "#e0dfc3"; text: qsTr("(e) Exceto se precedidos e seguidos grau conjunto") } }
      }

      CheckBox { id: doisSaltM; checked: true; x: 5; y: 86;

       Text { anchors.left: parent.right; anchors.leftMargin: 2; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
              color: "#e0dfc3"; text: qsTr("Dois saltos na mesma direção")
        CheckBox { id: doisSaltMEx; checked: true; x: 5; y: 13;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
                color: "#e0dfc3"; text: qsTr("Exceto se formar tríade")
         CheckBox { id: doisSaltMEx1; checked: true; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
                 color: "#e0dfc3"; text: qsTr("ou 5J + 4J ou 4J + 5J") }}
         }}
        }
       }

	    CheckBox { id: saltM5; checked: true; x: 5; y: 129;
		  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Salto maior do que 5ªJ não compensado \ncom direcionamento contrário") }
		   CheckBox { id: saltM5Ex1; checked: true; x: 300; y: -7;
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: qsTr("por grau conjunto") } }
	      CheckBox { id: saltM5Ex2; checked: true; x: 300; y: 9;
	          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
	          color: "#e0dfc3"; text: qsTr("por salto < 5ª") } }
	    }

      CheckBox { id: saltoTF; checked: false; x: 5; y: 158;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
              color: "#e0dfc3"; text: qsTr("Salto de tempo forte (")
       CheckBox { id: saltoTmF; checked: false; anchors.left: parent.right; anchors.leftMargin: 3; anchors.verticalCenter: parent.verticalCenter;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
               color: "#e0dfc3"; text: qsTr("e de tempo meio forte) para o tempo fraco") }}
         CheckBox { id: saltoTFEx; checked: false; x: 5; y: 12;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
                 color: "#e0dfc3"; text: qsTr("Somente se ascendente") }}
      }}
     }

    Rectangle { x: 3; y: 368; width: 526; height: 106; color: "#303030"; radius: 2
    CheckBox { id: varDir; checked: true; x: 5; y: 2;
		Text { id: varDirTxt; anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: qsTr("Monotonia no contorno: mais do que") }
		TextInput { id: varDirQt; anchors.left: varDirTxt.right; anchors.leftMargin: 5; y: varDirTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "4"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: varDirQt.right; anchors.leftMargin: 5; y: varDirQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("movimento(s) na mesma direção") }
	  }

	  CheckBox { id: repNota; checked: true; x: 5; y: 22;
		 Text { id: repNotaTxt; anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3";text: qsTr("Repetição de notas: mais do que") }
		 TextInput { id: repNotaQt; anchors.left: repNotaTxt.right; anchors.leftMargin: 5; y: repNotaTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
		 Text { anchors.left: repNotaQt.right; anchors.leftMargin: 5; y: repNotaQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("repetição(ões)")
      CheckBox { id: repeteNoutra; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
       color: "#e0dfc3";text: qsTr("sem mudar nota em outra voz") }
      }
     }

    }

	  CheckBox { id: repPad; checked: true; x: 5; y: 42;
		Text { id: repPadTxt; anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		color: "#e0dfc3"; text: qsTr("Repetição de padrões: mais do que") }
		TextInput { id: repPadQt; anchors.left: repPadTxt.right; anchors.leftMargin: 5; y: repPadTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "0"; validator: IntValidator{bottom: 0; top: 99;} }
		Text { anchors.left: repPadQt.right; anchors.leftMargin: 5; y: repPadQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("repetição(ões)") }
	  }

	  CheckBox { id: arpMel; checked: true; x: 5; y: 62;
		  Text { id: arpMelTxt; anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		   color: "#e0dfc3"; text: qsTr("Arpejo de acordes na linha melódica: mais do que") }
      TextInput { id: arpMelQt; anchors.left: arpMelTxt.right; anchors.leftMargin: 5; y: arpMelTxt.y; font.underline: true; font.pixelSize: 12; color: "yellow"; text: "1"; validator: IntValidator{bottom: 0; top: 99;} }
	    Text { anchors.left: arpMelQt.right; anchors.leftMargin: 5; y: arpMelQt.y; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("arpejo(s)") }
	  }

    Text { x: 28; y: 86; font.pixelSize: 12; color: "#e0dfc3"; text: qsTr("Repetição de Ponto Focal");
      CheckBox { id: melPFs; checked: true; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
	    	color: "#e0dfc3"; text: qsTr("Agudo")
        CheckBox { id: melPFi; checked: false; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;
  		   Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
  		   color: "#e0dfc3"; text: qsTr("Grave") }
  	     }
       }
	    }
    }
   }

	  Rectangle { x: 3; y: 478; width: 526; height: 44; color: "#303030"; radius: 2
      CheckBox { id: neutA; checked: true; x: 5; y: 2;
				Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: qsTr("Se não conduzir 6° e 7° alterados") }
				CheckBox { id: neutAim; checked: false; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: qsTr("imediatamente") }}
	  	}
	  	CheckBox { id: neutN; checked: true; x: 5; y: 22;
				Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
				       color: "#e0dfc3"; text: qsTr("Se 6°/7° naturais sem neutralizar") }
				CheckBox { id: neutNim; checked: true; x: 220; y: 0;
				  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
				         color: "#e0dfc3"; text: qsTr("a menos de")
            TextInput { id: neutNqt; anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter;  font.underline: true;
              font.pixelSize: 12; color: "yellow"; text: "4"; validator: IntValidator{bottom: 2; top: 99;}
              Text { anchors.left: parent.right; anchors.leftMargin: 5; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 11;
    				         color: "#e0dfc3"; text: qsTr("tempos da nota alterada") }
            }
          }
        }
	  	}
	 }

    Rectangle { x: 3; y: 526; width: 526; height: 42; color: "#303030"; radius: 2
     CheckBox { id: tonic; checked: true; x: 5; y:1;
		  Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("Nota inicial do CF diferente de tônica/finalis,") }

	   CheckBox { id: terça; checked: false; x: 275;
		 Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("terça,") }
	   }
	   CheckBox { id: quinta; checked: false; x: 355;
		 Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("ou quinta") }
	   }
	  }
	   CheckBox { id: tonicF; checked: true; x: 5; y:22;
		 Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("Nota final do CF diferente de tônica/finalis,") }
	   CheckBox { id: terçaF; checked: false; x: 270;
		 Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("terça,") }
	   }
	   CheckBox { id: quintaF; checked: false; x: 350;
		 Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; font.pixelSize: 12;
		 color: "#e0dfc3"; text: qsTr("ou quinta") }
	   }
	  }
   }
  }
 }
 Item { id: intervalosClasse; visible: false;
   Rectangle { x: 2; y: 28; width: 532; height: 551;	color: "#5a5a5a"; radius: 2
    Rectangle { x: 3; y: 3; width: 526; height: 545; color: "#333333"; radius: 2
     Rectangle { x: 3; y: 3; width: 520; height: 144; color: "#111111"; radius: 2
      CheckBox { id: intDissT1; checked: false; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: qsTr("Uníssono, 8ªJ, etc")
         CheckBox { id: intDissT1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT2; checked: true; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "2ªs, 9ªs, etc"
          CheckBox { id: intDissT2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT3; checked: false; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "3ªs, 10ªs, etc"
           CheckBox { id: intDissT3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT4; checked: true; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "4ªJ, 11ªJ, etc"
            CheckBox { id: intDissT4Ex; checked: true; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT5; checked: false; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "5ªJ, 12ªJ, etc"
             CheckBox { id: intDissT5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT6; checked: false; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "6ªs, 13ªs, etc"
              CheckBox { id: intDissT6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
      CheckBox { id: intDissT7; checked: true; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "7ªs, 14ªs, etc"
           CheckBox { id: intDissT7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: qsTr("somente em relação ao baixo") }}
       }}
     }
     Rectangle { x: 3; y: 150; width: 520; height: 144; color: "#111111"; radius: 2
      CheckBox { id: intDissTad1; checked: true; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Uníssono aumentado ou diminuto"
         CheckBox { id: intDissTad1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad2; checked: true; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "2ª aumentada ou diminuta"
          CheckBox { id: intDissTad2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad3; checked: true; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "3ª aumentada ou diminuta"
           CheckBox { id: intDissTad3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad4; checked: true; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "4ª aumentada ou diminuta"
            CheckBox { id: intDissTad4Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad5; checked: true; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "5ª aumentada ou diminuta"
             CheckBox { id: intDissTad5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad6; checked: true; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "6ª aumentada ou diminuta"
              CheckBox { id: intDissTad6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissTad7; checked: true; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "7ª aumentada ou diminuta"
           CheckBox { id: intDissTad7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
     }
     Rectangle { x: 3; y: 297; width: 520; height: 245; color: "#151515"; radius: 2
      CheckBox { id: intDissA0; checked: false; x: 3; y: 3;
       Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
              font.pixelSize: 14; text: "Intervalo 0"
         CheckBox { id: intDissA0Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA1; checked: false; x: 3; y: 23;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 1"
          CheckBox { id: intDissA1Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA2; checked: false; x: 3; y: 43;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 2"
           CheckBox { id: intDissA2Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA3; checked: false; x: 3; y: 63;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                 font.pixelSize: 14; text: "Intervalo 3"
            CheckBox { id: intDissA3Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
             Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                    font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA4; checked: false; x: 3; y: 83;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 14; text: "Intervalo 4"
             CheckBox { id: intDissA4Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
              Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                     font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA5; checked: false; x: 3; y: 103;
          Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 14; text: "Intervalo 5"
              CheckBox { id: intDissA5Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
               Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                      font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA6; checked: false; x: 3; y: 123;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 6"
           CheckBox { id: intDissA6Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA7; checked: false; x: 3; y: 143;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 7"
          CheckBox { id: intDissA7Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA8; checked: false; x: 3; y: 163;
         Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                font.pixelSize: 14; text: "Intervalo 8"
           CheckBox { id: intDissA8Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
            Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                   font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA9; checked: false; x: 3; y: 183;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 9"
          CheckBox { id: intDissA9Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA10; checked: false; x: 3; y: 203;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 10"
          CheckBox { id: intDissA10Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
      CheckBox { id: intDissA11; checked: false; x: 3; y: 223;
        Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
               font.pixelSize: 14; text: "Intervalo 11"
          CheckBox { id: intDissA11Ex; checked: false; anchors.left: parent.right; anchors.leftMargin: 10; anchors.verticalCenter: parent.verticalCenter;
           Text { anchors.left: parent.right; anchors.leftMargin: 0; anchors.verticalCenter: parent.verticalCenter; color: "#e0dfc3";
                  font.pixelSize: 11; text: "somente em relação ao baixo" }}
       }}
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
          onDoubleClicked: { explicarMsg(parent.value); }
          }
       } // retângulo msg
	  } // componente
 } // msgResult
 //--------------------------------------------------------------------------------
  // janela com o relatório
  ApplicationWindow {
     id: msgRelatorio
     title: "Relatório"
     width: 550; height: 40
     color: "#343530"
     visible: false
      Text {
        id: lRelatorio
        anchors.left: parent.left; anchors.leftMargin: 3
        anchors.verticalCenter: parent.verticalCenter
        text: "-"
        color: "#aaf0e1"
      }
 }
 // msgRelatorio

// ----------------------------------------------------------------------------------------------------------------
   MessageDialog {
      id: msgErros
      title: "Erros!"
      text: "-"
      property bool estado: false
      onAccepted: {
            msgErros.visible=false;
      }

      visible: false;
} // msgErros
//------------------------------------------------------------------------------
  MessageDialog {
     id: msgExplica
     title: "Dica!"
     text: "-"
     property bool estado: false
     onAccepted: {
           msgExplica.visible=false;
     }
     visible: false;
  } // msg de Explicação
// -----------------------------------------------------------------------------------------------------------------
// caixas de dialogo para salvar e abrir presets
FileDialog {
    id: openFileDialog
    nameFilters: ["Configuração do Analisador (*.cfA)"]
    onAccepted: openFile(openFileDialog.fileUrl)

}
FileDialog {
    id: saveFileDialog
    selectExisting: false
    nameFilters: ["Configuração do Analisador (*.cfA)", "All files (*)"]
    onAccepted: saveFile(saveFileDialog.fileUrl, "")
}
// -----------------------------------------------------------------------------------------------------------------
  // ---- variáveis globais ----

      property bool processaTudo: false;
      property var vozes: [];
      property var relator: "";
      property var avalia: 0;
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
      property bool livreCP: false;
      property bool finaliza: false;
      property var config: [];
      property var tipoCP: null;

// ----------- funções ---------
function atualizarTitulo() {
  if (melodia) { titulo2.text = "Cantus Firmus:"; tipoCP = 0; };
  if (priEsp) { titulo2.text = "1ª espécie:"; tipoCP = 1;};
  if (secEsp) { titulo2.text = "2ª espécie:"; tipoCP = 2;};
  if (terEsp) { titulo2.text = "3ª espécie:"; tipoCP = 3;};
  if (quaEsp) { titulo2.text = "4ª espécie:"; tipoCP = 4;};
  if (quiEsp) { titulo2.text = "5ª espécie:"; tipoCP = 5;};
  if (livreCP) { titulo2.text = "Contraponto livre:"; tipoCP = 6;};
  if (melodias.visible) { titulo1.text = "construção melódica" };
  if (dissonâncias.visible) { titulo1.text = "tratamento de dissonâncias" };
  if (conduz.visible) { titulo1.text = "condução de vozes" };
  if (outros.visible) { titulo1.text = "outros aspectos" };
  if (intervalosClasse.visible) { titulo1.text = "Seleção de intervalos dissonântes" };
}

function salvarCfg() {

   var j = 189 * tipoCP;
//console.log("salvarCfg ", tipoCP," j = ", j);
 // ---------------- conduz -----------
   if(primInt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex5Ji.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex3i.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ultInt.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex5Jf.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ex3f.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ultNotas.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quartaJi.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quartaJs.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(paralela8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par8Rep.text; j++;
   if(paralela5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par5Rep.text; j++;
   if(paralela4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par4Rep.text; j++;
   if(paralela36.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = par36Rep.text; j++;
   if(oculta8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(oculta5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ocultEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ocultSalto.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(inter5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interPM.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interSI.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTf3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExFim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExCF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(interExS.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = interExSn.text; j++;
   if(consecObli.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(consecCont.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(uniss.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = unissQt.text; j++;
   if(unissIF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(unissTF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(unissTmF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cruzaVozes.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(falsaR.checked){ config[j] = true; } else { config[j] = false; }; j++;
// ---------------- Outros ---------------
   if(sensCad.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(sensCadR.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(sensCadEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(distancia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = distQt.text; j++;
   config[j] = distInt.text; j++;
   if(consImp.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmonia.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cHarmoniaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
 // -------------- Dissonancias -----------
   if(dissonanciasG.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passagemL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(passaLExMF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLI.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraLS.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaduraD.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLExMF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(bordaLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiataL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx3MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(cambiLEx5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspensãoL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx1a.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(suspeLEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(antecipaEx4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaturaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(apojaEx3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapadaL.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapaEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(escapaEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedal.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedalEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(pedalEx1MF.checked){ config[j] = true; } else { config[j] = false; }; j++;
 // -------------- melodia -------------
   if(peNota.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(ambito.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = ambInp.text; j++;
   if(priviGC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(priviGCEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(salt6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltAum.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tritono1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(dissoC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltC.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltM.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltMEx.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltMEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltCEx1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(doisSaltCEx2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5Ex1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(saltM5Ex2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(varDir.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = varDirQt.text; j++;
   if(repNota.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = repNotaQt.text; j++;
   if(repeteNoutra.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(repPad.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = repPadQt.text; j++;
   if(arpMel.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = arpMelQt.text; j++;
   if(melPFs.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(melPFi.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutA.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutAim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutN.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(neutNim.checked){ config[j] = true; } else { config[j] = false; }; j++;
   config[j] = neutNqt.text; j++;
   if(tonic.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(terça.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quinta.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(tonicF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(terçaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(quintaF.checked){ config[j] = true; } else { config[j] = false; }; j++;
  // ----------------------- Intervalos ------------------------------
   if(intDissT1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissT7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissTad7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA0.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA0Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA1.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA1Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA2.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA2Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA3.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA3Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA4.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA4Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA5.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA5Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA6.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA6Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA7.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA7Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA8.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA8Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA9.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA9Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA10.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA10Ex.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA11.checked){ config[j] = true; } else { config[j] = false; }; j++;
   if(intDissA11Ex.checked){ config[j] = true; } else { config[j] = false; }; //console.log("salvarCfg j = ", j, "config[0]", config[0]);
}

function carregarCfg() {

   var j = 189 * tipoCP;

   // ---------------- conduz -----------
     primInt.checked = config[j]; j++;
     ex5Ji.checked = config[j]; j++;
     ex3i.checked = config[j]; j++;
     ultInt.checked = config[j]; j++;
     ex5Jf.checked  = config[j]; j++;
     ex3f.checked = config[j]; j++;
     ultNotas.checked = config[j]; j++;
     quartaJi.checked = config[j]; j++;
     quartaJs.checked = config[j]; j++;
     paralela8.checked = config[j]; j++;
     par8Rep.text = config[j]; j++;
     paralela5.checked = config[j]; j++;
     par5Rep.text = config[j]; j++;
     paralela4.checked = config[j]; j++;
     par4Rep.text = config[j]; j++;
     paralela36.checked = config[j]; j++;
     par36Rep.text = config[j]; j++;
     oculta8.checked = config[j]; j++;
     oculta5.checked = config[j]; j++;
     ocultEx.checked = config[j]; j++;
     ocultSalto.checked = config[j]; j++;
     inter8.checked = config[j]; j++;
     inter5.checked = config[j]; j++;
     interPM.checked = config[j]; j++;
     interSI.checked = config[j]; j++;
     interExTf.checked = config[j]; j++;
     interExTf1.checked = config[j]; j++;
     interExTf2.checked = config[j]; j++;
     interExTf3.checked = config[j]; j++;
     interExTF.checked = config[j]; j++;
     interExFim.checked = config[j]; j++;
     interExCF.checked = config[j]; j++;
     interExS.checked = config[j]; j++;
     interExSn.text = config[j]; j++;
     consecObli.checked = config[j]; j++;
     consecCont.checked = config[j]; j++;
     uniss.checked = config[j]; j++;
     unissQt.text = config[j]; j++;
     unissIF.checked = config[j]; j++;
     unissTF.checked = config[j]; j++;
     unissTmF.checked = config[j]; j++;
     cruzaVozes.checked = config[j]; j++;
     falsaR.checked = config[j]; j++;
  // --------------- outros -----------------
     sensCad.checked = config[j]; j++;
     sensCadR.checked = config[j]; j++;
     sensCadEx.checked = config[j]; j++;
     distancia.checked = config[j]; j++;
     distQt.text = config[j]; j++;
     distInt.text = config[j]; j++;
     consImp.checked = config[j]; j++;
     cHarmonia.checked = config[j]; j++;
     cHarmoniaEx.checked = config[j]; j++;
     cHarmoniaEx2.checked = config[j]; j++;
     cHarmoniaF.checked = config[j]; j++;
   // -------------- Dissonancias -----------
     dissonanciasG.checked = config[j]; j++;
     passagemL.checked = config[j]; j++;
     passaLEx.checked = config[j]; j++;
     passaLEx2.checked = config[j]; j++;
     passaLExMF.checked = config[j]; j++;
     bordaduraLI.checked = config[j]; j++;
     bordaduraLS.checked = config[j]; j++;
     bordaduraD.checked = config[j]; j++;
     bordaLEx.checked = config[j]; j++;
     bordaLExMF.checked = config[j]; j++;
     bordaLEx1.checked = config[j]; j++;
     cambiataL.checked = config[j]; j++;
     cambiLEx1.checked = config[j]; j++; //
     cambiLEx1MF.checked = config[j]; j++; //
     cambiLEx2.checked = config[j]; j++;
     cambiLEx3.checked = config[j]; j++;
     cambiLEx3MF.checked = config[j]; j++;
     cambiLEx4.checked = config[j]; j++;
     cambiLEx5.checked = config[j]; j++;
     suspensãoL.checked = config[j]; j++;
     suspeLEx1.checked = config[j]; j++; //
     suspeLEx1a.checked = config[j]; j++; //
     suspeLEx2.checked = config[j]; j++;
     suspeLEx3.checked = config[j]; j++;
     antecipaL.checked = config[j]; j++;
     antecipaEx2.checked = config[j]; j++;
     antecipaEx3.checked = config[j]; j++;
     antecipaEx4.checked = config[j]; j++;
     apojaturaL.checked = config[j]; j++;
     apojaEx1.checked = config[j]; j++;
     apojaEx1MF.checked = config[j]; j++;
     apojaEx2.checked = config[j]; j++;
     apojaEx3.checked = config[j]; j++;
     escapadaL.checked = config[j]; j++;
     escapaEx1.checked = config[j]; j++;
     escapaEx1MF.checked = config[j]; j++;
     pedal.checked = config[j]; j++;
     pedalEx1.checked = config[j]; j++;
     pedalEx1MF.checked = config[j]; j++;
   // -------------- melodia -------------
     peNota.checked = config[j]; j++;
     ambito.checked = config[j]; j++;
     ambInp.text = config[j]; j++;
     priviGC.checked = config[j]; j++;
     priviGCEx.checked = config[j]; j++;
     salt7.checked = config[j]; j++;
     salt6.checked = config[j]; j++;
     salt6Ex.checked = config[j]; j++;
     saltAum.checked = config[j]; j++;
     saltM8.checked = config[j]; j++;
     tritono2.checked = config[j]; j++;
     tritono1.checked = config[j]; j++;
     dissoC.checked = config[j]; j++;
     doisSaltC.checked = config[j]; j++;
     doisSaltM.checked = config[j]; j++;
     doisSaltMEx.checked = config[j]; j++;
     doisSaltMEx1.checked = config[j]; j++;
     doisSaltCEx1.checked = config[j]; j++;
     doisSaltCEx2.checked = config[j]; j++;
     saltM5.checked = config[j]; j++;
     saltM5Ex1.checked = config[j]; j++;
     saltM5Ex2.checked = config[j]; j++;
     varDir.checked = config[j]; j++;
     varDirQt.text = config[j]; j++;
     repNota.checked = config[j]; j++;
     repNotaQt.text = config[j]; j++;
     repeteNoutra.checked = config[j]; j++;
     repPad.checked = config[j]; j++;
     repPadQt.text = config[j]; j++;
     arpMel.checked = config[j]; j++;
     arpMelQt.text = config[j]; j++;
     melPFs.checked = config[j]; j++;
     melPFi.checked = config[j]; j++;
     neutA.checked = config[j]; j++;
     neutAim.checked = config[j]; j++;
     neutN.checked = config[j]; j++;
     neutNim.checked = config[j]; j++;
     neutNqt.text = config[j]; j++;
     tonic.checked = config[j]; j++;
     terça.checked = config[j]; j++;
     quinta.checked = config[j]; j++;
     tonicF.checked = config[j]; j++;
     terçaF.checked = config[j]; j++;
     quintaF.checked = config[j]; j++;
    // ----------------------- Intervalos ------------------------------
     intDissT1.checked = config[j]; j++;
     intDissT1Ex.checked = config[j]; j++;
     intDissT2.checked = config[j]; j++;
     intDissT2Ex.checked = config[j]; j++;
     intDissT3.checked = config[j]; j++;
     intDissT3Ex.checked = config[j]; j++;
     intDissT4.checked = config[j]; j++;
     intDissT4Ex.checked = config[j]; j++;
     intDissT5.checked = config[j]; j++;
     intDissT5Ex.checked = config[j]; j++;
     intDissT6.checked = config[j]; j++;
     intDissT6Ex.checked = config[j]; j++;
     intDissT7.checked = config[j]; j++;
     intDissT7Ex.checked = config[j]; j++;
     intDissTad1.checked = config[j]; j++;
     intDissTad1Ex.checked = config[j]; j++;
     intDissTad2.checked = config[j]; j++;
     intDissTad2Ex.checked = config[j]; j++;
     intDissTad3.checked = config[j]; j++;
     intDissTad3Ex.checked = config[j]; j++;
     intDissTad4.checked = config[j]; j++;
     intDissTad4Ex.checked = config[j]; j++;
     intDissTad5.checked = config[j]; j++;
     intDissTad5Ex.checked = config[j]; j++;
     intDissTad6.checked = config[j]; j++;
     intDissTad6Ex.checked = config[j]; j++;
     intDissTad7.checked = config[j]; j++;
     intDissTad7Ex.checked = config[j]; j++;
     intDissA0.checked = config[j]; j++;
     intDissA0Ex.checked = config[j]; j++;
     intDissA1.checked = config[j]; j++;
     intDissA1Ex.checked = config[j]; j++;
     intDissA2.checked = config[j]; j++;
     intDissA2Ex.checked = config[j]; j++;
     intDissA3.checked = config[j]; j++;
     intDissA3Ex.checked = config[j]; j++;
     intDissA4.checked = config[j]; j++;
     intDissA4Ex.checked = config[j]; j++;
     intDissA5.checked = config[j]; j++;
     intDissA5Ex.checked = config[j]; j++;
     intDissA6.checked = config[j]; j++;
     intDissA6Ex.checked = config[j]; j++;
     intDissA7.checked = config[j]; j++;
     intDissA7Ex.checked = config[j]; j++;
     intDissA8.checked = config[j]; j++;
     intDissA8Ex.checked = config[j]; j++;
     intDissA9.checked = config[j]; j++;
     intDissA9Ex.checked = config[j]; j++;
     intDissA10.checked = config[j]; j++;
     intDissA10Ex.checked = config[j]; j++;
     intDissA11.checked = config[j]; j++;
     intDissA11Ex.checked = config[j];
}

function openFile(fileUrl) {
  console.log(fileUrl)
    var request = new XMLHttpRequest();
    request.open("GET", fileUrl, false);
    request.send(null);
    var preSet = request.responseText.split("\n");

    nomePre.text = fileUrl;
    var nomeSplit = nomePre.text.split('/');
    nomePre.text = nomeSplit[nomeSplit.length-1];
console.log("Carregou presets:", preSet.length-1)
    for (var i=0;i<preSet.length-1;i++) {
      if (preSet[i] == "true") { preSet[i] = true; } else
      if (preSet[i] == "false") { preSet[i] = false; };
      config[i] = preSet[i];
      //console.log(i, config[i]);
    };

  carregarCfg();
    //return request.responseText;
}

function saveFile(fileUrl, text) {
    var request = new XMLHttpRequest();
    request.open("PUT", fileUrl, false);
    var conteudoArquivo = "";
console.log("Salvou presets:", config.length);
  for (var j = 0; j < config.length; j++) {
    conteudoArquivo+=config[j]+"\n";
  };

    request.send(conteudoArquivo);
    return request.status;
}

function gerarRelatorio() {
  var ajuste = 0;
  if (secEsp) { ajuste =  0.6; } else
  if (terEsp) { ajuste =  1.1; } else
  if (quaEsp) { ajuste =  1.2; } else
  if (quiEsp) { ajuste =  1.5; } else
  if (livreCP) { ajuste =  1.1; };

  msgRelatorio.visible = false;
  // if (avalia == 0) { msgErros.text = "Não foi encontrada nenhuma informação para relatar!\n" +
  //                                   "Antes de pedir um relatório, escolha a opção Verificar.";
  //                        msgErros.visible = true; return; };
  var avalFinal = Math.round((10 + ((avalia-ajuste)/(vozes.length/5)))*10)/10;
  if (avalFinal > 10) { avalFinal = 10; } else if (avalFinal < 0) { avalFinal = 0; };
  relator += "===========================\n";
  relator += "===    sugestão de nota: " + avalFinal + "    ===\n";
  relator += "===========================\n";
  msgRelatorio.height = Math.round(relator.length/30)*15+25;
  lRelatorio.text = relator;
  msgRelatorio.visible = true;
}

function explicarMsg(valor) {

  if (valor >= 10) { var n = 4; } else { var n = 3; };
  var explica = "----";
  if (resultado[valor][0].slice(0+n, 10+n) == "não conduz") { explica = "Para criar um sentido de conclusão mais acentuado, a melodia deve finalizar conduzindo para a finalis por grau conjunto." } else // melodia
  if (resultado[valor][0].slice(0+n, 9+n) == "penúltima") { explica = "Para criar uma expectativa de resolução e conclusão na nota final, a penúltima nota da melodia deve pertencer ao acorde do V ou do vii° grau." } else
  if (resultado[valor][0].slice(0+n, 6+n) == "Âmbito") { explica = "O âmbito melódico (intervalo entre a nota mais grave e a mais aguda da melodia), ultrapassou o limite estabelecido." } else
  if (resultado[valor][0].slice(0+n, 24+n) == "intervalo melódico de 7ª") { explica = "Intervalo melódico de 7ª prejudica a fluência melódica e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 24+n) == "intervalo melódico de 6ª") { explica = "Intervalo melódico de 6ª prejudica a fluência melódica." } else
  if (resultado[valor][0].slice(0+n, 28+n) == "intervalo melódico aumentado") { explica = "Intervalo melódico aumentado ou diminuto prejudica a fluência melódica e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 23+n) == "intervalo melódico > 8ª") { explica = "Intervalo melódico maior do que a 8ª prejudica a fluência melódica e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 13+n) == "trítono nas 2") { explica = "O intervalo de trítono entre as notas das duas extremidades de um segmento melódico de intervalos na mesma direção coloca em evidência este trítono. Embora mais sutil do que a realização melódica direta do trítono, em alguns contextos, o trítono nas duas extremidades também prejudica a fluência e o direcionamento melódico e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 13+n) == "trítono em 1") { explica = "O intervalo de trítono entre uma nota da extremidade de um segmento melódico de intervalos na mesma direção e outra nota deste mesmo segmento coloca em evidência este trítono. Embora mais sutil do que a realização melódica direta do trítono e do que o trítono nas duas extremidades, em alguns contextos, o trítono em uma extremidade também prejudica a fluência e o direcionamento melódico e é de difícil execução vocal." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "dissonância composta") { explica = "A dissonância composta (dois saltos que, somados, geram um intervalo melódico de 7ª ou 9ª) prejudica a fluência melódica e dificulta a execução vocal." } else
  if (resultado[valor][0].slice(0+n, 23+n) == "intervalo melódico > 5ª") { explica = "O intervalo melódico maior do que a quinta deve ser compensado por movimento em direção contrária e movimento menor do que o do salto de quinta (preferencialmente por grau conjunto). Isso beneficia a fluência e direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 19+n) == "movimentos na mesma") { explica = "O excesso de movimentos na mesma direção e em sequência pode gerar monotonia na melodia, por ser muito previsível." } else
  if (resultado[valor][0].slice(0+n, 18+n) == "repetição de notas") { explica = "A repetição de notas (sem a mudança de nota na outra voz) tende a gerar monotonia." } else
  if (resultado[valor][0].slice(0+n, 19+n) == "repetição de padrão") { explica = "A repetição seguida de padrões melódicos curtos pode gerar monotonia." } else
  if (resultado[valor][0].slice(0+n, 6+n) == "arpejo") { explica = "O excesso de arpejos na melodia prejudica a fluência e o direcionamento." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "repete ponto focal s") { explica = "A repetição de Ponto Focal superior (a nota mais aguda da melodia), em trechos diferentes, enfraquece a definição do clímax da melodia e o direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 20+n) == "repete ponto focal i") { explica = "A repetição de Ponto Focal inferior (a nota mais grave da melodia), em trechos diferentes, enfraquece a definição do clímax da melodia e o direcionamento melódico." } else
  if (resultado[valor][0].slice(0+n, 9+n) == "alteração") { explica = "O uso frequente da sensível é indispensável para a definição de tonalidades, no modo menor. A alteração do 7º grau melódico (sensível) pode exigir também a alteração ascendente do 6º grau, para evitar o intervalo melódico aumentado de 2ª." } else
  if (resultado[valor][0].slice(0+n, 9+n) == "neutraliz") { explica = "Em tonalidades menores, as tendências melódicas do 6º e 7º graus devem ser neutralizadas através da sua resolução nas notas subsequentes. O 6º grau melódico, quando alterado, deve seguir para o 7º grau também alterado. O 7º grau alterado (sensível), deve resolver na tônica. Os 6º e 7º graus naturais resolvem por grau conjunto descendente, no 5º e 6º graus, respectivamente." } else
  if (resultado[valor][0].slice(0+n, 12+n) == "Nota inicial") { explica = "A nota inicial da melodia é, frequentemente, importante para a definição tonal/modal (principalmente no Cantus Firmus). O uso da tônica/finalis como primeira nota, em uma posição métrica forte, é a forma mais eficiente para determinar o tom/modo já no início da melodia." } else
  if (resultado[valor][0].slice(0+n, 11+n) == "2 saltos na") { explica = "2 ou mais saltos seguidos, na mesma direção, prejudicam a fluência melódica." } else
  if (resultado[valor][0].slice(0+n, 11+n) == "2 saltos em") { explica = "2 ou mais saltos seguidos, em direção contrária, podem criar ruptura e prejudicar a fluência melódica." } else
  if (resultado[valor][0].slice(0+n, 8+n) == "salto de") { explica = "A ênfase melódica na nota alcançada por salto pode gerar um deslocamento do acento métrico." } // else

  //explica = resultado[valor][0].slice(0+n, 9+n);

  msgExplica.text = explica;
  msgExplica.estado = true;
  msgExplica.visible = true; return;
}

function colorir(valor) {
console.log("colorir = ", valor, resultado[valor][0]);
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

function removeRepetição(tpc) {  //
  var acordeX = [];
  for (var i = 0;i < tpc.length; i++){
        if(acordeX.indexOf(tpc[i]) == -1){
            acordeX.push(tpc[i]);
        };
  };
  return acordeX;
}

function verificaGrauMelodico(tonal,i) {
  texto2tonica(vozes[i].tom);
  var tom = tonicaTPC(btTonica.text, btAcid.text);
  var x = tonal - tom;
 	var modo = btModo.text;
//console.log("grau melódico:", tonal, i, tom, x, modo);
  switch(modo) {
  	case "Maior":
  	 switch (x) {
  	 	case 0: return 1;
      case 7: return "1+";
      case -5: return "2-";
  	 	case 2: return 2;
      case 9: return "2+";
      case -3: return "3-";
  	 	case 4: return 3;
  	 	case -1: return 4;
      case 6: return "4+";
      case -6: return "5-";
  	 	case 1: return 5;
      case 8: return "5+";
      case -4: return "6-"
  	 	case 3: return 6;
      case 10: return "6+";
      case -2: return "7-";
  	 	case 5: return 7;
    };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n" ;
      // msgErros.estado=true; return "NA";
  	case "Menor":
  	 switch (x) {
  	 	case 0: return 1;
      case 7: return "1+";
      case -5: return "2-";
  	 	case 2: return 2;
      case 9: return "2+";
  	 	case -3: return 3;
      case 4: return "3+";
  	 	case -1: return 4;
      case 6: return "4+";
      case -6: return "5-";
  	 	case 1: return 5;
      case 8: return "5+";
  	 	case -4: return 6;
  	 	case 3: return "6+";
  	 	case -2: return 7;
  	 	case 5: return "7+";
  	 };
       // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
       // msgErros.estado=true; return "NA";
  	case "Jônico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case -1: return 4;
      case 6: return "4+";
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
      case -2: return "7-";
    };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
  	case "Dórico":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case -3: return 3;
      case 4: return "3+";
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
      case -4: return "6-";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
  	case "Frígio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
      case 2: return "2+";
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
      case -6: return "5-";
  	 	case -4: return 6;
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
      // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
      // msgErros.estado=true; return "NA";
  	case "Lídio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
  	 	case 6: return 4;
      case -1: return "4-";
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case 5: return 7;
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  	case "Mixolídio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
  	 	case 4: return 3;
      case -3: return "3-";
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case 3: return 6;
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  	case "Eólio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case 2: return 2;
      case -5: return "2-";
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case 1: return 5;
  	 	case -4: return 6;
      case 3: return "6+";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  	case "Lócrio":
  	 switch (x) {
  	 	case 0: return 1;
  	 	case -5: return 2;
  	 	case -3: return 3;
  	 	case -1: return 4;
  	 	case -6: return 5;
      case 1: return "5+";
  	 	case -4: return 6;
      case 3: return "6+";
  	 	case -2: return 7;
      case 5: return "7+";
  	 };
     // msgErros.text += "Verificação de Grau Melódico não encontrou resultado!\n";
     // msgErros.estado=true; return "NA";
  }
 }

function verificaTempoForte(tempo,metrica) {
  if (tempo%1 > 0) { return "c" };
   switch(metrica) {
    case 1:
    case 2:
    case 3: if (tempo == 1) { return "F"; } else { return "f"; };
      break;
    case 4: if (tempo == 1) { return "F"; } else if (tempo == 3) { return "mF"; } else { return "f"; };
      break;
    case 6: if (tempo == 1) { return "F"; } else if (tempo == 4) { return "mF"; } else { return "f"; };
      break;
    case 8: if (tempo == 1) { return "F"; } else if (tempo == 3 || tempo == 5 || tempo == 7) { return "mF"; } else { return "f"; };
      break;
    case 9: if (tempo == 1) { return "F"; } else if (tempo == 4 || tempo == 7) { return "mF"; } else { return "f"; };
      break;
    case 12: if (tempo == 1) { return "F"; } else if (tempo == 4 || tempo == 7 || tempo == 10) { return "mF"; } else { return "f"; };
      break;
   };

}

function verificaConsonancia(vIN, vIT) {
  vIN = vIN % 12;
  if ((vIN == 0 && vIT == 0) || (vIN == 7 && vIT == 1)) { return "CP"; } else
  if ((vIN == 3 && vIT == 3) || (vIN == 4 && vIT == 4) ||
      (vIN == 8 && vIT == 4) || (vIN == 9 && vIT == 3)) { return "CI"; } else { return "D" };
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

function tonicaPC(nome,acidente) {
  var a, b;
   switch (nome) {
     case "Dó": a = 0; break;
     case "Ré": a = 2; break;
     case "Mi": a = 4; break;
     case "Fá": a = 5; break;
     case "Sol": a = 7; break;
     case "Lá": a = 9; break;
     case "Si": a = 11;
   };
   if (acidente == "#") { b = 1; } else
     if (acidente == "b") { b = -1; } else { b = 0; };

   return a + b;
}

function n2m(texto) { // converte nota (formato nome + oitava: C4) para nota midi (int)
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

function sePertence(acorde, nota) { // verifica se 'nota' pertence ao 'acorde'
  if (!acorde) { console.log("Erro: sePertence(), 'acorde' indefinido!!"); return};
  if (!nota && nota != 0) { console.log("Erro: sePertence(), 'nota' indefinido!!"); return};
  for (var k = 0; k < acorde.length; k++) {
    if (acorde[k] == nota) { return true };
  };
  return false;
}

function texto2tonica(texto){
  if (!texto) { return; };
  texto = texto.split(" ");
  if (texto[0].substr(-1, 1) == "#") {
    texto[0] = texto[0].substr(0, texto[0].length-1); menuAcid.value = 2; btAcid.text = "#"; } else
    if (texto[0].substr(-1, 1) == "B") {
      texto[0] = texto[0].substr(0, texto[0].length-1); menuAcid.value = 3; btAcid.text = "b"; }
      else { menuAcid.value = 1; btAcid.text = ""; };
  var texto0 = texto[0].toUpperCase();
  switch (texto0) {
    case "DÓ": menuTonica.value = 1; btTonica.text = "Dó"; break;
    case "RÉ": menuTonica.value = 2; btTonica.text = "Ré"; break;
    case "MI": menuTonica.value = 3; btTonica.text = "Mi"; break;
    case "FÁ": menuTonica.value = 4; btTonica.text = "Fá"; break;
    case "SOL": menuTonica.value = 5; btTonica.text = "Sol"; break;
    case "LÁ": menuTonica.value = 6; btTonica.text = "Lá"; break;
    case "SI": menuTonica.value = 7; btTonica.text = "Si"; break;
  };
  var texto1 = texto[1].toUpperCase(); //console.log("texto1", texto1);
  switch (texto1) {
    case "MAIOR": menuModo.value = 1; btModo.text = "Maior"; break;
    case "MENOR": menuModo.value = 2; btModo.text = "Menor"; break;
    case "JÔNICO": menuModo.value = 3; btModo.text = "Jônico"; break;
    case "DÓRICO": menuModo.value = 4; btModo.text = "Dórico"; break;
    case "FRÍGIO": menuModo.value = 5; btModo.text = "Frígio"; break;
    case "LÍDIO": menuModo.value = 6; btModo.text = "Lídio"; break;
    case "MIXOLÍDIO": menuModo.value = 7; btModo.text = "Mixolídio"; break;
    case "EÓLIO": menuModo.value = 8; btModo.text = "Eólio"; break;
    case "LÓCRIO": menuModo.value = 9; btModo.text = "Lócrio"; break;
  };
}

function cifra2notas(cifra,x) { // analisa uma 'cifra' e retorna a estrutura intervalar do acorde (em intervalos tonais)
  if (!cifra) { //console.log("Erro(cifra2notas)! não contém cifra!!");
                return; };
  var notas = [];
  texto2tonica(vozes[x].tom);
  var modo = btModo.text;
  var f; // fundamental
  var m; // variável para designar aumentado ou diminuto
  var d; // variavel para dissonancia
  var cifraM = cifra.toUpperCase();
  var idx1 = cifraM.lastIndexOf("I") + 1;
  var idx2 = cifraM.lastIndexOf("V") + 1;
  var idx3 = cifraM.lastIndexOf("/") + 1;
  if (idx1 == 0 && idx2 == 0) { console.log("Erro(cifra2notas)! cifra fora do padrão!!");
                                return; };
  if (idx1 > idx2) { var i = idx1;  } else { var i = idx2; }; // i = posição do ultimo caracter que indica o grau

  switch (cifra.substr(i, 1)) { // define se aumentado ou diminuto
    case "°":
    case "o":
    case "0":
    case "º":
    case "dim":
    case "d":
    case "-": m = 0; break;
    case "+":
    case "a":
    case "aum": m = 1; break;
    default: m = null;
  };

  if (m != null) { d = cifra.substr(i+1); } else { d = cifra.substr(i);};

  var grau = cifra.slice(0, i);
  var grauM = grau.toUpperCase();
//  console.log(m,x,d, grau);
  if (modo == "Menor" && grauM == "VI" && m == 0) { var grauF = "VI+" } else
    if (modo == "Menor" && grauM == "VII" && m == 0) { var grauF = "VII+" }
      else { var grauF = grauM; };
    //  console.log("modo e grauF:", x, modo, grauF);
  switch (grauF) { // define fundamental
    case "V/IV":
    case "I": f = 0; break;
    case "V/V":
    case "II":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Lídio":
        case "Mixolídio":
        case "Eólio": f = 2; break;
        case "Frígio":
        case "Lócrio": f = -5; break;
      }; break;
    case "V/VI":
    case "III":
        switch (modo){
         case "Maior":
         case "Jônico":
         case "Lídio":
         case "Mixolídio": f = 4; break;
         case "Menor":
         case "Dórico":
         case "Frígio":
         case "Eólio":
         case "Lócrio": f = -3; break;
       }; break;
    case "V/VII":
    case "IV":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Frígio":
        case "Mixolídio":
        case "Eólio":
        case "Lócrio": f = -1; break;
        case "Lídio": f = 6; break;
      }; break;
    case "V":
       switch (modo){
        case "Maior":
        case "Menor":
        case "Jônico":
        case "Dórico":
        case "Frígio":
        case "Lídio":
        case "Mixolídio":
        case "Eólio": f = 1; break;
        case "Lócrio": f = -6; break;
      }; break;
    case "VI":
       switch (modo){
        case "Maior":
        case "Jônico":
        case "Dórico":
        case "Lídio":
        case "Mixolídio": f = 3; break;
        case "Menor":
        case "Frígio":
        case "Eólio":
        case "Lócrio": f = -4; break;
      }; break;
    case "V/II":
    case "VI+": f = 3; break;
    case "V/III":
    case "VII":
       switch (modo){
        case "Maior":
        case "Jônico":
        case "Lídio": f = 5; break;
        case "Menor":
        case "Dórico":
        case "Frígio":
        case "Mixolídio":
        case "Eólio":
        case "Lócrio": f = -2; break;
      }; break;
    case "VII+": f = 5; break;
    default: msgErros.text += "Não foi encontrado o grau do acorde na cifra, para a verificação de Coerência Harmônica!\n";
             msgErros.estado=true; return;
   };
//console.log(grau != grauM, m);
   if (idx3 && m == null) { notas = [0+f, 4+f, 1+f]; } else
   if (idx3 && m == 0) { notas = [0+f, -3+f, -6+f]; } else
   if (idx3 && m == 1) { notas = [0+f, 4+f, 8+f]; } else
   if (grau == grauM && m == null) { notas = [0+f, 4+f, 1+f]; } else
   if (grau != grauM && m == null) { notas = [0+f, -3+f, 1+f]; } else
   if (grau != grauM && m == 0) { notas = [0+f, -3+f, -6+f]; } else
   if (grau == grauM && m == 1) { notas = [0+f, 4+f, 8+f]; };
//  console.log(x, idx3, grau, grauM, m, "notas:", notas);
   switch (d) {
     case "7": notas.push(-2+f); break;
     case "7+":
     case "7M": notas.push(5+f); break;
     case "7-":
     case "7d": notas.push(-9+f); break;
   };
   return notas;
}

function vCantusFirmus() {
  if (vozes[1].nota.length == 1) { vozCF = 0; }
   else {	vozCF = parseInt(vozCantusFirmus.text) - 1; };

  if (vozCF >= vozes[vozes.length-1].nota.length || vozCF < 0) {
          msgErros.text = "Erro! \n voz do Cantus Firmus não detectado! \n Por favor, insira um valor válido.";
                       msgErros.visible=true; finaliza = true; return; };
}
//-----------------------------------------------
function verificar() {
 vozCF = null;
 finaliza = false;
 msgErros.text = "";
 msgErros.estado = false;
 msgResult.height = 40;
 relator = "";
 avalia = 0;
console.log("- verificar ---------");
 if (!priEsp && !secEsp && !terEsp && !quaEsp && !quiEsp && !melodia && !livreCP) {
          msgErros.text += "Erro! \n Nenhuma tipo de contraponto selecionado!\n Utilize a barra laterial para selecionar.";
                       msgErros.visible=true; return; };

 destroirMsg();
 resultado = [];
 carregarNotas();
 if (finaliza) { return; };
 vCantusFirmus();

 // --------------- melodia --------------------
 if (peNota.checked) { penultimaNota(); };
 if (ambito.checked) { ambitoMelodico(); };
 if (priviGC.checked) { privilegiaConj(); };
 if (salt7.checked) { melodia7(); };
 if (salt6.checked) { melodia6(); };
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
 if (melodia && (tonic.checked || tonicF.checked)) { notaIniFin(); };
 if (doisSaltM.checked) { doisSaltosMdireção(); };
 if (doisSaltC.checked) { doisSaltosMContra(); };
 if (saltoTF.checked) { saltoTempoForte(); };
 // --------------- conduz ------------
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
 if (!melodia && (primInt.checked || ultInt.checked)) { primUltIntervalo(); };
 if (!melodia && ultNotas.checked) { alcançarMovContra(); };
 if (!melodia && sensCad.checked) { sensivelCadencia(); };
 if (!melodia && consImp.checked) { consonancias(); };
 if (cHarmonia.checked) { coerenciaHarmonica(); };
 if (cHarmoniaF.checked) { coerHarmFund(); };
 // --------------- dissonâncias --------------
 if (!melodia && dissonanciasG.checked) { dissonanciasL(); };
 // ----------------------------------------------
  (typeof(quit) === 'undefined' ? Qt.quit : quit)();
  resultado = removeRepetição(resultado);
  for (var i=0;i<verificados;i++) {
  	mensagem[i] = component.createObject(msgResult);
  	mensagem[i].y = i*25 + 40;
  	mensagem[i].text = resultado[i+1][0];
  	mensagem[i].value = i+1;
  	msgResult.height = i*25 + 70;
  };

  msgResult.visible = true;
  msgResult.raise(); msgResult.raise();
  msgResult.raise(); msgResult.raise();


  if (msgErros.estado) { msgErros.visible = true; };
}
//---------------------------------------
function carregarNotas() {

  console.log("Contraponto .............................................. Rogério Tavares Constante - 2019(c)")

  if (typeof curScore == 'undefined' || curScore == null) { // verifica se há partitura
     console.log("nenhuma partitura encontrada");
     msgErros.text = "Erro! \n Nenhuma partitura encontrada!";
                       msgErros.visible=true; finaliza = true; return; };

  // curScore.startCmd(); // atualizar a leitura dos texto de harmonia ------------
  // cmd("transpose-up"); cmd("transpose-down"); cmd("undo"); cmd("undo");
  // curScore.endCmd(); //  (don't know if it's necessary to restart cmd)
  //----------------------------------------------------------------------------
  vozCF = parseInt(vozCantusFirmus.text) - 1;
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
       if (melodia) { pautaInicial = vozCF; pautaFinal = vozCF + 1}
               else { pautaInicial = 0; pautaFinal = curScore.nstaves; };
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
            var tickComp = [];  // posição de início dos compassos

            cursor.rewind(0);
            while (cursor.segment && (processaTudo || cursor.segment.tick < posFinal)) { // cria array com as formulas de compasso
              compasso++;
              tickComp[compasso] = cursor.segment.tick;
              cursor.nextMeasure();
            };

          // lê as informações da seleção (ou do documento inteiro, caso não haja seleção)

            if(processaTudo) { cursor.rewind(0); } else { cursor.rewind(1); }; // posiciona o cursor no início
            var segmento = cursor.segment;
            var pausa = false;
            for (var c=1;c<tickComp.length;c++) { // atualiza 'compasso' para posição do segmento
              if (tickComp[c] >= segmento.tick) { compasso = c; break; };
            };
           while (segmento && (processaTudo || segmento.tick < posFinal)) {
            carregou = false;
            var denominador = cursor.measure.timesigActual.denominator;
            var numerador = cursor.measure.timesigActual.numerator;
            var tempo = ((segmento.tick - tickComp[compasso]) / (1920 / denominador)) + 1;
            var voz = 0;
            var cifras, tom;
            for (var cif = 0; cif < segmento.annotations.length; cif++) { //console.log(segmento.annotations[cif].type, segmento.annotations[cif].subStyle, segmento.annotations[cif].text);
                 if (segmento.annotations[cif].subStyle == 29) {
                  //console.log("compasso", compasso, ":", segmento.annotations[cif]);
                  cifras = segmento.annotations[cif].text;
                  console.log("cif", cif, cifras);
               } else if ((segmento.annotations[cif].type == 41 ||
                           segmento.annotations[cif].type == 42) &&
                           segmento.annotations[cif].text.length > 4) {
                  var textoTom = segmento.annotations[cif].text;
                  textoTom = textoTom.toUpperCase();
                  textoTom = textoTom.replace(/DO/g, "DÓ");
                  textoTom = textoTom.replace("RE", "RÉ");
                  textoTom = textoTom.replace("MÍ", "MI");
                  textoTom = textoTom.replace("FA", "FÁ");
                  textoTom = textoTom.replace("SÓL", "SOL");
                  textoTom = textoTom.replace("LA", "LÁ");
                  textoTom = textoTom.replace("SÍ", "SI");
                  textoTom = textoTom.replace("JO", "JÔ");
                  textoTom = textoTom.replace("FRI", "FRÍ");
                  textoTom = textoTom.replace("LID", "LÍD");
                  textoTom = textoTom.replace("EO", "EÓ");
                  textoTom = textoTom.replace("LO", "LÓ");
                  if ( textoTom.substr(0, 2) == "DÓ" || textoTom.substr(0, 2) == "RÉ" ||
                       textoTom.substr(0, 2) == "MI" || textoTom.substr(0, 2) == "FÁ" ||
                       textoTom.substr(0, 2) == "SO" || textoTom.substr(0, 2) == "LÁ" ||
                       textoTom.substr(0, 2) == "SI") { tom = textoTom; };
              };
            };

            vozes[seg] = { nota: [], tonal: [], posição: [], duração: [], trilha: [], objeto: [], ligadura: [], tempo: [], cifras: [], tom: [] };

             // Passo 1: ler as notas e guardar em "vozes"
               for (trilha = trilhaInicial; trilha < trilhaFinal; trilha++) {
               	cursor.track = trilha;
            	  if (segmento.elementAt(trilha)) {
            	  	 if (segmento.elementAt(trilha).type == Element.REST) { //console.log(seg, "tipo pausa", trilha, segmento.tick);
            	  	 	 if (seg == 0) { pausa = true; //console.log("seg 0, voz", voz, "ligadura true");
                       vozes[seg].nota[voz] = 0;
                       vozes[seg].tonal[voz] = 12;
                       vozes[seg].trilha[voz] = trilha;
                       vozes[seg].posição[voz] = segmento.tick;
                       vozes[seg].duração[voz] = segmento.elementAt(trilha).duration.ticks;
                       vozes[seg].compasso = compasso;
                       vozes[seg].formula = [numerador, denominador];
                       vozes[seg].objeto[voz] = segmento.elementAt(trilha).rest;
                       vozes[seg].ligadura[voz] = true;
                       vozes[seg].tempo[voz] = tempo;
                       vozes[seg].cifras = cifras;
                       vozes[seg].tom = tom;

                       voz++;
                       carregou = true;
                       continue;
                     } else { //console.log("seg != 0, voz", voz, "ligadura true");
                        vozes[seg].nota[voz] = vozes[seg-1].nota[voz];
                        vozes[seg].tonal[voz] = vozes[seg-1].tonal[voz];
                        vozes[seg].trilha[voz] = vozes[seg-1].trilha[voz];
                        vozes[seg].posição[voz] = segmento.tick;
                        vozes[seg].duração[voz] = segmento.elementAt(trilha).duration.ticks;
                        vozes[seg].compasso = compasso;
                        vozes[seg].formula = [numerador, denominador];
                        vozes[seg].objeto[voz] = segmento.elementAt(trilha).rest;
                        vozes[seg].ligadura[voz] = true;
                        vozes[seg].tempo[voz] = tempo;
                        vozes[seg].cifras = cifras;
                        vozes[seg].tom = tom;

                        voz++;
                        carregou = true;
            	  	      continue; };

            	  	 } else if (segmento.elementAt(trilha).type == Element.CHORD) { //console.log(seg, "tipo CHORD", trilha, segmento.tick);
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
                       vozes[seg].cifras = cifras;
                       vozes[seg].tom = tom;
        //console.log("voz", voz, "ligadura",vozes[seg].ligadura[voz]);
                       voz++;
                       carregou = true;

                     };
                   };
                 } else { //console.log(seg, "tipo: nem pausa, nem chord", trilha, segmento.tick);

              if (vozes[seg-1]) { //console.log("existe vozes anterior.");
					     for (var y=0; y<vozes[seg-1].nota.length;y++) {
						    if (trilha == vozes[seg-1].trilha[y]) { //console.log("trilha atual é a mesma da vozes anterior.");
						    	if ((vozes[seg-1].duração[y] + vozes[seg-1].posição[y]) > segmento.tick) { var prolonga = true; } else { var prolonga = false; };
                //  console.log("Duração da vozes anterior ultrapassa posição do segmento:", prolonga);
						    if (prolonga){
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
                    vozes[seg].cifras = cifras;
                    vozes[seg].tom = tom;

						        voz++;
						        carregou = true;
							   };
							   break;
						    };
					     };
					    };
             };
            };

              if (carregou) { //console.log("vozes", seg, ":", vozes[seg].nota[0], vozes[seg].nota[1]);
                 cursor.track = trilhaInicial;
                 for (var i=1;i<vozes[seg].nota.length;i++) {
                 	 if (vozes[seg].duração[1] < vozes[seg].duração[0]) { cursor.track = vozes[seg].trilha[1]; };
                 };
                 seg++;
              };

        		  cursor.next(); segmento = cursor.segment;
              compasso++;
              if (tickComp[compasso] && segmento.tick < tickComp[compasso]) { compasso--; };
           };

   if (seg == 0) { msgErros.text += "Nenhum acorde carregado!!\n";
                        msgErros.estado=true; (typeof(quit) === 'undefined' ? Qt.quit : quit)(); };
 for (var x=0;x<vozes.length;x++) { //console.log(x, vozes[x].nota);
   if (vozes[x].nota[0] == 0 || vozes[x].nota[1] == 0) { vozes.splice(0, 1); x--; };
 };
 if (vozes.length < 2) { // verifica se há partitura
    console.log("vozes.length < 2");
    msgErros.text = "Erro! \n Não foi detectada quantidade mínima de notas!";
                      msgErros.visible=true; finaliza = true; return; };
}
//------------------- melodia -----------
function penultimaNota() {
 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação da penúltima nota!\n";
                        msgErros.estado = true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
    if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
    var x = vozes.length - 1;
    var g1 = parseInt(verificaGrauMelodico(vozes[x-1].tonal[voz], x-1));
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
  };
}

function ambitoMelodico() {
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
}

function privilegiaConj() {
  if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de privilegiar grau conjunto!\n";
                        msgErros.estado = true; return; };

 var tom = tonicaTPC(btTonica.text, btAcid.text);
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var numAcordes = vozes.length;
  var conj = 0, disj = 0;

  for (var x=1;x<vozes.length;x++) { // percorre acorde
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};
   if (!vozes[x].ligadura[voz]) { var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
    if (priviGCEx.checked) { if (intervalo > 4) { disj++; } else { conj++ };
    } else if (intervalo > 2) { disj++; } else { conj++ };
   };
  };
   if (priviGCEx.checked) { var nome = "Não privilegia graus conj. e 3ªs"; } else { var nome = "Não privilegia grau conjunto"; }
   if (conj <= disj) {
      verificados++;
      criaResultado(verificados, numAcordes-1, voz, voz, nome, numAcordes, 1);
    };
 }
}

function melodia7() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sétima!\n";
                        msgErros.estado=true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};
   var intN = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intCT = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);

   if ((intN == 10 && intCT == 2) || // 7ªm
       (intN == 11 && intCT == 5) || // 7ªM
        (intN == 9 && intCT == 9)) { // 7ªd
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 7ª", 2, 1);
    };
  };
 };
}

function melodia6() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Salto de sexta!\n";
                        msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {return;};

   var intervalo = vozes[x].nota[voz] - vozes[x-1].nota[voz];
   var intCT = vozes[x].tonal[voz] - vozes[x-1].tonal[voz];

   if ((intervalo == 8 || intervalo == 9 || intervalo == -8 || intervalo == -9) // 6ª M e m, desc e asc
        && intCT != 9 && intCT != 8 && intCT != -9 && intCT != -8) { // não 7ªd e não 5ªa
     if (salt6Ex.checked && intervalo > 0 && intCT == -4) { continue; };
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico de 6ª", 2, 1);
    };
  };
 };
}

function melodiaAum() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo melódico aumentado!\n";
                        msgErros.estado = true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acordes
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
   var intCT = Math.abs(vozes[x].tonal[voz] - vozes[x-1].tonal[voz]);

   if (intervalo == 6 || // 4ªa e 5ªd
       (intervalo == 3 && intCT == 9) || // 2ªa
       (intervalo == 8 && intCT == 8)) { // 5ªa
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico aumentado ou diminuto", 2, 1);
    };
  };
 };
}

function melodia8() {

 if (vozes.length<2) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a oitava!\n ";
                        msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  for (var x=1;x<vozes.length;x++) { // percorre acorde
   if (!vozes[x].nota[voz] || !vozes[x-1].nota[voz]) {break;};

   var intervalo = Math.abs(vozes[x].nota[voz] - vozes[x-1].nota[voz]);

   if (intervalo > 12) {
      verificados++;
      criaResultado(verificados, x, voz, voz, "intervalo melódico > 8ª", 2, 1);
    };
  };
 };
}

function tritono2Ext() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de notas para a verificação de trítono!\n";
                        msgErros.estado = true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 };
}

function melodia5() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos maiores do que a quarta justa!\n";
                       msgErros.estado=true; return; };

 var cond1 = false, cond2 = false, cond3 = false;
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
      criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "intervalo melódico > 5ª", 2, 1);
     };
   };
  };
 };
}

function variedadeDirecionamento() {

 var qtMov = parseInt(varDirQt.text);
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 };
 function testaQt(qt) {

   if (qt > qtMov) {
           verificados++;
           criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "movimentos na mesma direção", posIni, 1); };
 };

}

function repetiçãoNotas() {

	var qtRep = parseInt(repNotaQt.text);
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  for (var voz = vozInicial; voz < vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
  //console.log(">=<=><=>=<=>", voz, novaVoz.length, pos1);
   var posIni = novaVoz[novaVoz.length-1].pos - novaVoz[pos1].pos;
   testaRep();
  };
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
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
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
 };
}

function melodiaPF() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Ponto focal!\n";
                       msgErros.estado=true; return; };
 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 var ultComp = vozes[vozes.length-1].compasso;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var vozSup = [];
  var pfSs = 0, pfSi = 127;  // ponto focal da voz Superior/Inferior, inferior/superior
  var pfSsc = 0, pfSic = 0; // var para contagem dos pontos focais;
  var pfAntS = 0, pfAntI = 0; // var para marcar a posição de PF anterior

  for (var x=0;x<vozes.length;x++) { // percorre acordes para encontrar pontos focais

   vozSup[x] = vozes[x].nota[voz];

   if (vozSup[x] > pfSs) { pfSs = vozSup[x]; };
   if (vozSup[x] < pfSi) { pfSi = vozSup[x]; };

 };

  for (var x=1;x<vozes.length-1;x++) { // percorre acordes
   var distMax = (1920/vozes[x].formula[1]) * 2; // define distância máxima para considerar como o mesmo PF. = 2 tempos
   if (vozSup[x] == pfSs) { pfSsc++; // contagem dos pontos focais superiores;
     var distS = vozes[x].posição[voz] - vozes[pfAntS].posição[voz]; //distância para o PF anterior
     if (vozSup[x-1] == pfSs || // não conta se nota anterior é ponto focal
         ((x >= vozes.length-3 && (vozes[x].compasso == ultComp-1 || vozes[x].compasso == ultComp)) || (x <= 3 && vozes[x].compasso == 1)) || // não conta se é a uma das 3 primeiras (no 1º comp.) ou 3 últimas notas (no último ou penúltimo comp.)
         distS <= distMax // não conte se distância entre os PFs for <= a dois tempos
        ) { pfSsc--; } else
     if (melPFs.checked && pfSsc > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal superior", 1, 1); } else
      { pfAntS = x; };
   };
   if (vozSup[x] == pfSi) { pfSic++; // contagem dos pontos focais inferiores;
     var distI = vozes[x].posição[voz] - vozes[pfAntI].posição[voz]; //distância para o PF anterior
    // console.log(voz, x, distMax, distI, pfAntI);
     if (vozSup[x-1] == pfSi || // não conta se nota anterior é ponto focal
        ((x >= vozes.length-3 && (vozes[x].compasso == ultComp-1 || vozes[x].compasso == ultComp)) || (x <= 3 && vozes[x].compasso == 1)) || // não conta se é a uma das 3 primeiras (no 1º comp.) ou 3 últimas notas (no último ou penúltimo comp.)
         distI <= distMax // não conte se distância entre os PFs for <= a dois tempos
        ) { pfSic--; } else
     if (melPFi.checked && pfSic > 1) { verificados++; criaResultado(verificados, x, voz, voz, "repete ponto focal inferior", 1, 1); } else
      { pfAntI = x; };
   };
 };
 };
}

function neutralterações() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de neutralização de alterações!\n";
                       msgErros.estado=true; return; };
var temposNeutra = parseInt(neutNqt.text);

var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
for (var voz = vozInicial; voz <= vozFinal; voz++) {
  //console.log("=> voz", voz);
  if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
  var novaVoz = []; var int1, int2, int3, int4;
  for (var x=0;x<vozes.length;x++) { // cria novaVoz excluindo repetições e ligaduras
   if (x > 0) {
    if (vozes[x].nota[voz] != vozes[x-1].nota[voz]) {
      novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}) ;
    }; } else { novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}); };
   };

  for (var x=0;x<novaVoz.length-1;x++) { // verifica o grau e se possuem alterações
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, novaVoz[x].pos);
    var tom1 = tonicaTPC(btTonica.text, btAcid.text);
    var nota1 = novaVoz[x].tonal-tom1;
    alt1 = alt1.toString();
    var alt2 = verificaGrauMelodico(novaVoz[x+1].tonal, novaVoz[x+1].pos);
    var tom2 = tonicaTPC(btTonica.text, btAcid.text);
    var nota2 = novaVoz[x+1].tonal-tom2;
    alt2 = alt2.toString();
    if (x < novaVoz.length-2) {
      var alt3 = verificaGrauMelodico(novaVoz[x+2].tonal, novaVoz[x+2].pos);
      var tom3 = tonicaTPC(btTonica.text, btAcid.text);
      var nota3 = novaVoz[x+2].tonal-tom3;
      alt3 = alt3.toString();
    };
    if (x < novaVoz.length-3) {
      var alt4 = verificaGrauMelodico(novaVoz[x+3].tonal, novaVoz[x+3].pos);
      var tom4 = tonicaTPC(btTonica.text, btAcid.text);
      var nota4 = novaVoz[x+3].tonal-tom4;
      alt4 = alt4.toString();
    };
    if (x < novaVoz.length-4) {
      var alt5 = verificaGrauMelodico(novaVoz[x+4].tonal, novaVoz[x+4].pos);
      var tom5 = tonicaTPC(btTonica.text, btAcid.text);
      var nota5 = novaVoz[x+4].tonal-tom5;
      alt5 = alt5.toString();
    };
    // verifica tratamento das alterações --------
    if (alt1.slice(-1) == "+") { // se alteração elevando

     if (neutAim.checked) { // conduz alteração imediatamente?
       if (alt1.slice(0, 1) == "6") { // 6º conduz imediatamente para 7º e 1º?
         //console.log("6º conduz imediatamente para 7º e 1º?", x, tom1, tom2, tom3, nota2, alt3);
         if (x < novaVoz.length-2 && (nota2 != 5 || alt3 != "1") &&
              tom1 == tom2 && tom1 == tom3) { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       } else
       if (alt1.slice(0, 1) == "7") { // 7º conduz imediatamente para o 1º
         //console.log("7º conduz imediatamente para o 1º?", x, tom1, tom2, alt2);
         if (alt2 != "1" && tom1 == tom2) { var a = x + 1; verificaAlter(); }; // se não, manda pra lista de verificações
       };
     } else { // conduz alteração não imediatamente
       for (var a=x+1;a<novaVoz.length;a++) {
         var tam = a - x;
         //console.log("tam =", tam);
         if (x < novaVoz.length-2 && tam > 4) { // se ultrapassar distância de 3 notas, manda pra lista de verificações
           //console.log("ultrapassou distância de 3 notas, em", x, a);
           a = x; verificaAlter(); x += 4; break; };
         var procuraT = verificaGrauMelodico(novaVoz[a].tonal, novaVoz[a].pos);
         procuraT = procuraT.toString();
         if (procuraT == "1") {  //procura resolução no 1º
           //console.log("achou resolução no 1º: 5 toms", tom1, tom2, tom3, tom4, tom5);
           if (x < novaVoz.length-2 && tam == 4 && tom1 == tom2 && tom1 == tom3 && tom1 == tom4) { // testa solução com distância de 4 notas
          //  console.log("testa solução com distância de 4 notas", x, a, "alts", alt1, alt2, alt3, alt4);
            if (alt1 == "7+" && alt2 == "6+" && alt3 == "7+" && alt4 == "5") { x += 4; break;}
                else { a = x; verificaAlter(); x += 3; break; };
          } else if (x < novaVoz.length-2 && tam == 3 && tom1 == tom2 && tom1 == tom3) { // testa solução com distância de 3 notas
          //   console.log("testa solução com distância de 3 notas", x, a, "alts", alt1, alt2, alt3, "notas", nota1, nota2, nota3);
             if (alt1 == "6+" && (((alt2 == "2" || alt2 == "5" || alt2 == "1") && nota1 == 5) ||
                                  (nota2 == 5 && (alt3 == "5" || alt3 == "2")))) { x += 3; break;} else
             if (alt1 == "7+" && ((alt2 == "2" && alt3 == "5") || (nota2 == 3 && nota3 == 5))) { x += 3; break;}
                 else { a = x; verificaAlter(); x += 3; break; };
           } else if (tam == 2) { // testa solução com distância de 2 notas
            // console.log("testa solução com distância de 2 notas", x, a, "alts", alt1, alt2, "notas", nota2);
             if (alt1 == "7+" && (alt2 == "2" || alt2 == "5")) { x += 2; break; } else
             if (alt1 == "6+" && nota2 == 5) { x += 2; break; }
                  else { a = x; verificaAlter(); x += 2; break; };
           } else if (tam == 1) { // testa solução com distância de 1 nota (e alternativa de 4 notas, com T na 2ª nota)
             if (x < novaVoz.length-3 && tam == 1 && tom1 == tom2 && tom1 == tom3 && tom1 == tom4 && tom1 == tom5) { // testa solução com distância de 4 notas
            //   console.log("testa solução com distância de 1 e 4 notas", x, a, "alts", alt1, alt2, alt3, alt4);
               if (alt1 == "6+" && alt2 == "1" && ((alt3 == "7+" && alt4 == 2) || (alt4 == "7+" && alt3 == 2))) { x += 4; break;}};
             if (alt1 == "7+") { x += 1; break; } else { verificaAlter(); x += 1; break; };
           };
         };
       };
     };
   };
 };

  for (var x=0;x<novaVoz.length;x++) { // verifica neutralizações do 6 e 7
    var alt1 = verificaGrauMelodico(novaVoz[x].tonal, novaVoz[x].pos); // nota com alteração
    alt1 = alt1.toString();

    if (alt1.slice(-1) == "+") {
      for (var a=x-1;a>=0;a--) { // procura neutralização regressivamente
        if (neutNim.checked && (x-a) > temposNeutra) { break; }; // se ultrapassar a qt de tempos da condição neutNim
        var alt2 = verificaGrauMelodico(novaVoz[a].tonal, novaVoz[a].pos); // nota anterior, de mesmo grau, sem alteração
        alt2 = alt2.toString();
        if (alt2 == alt1) { break; };
        var alt3 = verificaGrauMelodico(novaVoz[a+1].tonal, novaVoz[a+1].pos); // nota que neutraliza
        alt3 = alt3.toString();
        if (alt1.slice(0, 1) == alt2 ) { //se encontrou nota natural (alt2 mesmo grau de alt1)
         switch (alt2) { // se alt3 neutraliza, encerra busca. Se não manda pra lista
           case "6": if (alt3 == "5") { a = -1; } else { verificaNeutr(); a = -1; }; break;
           case "7": if (alt3.slice(0, 1) == "6") { a = -1; } else { verificaNeutr(); a = -1; }; break;
         };
       };
      };
    };
  };
 };
 function verificaAlter() {
   //console.log(">>>>>> alteração 6º e/ou 7º", novaVoz[x].pos, novaVoz[a].pos );
   var posIni = (novaVoz[a].pos - novaVoz[x].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[a].pos, voz, voz, "alteração 6º e/ou 7º", posIni, "ne");
 };
 function verificaNeutr() {
   var posIni = (novaVoz[x].pos - novaVoz[a].pos) + 1;
   verificados++;
   criaResultado(verificados, novaVoz[x].pos, voz, voz, "neutralização 6º e/ou 7º", posIni, "ne");
 };
}

function notaIniFin() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de nota inicial e final!\n";
                       msgErros.estado=true; return; };

 var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
 for (var voz = vozInicial; voz <= vozFinal; voz++) {
   if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
   var test1 = false, test2 = false, test3 = false, test4 = false, test5 = false, test6 = false;
   var nI = parseInt(verificaGrauMelodico(vozes[0].tonal[voz], 0));
   var nF = parseInt(verificaGrauMelodico(vozes[vozes.length-1].tonal[voz], vozes.length-1));

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
  };
}

function doisSaltosMdireção() {

   if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos na mesma direção!\n";
                         msgErros.estado=true; return; };
   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1, triade = false, justos = false;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
     var novaVoz = [];
    for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
        novaVoz.push({ nota: vozes[x].nota[voz], tonal: vozes[x].tonal[voz], pos: x}) ;
       };
     };

    for (var x=2;x<novaVoz.length;x++) { // percorre acordes
     if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

     var int1 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var int2 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
     var intT1 = Math.abs(novaVoz[x-1].tonal - novaVoz[x-2].tonal);
     var intT2 = Math.abs(novaVoz[x].tonal - novaVoz[x-1].tonal);
     var dir1 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var dir2 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
     if ((((int1 == 3 || int1 == 4) && (int2 == 3 || int2 == 4)) && ((intT1 == 3 || intT1 == 4) && (intT2 == 3 || intT2 == 4))) ||
         (((int1 == 3 || int1 == 4) && (int2 == 5 || int2 == 6)) && ((intT1 == 3 || intT1 == 4) && (intT2 == 1 || intT2 == 6))) ||
         (((int1 == 5 || int1 == 6) && (int2 == 3 || int2 == 4)) && ((intT1 == 1 || intT1 == 6) && (intT2 == 3 || intT2 == 4)))) { triade = true; } else { triade = false; };
     if (((int1 == 5 && intT1 == 1) && (int2 == 7 && intT2 == 1)) || ((int1 == 7 && intT1 == 1) && (int2 == 5 && intT2 == 1))) { justos = true; } else { justos = false; };
     if (int1 > 2 && int2 > 2 && dir1 == dir2 && dir1 != 0) {
        if ((doisSaltMEx.checked && triade) || (doisSaltMEx1.checked && justos)) { continue; };
        var posIni = (novaVoz[x].pos - novaVoz[x-2].pos) + 1
        verificados++;
        criaResultado(verificados, novaVoz[x].pos, voz, voz, "2 saltos na mesma direção", posIni, 1);
     };
    };
   };
}

function doisSaltosMContra() {

   if (vozes.length<5) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos consecutivos em movimento contrário!\n";
                         msgErros.estado=true; return; };
   var exceção1 = false, exceção2 = false;
   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
    var novaVoz = [];
    for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
        novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
       };
     };
    for (var x=4;x<novaVoz.length;x++) { // percorre acordes
     if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

     var int1 = Math.abs(novaVoz[x-3].nota - novaVoz[x-4].nota);
     var int2 = Math.abs(novaVoz[x-2].nota - novaVoz[x-3].nota);
     var int3 = Math.abs(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var int4 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
     var dir1 = direção(novaVoz[x-3].nota - novaVoz[x-4].nota);
     var dir2 = direção(novaVoz[x-2].nota - novaVoz[x-3].nota);
     var dir3 = direção(novaVoz[x-1].nota - novaVoz[x-2].nota);
     var dir4 = direção(novaVoz[x].nota - novaVoz[x-1].nota);

     if (int2 > 2 && int3 > 2 && dir2 != dir3 && dir2 != 0 && dir3 != 0) {// 2 saltos em mov contrário

        if ((dir1 != dir2 && dir1 != 0 && dir2 != 0) && // seguido e precedido por mov contra.
            (dir3 != dir4 && dir3 != 0 && dir4 != 0)) {
                 exceção1 = true; } else { exceção1 = false; };
        if (int1 < 3 && int4 < 3) {// por grau conjunto
                 exceção2 = true; } else { exceção2 = false; };

        if ((doisSaltCEx1.checked && doisSaltCEx2.checked) && exceção1 && exceção2) { continue; } else
        if ((doisSaltCEx1.checked && !doisSaltCEx2.checked) && exceção1) { continue; } else
        if ((!doisSaltCEx1.checked && doisSaltCEx2.checked) && exceção2) { continue; };

        var posIni = (novaVoz[x-1].pos - novaVoz[x-3].pos) + 1
        verificados++;
        criaResultado(verificados, novaVoz[x-1].pos, voz, voz, "2 saltos em mov. contrário", posIni, 1);
     };
    };
   };
}

function saltoTempoForte() {

  if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de Saltos de tempo forte para tempo fraco!\n";
                       msgErros.estado=true; return; };

   var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
   for (var voz = vozInicial; voz <= vozFinal; voz++) {
     if ((melodia && voz != vozCF) || (!melodia && !livreCP && voz == vozCF)) { continue; };
     var novaVoz = [];
     for (var x=0;x<vozes.length;x++) {
      if (!vozes[x].ligadura[voz]) {
          novaVoz.push({ nota: vozes[x].nota[voz], pos: x}) ;
      };
    };
    for (var x=1;x<novaVoz.length;x++) { // percorre acordes
      if (!novaVoz[x].nota || !novaVoz[x-1].nota) { break; };

      var int1 = Math.abs(novaVoz[x].nota - novaVoz[x-1].nota);
      var dir1 = direção(novaVoz[x].nota - novaVoz[x-1].nota);
      var pos1 = novaVoz[x-1].pos;
      var pos2 = novaVoz[x].pos;
      var met1 = verificaTempoForte(vozes[pos1].tempo[voz], vozes[pos1].formula[voz]);
      var met2 = verificaTempoForte(vozes[pos2].tempo[voz], vozes[pos2].formula[voz]);
//console.log(x, int1, dir1, pos1, pos2, met1, met2, saltoTmF.checked);
      if (int1 > 2 && (met1 == "F" || (saltoTmF.checked && met1 == "mF")) &&
          (met2 == "f" || met2 == "c") && (!saltoTFEx.checked || dir1 == 1)) {
         var posIni = pos2 - pos1 + 1
         verificados++;
         criaResultado(verificados, pos2, voz, voz, "salto de tempo forte para tempo fraco", posIni, 1);
      };
    };
  };
}

// --------------------- conduz: condução de vozes ------------
function quintasOitavas() {
   var par5Status = true, par8Status = true;
   var acorAnt = 1;
   var qtdpar8Rep = parseInt(par8Rep.text), qtdpar5Rep = parseInt(par5Rep.text);

     for (var voz=0; voz < vozes[1].nota.length-1; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < vozes[1].nota.length; i++) { //  percorre outras vozes
   		 var vozAtual = i;
   		 var par5 = 0, par8 = 0;

	       for (var x=1;x<=vozes.length;x++) { // percorre acordes
	         if (x==vozes.length) { verificou58(); continue ; };
	        // if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { continue ; };

         var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
         var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);
         var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
         var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];
         var intT1 = Math.abs(vozes[x].tonal[voz] - vozes[x].tonal[i]);
         var intT2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x-1].tonal[i]);

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if (Math.abs(intAtual%12) == 7 && intT1 == 1 && intT2 == 1 && intAtual == intAnt && paralela5.checked) { //testa 5ª paralela

                 if (vozAnt == voz) { var qtdPar5 = par5 + 1; }
                 if (par5 == 0) { par5 = 2; } else { par5++; };
                 par5Status = true;
                 vozAnt = voz, vozAtual = i;
                 acorAnt = x;
                 par8 = 0, par8Status = false;

              } else if (par5Status) { verificou58(); };

               if (Math.abs(intAtual%12) == 0 && intT1 == 0 && intT2 == 0 && intAtual == intAnt && paralela8.checked) {  // testa 8ª paralela

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
         if (qtdPar8 >= vozes.length) { qtdPar8 = vozes.length; } else { qtdPar8++; };
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "8ª paralela", qtdPar8 , 2);};

       if (par5Status && par5 > qtdpar5Rep && paralela5.checked) {
         verificados++;
         if (qtdPar5 >= vozes.length) { qtdPar5 = vozes.length; } else { qtdPar5++; };
         criaResultado(verificados, acorAnt, vozAnt, vozAtual, "5ª paralela", qtdPar5 , 2);};

      par8Status = false; par8 = 0;
      par5Status = false; par5 = 0;
    };
 }

function quartas() {

   var par4Status = true;
   var acorAnt = 1;
   var qtdpar4Rep = parseInt(par4Rep.text);

  // console.log("par4Rep : "+ qtdpar4Rep)

     for (var voz=0; voz < vozes[1].nota.length-1; voz++) { // percorre vozes
       var vozAnt = voz;
       for (var i=voz+1; i < vozes[1].nota.length; i++) { // percorre outras vozes
         var vozAtual = i;
         var par4 = 0;
	       for (var x=1;x<vozes.length;x++) { // percorre acordes

	        // if (voz >= vozes[x].nota.length-1 || i >= vozes[x].nota.length) { verificou4(); continue; };

	          var dir1 = direção(vozes[x].nota[voz] - vozes[x-1].nota[voz]);
            var dir2 = direção(vozes[x].nota[i] - vozes[x-1].nota[i]);
            var intAtual = vozes[x].nota[voz] - vozes[x].nota[i];
            var intAnt = vozes[x-1].nota[voz] - vozes[x-1].nota[i];
            var intT1 = Math.abs(vozes[x].tonal[voz] - vozes[x].tonal[i]);
            var intT2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x-1].tonal[i]);

            if (Math.abs(intAtual%12) == 5 && intAtual == intAnt && intT1 == 1 && intT2 == 1 && dir1 == dir2 && dir1 != 0) { //testa por 4ª paralela

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

     for (var voz=0; voz < vozes[1].nota.length-1; voz++) { // percorre vozes
       var vozAnt = voz;

       for (var i=voz+1; i < vozes[1].nota.length; i++) { // percorre outras vozes
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
            var intT1 = Math.abs(vozes[x].tonal[voz] - vozes[x].tonal[i]);
            var intT2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x-1].tonal[i]);

            if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

              if ((Math.abs(intAtual%12) == 3 || Math.abs(intAtual%12) == 4) &&   //testa por 3ª paralela --
                  (Math.abs(intAnt%12) == 3 || Math.abs(intAnt%12) == 4) &&
                  ((intT1 == 3 || intT1 == 4) && (intT2 == 3 || intT2 == 4))) {

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
         var intT1 = Math.abs(vozes[x].tonal[voz] - vozes[x].tonal[i]);

         if (dir1 == dir2 && dir1 != 0) {          // both voices moving in the same direction

           if (Math.abs(intAtual%12) == 7 && intAtual != intAnt && intT1 == 1 && oculta5.checked) {             // testa ocultas
             // testa condições
             if (!ocultEx.checked || (ocultEx.checked && x != vozes.length-1)) {
               if (!ocultSalto.checked || (ocultSalto.checked && Math.abs(vozes[x-1].nota[0] - vozes[x].nota[0]) > 2)) {
                verificados++;
                criaResultado(verificados, x, voz, i, "5ª oculta", 2, 2);
               };
             };
           };

           if (Math.abs(intAtual%12) == 0 && intAtual != intAnt && intT1 == 0 && oculta8.checked) { // testa ocultas
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
            var intT1 = Math.abs(vozes[x].tonal[voz] - vozes[x].tonal[i]);
            var intT2 = Math.abs(vozes[x-1].tonal[voz] - vozes[x-1].tonal[i]);

            // consecutivas

             if ((Math.abs(intAtual%12) == 7 || Math.abs(intAtual%12) == 0) &&
                 (Math.abs(intAnt%12) == 7 || Math.abs(intAnt%12) == 0) &&
                 (intT1 == 1 || intT1 == 0) && (intT2 == 1 || intT2 == 0))  {

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
  var voz = 1 - vozCF;
  var separa = parseInt(interExSn.text);
   for (var x=0;x<vozes.length-2;x++) { // percorre acordes
    var tF = verificaTempoForte(vozes[x].tempo[0], vozes[x].formula[0]); // verifica posição métrica
    for (var y=x+2;y<vozes.length;y++) { // percorre acordes
      var ac = y - x + 1; // calcula qtd de acordes entre x e y
      var tF2 = verificaTempoForte(vozes[y].tempo[0], vozes[y].formula[0]); // verifica posição métrica
      var alc = Math.abs(vozes[y].nota[voz] - vozes[y-1].nota[voz]); // calcula intervalo melódico que alcança a intermitente
      if (interExTf.checked && ((interExTf3.checked && tF != "F" && tF2 != "F") || // verifica exceção de tempo fraco e meio fraco
           (!interExTf3.checked && tF != "F" && tF != "mF" && tF2 != "F" && tF2 != "mF")) && // verifica exceção de tempo fraco
           (!interExTf2.checked || (alc < 3 && alc != 0)) && // alcançada por grau conjunto
           (!interExTf1.checked || vozes[x+1].ligadura[voz])) { continue; }; // verifica sincopada
      if (interExTF.checked && tF == "F" && vozes[x].ligadura[voz] && vozes[y].ligadura[voz]) { continue; }; // verifica exceção de tempo forte
      if (interExFim.checked && y == vozes.length-1) { continue; }; // verifica a exceção de cadência final
      if (interExS.checked && ac-2 > separa) { continue; }; // verifica qtd de notas que separam
      var notasIguais = true; // verifica a exceção de CF parado
      var notasIguais2 = true;
      var notasIguais3 = true;
      for (var j=x+1;j<=y;j++){
        if (!livreCP && vozes[x].nota[vozCF] != vozes[j].nota[vozCF]) { notasIguais = false; };
        if (livreCP && vozes[x].nota[voz] != vozes[j].nota[voz]) { notasIguais2 = false; };
        if (livreCP && vozes[x].nota[vozCF] != vozes[j].nota[vozCF]) { notasIguais3 = false; };
      };
      if (interExCF.checked && notasIguais && (notasIguais2 || notasIguais3)) { continue; }
      var int1 = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]); // calcula intervalo x
      var int2 = Math.abs(vozes[y].nota[0] - vozes[y].nota[1]); // calcula intervalo y
      var intT1 = Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]);
      var intT2 = Math.abs(vozes[y].tonal[0] - vozes[y].tonal[1]);

      if (interPM.checked && vozes[x].compasso+1 == vozes[y].compasso && vozes[x].tempo[0] == vozes[y].tempo[0]) { //mesma posição métrica
          if (int1%12 == 7 && int1 == int2 && intT1 == 1 && intT2 == 1 && inter5.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); };
	        if (int1%12 == 0 && int1 == int2 && intT1 == 0 && intT2 == 0 && inter8.checked) {
	         verificados++;
		       criaResultado(verificados, y, 0, 1, "8ª intermitente", ac, "in");
          };
        };
      if (interSI.checked && y-x == 2) { // separadas por uma nota
        if (int1%12 == 7 && int1 == int2 && intT1 == 1 && intT2 == 1 && inter5.checked) {
	        verificados++;
		      criaResultado(verificados, y, 0, 1, "5ª intermitente", ac, "in"); };
	      if (int1%12 == 0 && int1 == int2 && intT1 == 0 && intT2 == 0 && inter8.checked) {
	        verificados++;
		      criaResultado(verificados, y, 0, 1, "8ª intermitente", ac, "in");
        };
      };
     };
    };
}

function unissono() {

  var unissono = parseInt(unissQt.text)
  var uni = 0;

  if (unissIF.checked) { var a1 = 1, a2 = vozes.length-1; } // exceção início e final
    else { var a1 = 0, a2 = vozes.length; } ;

  for (var x=a1;x<a2;x++) { // percorre acordes
   var pMetric = verificaTempoForte(vozes[x].tempo[0],vozes[x].formula[0]);
   if ((!unissTF.checked || pMetric != "f") && (!unissTmF.checked || pMetric != "mF"))  { // exceção tempo fraco e meio forte
    for (var voz=1;voz<vozes[x].nota.length;voz++) {
      var int1 = vozes[x].nota[voz-1] - vozes[x].nota[voz];
      var intT1 = vozes[x].tonal[voz-1] - vozes[x].tonal[voz];
      if (int1 == 0 && intT1 == 0) { uni++; };
      if (int1 == 0 && intT1 == 0 && uni > unissono) {
        verificados++;
    	  criaResultado(verificados, x, voz-1, voz, "uníssono", 1, 2); };
    };
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

// ------------- outros aspectos -------------
function primUltIntervalo() {

 if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de intervalo inicial e final!\n";
                       msgErros.estado=true; return; };
 texto2tonica(vozes[0].tom);
 var tonica1 = tonicaPC(btTonica.text, btAcid.text);
 texto2tonica(vozes[vozes.length-1].tom);
 var tonica2 = tonicaPC(btTonica.text, btAcid.text);
 var notaInferior1 = vozes[0].nota[1];
 var notaInferior2 =  vozes[vozes.length-1].nota[1];
 var intI = (Math.abs(vozes[0].nota[0] - notaInferior1)) % 12;
 var intF = (Math.abs(vozes[vozes.length-1].nota[0] - notaInferior2)) % 12;
 var inicio = false, finale = false;
//console.log("teste Intervalo inicial:",intI);
 if (intI != 0) { // se inicio não for U ou 8ª
//   console.log(ex5Ji.checked, ex3i.checked, tonica1, notaInferior1%12);
   if (ex5Ji.checked && (intI == 7 && tonica1 == notaInferior1%12)) { inicio = true; } else // se for 5ª com tonica na voz inferior
   if (ex3i.checked && ((intI == 3 || intI == 4) && tonica1 == notaInferior1%12)) { inicio = true; }; // se for 3ª com tonica na voz inferior
   if (!inicio) {
   	verificados++;
	  criaResultado(verificados, 0, 0, 1, "intervalo inicial", 1, 2); };
 };

 if (intF != 0) { // se final não for U ou 8ª
   if (ex5Jf.checked && (intF == 7 && tonica2 == notaInferior2%12)) { finale = true; } else // se for 5ª com tonica na voz inferior
   if (ex3f.checked && ((intF == 3 || intF == 4) && tonica2 == notaInferior2%12)) { finale = true; }; // se for 3ª com tonica na voz inferior
   if (!finale) {
    verificados++;
    criaResultado(verificados, vozes.length-1, 0, 1, "intervalo final", 1, 2); };
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

function sensivelCadencia(){

   if (btModo.text == "Frígio") { return; };
   if (vozes.length<3) { msgErros.text += "Não possui a quantidade mínima de acordes para a verificação de sensível na cadência final!\n";
                         msgErros.estado=true; return; };
   var tom = tonicaTPC(btTonica.text, btAcid.text);
   var achou = false;
   var c = (vozes[vozes.length-1].compasso) - 1; // penúltimo compasso
   for (var voz=0;voz<vozes[1].nota.length;voz++) { // percorre vozes
     var x = vozes.length-2;
//  console.log(voz, vozes[x].compasso, c);
     while (vozes[x].compasso >= c && x >= 0) { // procura sensível no penúltimo compasso
       var intM = Math.abs(vozes[vozes.length-1].nota[voz] - vozes[x].nota[voz]); // intervalo melódico na nota final para a nota X
//console.log(voz, sensCadR.checked, vozes[vozes.length-1].tonal[voz], tom, intM, vozes[x].tonal[voz]);
       if ((!sensCadR.checked || (vozes[vozes.length-1].tonal[voz] == tom && intM == 1)) && // resolve sensível?
            vozes[x].tonal[voz] == tom+5) { achou = true; break; }; // achou a sensível?
       x--;
     };
     if (achou) { break; };
   };
   if (!achou) {
  	 verificados++;
     var n = (vozes.length - x) - 1;
  	 criaResultado(verificados, vozes.length-1, 0, 1, "cadência final sem a sensível", n, 2);
   };
}

function consonancias() {

  var cP = 0, cI = 0;
  for (var x=0;x<vozes.length;x++) { // percorre acordes
   var vIN = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]);
   var vIT = Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]);
   var int1 = verificaConsonancia(vIN, vIT);
   if (int1 == "CP") { cP++; } else if (int1 == "CI") { cI++; }
  };
//  console.log("consonancias:", cP, cI);
  if (cP > cI) {
  	 verificados++;
     var resultado = "cons. imperfeita não é maioria (p=" + cP + ", i=" + cI + ")";
	 criaResultado(verificados, vozes.length-1, 0, 1, resultado, vozes.length, "null");
  };
}

function espaçamento() {

  var qt = parseInt(distQt.text);
  var intT= parseInt(distInt.text);
  switch (intT) {
   case 8: intT= 12; break;
   case 9: intT= 14; break;
   case 10: intT= 16; break;
   case 11: intT= 17; break;
   case 12: intT= 19; break;
   case 13: intT= 21; break;
   case 14: intT= 23; break;
   case 15: intT= 24;
  };
  var int1, conta = 0, conta2 = 0;
  for (var x=0;x<vozes.length;x++) { // percorre acordes
    for (var voz=1;voz<vozes[x].nota.length;voz++) {
      int1 = Math.abs(vozes[x].nota[voz-1] - vozes[x].nota[voz]);
      if (int1 > intT) {
       conta++;
     } else {
        testaResultado(x-1,voz);
        conta = 0;
      };
    };
  };
  testaResultado(vozes.length-1,vozes[1].nota.length-1);
 function testaResultado(x,voz){
  if (conta > qt) {
    var msg = "distância vozes (" + conta + ")";
    verificados++;
    criaResultado(verificados, x, voz-1, voz, msg , conta, 2);
  };
 };
}

function coerenciaHarmonica() {
//  console.log( "================ Coerência Harmônica =================\n")
  var novoX, acordeAnterior;
  for (var x=0;x<vozes.length;x++) {
    //console.log(x, vozes[x].tom);
    texto2tonica(vozes[x].tom);
    var tom = tonicaTPC(btTonica.text, btAcid.text);
    //console.log("===========", tom);
    for (var voz = 0; voz < vozes[1].tonal.length; voz++) {
      //console.log("= = = = = = ", x, vozes.length);
      var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
      var nota = vozes[x].tonal[voz] - tom;
      //console.log("==========", x, vozes[x].cifras);
      var acorde = cifra2notas(vozes[x].cifras, x); //console.log(x, "Acorde:", acorde);
      if (!acorde) { //console.log(x,") var acorde = indefinido!!");
                    continue; };
      //console.log("===========----------------===========", x, acorde, nota);
      var pertence = sePertence(acorde, nota);
      var mudaAcorde = true;
      if (acordeAnterior && acorde.toString() == acordeAnterior.toString()) { mudaAcorde = false; };
      //console.log("nota pertence ao acorde?", pertence, acorde.toString(), acordeAnterior, mudaAcorde, notaAcento);
      if (!pertence &&
                ( notaAcento == "F" || mudaAcorde ||
                 (!cHarmoniaEx.checked && notaAcento == "f") ||
                 (!cHarmoniaEx2.checked && notaAcento == "mF")
              )) {
        if (!priEsp) {
          // console.log("compasso:", vozes[x].compasso, x);
          novoX = cambiata(x, "ch"); if (novoX != x) { continue; };
          novoX = bordadura4(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão5(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem5(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão4(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem4(x, "ch"); if (novoX != x) { continue; };
          novoX = suspensão3(x, "ch"); if (novoX != x) { continue; };
          novoX = bordadura(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPassagem(x, "ch"); if (novoX != x) { continue; };
          novoX = apojatura(x, "ch"); if (novoX != x) { continue; };
          novoX = antecipação(x, "ch"); if (novoX != x) { continue; };
          novoX = escapada(x, "ch"); if (novoX != x) { continue; };
          novoX = notaPedal(x, "ch"); if (novoX != x) { continue; };
        };
        verificados++;
        criaResultado(verificados, x, voz, voz, "nota não pertence ao acorde", 1, 1);
     };
   };
   acordeAnterior = acorde;
 };
}

function coerHarmFund() {

  var conjNotas = [];
  var tom;
  var vozInicial = 0, vozFinal = vozes[1].tonal.length-1;
  var cifraAtual, cifraAnterior, jAnterior;

  for (var j=0; j<vozes.length;j++) {
    cifraAtual = vozes[j].cifras;
    if (j == 0) { cifraAnterior = cifraAtual; jAnterior = j; };
    for (var voz = vozInicial; voz <= vozFinal; voz++) {
      if (cifraAtual == cifraAnterior) {
        conjNotas.push(vozes[j].tonal[voz]);
      } else { //console.log(cifraAnterior);
        if (!cifraAnterior) { return; };
        var acorde = cifra2notas(cifraAnterior, jAnterior);
        if (!acorde) { //console.log(jAnterior,") var acorde = indefinido!!");
                       continue; };
        texto2tonica(vozes[jAnterior].tom);
        tom = tonicaTPC(btTonica.text, btAcid.text);
        // console.log("acorde:", acorde);
        var fund = acorde[0] + tom;
        //console.log(j,") conjunto de notas", conjNotas, " == Fund:", fund);
        var pertence = sePertence(conjNotas, fund, tom);
        //console.log("fundamental?", pertence);
        if (!pertence && cHarmoniaF.checked) {
          var msg = cifraAnterior + " sem a fundamental";
          var ac = j - jAnterior;
          verificados++;
          criaResultado(verificados, j-1, 0, 1, msg, ac, 2);
        };
        jAnterior = j; cifraAnterior = cifraAtual;
        conjNotas = []; conjNotas.push(vozes[j].tonal[voz]);
      };
    };
 };
}

// ------------------------Dissonâncias ------------
function dissonanciasL() {
  //relator += "================ função dissonanciasL ================\n";
  var novoX;
  // procura dissonâncias
  for (var x = 0; x < vozes.length; x++) {  // percorre acordes
  //  console.log("percorre acordes", novoX, x);
    var acusaDissonancia = true;
    //console.log("cambiataL",x);
    if (cambiataL.checked) { novoX = cambiata(x, "td"); if (novoX != x) { x = novoX-1; continue; }; };
      //  console.log("bordadura4",x);
    if (bordaduraD.checked) { novoX = bordadura4(x, "td"); if (novoX != x) { x = novoX; continue; }; };
        var vIN = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]);
    var vIT = Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]);
    var intHarm = verificaConsonancia(vIN, vIT);
    if (intHarm == "D") { //console.log("Dissonância em", x);
       //procura padrão melódico de tratamento, do maior para o menor, até 3 notas. Primeiro na voz superior, depois na inferior.
       if (passagemL.checked) { //console.log("passagemL");
         if (passaLEx2.checked) { //console.log("passaLEx");
           novoX = notaPassagem5(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
           novoX = notaPassagem4(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
         };
         novoX = notaPassagem(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
         //console.log("passagem");
       };

       if (suspensãoL.checked) { //console.log("suspensãoL"); console.log("----=====",novoX, x);
          novoX = suspensão3(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
          novoX = suspensão4(x, "td"); if (novoX != x) { x = novoX; acusaDissonancia = false; continue; };
          novoX = suspensão5(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; };
       };

      // console.log("bordaduras");
       if (bordaduraLI.checked || bordaduraLS.checked) { novoX = bordadura(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };

      // console.log("apojaturaL");
       if (apojaturaL.checked) { novoX = apojatura(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      // console.log("antecipaL");
       if (antecipaL.checked) { novoX = antecipação(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      // console.log("escapadaL");
       if (escapadaL.checked) { novoX = escapada(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      // console.log("pedal");
       if (pedal.checked) { novoX = notaPedal(x, "td"); if (novoX != x) { x = novoX-1; acusaDissonancia = false; continue; }; };
      // console.log("acusaDissonancia", acusaDissonancia);

       if (acusaDissonancia) {
        verificados++;
        if (priEsp) { criaResultado(verificados, x, 0, 1, "dissonância", 1, 2); } else
              { criaResultado(verificados, x, 0, 1, "dissonância não tratada", 1, 2); };
       };
    } else { acusaDissonancia = false; };
  };
}

function suspensão3(x, tipo) { //console.log(x,"=============== função suspensão3 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, r = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
      var vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
      var notaPrepara = verificaConsonancia(vIN, vIT);
      var pos1 = vozes[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    if (!vozes[r]) { return x; };
    if (!notaPrepara) {
      var vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
      var vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
      var notaPrepara = verificaConsonancia(vIN, vIT); };
    var vIN = Math.abs(vozes[r].nota[0] - vozes[r].nota[1]);
    var vIT = Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]);
    var notaResolve = verificaConsonancia(vIN, vIT);
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[r].posição[voz] - pos1;
    if (!vozes[r+1]) { var dur3 = dur1; } else { var dur3 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//  console.log(p, x, r, "duração:", dur1, dur2, dur3);
    if (mov1 == 0 && mov2 != 0 && intM < 3 && // desenho melódico, intervalos
        //(dur2 <= dur1*2 && dur2 <= dur3*2) && // proporção entre as durações de dissonâncias e consonâncias
        (notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch") // e consonâncias em t.f.
        && p < x && r > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente

        if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão 3 notas -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão 3 notas -"; };
        if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n"; };
        return r;
      } else if (voz == qtVozes) { return x; };
   };
}
function suspensão4(x, tipo) { //console.log(x,"=============== função suspensão4 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, i = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
      var vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
      var notaPrepara = verificaConsonancia(vIN, vIT);
      var pos1 = vozes[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[i].nota[voz]) { // procura nota interrompe
      i++; if (i >= vozes.length) { i = vozes.length-1; break; }; };
     var r = i;
    while (vozes[i].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };
    if (!vozes[r]) { return x; };
    if (!notaPrepara) {
      var vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
      var vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
      var notaPrepara = verificaConsonancia(vIN, vIT); };
    var vIN = Math.abs(vozes[i].nota[0] - vozes[i].nota[1]);
    var vIT = Math.abs(vozes[i].tonal[0] - vozes[i].tonal[1]);
    var notaInterrompe = verificaConsonancia(vIN, vIT);
    var vIN = Math.abs(vozes[r].nota[0] - vozes[r].nota[1]);
    var vIT = Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]);
    var notaResolve = verificaConsonancia(vIN, vIT);
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[i].posição[voz] - pos1;
    var dur3 = vozes[r].posição[voz] - vozes[i].posição[voz];
    if (!vozes[r+1]) { var dur4 = dur1; } else { var dur4 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//  console.log(p,x,i,r,", mov:", mov1, mov2, mov3, mov4, ", ints:", intM, intM2, intM3, ", acentos:", notaAcento, notaAcentoR, ", cons:", notaPrepara, notaInterrompe, notaResolve);
    if (mov1 == 0 && mov2 != 0 && intM < 3 &&
       (dur2 <= dur1*2 && dur2 <= dur4*2 && dur3 <= dur4) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i && i > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && (!suspeLEx1a.checked || notaInterrompe != "D") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente
          if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão RI 4 notas -"; avalia += 0.5; } else
          if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão RI 4 notas -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n"; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function suspensão5(x, tipo) { //console.log(x,"=============== função suspensão5 =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, i = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
      var vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
      var notaPrepara = verificaConsonancia(vIN, vIT);
      var pos1 = vozes[x].posição[voz];
      if (notaPrepara != "D") { break; };
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[i].nota[voz]) { // procura 1ª nota interrompe
      i++; if (i >= vozes.length) { i = vozes.length-1; break; }; };
     var i2 = i;
    while (vozes[i].nota[voz] == vozes[i2].nota[voz]) { // procura 2ª nota interrompe
       i2++; if (i2 >= vozes.length) { i2 = vozes.length-1; break; }; };
      var r = i2;
    while (vozes[i2].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };
    if (!vozes[r]) { return x; };
    vIN = Math.abs(vozes[p].nota[0] - vozes[p].nota[1]);
    vIT = Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]);
    if (!notaPrepara) { var notaPrepara = verificaConsonancia(vIN, vIT); };
    vIN = Math.abs(vozes[i].nota[0] - vozes[i].nota[1]);
    vIT = Math.abs(vozes[i].tonal[0] - vozes[i].tonal[1]);
    var notaInterrompe = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozes[i2].nota[0] - vozes[i2].nota[1]);
    vIT = Math.abs(vozes[i2].tonal[0] - vozes[i2].tonal[1]);
    var notaInterrompe2 = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozes[r].nota[0] - vozes[r].nota[1]);
    vIT = Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]);
    var notaResolve = verificaConsonancia(vIN, vIT);
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[i].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[i].nota[voz]);
    var intM4 = Math.abs(vozes[i2].nota[voz] - vozes[i].nota[voz]);
    var intM5 = Math.abs(vozes[r].nota[voz] - vozes[i2].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[i].posição[voz] - pos1;
    var dur3 = vozes[i2].posição[voz] - vozes[i].posição[voz];
    var dur4 = vozes[r].posição[voz] - vozes[i2].posição[voz];
    if (!vozes[r+1]) { var dur5 = dur1; } else { var dur5 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };

    if (mov1 == 0 && mov2 != 0 && intM < 3 &&
       (dur2 <= dur1*2 && dur2 <= dur5*2 && dur3 <= dur5 && dur4 <= dur5) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // desenho melódico, intervalos e consonâncias em t.f.
        && p < x && r > i2 && i2 > i && i > x && (notaAcento == "F" || ((notaAcento == "f" && notaAcentoR == "c") || (notaAcento == "mF" && notaAcentoR == "f"))) && // dissonância métrica forte
        mov3 != mov4 && mov3 != 0 && mov4 != 0 && intM2 < 8 && intM3 < 8 && intM4 < 3 && intM5 < 3 &&
        (!suspeLEx1a.checked || notaInterrompe != "D" || tipo == "ch") && suspeLEx1.checked && // resolução interrompida
        (!suspeLEx3.checked || notaResolve == "CI" || tipo == "ch") && // resolução somente em consonância perfeita
        (suspeLEx2.checked || mov2 == -1 || tipo == "ch")) { // permitir também resolução ascendente
  //console.log(p,x,i,i2,r);
          if (tipo == "td") { var nome = "- Tratamento de dissonância: suspensão RI 5 notas -"; avalia += 0.5; } else
          if (tipo == "ch") { var nome = "- Coerência Harmônica: suspensão RI 5 notas -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function cambiata(x, tipo) { //console.log(x,"=============== função cambiata =============");
   var diss1 = false, diss2 = false, diss3 = false;
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var np1 = x;
    while (vozes[x].nota[voz] == vozes[np1].nota[voz]) { // procura nota passagem 1
      np1++; if (np1 >= vozes.length) { np1 = vozes.length-1; break; }; };
     var np2 = np1;
    while (vozes[np1].nota[voz] == vozes[np2].nota[voz]) { // procura nota passagem 2
      np2++; if (np2 >= vozes.length) { np2 = vozes.length-1; break; }; };
     var np3 = np2;
    while (vozes[np2].nota[voz] == vozes[np3].nota[voz]) { // procura nota passagem 3
       np3++; if (np3 >= vozes.length) { np3 = vozes.length-1; break; }; };
     var r = np3;
    while (vozes[np3].nota[voz] == vozes[r].nota[voz]) { // procura nota resolução
      r++; if (r >= vozes.length-1) { r = vozes.length-1; break; }; };
    if (!vozes[r]) { return x; };
    var vIN = Math.abs(vozes[x].nota[0] - vozes[x].nota[1]);
    var vIT = Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]);
    var notaInicial = verificaConsonancia(vIN, vIT);
    vIN = Math.abs(vozes[r].nota[0] - vozes[r].nota[1]);
    vIT = Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]);
    var notaResolve = verificaConsonancia(vIN, vIT);
    var dCounter = 0; // contagem de dissonâncias
    if (verificaConsonancia(Math.abs(vozes[np1].nota[0] - vozes[np1].nota[1]),
                            Math.abs(vozes[np1].tonal[0] - vozes[np1].tonal[1])) == "D") { dCounter++; diss1 = true; };
    if (verificaConsonancia(Math.abs(vozes[np2].nota[0] - vozes[np2].nota[1]),
                            Math.abs(vozes[np2].tonal[0] - vozes[np2].tonal[1])) == "D") { dCounter++; diss2 = true; };
    if (verificaConsonancia(Math.abs(vozes[np3].nota[0] - vozes[np3].nota[1]),
                            Math.abs(vozes[np3].tonal[0] - vozes[np3].tonal[1])) == "D") { dCounter++; diss3 = true; };
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]); // posição métrica das notasIguais
    var notaAcento1 = verificaTempoForte(vozes[np1].tempo[voz],vozes[np1].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[np2].tempo[voz],vozes[np2].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[np3].tempo[voz],vozes[np3].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov0 = direção(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var mov1 = direção(vozes[np2].nota[voz] - vozes[np1].nota[voz]);
    var mov2 = direção(vozes[np3].nota[voz] - vozes[np2].nota[voz]);
    var mov3 = direção(vozes[r].nota[voz] - vozes[np3].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dirCF = direção(vozes[r].nota[vozCF] - vozes[x].nota[vozCF]);
    var intM0 = Math.abs(vozes[x].nota[voz] - vozes[np1].nota[voz]);
    var intM1 = Math.abs(vozes[np1].nota[voz] - vozes[np2].nota[voz]);
    var intM2 = Math.abs(vozes[np2].nota[voz] - vozes[np3].nota[voz]);
    var intM3 = Math.abs(vozes[np3].nota[voz] - vozes[r].nota[voz]);
    var intM4 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dur1 = vozes[np1].posição[voz] - vozes[x].posição[voz];
    var dur2 = vozes[np2].posição[voz] - vozes[np1].posição[voz];
    var dur3 = vozes[np3].posição[voz] - vozes[np2].posição[voz];
    var dur4 = vozes[r].posição[voz] - vozes[np3].posição[voz];
    if (!vozes[r+1]) { var dur5 = dur1; } else { var dur5 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//console.log(x,np1,np2,np3,r,", mov:", mov0, mov1, mov2, mov3, mov4, ", ints:", intM0, intM1, intM2, intM3, intM4,", acentos:", notaAcento, notaAcento1, notaAcento2, notaAcento3, notaAcentoR, ", cons:", notaInicial, diss1, diss2, diss3, notaResolve);
    if (mov0 == mov1 && mov1 != 0 && mov2 == mov1*-1 && mov3 == mov2 && // contorno melódico
        intM0 < 3 && (intM1 == 3 || intM1 == 4) && intM2 < 3 && intM3 < 3 && // intervalos melódicos
        ((notaAcento == "F" || (cambiLEx1MF.checked && notaAcento == "mF")) &&
         (notaAcentoR == "F" || (cambiLEx1MF.checked && notaAcentoR == "mF")) || !cambiLEx1.checked) && // posição métrica 1ª e última nota
        (((!diss1 || (notaAcento1 != "F" && (cambiLEx3MF.checked || notaAcento1 != "mF"))) &&
          (!diss2 || (notaAcento2 != "F" && (cambiLEx3MF.checked || notaAcento2 != "mF")) ) && // dissonancia em tempo fraco
          (!diss3 || (notaAcento3 != "F" && (cambiLEx3MF.checked || notaAcento3 != "mF")))) || !cambiLEx3.checked) &&
        (diss1 || !cambiLEx4.checked || tipo == "ch") && // 2ª nota deve ser dissonante
        ((vozes[np1].duração[voz] <= vozes[x].duração[voz] && vozes[np1].duração[voz] <= vozes[r].duração[voz]) || !cambiLEx5.checked) && // duração 2ª nota < 1ª e última
        (dirCF == mov4 || !cambiLEx2.checked) && // cambiata na mesma direção do CF
        dCounter < 3 && // quantidade de dissonâncias
        notaInicial != "D" && notaResolve != "D" && // consonâncias
        (dur2 <= dur1*2.1 && dur3 <= dur1*2.1 && dur4 <= dur1*2.1 && dur5 <= dur1*2.1) // proporção entre as durações de dissonâncias e consonâncias
      ) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: cambiata -"; avalia += 0.5; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: cambiata -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n"; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function bordadura(x, tipo) { //console.log(x,"=============== função bordadura =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x, r = x; // preparação, resolução
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                            Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
      if (notaPrepara != "D") { break; };
      var pos1 = vozes[p].posição[voz];
      p--; if (p < 0) { p++; break; }; };
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    if (!vozes[r]) { return x; };
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[r].posição[voz] - pos1;
    if (!vozes[r+1]) { var dur3 = dur1; } else { var dur3 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
    if (mov1 != 0 && mov1 == mov2*-1 && intM1 < 3 && intM2 < 3 &&
       (dur2 < dur1*2.1 && dur2 < dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch")
        && p < x && r > x && ((notaAcento != "F" && (bordaLExMF.checked || notaAcento != "mF")) || !bordaLEx.checked) &&
        ((mov1 > 0 && bordaduraLS.checked) || (mov1 < 0 && bordaduraLI.checked) || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Bordadura -"; avalia += 0.3; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Bordadura -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };

      } else if (voz == qtVozes) { return x; };
   };
}
function bordadura4(x, tipo) { //console.log(x,"=============== função bordadura4 =============");
   if (x == 0 || x+2 >= vozes.length) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, r = x+2; // preparação, resolução
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaBorda1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]),
                                         Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]));
    var notaBorda2 = verificaConsonancia(Math.abs(vozes[x+1].nota[0] - vozes[x+1].nota[1]),
                                         Math.abs(vozes[x+1].tonal[0] - vozes[x+1].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento0 = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[x+1].tempo[voz],vozes[x+1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[r].nota[voz] - vozes[x+1].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[x+1].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[x+1].nota[voz]);
    var dur1 = vozes[x].posição[voz] - vozes[p].posição[voz];
    var dur2 = vozes[x+1].posição[voz] - vozes[x].posição[voz];
    var dur3 = vozes[r].posição[voz] - vozes[x+1].posição[voz];
    if (!vozes[r+1]) { var dur4 = dur1; } else { var dur4 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//console.log(x,")", vozes[p].nota[voz], vozes[x].nota[voz], vozes[x+1].nota[voz],vozes[r].nota[voz], "|",
            // notaPrepara, notaBorda1, notaBorda2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2*-1 && mov3 == mov1 &&
        (dur2 < dur1*2.1 && dur2 < dur4*2.1 && dur3 < dur4*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && (intM2 == 3 || intM2 == 4) &&
        (notaBorda1 == "D" || notaBorda2 == "D" || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > x+1 &&
        //(((notaAcento0 != "F" || notaAcento0 != "mF") && (notaAcento3 != "F" || notaAcento3 != "mF")) || !bordaLEx2.checked || tipo == "ch") && // notas principais em tempo forte
        ((notaAcento1 != "F" && notaAcento2 != "F") || !bordaLEx1.checked || tipo == "ch")) { // em tempo fraco e meio forte
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Bordadura dupla -"; avalia += 0.5; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Bordadura dupla -"; };
        if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };

      } else if (voz == qtVozes) { return x; };
   };
}
function notaPassagem(x, tipo) { //console.log(x,"=============== função NP =============", tipo);
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x, r = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz] || // procura nota preparação
           verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                               Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1])) == "D")  {
      if (vozes[x].nota[voz] == vozes[p].nota[voz]) { var pos1 = vozes[p].posição[voz] };
      if (p <= 0) { break; }; p--;  }; // console.log("a:", p, vozes[p].nota[voz]);
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    if (!vozes[r]) { return x; };
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intMT1 = Math.abs(parseInt(verificaGrauMelodico(vozes[x].tonal[voz], x)) - parseInt(verificaGrauMelodico(vozes[p].tonal[voz], p)));
    var intMT2 = Math.abs(parseInt(verificaGrauMelodico(vozes[x].tonal[voz], x)) - parseInt(verificaGrauMelodico(vozes[r].tonal[voz], r)));
    if (intMT1 == 6) { intMT1 = 1; };
    if (intMT2 == 6) { intMT2 = 1; };
  // console.log(p, x, r, verificaGrauMelodico(vozes[x].tonal[voz], x), verificaGrauMelodico(vozes[r].tonal[voz], r), intMT1, intMT2);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[r].posição[voz] - pos1;
    if (!vozes[r+1]) { var dur3 = dur1; } else { var dur3 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
 //console.log(p,x,r,"NP:", notaPrepara, notaResolve, notaAcento, mov1, mov2, intM1, intM2, intMT1, intMT2, dur1, dur2, dur3, passaLExMF.checked);
    if (mov1 == mov2 && mov1 != 0 && ((intM1 < 4 && intMT1 == 1) || intM1 < 3) && ((intM2 < 4 && intMT2 == 1) || intM2 < 3) &&// contorno melódico e graus conjuntos
       (dur2 < dur1*2.1 && dur2 <= dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaPrepara != "D" || tipo == "ch") && (notaResolve != "D" || tipo == "ch") // prepara e resolve em consonâncias
        && p < x && r > x && ((notaAcento != "F" && (passaLExMF.checked || notaAcento != "mF")) || !passaLEx.checked || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Nota de passagem -";
                            if (terEsp || quiEsp || livreCP) { avalia += 0.2; } else { avalia += 0.3;}; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Nota de passagem -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function notaPassagem4(x, tipo) { //console.log(x,"=============== função NP4 =============");
   if (!passaLEx2.checked) { return x; };
   if (x == 0 || x+2 >= vozes.length) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x, np1 = x, r; // preparação, resolução
    while (vozes[x].nota[voz] == vozes[p].nota[voz] ||
           verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                               Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1])) == "D")  { // procura nota preparação
      if (vozes[x].nota[voz] == vozes[p].nota[voz]) { var pos1 = vozes[p].posição[voz] };
      if (p <= 0) { break; }; p--;  }; // console.log("a:", p, vozes[p].nota[voz]);
    while (vozes[x].nota[voz] == vozes[np1].nota[voz]) { // procura nota posterior
        np1++; if (np1 >= vozes.length-1) { break; }; }; if (!vozes[np1]) { return x; }; r = np1;
    while (vozes[np1].nota[voz] == vozes[r].nota[voz]) { // procura nota posterior
        r++; if (r >= vozes.length-1) { break; }; }; if (!vozes[r]) { return x; };
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaPassa1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]),
                                         Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]));
    var notaPassa2 = verificaConsonancia(Math.abs(vozes[np1].nota[0] - vozes[np1].nota[1]),
                                         Math.abs(vozes[np1].tonal[0] - vozes[np1].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento0 = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[np1].tempo[voz],vozes[np1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[r].nota[voz] - vozes[np1].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[r].nota[voz] - vozes[np1].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[np1].posição[voz] - pos1;
    var dur3 = vozes[r].posição[voz] - vozes[np1].posição[voz];
    if (!vozes[r+1]) { var dur4 = dur1; } else { var dur4 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//console.log(x,")", vozes[p].nota[voz], vozes[x].nota[voz], vozes[x+1].nota[voz],vozes[r].nota[voz], "|",
          //   notaPrepara, notaPassa1, notaPassa2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2 && mov3 == mov1 &&
        (dur2 <= dur1*2.1 && dur2 <= dur4*2.1 && dur3 <= dur4*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && intM2 < 3 &&
        ((notaPassa1 == "D" && notaPassa2 == "D") || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > np1 &&
        (((notaAcento1 != "F" && (passaLExMF.checked || notaAcento1 != "mF")) && (notaAcento2 != "F" && (passaLExMF.checked || notaAcento2 != "mF"))) || !passaLEx.checked || tipo == "ch")) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: NP grupo 2 -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: NP grupo 2 -"; };
        if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function notaPassagem5(x, tipo) { //console.log(x,"=============== função NP5 =============");
   if (!passaLEx2.checked) { return x; };
   if (x == 0 || x+3 >= vozes.length) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
     var p = x, np1 = x, np2, r; // preparação, resolução
     while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
       if (vozes[x].nota[voz] == vozes[p].nota[voz]) { var pos1 = vozes[p].posição[voz] };
       p--; if (p < 0) { break; }; };
       p++; if (p == x) { p--; }; // console.log("a:", p, vozes[p].nota[voz]);
     while (vozes[x].nota[voz] == vozes[np1].nota[voz]) { // procura nota posterior
         if (verificaConsonancia(Math.abs(vozes[np1].nota[0] - vozes[np1].nota[1]),
                                 Math.abs(vozes[np1].tonal[0] - vozes[np1].tonal[1])) != "D") { break; };
         np1++; if (np1 >= vozes.length-1) { break; }; }; if (!vozes[np1]) { return x; }; np2 = np1;
     while (vozes[np1].nota[voz] == vozes[np2].nota[voz]) { // procura nota posterior
         if (verificaConsonancia(Math.abs(vozes[np2].nota[0] - vozes[np2].nota[1]),
                                 Math.abs(vozes[np2].tonal[0] - vozes[np2].tonal[1])) != "D") { break; };
         np2++; if (np2 >= vozes.length-1) { break; }; }; if (!vozes[np2]) { return x; }; r = np2;
     while (vozes[np2].nota[voz] == vozes[r].nota[voz]) { // procura nota posterior
         if (verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                 Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1])) != "D") { break; };
         r++; if (r >= vozes.length-1) { break; }; }; if (!vozes[r]) { return x; };
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaPassa1 = verificaConsonancia(Math.abs(vozes[x].nota[0] - vozes[x].nota[1]),
                                         Math.abs(vozes[x].tonal[0] - vozes[x].tonal[1]));
    var notaPassa2 = verificaConsonancia(Math.abs(vozes[np1].nota[0] - vozes[np1].nota[1]),
                                         Math.abs(vozes[np1].tonal[0] - vozes[np1].tonal[1]));
    var notaPassa3 = verificaConsonancia(Math.abs(vozes[np2].nota[0] - vozes[np2].nota[1]),
                                         Math.abs(vozes[np2].tonal[0] - vozes[np2].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento0 = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
    var notaAcento1 = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcento2 = verificaTempoForte(vozes[np1].tempo[voz],vozes[np1].formula[0]);
    var notaAcento3 = verificaTempoForte(vozes[np2].tempo[voz],vozes[np2].formula[0]);
    var notaAcento4 = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var mov3 = direção(vozes[np2].nota[voz] - vozes[np1].nota[voz]);
    var mov4 = direção(vozes[r].nota[voz] - vozes[np2].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[np1].nota[voz] - vozes[x].nota[voz]);
    var intM3 = Math.abs(vozes[np2].nota[voz] - vozes[np1].nota[voz]);
    var intM4 = Math.abs(vozes[r].nota[voz] - vozes[np2].nota[voz]);
    var dur1 = pos1 - vozes[p].posição[voz];
    var dur2 = vozes[np1].posição[voz] - pos1;
    var dur3 = vozes[np2].posição[voz] - vozes[np1].posição[voz];
    var dur4 = vozes[r].posição[voz] - vozes[np2].posição[voz];
    if (!vozes[r+1]) { var dur5 = dur1; } else { var dur5 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
//console.log(x,")", vozes[p].nota[voz], vozes[x].nota[voz], vozes[np1].nota[voz],vozes[r].nota[voz], "|",
             //notaPrepara, notaPassa1, notaPassa2, notaResolve, "|", notaAcento1, notaAcento2, "|", mov1, mov2, mov3, "|", intM1, intM2, intM3);
    if (mov1 != 0 && mov1 == mov2 && mov3 == mov1 && mov4 == mov1 &&
        (dur2 <= dur1*2.1 && dur2 <= dur5*2.1 && dur3 <= dur1*2.1 && dur3 <= dur5*2.1
         && dur4 <= dur1*2.1 && dur4 <= dur5*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        intM1 < 3 && intM3 < 3 && intM2 < 3 && intM3 < 3 &&
        ((notaPassa1 == "D" && notaPassa2 == "D" && notaPassa3 == "D") || tipo == "ch") &&
        notaPrepara != "D" && notaResolve != "D" && p < x && r > np1 &&
        (((notaAcento1 != "F" && (passaLExMF.checked || notaAcento1 != "mF")) &&
          (notaAcento2 != "F" && (passaLExMF.checked || notaAcento2 != "mF")) &&
          (notaAcento3 != "F" && (passaLExMF.checked || notaAcento3 != "mF"))) || !passaLEx.checked || tipo == "ch")) {
      // var testaVozMove = true;
      // if (testaVozMove) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: NP grupo 3 -"; avalia += 0.4; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: NP grupo 3 -"; };
        if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";; };
          if (r-1 == x) { return r; } else { return r-1; };
        //} else { return x-1; };
      } else if (voz == qtVozes) { return x; };
   };
}
function apojatura(x, tipo) { //console.log(x,"=============== função apojatura =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x-1, r = x+1;
    if (!vozes[r]) { return x; };
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
    var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var dur1 = vozes[x].posição[voz] - vozes[p].posição[voz];
    var dur2 = vozes[r].posição[voz] - vozes[x].posição[voz];
    if (!vozes[r+1]) { var dur3 = dur1; } else { var dur3 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
    if ((notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch") &&
        p < x && r > x && intM1 > 2 && intM2 < 3 &&
        (dur2 <= dur1*2.1 && dur2 <= dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (mov1 != 0 && (!apojaEx2.checked || mov1 == 1 || tipo == "ch")) &&  // introduzida por movimento ascendente
        (mov2 != 0 && (!apojaEx3.checked || mov2 == -1 || tipo == "ch")) && // resolução descendente
        (!apojaEx1.checked || (notaAcento == "F" || (apojaEx1MF.checked && notaAcento == "mF") || (notaAcento == "f" && notaAcentoR == "c")) || tipo == "ch")) {
      // var testaVozMove = true;
      // for (var d = x+1; d < r; d++) {
      //   var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]),
      //                                      Math.abs(vozes[d].tonal[0] - vozes[d].tonal[1]));
      //   if (vozmove1 == "D") {
      //     var voz2 = 1 - voz;
      //     var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]),
      //                                        Math.abs(vozes[d].tonal[voz2] - vozes[r].tonal[voz]));
      //     if (vozmove2 == "D") { testaVozMove = false; };
      //   };
      // };
      //if (testaVozMove) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Apojatura -"; avalia += 0.3; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Apojatura -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      //  } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
}
function antecipação(x, tipo) { //console.log(x,"=============== função antecipação =============");
   if (x == 0) { return x; };
   var qtVozes, vozIni;
   if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
            else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
   for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes

    var r = x+1;
    if (!vozes[r]) { return x; };
    // while (vozes[x].nota[voz] == vozes[r].nota[voz] && vozes[r].ligadura[voz]) {
    //   r++; if (r >= vozes.length-1) { break; }; }; // procura nota posterior
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
    var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
    var int1 = vozes[x].nota[voz] - vozes[x-1].nota[voz];
    var dur1 = vozes[r].posição[voz] - vozes[x].posição[voz];
    if (!vozes[r+1]) { var dur2 = dur1; } else { var dur2 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
    if (mov1 == 0 && (notaResolve != "D" || tipo == "ch") && r > x &&
        (dur1 <= dur2*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaAcentoR == "F" || ((notaAcentoR == "f" || notaAcentoR == "mF") && notaAcento == "c") || tipo == "ch") &&
        ((antecipaEx2.checked && antecipaEx3.checked && ((int1 > -3 && int1 < 0) || (int1 < 3 && int1 > 0))) ||
            (antecipaEx2.checked && !antecipaEx3.checked && (int1 > -3 && int1 < 0)) ||
            (!antecipaEx2.checked && antecipaEx3.checked && (int1 < 3 && int1 > 0)) ||
            (!antecipaEx2.checked && !antecipaEx3.checked)) &&
        (!antecipaEx4.checked || r == vozes.length-1 || tipo == "ch")) {
      // var testaVozMove = true;
      // for (var d = x+1; d < r; d++) {
      //   var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]),
      //                                      Math.abs(vozes[d].tonal[0] - vozes[d].tonal[1]));
      //   if (vozmove1 == "D") {
      //     var voz2 = 1 - voz;
      //     var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]),
      //                                        Math.abs(vozes[d].tonal[voz2] - vozes[r].tonal[voz]));
      //     if (vozmove2 == "D") { testaVozMove = false; };
      //   };
      // };
      // if (testaVozMove) {
        if (tipo == "td") { var nome = "- Tratamento de dissonância: Antecipação -"; avalia += 0.2; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: Antecipação -"; };
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r-1; };
      //  } else { return x; };
      } else if (voz == qtVozes) { return x; };
   };
}
function escapada(x, tipo){ //console.log(x,"=============== função escapada =============");
    if (x == 0) { return x; };
    var qtVozes, vozIni;
    if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
             else { vozIni = 0; qtVozes = vozes[x].nota.length-1; };
    for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
     var p = x-1, r = x+1;
     if (!vozes[r]) { return x; };
     var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                           Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
     var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                           Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
     var notaAcentoP = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
     var notaAcento = verificaTempoForte(vozes[x].tempo[voz],vozes[x].formula[0]);
     var notaAcentoR = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
     var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
     var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
     var intM1 = Math.abs(vozes[p].nota[voz] - vozes[x].nota[voz]);
     var intM2 = Math.abs(vozes[r].nota[voz] - vozes[x].nota[voz]);
     var dur1 = vozes[x].posição[voz] - vozes[p].posição[voz];
     var dur2 = vozes[r].posição[voz] - vozes[x].posição[voz];
     if (!vozes[r+1]) { var dur3 = dur1; } else { var dur3 = vozes[r+1].posição[voz] - vozes[r].posição[voz]; };
 //console.log(x,")");
     if (p < x && r > x && intM1 < 3 && intM2 > 2 &&
        (dur2 < dur1*2.1 && dur2 < dur3*2.1) && // proporção entre as durações de dissonâncias e consonâncias
        (notaResolve != "D" || tipo == "ch") &&  (notaPrepara != "D" || tipo == "ch") &&
         mov1 != 0 &&  (mov2 != 0 && mov2 != mov1) && notaAcentoR != "c" && notaAcentoP != "c" &&
         (!escapaEx1.checked || (escapaEx1MF.checked && notaAcento == "mF") || (notaAcento == "f" || notaAcento == "c"))) {
       // var testaVozMove = true;
       // for (var d = x+1; d < r; d++) {
       //   var vozmove1 = verificaConsonancia(Math.abs(vozes[d].nota[0] - vozes[d].nota[1]),
       //                                      Math.abs(vozes[d].tonal[0] - vozes[d].tonal[1]));
       //   if (vozmove1 == "D") {
       //     var voz2 = 1 - voz;
       //     var vozmove2 = verificaConsonancia(Math.abs(vozes[d].nota[voz2] - vozes[r].nota[voz]),
       //                                        Math.abs(vozes[d].tonal[voz2] - vozes[r].tonal[voz]));
       //     if (vozmove2 == "D") { testaVozMove = false; };
       //   };
       // };
       // if (testaVozMove) {
         if (tipo == "td") { var nome = "- Tratamento de dissonância: Escapada -"; avalia += 0.2; } else
         if (tipo == "ch") { var nome = "- Coerência Harmônica: Escapada -"; };
           if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
           if (r-1 == x) { return r; } else { return r-1; };
         //} else { return x; };
       } else if (voz == qtVozes) { return x; };
    };
}
function notaPedal(x, tipo) { //console.log(x,"=============== função nota pedal =============");
  if (x == 0) { return x; };
  var qtVozes, vozIni;
  //if (!livreCP) { vozIni = 1-vozCF; qtVozes = 1-vozCF; }
           //else {
             vozIni = 0; qtVozes = vozes[x].nota.length-1; //};
  for (var voz = vozIni; voz <= qtVozes; voz++) { // percorre vozes
    var p = x, r = x;
    while (vozes[x].nota[voz] == vozes[p].nota[voz]) { // procura nota preparação
      p--; if (p < 0) { break; }; };
      p++; if (p == x) { p--; }; // console.log("a:", p, vozes[p].nota[voz]);
    while (vozes[p].nota[voz] == vozes[x].nota[voz] && p < x ) {
      if (verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                              Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1])) == "D") { p++; } else { break; };
    }; //console.log("b:", p, vozes[p].nota[voz]);
    while (vozes[x].nota[voz] == vozes[r].nota[voz]) { // procura nota posterior
      if (verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                              Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1])) != "D") { break; };
      r++; if (r >= vozes.length-1) { break; }; };
    if (!vozes[r]) { return x; };
  //console.log("intervalos em p e r:", Math.abs(vozes[p].nota[0] - vozes[p].nota[1]), Math.abs(vozes[r].nota[0] - vozes[r].nota[1]));
    var notaPrepara = verificaConsonancia(Math.abs(vozes[p].nota[0] - vozes[p].nota[1]),
                                          Math.abs(vozes[p].tonal[0] - vozes[p].tonal[1]));
    var notaResolve = verificaConsonancia(Math.abs(vozes[r].nota[0] - vozes[r].nota[1]),
                                          Math.abs(vozes[r].tonal[0] - vozes[r].tonal[1]));
    var metrPrepara = verificaTempoForte(vozes[p].tempo[voz],vozes[p].formula[0]);
    var metrResolve = verificaTempoForte(vozes[r].tempo[voz],vozes[r].formula[0]);
    var mov1 = direção(vozes[x].nota[voz] - vozes[p].nota[voz]);
    var mov2 = direção(vozes[r].nota[voz] - vozes[x].nota[voz]);
//  console.log("voz",voz, "|", p, x, r,") notas:", vozes[p].nota[voz], vozes[x].nota[voz], vozes[r].nota[voz],
      //        "| mov:", mov1, mov2, "| metro:", metrPrepara, metrResolve, pedalEx1MF.checked,
      //        "| cons:", notaPrepara, notaResolve);
    if (mov1 == 0 && mov2 == 0 &&  // desenho melódico
        (notaResolve != "D" || tipo == "ch") && (notaPrepara != "D" || tipo == "ch") // consonâncias
        && p < x && r > x &&
        (((metrPrepara == "F" || (pedalEx1MF.checked && metrPrepara == "mF")) &&
          (metrResolve == "F" || (pedalEx1MF.checked && metrResolve == "mF"))) || !pedalEx1.checked)) { // dissonância métrica forte
        if (tipo == "td") { var nome = "- Tratamento de dissonância: nota pedal -"; avalia += 0.2; } else
        if (tipo == "ch") { var nome = "- Coerência Harmônica: nota pedal -"; }
          if (tipo) { relator += nome + " Comp. " + vozes[x].compasso + " , voz " + (voz+1) + "\n";};
          if (r-1 == x) { return r; } else { return r; };
    } else if (voz == qtVozes) { return x; };
  };
}

//------------------------------------------------------------------------------
function criaResultado(verificados, x, voz, i, tipo, numAcordes, numVozes) {
//console.log(x, voz, i, tipo, numAcordes, numVozes);
 	var primAcorde = x - (numAcordes-1);
 	var compAnt = Math.floor(vozes[primAcorde].compasso);
 	var compAtual = Math.floor(vozes[x].compasso);
 	var qtdVozes = vozes[x].nota.length;
 	if (compAnt != compAtual && numAcordes > 1) { var compasso = compAnt+" ao "+compAtual;}
 														  else { var compasso = compAtual; };
 	switch (numVozes) {   // cria mensagem de texto
     case "ne":
 	   case 1: var qualVoz = ", na voz "+ (voz+1); break;
 	   case "fr": //falsa relação
     case "in": //intermitente
 	   case 2: var qualVoz = ", vozes "+(voz+1)+" e "+(i+1); break;
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
      case "ne":
        if (y == primAcorde || y == x) { resultado[verificados].push(vozes[y].objeto[voz]); }; break;
      case "in":
        if (y == primAcorde || y == x) { resultado[verificados].push(vozes[y].objeto[voz], vozes[y].objeto[i]); }; break;
    };
   };

if (tipo == "não conduz para finalis por grau conj." || // melodia
    tipo == "penúltima nota não pertence ao V ou viiº" ||
    tipo == "Âmbito melódico" ||
    tipo.substring(0, 14) == "Não privilegia" ||
    tipo == "intervalo melódico de 7ª" ||
    tipo == "intervalo melódico de 6ª" ||
    tipo == "intervalo melódico aumentado" ||
    tipo == "intervalo melódico > 8ª" ||
    tipo == "trítono nas 2 extremidades" ||
    tipo == "trítono em 1 extremidade" ||
    tipo == "dissonância composta" ||
    tipo == "intervalo melódico > 5ªJ" ||
    tipo == "movimentos na mesma direção" ||
    tipo == "repetição de notas" ||
    tipo == "repetição de padrão mel." ||
    tipo == "arpejo de acorde" ||
    tipo == "repete ponto focal superior" ||
  //  tipo == "repete ponto focal inferior" ||
    tipo == "alteração 6º e/ou 7º" ||
    tipo == "neutralização 6º e/ou 7º" ||
    tipo.substring(0, 12) == "Nota inicial" ||
    tipo.substring(0, 10) == "Nota final" ||
    tipo == "2 saltos na mesma direção" ||
    tipo == "2 saltos em mov. contrário" ||
    tipo.slice(0, 14) == "salto de tempo" ||
    tipo == "intervalo inicial" || // Gerais ----------
    tipo == "intervalo final" ||
    tipo == "alcança intervalo final" ||
    tipo.slice(0, 8) == "cadência" ||
    tipo.substring(0, 12) == "cons. imperf" ||
    tipo.slice(0, 9) == "distância" ||
    tipo == "5ª ou 8ª consecutivas" ||
    tipo == "uníssono" ||
  //  tipo == "cruzamento" ||
    tipo == "falsa relação") { avalia -= 1; } else
if (tipo.slice(-6) == "oculta" ||
    tipo.slice(-12) == "intermitente") { avalia -= 2; } else
if (tipo.slice(-8) == "paralela" ||
    tipo == "nota não pertence ao acorde" ||
    tipo.slice(-11) == "fundamental") { avalia -= 3; } else
if (tipo == "dissonância não tratada") { avalia -= 5; };
//console.log(x,"avalia = ", avalia);
 }
//---------------------------------------------------------

  onRun: {

  //openFile('config.cfA');

  inicializaVariáveis();
  carregarCfg();
  function inicializaVariáveis() {
   var preSet = "false-false-false-false-false-false-false-false-false-false-1-false-1-false-1-false-4-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-0-false-false-false-0-false-false-false-false-false-false-false-false-false-1-10-false-true-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-12-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-4-true-0-false-true-0-true-1-true-true-false-false-false-false-2-true-false-false-true-false-false-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-0-false-false-true-true-false-true-true-true-true-0-15-true-true-true-true-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-24-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-4-true-1-false-true-1-true-3-true-true-false-false-false-false-2-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-1-false-false-true-true-false-true-true-true-true-0-15-true-true-true-true-true-true-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-24-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-5-true-1-true-true-2-true-4-true-true-false-false-false-false-4-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-2-false-false-true-true-false-true-true-true-true-3-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-true-true-true-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-24-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-7-true-1-true-true-2-true-5-true-true-false-false-false-false-8-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-2-false-false-true-true-false-true-true-true-true-0-15-true-true-true-true-true-true-true-true-false-false-true-true-false-true-false-false-false-false-false-false-false-false-false-false-true-false-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-24-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-4-true-1-true-true-2-true-3-true-true-false-false-false-false-4-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-2-false-false-true-true-false-true-true-true-true-3-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-false-true-true-true-false-true-false-false-false-true-true-true-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-24-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-7-true-1-true-true-2-true-4-true-true-false-false-false-false-8-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-true-true-true-true-true-true-false-false-false-true-1-true-1-false-1-true-4-true-true-true-true-true-true-true-true-true-false-false-false-true-true-true-true-4-false-false-false-0-false-false-true-true-false-true-true-true-true-5-15-true-true-true-true-true-true-true-false-true-false-true-true-true-false-false-false-true-true-true-false-true-false-false-false-true-true-true-true-false-true-true-true-false-true-true-true-true-true-false-false-false-false-false-false-false-false-21-true-true-true-false-false-true-true-false-false-false-false-true-true-true-false-false-true-true-true-true-10-true-2-true-true-3-true-5-true-true-false-false-false-false-8-true-true-true-true-true-true-false-false-true-false-false-false-true-true-false-false-false-false-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-true-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false-false"

   preSet = preSet.split("-");
   for (var i=0;i<preSet.length;i++) {
    if (preSet[i] == "true") { preSet[i] = true; } else
    if (preSet[i] == "false") { preSet[i] = false; };
    config[i] = preSet[i];
   };

   console.log(config.length, config[config.length-1]);

  }
  window.visible = true;
  window.raise();
  window.raise();
  window.raise();
  window.raise();
 } // fecha onRun

} // fecha função Musescore
