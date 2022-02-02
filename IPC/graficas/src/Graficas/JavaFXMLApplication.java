/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Graficas;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.stage.Stage;


public class JavaFXMLApplication extends Application {
    
    @Override
    public void start(Stage stage) throws Exception {
        FXMLLoader loader= new  FXMLLoader(getClass().getResource("Graficas.fxml"));
        Parent root = loader.load();

        Scene scene = new Scene(root);

        stage.setScene(scene);
        stage.setTitle("Gráficas de las Notas");
        stage.show();
    }

    /**
     * @param args the command line arguments
     */
    public static void main(String[] args) {
        launch(args);
        
    }


    
}
