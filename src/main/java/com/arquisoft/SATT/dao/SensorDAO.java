package com.arquisoft.SATT.dao;

import java.io.BufferedReader;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.List;

import javax.ws.rs.core.Response;

import org.bson.Document;

import com.arquisoft.SATT.mundo.EventoSismicoDTO;
import com.arquisoft.SATT.mundo.SensorDTO;
import com.arquisoft.SATT.utilidades.KeyValueSearch;
import com.arquisoft.SATT.utilidades.MongoConnection;
import com.arquisoft.SATT.utilidades.MongoManager;
import com.arquisoft.SATT.utilidades.ResponseSATT;
import com.arquisoft.SATT.utilidades.SATTDB;
import com.arquisoft.SATT.utilidades.KeyValueSearch.SearchType;
import com.arquisoft.SATT.utilidades.KeyValueUpdate;
import com.arquisoft.SATT.utilidades.KeyValueUpdate.UpdateType;
import com.arquisoft.SATT.utilidades.MongoConnection.MongoQuery;
import com.google.gson.Gson;
import com.mongodb.util.JSON;

public class SensorDAO {
	
	private static String json;
	
	private static final String COLECCION = "sensores";
	
	private static ArrayList<Document> documentos = new ArrayList<Document>();
	
	private static List<Object> listaSensores = new ArrayList<Object>();
	
	private static SensorDTO sensor = null;
	
	//----------------------------------------------------------------------
	//GET
	//----------------------------------------------------------------------

	public static Response getAllSensores() {
		json = "";
		documentos = new ArrayList<Document>();
		MongoConnection connection = SATTDB.requestConecction();
		try {
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				@Override
				public void query(MongoManager manager) {
					documentos = manager.queryByFilters(COLECCION, null).into(new ArrayList<Document>());
					json = JSON.serialize(documentos);
				}
			});
		} catch(Exception e) {
			e.printStackTrace();
			json = "{\"exception\":\"Error Fetching Sensores Collection.\"}";
		}
		return ResponseSATT.buildResponse(json);
	}
	
	
	public static List<Object> getListSensores() {
		json = "";
		documentos = new ArrayList<Document>();		
		MongoConnection connection = SATTDB.requestConecction();
		try {
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				@Override
				public void query(MongoManager manager) {
					documentos = manager.queryByFilters(COLECCION, null).into(new ArrayList<Document>());
					listaSensores = ResponseSATT.transformDocumentList(documentos, SensorDTO.class);
				}
			});
		} catch(Exception e) {
			e.printStackTrace();
			json = "{\"exception\":\"Error Fetching Sensores Collection.\"}";
		}
		
		return listaSensores;
	}
	
	public static Response getSensorJson(String id){
		MongoConnection connection = SATTDB.requestConecction();
		try {
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				
				@Override
				public void query(MongoManager manager) {
					ArrayList<KeyValueSearch> filters = new ArrayList<KeyValueSearch>();
					filters.add(new KeyValueSearch("_id", id, SearchType.ID));
					Document sensorDoc = manager.queryByFilters(COLECCION, filters).first();
					json = sensorDoc.toJson();
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
			json = "{\"exception\":\"Error Fetching Sensores Collection.\"}";
		}
		return ResponseSATT.buildResponse(json);
	}
	
	public static SensorDTO getSensor(String id){
		MongoConnection connection = SATTDB.requestConecction();
		try {
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				
				@Override
				public void query(MongoManager manager) {
					ArrayList<KeyValueSearch> filters = new ArrayList<KeyValueSearch>();
					filters.add(new KeyValueSearch("_id", id, SearchType.ID));
					Document sensorDoc = manager.queryByFilters(COLECCION, filters).first();
					sensor = new Gson().fromJson(sensorDoc.toJson(), SensorDTO.class);
					
				}
			});
		} catch (Exception e) {
			e.printStackTrace();
		}
		return sensor;
	}
	
	//----------------------------------------------------------------------
	//POST
	//----------------------------------------------------------------------
	
	public static Response addSensor(SensorDTO sensor) {
		MongoConnection connection = SATTDB.requestConecction();
		Gson gson = new Gson();
		sensor.setNombreZona(ZoneFinderDAO.getZonaDeEvento(new EventoSismicoDTO(null, sensor.getLat(), sensor.getLng(), 0)));
		json = gson.toJson(sensor);
		try {
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				@Override
				public void query(MongoManager manager) {
					Document sensorDoc = Document.parse(json);
					if(manager.persist(sensorDoc, COLECCION)) {
						json = sensorDoc.toJson();
					} else {
						json = "{\"exception\":\"Sensor not added.\"}";
					}
				}
			});
		} catch(Exception e) {
			e.printStackTrace();
			json = "{\"exception\":\"Error Fetching Sensores Collection.\"}";
		}
		return ResponseSATT.buildResponse(json);
	}

	//----------------------------------------------------------------------
	//PUT
	//----------------------------------------------------------------------
	
	public static Response addLecturaToSensor(SensorDTO sensor) {
		MongoConnection connection = SATTDB.requestConecction();
		try {
			ArrayList<KeyValueSearch> filters = new ArrayList<KeyValueSearch>();
			filters.add(new KeyValueSearch("lat", sensor.getLat(), SearchType.EQUALS));
			filters.add(new KeyValueSearch("lng", sensor.getLng(),SearchType.EQUALS));
			ArrayList<KeyValueUpdate> updates = new ArrayList<KeyValueUpdate>();
			
			SATTDB.executeQueryWithConnection(connection, new MongoQuery() {
				@Override
				public void query(MongoManager manager) {
					Document sensorDoc = manager.queryByFilters(COLECCION, filters).first();
					if(sensorDoc != null) {
						updates.add(new KeyValueUpdate("altura", sensor.getAltura(), UpdateType.SET));
						updates.add(new KeyValueUpdate("velocidad", sensor.getVelocidad(), UpdateType.SET));
						updates.add(new KeyValueUpdate("historial", new Document().append("altura", sensorDoc.getString("altura")).append("velocidad", sensorDoc.getString("velocidad")), UpdateType.INSERT));
						if(manager.updateFirst(COLECCION, filters, updates)) {
							json = "{\"exception\":\"Lectura added.\"}";
						}
					}
					json = "{\"exception\":\"Lectura not added.\"}";
				}
			});
		} catch(Exception e) {
			e.printStackTrace();
			json = "{\"exception\":\"Error Fetching Sensores Collection.\"}";
		}
		return ResponseSATT.buildResponse(json);
	}
	
	public static void main(String[] args) {
		int i=0;
		
		try {
			ZoneFinderDAO.loadPuntosCardinales();
			BufferedReader br = new BufferedReader(new FileReader("./data/sensores.csv"));
			String line = br.readLine();
			while (i<4000){
				SensorDTO sensor = new SensorDTO();
				line = br.readLine();
				String[] values = line.split(",");
				sensor.setLat(Double.parseDouble(values[0]));
				sensor.setLng(Double.parseDouble(values[1]));
				sensor.setAltura(Double.parseDouble(values[2]));
				sensor.setVelocidad(Double.parseDouble(values[3]));
				i++;
				SensorDAO.addSensor(sensor);
				System.out.println("Added sensor "+i);
			}
			br.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

}
