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
import javafx.scene.input.KeyCode;
import javafx.scene.input.KeyEvent;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.GridPane;
import javafx.scene.shape.Circle;

/**
 *
 * @author jsole
 */
public class FXMLDocumentController implements Initializable {
    
    @FXML
    private GridPane grid;
    @FXML
    private Circle circulo;
    private double sceneX;
    private double sceneY;
    
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        circulo.requestFocus();
        circulo.radiusProperty().bind(Bindings.min(
                Bindings.divide(grid.heightProperty(), 15)
                , Bindings.divide(grid.widthProperty(), 15)));
    }    

    @FXML
    private void moverCirculo(KeyEvent event) {
        KeyCode tecla = event.getCode();
        Integer columna = grid.getColumnIndex(circulo);
        Integer fila = grid.getRowIndex(circulo);
        switch (tecla){
            case UP: //mover hacia arriba
                fila = (fila-1+5)%5;
                break;
            case DOWN:
                fila = (fila+1+5)%5;
                break;
            case RIGHT:
                columna = (columna+1+5)%5;
                break;
            case LEFT:
                columna = (columna-1+5)%5;
                break;
        }
        grid.setConstraints(circulo,columna,fila);
    }

    @FXML
    private void mover2celda(MouseEvent event) {
        double sceneX = event.getSceneX();
        double sceneY = event.getSceneY();
        
        int col = (int)(sceneX / (grid.getWidth() / 5));
        int fil = (int)(sceneY / (grid.getHeight() / 5));
        grid.setConstraints(circulo,col,fil);
    }
// cómo hacer aparecer figuras para el 3enralla, como cambiar tamaño puntito, 

    @FXML
    private void soltar(MouseEvent event) {
        circulo.setTranslateX(0);
        circulo.setTranslateY(0);
        mover2celda(event);
    }

    @FXML
    private void arrastrar(MouseEvent event) {
        double despX = event.getSceneX() - sceneX;
        double despY = event.getSceneY() - sceneY;
        circulo.setTranslateX(despX);
        circulo.setTranslateY(despY);
    }

    @FXML
    private void pinchar(MouseEvent event) {
         sceneX = event.getSceneX();
         sceneY = event.getSceneY();
    }
    

    
    


    
    
}
