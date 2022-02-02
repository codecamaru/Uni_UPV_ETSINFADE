/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

/**
 * FXML Controller class
 *
 * @author carolinaalbamaruganrubio
 */


import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.beans.binding.Bindings;

import modelo.Persona;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.ListView;
import javafx.scene.control.TextField;
import javafx.scene.control.ListCell;
import javafx.stage.Modality;
import javafx.stage.Stage;

public class FXMLPersonasTableController implements Initializable {

    
    private ListView<Persona> listaLV;
    @FXML
    private Button addButton;
    @FXML
    private Button modButton;
    @FXML
    private Button delButton;
    
    ObservableList<Persona> listaObservable;
    @FXML
    private ListView<Persona> personasList;



    @Override
    public void initialize(URL arg0, ResourceBundle arg1) {
        // TODO Auto-generated method stub
        ArrayList<Persona> misdatos = new ArrayList<Persona>();
        misdatos.add(new Persona("Pepe", "García"));
        misdatos.add(new Persona("María", "Pérez"));
        /*----------------------------------------------------------------*/
        /*  crear la listaobservable datos a partir del arraylist misdatos*/
        listaObservable = FXCollections.observableArrayList(misdatos);
        
        /*----------------------------------------------------------------*/
        /*  asociar la listaobservable de personas al listview listaLV           */   

        personasList.setItems(listaObservable);
        /*-------------------------------------------------------*/
        /* asignar aqui el nuevo estilo de la celda*/
 
        personasList.setCellFactory(c-> new MiCelda());
        
        /*-------------------------------------------------------*/
        // inhabilitar botones al arrancar.
        modButton.setDisable(true);
        delButton.setDisable(true);
        /*-------------------------------------------------------*/
        //binding para habilitar el boton Añadir
//***** // hay que intentar que solo se pueda pulsar el botón añadir
        //cuando haya texto en nombre y apellidos 
        // y hay que copiar en el nuevo scenebuilder lo del anterior segun foto 
        // (y más cosas pero no lo he pillado)
         
        
        // binding para el boton borrar
        delButton.disableProperty().bind(Bindings.equal(
                personasList.getSelectionModel().selectedIndexProperty(), -1));
        //----------------------------------------------
        // gestiona el disable del boton modificar
        modButton.disableProperty().bind(Bindings.isNull(personasList.getSelectionModel().selectedItemProperty()));
     
        
        /*-------------------------------------------------------*/
    }

    @FXML
    private void addPersona(ActionEvent event) throws IOException {
        //Persona p = new Persona(nombreTF.getText(), apellidoTF.getText());
        //listaObservable.add(p);
        //nombreTF.setText("");
        //apellidoTF.setText("");
        FXMLLoader loader= new  FXMLLoader(getClass().getResource("/vista/VistaPersona.fxml"));
        Parent root = loader.load();
        FXMLPersonaController controllerPersona = loader.getController();

        Scene scene = new Scene(root);
        Stage ventana2 = new Stage();
        ventana2.setScene(scene);
        ventana2.setTitle("Vista Personas");
        ventana2.initModality(Modality.APPLICATION_MODAL);
      //  ventana2.show();
        ventana2.showAndWait();
        if(controllerPersona.isOK()){
            // recuperar persona y guardar en datos
            listaObservable.add(controllerPersona.getPersona());
        }
    }

    private void delPersona(ActionEvent event) {
        listaObservable.remove(personasList.getSelectionModel().getSelectedItem());
    }

    private void addManejador(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/vista/VistaPersona.fxml"));//aqui se encuentra la referencia a Añadir Persona
        Parent root = loader.load();
        FXMLPersonaController controladorSecund = loader.getController(); //nos devuelve la nueva ventana
            // a partir de aqui puedo invocar metodos publicos 
        
        Scene scene = new Scene(root);
        Stage ventanaSecundaria = new Stage();
        ventanaSecundaria.setScene(scene);
        ventanaSecundaria.initModality(Modality.APPLICATION_MODAL);
        ventanaSecundaria.setTitle("Añadir Persona");
        //ventanaSecundaria.show();
        ventanaSecundaria.showAndWait();
        // creamos ventana secundaria como FXMLPersona 
        if(controladorSecund.isOK()){
            //pedir nueva persona y añadir lista datos
            listaObservable.add(controladorSecund.getPersona());
        }
    }

    @FXML
    private void updateManejador(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/vista/VistaPersona.fxml"));//aqui se encuentra la referencia a Añadir Persona
        Parent root = loader.load();
        FXMLPersonaController controladorSecund = loader.getController(); //nos devuelve la nueva ventana
            // a partir de aqui puedo invocar metodos publicos 
        
        Scene scene = new Scene(root);
        Stage ventanaSecundaria = new Stage();
        ventanaSecundaria.setScene(scene);
        ventanaSecundaria.initModality(Modality.APPLICATION_MODAL);
        ventanaSecundaria.setTitle("Modificar Persona");
        //ventanaSecundaria.show();
        controladorSecund.setPersona(personasList.getSelectionModel().getSelectedItem());
        ventanaSecundaria.showAndWait();
        // creamos ventana secundaria como FXMLPersona 
        personasList.refresh();
    }

    @FXML
    private void delManejador(ActionEvent event) {
        listaObservable.remove(personasList.getSelectionModel().getSelectedItem());
    }

}
/*-------------------------------------------------------*/
/* crear aqui la nueva clase que extiende a ListCell     */
class MiCelda extends ListCell<Persona>{

    @Override
    protected void updateItem(Persona t, boolean bln) {
        super.updateItem(t, bln); //To change body of generated methods, choose Tools | Templates.
        if(t == null || bln){
            setText("");
        }
        else{
            setText(t.getApellidos() + ", "+ t.getNombre());
        }
    }

}




/*-------------------------------------------------------*/
