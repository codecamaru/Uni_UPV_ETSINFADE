package pract4;

import java.net.*;
import java.io.*;
import java.util.Scanner;

public class ClienteSMTP {

        static void error(String cadena) {
		System.out.println(cadena);
		System.exit(0);
	}

	public static void main(String args[]) {
	try{
		System.setProperty ("line.separator","\r\n");
		Socket s=new Socket("zoltar.redes.upv.es",25);
		System.out.println("Conectado al servidor SMTP de zoltar");
		PrintWriter salida = new PrintWriter(s.getOutputStream(),true);
		Scanner entrada=new Scanner(s.getInputStream());
		String respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("220")) {error(respuesta);}

		salida.println("HELO [10.0.2.15]");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("250")) {error(respuesta);}

		salida.println("MAIL FROM:<redes18@redes.upv.es>");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("250")) {error(respuesta);}

		salida.println("RCPT TO:<redes18@redes.upv.es>");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("250")) {error(respuesta);}

		salida.println("DATA");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("354")) {error(respuesta);}

		// **completar** 
		// Aqui van varios println con todo el correo 
		// electronico incluidas las cabeceras

		salida.println("To: redes18@redes.upv.es");
		salida.println("From: Alumno de Redes <redes18@redes.upv.es>");
		salida.println("Subject: BueJ");
		salida.println("Message-ID: <718a7079-2e8e-ad93-be11-8cc6a2fa848c@redes.upv.es>");
		salida.println("Date: Tue, 27 Oct 2020 17:40:21 +0100");
		salida.println("Content-Type: text/plain; charset=utf-8; format=flowed");
		salida.println("Content-Transfer-Encoding: 7bit");
		salida.println("Content-Language: en-US");
		salida.println("");
		salida.println("BlaBla");
		salida.println("BueJBlueJ");
		salida.println("");
		salida.println(".");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("250")) {error(respuesta);}

		salida.println("QUIT");
		salida.flush();
		respuesta = entrada.nextLine();
		System.out.println(respuesta);
		if (!respuesta.startsWith("221")) {error(respuesta);}

		s.close();
		System.out.println("Desconectado");

	} catch (UnknownHostException e) {
		System.out.println("Host desconocido");
		System.out.println(e);
	} catch (IOException e) {
		System.out.println("No se puede conectar");
		System.out.println(e);
	}
	}
}
