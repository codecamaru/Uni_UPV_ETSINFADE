/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javafxmlapplication;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.beans.binding.Bindings;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Label;
import javafx.scene.control.Slider;
import javafx.scene.shape.Rectangle;

/**
 *
 * @author jsole
 */
public class FXMLDocumentController implements Initializable {
    
    @FXML
    private Rectangle rectangulo;
    @FXML
    private Slider horizontalslider;
    @FXML
    private Slider verticalslider;
    
    
    // este metodo me asegura que cuando se inicializa, se crean los objetos de arriba (inyeccion)
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        horizontalslider.valueProperty().addListener((a,b,c)->{
            rectangulo.setWidth((double) c);
        });
        verticalslider.valueProperty().addListener((a,b,c)->{
            rectangulo.setHeight((double) c);
        });
        //rectangulo.widthProperty().bind(horizontalslider.valueProperty());
        //rectangulo.widthProperty().bind(Bindings.divide(horizontalslider.valueProperty(),2));
        //rectangulo.heightProperty().bind(verticalslider.valueProperty());
    }    
    
}
