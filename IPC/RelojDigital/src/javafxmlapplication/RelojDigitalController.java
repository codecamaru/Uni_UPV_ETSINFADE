/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package javafxmlapplication;

import java.net.URL;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;
import java.time.format.FormatStyle;
import java.util.ResourceBundle;
import javafx.application.Platform;
import javafx.concurrent.Task;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.fxml.Initializable;
import javafx.scene.text.Text;

/**
 * FXML Controller class
 *
 * @author carolinaalbamaruganrubio
 */
public class RelojDigitalController implements Initializable {

    @FXML
    private Text timeLabel;

    /**
     * Initializes the controller class.
     */
    @Override
    public void initialize(URL url, ResourceBundle rb) {
        // TODO
        MiTarea tarea = new MiTarea();
        Thread hilo = new Thread(tarea);
        hilo.setDaemon(true);
        hilo.start();
      //  timeLabel.textProperty().bind(tarea.messageProperty());
    }    
    // boton iniciar: crear método que me cree todo el rato un nuevo hilo
    // boton parar: sacar fuera variable hilo y comprobar isCancelled()
    @FXML
    private void parar(ActionEvent event) {
       // hilo.cancel();
    }

    @FXML
    private void iniciar(ActionEvent event) {
    }
    
    class MiTarea extends Task<Void>{

        @Override
        protected Void call() throws Exception {
            while(true){
               if(isCancelled()){ break; }
               // updateMessage(LocalTime.now().format(DateTimeFormatter.ofLocalizedTime(FormatStyle.MEDIUM)));
               //ESTO TIENE MISMA FUNCIONALIDAD QUE ANTES Y EN EL {} PUEDES PONER LO QUE QUIERAS
                Platform.runLater(()->{ timeLabel.setText(LocalTime.now().format(DateTimeFormatter.ofLocalizedTime(FormatStyle.MEDIUM))); });
                Thread.sleep(1000);
            }
        }
    
    }
}
