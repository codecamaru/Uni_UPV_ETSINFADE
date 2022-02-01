/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javafxmlapplication;

import java.net.URL;
import java.util.ResourceBundle;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.control.Button;
import javafx.scene.control.CheckBox;
import javafx.scene.control.Label;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;

/**
 *
 * @author jsole
 */
public class FXMLDocumentController implements Initializable {
    
    private Label label;
    @FXML
    private Label estarRestando;
    @FXML
    private CheckBox checkbox;
    
    private Double princNum = -20.0;
    @FXML
    private Button uno;
    @FXML
    private Button cinco;
    @FXML
    private Button diez;
    @FXML
    private Label etiquetaPrin;
    @FXML
    private TextField textField;
    
    private void handleButtonAction(ActionEvent event) {
        System.out.println("You clicked me!");
        label.setText("Hello World!");
    }
    
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
    }    

    @FXML
    private void estasRestando(ActionEvent event) {
        if(checkbox.isSelected()){
            estarRestando.setText("¡Estás restando!");
        }
        else{
            estarRestando.setText("");
        }
        
    }

    @FXML
    private void operaUno(ActionEvent event) {
        if(checkbox.isSelected()){
            princNum -= 1;
            etiquetaPrin.setText(Double.toString(princNum));
        }
        else{
            princNum += 1;
            etiquetaPrin.setText(Double.toString(princNum));
        }
    }

    @FXML
    private void operaCinco(ActionEvent event) {
        if(checkbox.isSelected()){
            princNum -= 5;
            etiquetaPrin.setText(Double.toString(princNum));
        }
        else{
            princNum += 5;
            etiquetaPrin.setText(Double.toString(princNum));
        }
    }

    @FXML
    private void operaDiez(ActionEvent event) {
        if(checkbox.isSelected()){
            princNum -= 10;
            etiquetaPrin.setText(Double.toString(princNum));
        }
        else{
            princNum += 10;
            etiquetaPrin.setText(Double.toString(princNum));
        }
    }

    @FXML
    private void operar(ActionEvent event) {
        
        String s = String.valueOf(textField.getCharacters());
        Double valor = Double.parseDouble(s);
        if(checkbox.isSelected()){
            princNum -= valor;
            etiquetaPrin.setText(Double.toString(princNum));
        }
        else{
            princNum += valor;
            etiquetaPrin.setText(Double.toString(princNum));
        }
    }

    
}
