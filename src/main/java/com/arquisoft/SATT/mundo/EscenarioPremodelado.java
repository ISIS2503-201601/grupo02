package com.arquisoft.SATT.mundo;


public class EscenarioPremodelado {
	
	public enum PerfilAlerta{
		
		informativo("Informativo"), 
		precaucion("Precuaucion"), 
		alerta("Alerta"),
		alarma("Alarma");
		
		String perfilString;
		
		PerfilAlerta(String s){
			perfilString = s;
		}
		
		public String string(){return perfilString;}
		
	}

	
}
