/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.beans.binding.Bindings;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.Node;
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import modelo.Persona;

/**
 * FXML Controller class
 *
 * @author jsoler
 */
public class FXMLPersonaController implements Initializable {
    
    @FXML
    private TextField nombreText;
    @FXML
    private TextField apellidosText;
    @FXML
    private Button okButton;
    private boolean pulsadoAceptar = false;
    private Persona personaSecundario;
 

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        okButton.disableProperty().bind(Bindings.or(nombreText.textProperty().isEmpty(), apellidosText.textProperty().isEmpty()));
        
    }

    @FXML
    private void cancel(ActionEvent event) {
      ((Stage)nombreText.getScene().getWindow()).close();
    }

    boolean isAceptar() {
        return pulsadoAceptar;
    }

    @FXML
    private void aceptarManejador(ActionEvent event) {
        pulsadoAceptar = true;
        if(personaSecundario == null){
            personaSecundario = new Persona();
        }
        personaSecundario.setNombre(nombreText.getText());
        personaSecundario.setApellidos(apellidosText.getText());
        //Node minodo = (Node) event.getSource();
        //((Stage)minodo.getScene().getWindow()).close();
        ((Stage)nombreText.getScene().getWindow()).close();
    }
    
    public Persona getPersona(){
        return personaSecundario;
    }
    
    public void setPersona(Persona selectedItem){
        personaSecundario = selectedItem;
        nombreText.setText(personaSecundario.getNombre());
        apellidosText.setText(personaSecundario.getApellidos());
    }

}
