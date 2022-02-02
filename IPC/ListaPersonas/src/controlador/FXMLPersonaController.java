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
import javafx.scene.control.Button;
import javafx.scene.control.TextField;
import javafx.stage.Stage;
import modelo.Persona;

/**
 * FXML Controller class
 *
 * @author carolinaalbamaruganrubio
 */
public class FXMLPersonaController implements Initializable {

    @FXML
    private TextField nombreTF;
    @FXML
    private TextField apellidoTF;
    @FXML
    private Button okButton;
    private boolean pulsadoAceptar = false;
    private Persona personaSecundario;
     private boolean pulsadorOK = false;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        okButton.disableProperty().bind(Bindings.or(nombreTF.textProperty().isEmpty(), apellidoTF.textProperty().isEmpty()));
    }    

    @FXML
    private void cancel(ActionEvent event) {
        ((Stage)nombreTF.getScene().getWindow()).close();
    }

    @FXML
    private void aceptarManejador(ActionEvent event) {
        pulsadoAceptar = true;
        
        if(personaSecundario == null){
            personaSecundario = new Persona();
        }
        personaSecundario.setNombre(nombreTF.getText());
        personaSecundario.setApellidos(apellidoTF.getText());
        //Node minodo = (Node) event.getSource();
        //((Stage)minodo.getScene().getWindow()).close();
        ((Stage)nombreTF.getScene().getWindow()).close();
    }
    boolean isOK() {
       // return pulsadorOK;
        return pulsadoAceptar;
    }
    
    public Persona getpersona(){
        return new Persona(nombreTF.getText(), apellidoTF.getText());
        //nombreTF.getScene().getWindow();
    }
    public void setPersona(Persona selectedItem){
        personaSecundario = selectedItem;
        nombreTF.setText(personaSecundario.getNombre());
        apellidoTF.setText(personaSecundario.getApellidos());
    }
    private void ok(ActionEvent event){
        pulsadorOK = true;
    }
    public Persona getPersona(){
        return personaSecundario;
    }
    
}
