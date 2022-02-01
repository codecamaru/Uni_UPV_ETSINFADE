/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package barraMenus;

import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.ResourceBundle;
import javafx.application.Platform;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Alert;
import javafx.scene.control.Alert.AlertType;
import javafx.scene.control.ButtonType;
import javafx.scene.control.ChoiceDialog;
import javafx.scene.control.Label;
import javafx.scene.control.RadioMenuItem;
import javafx.scene.control.TextInputDialog;
import javafx.scene.control.ToggleGroup;
import javafx.scene.image.ImageView;

/**
 *
 * @author jsole
 */
public class FXMLDocumentController implements Initializable {
    
    private Label label;
    @FXML
    private ToggleGroup compras;
    @FXML
    private ImageView amazon;
    @FXML
    private Label barraEstado;
    @FXML
    private RadioMenuItem amazonb;
    @FXML
    private RadioMenuItem ebayb;
    
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    @FXML
    private void salir(ActionEvent event) {
        Alert alert = new Alert(Alert.AlertType.CONFIRMATION);
        alert.setHeaderText("Quieres cerrar la aplicación?");
        Optional<ButtonType> cerrar = alert.showAndWait(); 
        if(cerrar.isPresent()){
            if(cerrar.get()== ButtonType.OK){
                Platform.exit();
            }
        }
    }

    @FXML
    private void amazon(ActionEvent event) {
        if(amazonb.isSelected()){
            	Alert alert	=	new	Alert(AlertType.INFORMATION);	
//	ó	AlertType.WARNING	ó	AlertType.ERROR	ó	AlertType.CONFIRMATION
		alert.setTitle("Confirmación");	
		alert.setHeaderText("Compra realizada correctamente");	
//	ó	null	si	no	queremos	cabecera	
		alert.setContentText("Has comprado en Amazon");	
		Optional<ButtonType>	result	=	alert.showAndWait();	
                if(result.isPresent()	&&	result.get()	==	ButtonType.OK){		
                }	
        }
        else{
                Alert alert	=	new	Alert(AlertType.INFORMATION);	
//	ó	AlertType.WARNING	ó	AlertType.ERROR	ó	AlertType.CONFIRMATION
		alert.setTitle("Error en la selección");	
		alert.setHeaderText("No puede comprar en Amazon");	
//	ó	null	si	no	queremos	cabecera	
		alert.setContentText("Por favor, cambie la selección actual en el menú Opciones");	
		Optional<ButtonType>	result	=	alert.showAndWait();	
                if(result.isPresent()	&&	result.get()	==	ButtonType.OK){		
                }
        }
    }

    @FXML
    private void ebay(ActionEvent event) {
        if(ebayb.isSelected()){
            	Alert alert	=	new	Alert(AlertType.INFORMATION);	
//	ó	AlertType.WARNING	ó	AlertType.ERROR	ó	AlertType.CONFIRMATION
		alert.setTitle("Confirmación");	
		alert.setHeaderText("Compra realizada correctamente");	
//	ó	null	si	no	queremos	cabecera	
		alert.setContentText("Has comprado en Ebay");	
		Optional<ButtonType>	result	=	alert.showAndWait();	
                if(result.isPresent()	&&	result.get()	==	ButtonType.OK){		
                }	
        }
        else{
                Alert alert	=	new	Alert(AlertType.INFORMATION);	
//	ó	AlertType.WARNING	ó	AlertType.ERROR	ó	AlertType.CONFIRMATION
		alert.setTitle("Error en la selección");	
		alert.setHeaderText("No puede comprar en Ebay");	
//	ó	null	si	no	queremos	cabecera	
		alert.setContentText("Por favor, cambie la selección actual en el menú Opciones");	
		Optional<ButtonType>	result	=	alert.showAndWait();	
                if(result.isPresent()	&&	result.get()	==	ButtonType.OK){		
                }
        }
    }

    @FXML
    private void blogger(ActionEvent event) {
        List<String>	choices	=	new	ArrayList<>();	
        choices.add("El blog de Athos");	
        choices.add("El blog de Portos");	
        choices.add("El blog de Aramis");	
        ChoiceDialog<String>	dialog	=	new	ChoiceDialog<>("Blog de Athos",	choices);	
        dialog.setTitle("Selecciona un blog");	
        dialog.setHeaderText("¿Qué blog quieres visitar?");	
        dialog.setContentText("Elige:");	
        Optional<String>	result	=	dialog.showAndWait();	
        //	Pre	Java	8	
        if	(result.isPresent())	{	
                barraEstado.setText("Visitando " + result.get());
        }	
    }

    @FXML
    private void facebook(ActionEvent event) {
        TextInputDialog dialog	=	new	TextInputDialog("Pepe");	//	Por	defecto	
        dialog.setTitle("Introduce tu nombre");	
        dialog.setHeaderText("¿Con qué usuario quieres escribir en Facebook?");	
        dialog.setContentText("Introduce tu nombre:");	
        Optional<String>	result	=	dialog.showAndWait();	
        //	Obteniendo	el	resultado	(pre	Java	8)	
        if	(result.isPresent()){	
            barraEstado.setText("Mensaje enviado como "	+ result.get());	
        }	
    }

    @FXML
    private void borrar(ActionEvent event) {
        if(amazonb.isSelected()){ amazonb.setSelected(false); }
        if(ebayb.isSelected()){ ebayb.setSelected(false); }
    }
    
}
