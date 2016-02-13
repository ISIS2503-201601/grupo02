package com.arquisoft.SATT.mundo;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlRootElement;

import org.bson.types.ObjectId;

@XmlRootElement
@XmlAccessorType(XmlAccessType.FIELD)
public class SensorDTO {
	
	private ObjectId _id;
	
	private String id;

	private long lat;
	
	private long lng;
	
	private double altura;
	
	private double velocidad;
	
	public SensorDTO(){
		
	}

	public SensorDTO(ObjectId _id, long lat, long lng, double altura, double velocidad) {
		super();
		this._id = _id;
		this.lat = lat;
		this.lng = lng;
		this.altura = altura;
		this.velocidad = velocidad;
	}

	public ObjectId get_id() {
		return _id;
	}

	public void set_id(ObjectId _id) {
		this._id = _id;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public long getLat() {
		return lat;
	}

	public void setLat(long lat) {
		this.lat = lat;
	}

	public long getLng() {
		return lng;
	}

	public void setLng(long lng) {
		this.lng = lng;
	}

	public double getAltura() {
		return altura;
	}

	public void setAltura(double altura) {
		this.altura = altura;
	}

	public double getVelocidad() {
		return velocidad;
	}

	public void setVelocidad(double velocidad) {
		this.velocidad = velocidad;
	}
}
