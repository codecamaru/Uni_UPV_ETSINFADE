package ejemplos.tema1;

import librerias.estructurasDeDatos.lineales.ArrayDequeColaPlus;
import java.util.Deque;
import ejemplos.tema1;

public class GestorDePacientesVDeque{
    private Deque<Paciente> q;
    private double horaCita;

    public static final int MAXIMO_DIARIO_PACIENTES = 40;
    public static final double HORA_INICIO_CONSULTA = 9.00;
    public static final double TIEMPO_MEDIO_VISITA = 0.15;

    public GestorDePacientesVDeque(){
        q = new ArrayDequeColaPlus<Paciente>();
        horaCita = HORA_INICIO_CONSULTA;
    }
    
    public String darCita(Paciente x) {
        String res = "Espere un momento; consulto si le pueden atender mañana ... ";
        boolean aceptado = (q.talla() <= MAXIMO_DIARIO_PACIENTES); 
        if (!aceptado) { res += "\nLo siento. Mañana no podemos atenderle"; }
        else{
            q.encolar(x); 
            res += "\nConfirmado, le esperamos mañana a las "  + String.format("%2.2f", horaCita);
            horaCita += TIEMPO_MEDIO_VISITA;
            if (horaCita - Math.round(horaCita) < 0.0) 
                horaCita = Math.round(horaCita);
        }
        return res;
    }

    public String toString() {
        return "Historiales de sus " + q.talla()
            + " Pacientes de mañana en orden de visita\n" + q;
    }
}