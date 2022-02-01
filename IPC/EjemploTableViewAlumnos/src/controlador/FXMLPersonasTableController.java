/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controlador;

import ejemplotableview.EjemploTableView;
import java.io.IOException;
import java.net.URL;
import java.util.ArrayList;
import java.util.ResourceBundle;
import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.FXMLLoader;
import javafx.fxml.Initializable;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TableCell;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.image.ImageView;
import javafx.scene.image.Image ;
import javafx.stage.Modality;
import javafx.stage.Stage;
import modelo.Persona;

/**
 * FXML Controller class
 *
 * @author jsoler
 */
public class FXMLPersonasTableController implements Initializable {
    
    @FXML
    private Button addButton;
    @FXML
    private Button modButton;
    @FXML
    private Button delButton;
    @FXML
    private TableView<Persona> personasTable;
    @FXML
    private TableColumn<Persona, String> nombrecolumna;
    @FXML
    private TableColumn<Persona, String> apellidocolumna;
    
    private ObservableList<Persona> datos;
    @FXML
    private TableColumn<Persona, String> imagencolumna; 
    
    private void inicializaModelo() {
        ArrayList<Persona> misdatos = new ArrayList<Persona>();
        misdatos.add(new Persona("Pepe", "García","/resources/Sonriente.png"));
        misdatos.add(new Persona("María", "Pérez","/resources/Sonriente.png"));
        datos=FXCollections.observableList(misdatos);
    }
    // qué diferencia había entre pref y computed size ???
    /**
     * Initializes the controller class.
     */
    @Override //controlador
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        inicializaModelo();
        //--------------------------------------------
        // inicializa la tabla y las columnas
       
        personasTable.setItems(datos);
       
        nombrecolumna.setCellValueFactory(fila->fila.getValue().NombreProperty()); // debe ser una property
        apellidocolumna.setCellValueFactory(fila->fila.getValue().ApellidosProperty()); 
        // indica el valor que irá en la columna
        imagencolumna.setCellValueFactory(celda4 -> celda4.getValue().pathImageProperty());
        // CellFactory indica cómo se presentará en pantalla
        imagencolumna.setCellFactory(columna -> {
            return new TableCell<Persona,String> () {
                private ImageView view = new ImageView();
                @Override
                protected void updateItem(String item, boolean empty) {
                   super.updateItem(item, empty);
                       if (item == null || empty) setGraphic(null);
                       else {
                         //  Image image = new Image(EjemploTableView.class.getResourceAsStream(item)),
                          //      40, 40, true, true);
                             // Image image = new Image(getClass().getResource("/resources/LLoroso.png"),
                               // 40, 40, true, true);
                               Image image = new Image(item, 40, 40, true, true);
                            view.setImage(image);
                            setGraphic(view);
                            }
                }
            };
        }); //setCellFactory
        
        
        delButton.setDisable(true);
        delButton.disableProperty().bind(Bindings.equal(
                personasTable.getSelectionModel().selectedIndexProperty(), -1));
        //----------------------------------------------
        // gestiona el disable del boton modificar
        modButton.setDisable(true);
        modButton.disableProperty().bind(Bindings.isNull(personasTable.getSelectionModel().selectedItemProperty()));
     
    }

    @FXML
    private void addManejador(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/vista/FXMLPersona.fxml"));//aqui se encuentra la referencia a Añadir Persona
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
        if(controladorSecund.isAceptar()){
            //pedir nueva persona y añadir lista datos
            datos.add(controladorSecund.getPersona());
        }
        
    }

    @FXML
    private void updateManejador(ActionEvent event) throws IOException {
        FXMLLoader loader = new FXMLLoader(getClass().getResource("/vista/FXMLPersona.fxml"));//aqui se encuentra la referencia a Añadir Persona
        Parent root = loader.load();
        FXMLPersonaController controladorSecund = loader.getController(); //nos devuelve la nueva ventana
            // a partir de aqui puedo invocar metodos publicos 
        
        Scene scene = new Scene(root);
        Stage ventanaSecundaria = new Stage();
        ventanaSecundaria.setScene(scene);
        ventanaSecundaria.initModality(Modality.APPLICATION_MODAL);
        ventanaSecundaria.setTitle("Modificar Persona");
        //ventanaSecundaria.show();
        controladorSecund.setPersona(personasTable.getSelectionModel().getSelectedItem());
        ventanaSecundaria.showAndWait();
        // creamos ventana secundaria como FXMLPersona 
        
    }

    @FXML
    private void delManejador(ActionEvent event) {
        datos.remove(personasTable.getSelectionModel().getSelectedItem());
    }
     
    class ColumnaImagen extends TableCell<Persona, String>{
        
    }

    
}
