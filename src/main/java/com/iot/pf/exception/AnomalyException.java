package com.iot.pf.exception;

public class AnomalyException extends Exception {
	
	public AnomalyException() {
	   super("you have an anomaly result value after[INSERT/UPDATE/DELETE] quert!!");	
	}
	public AnomalyException(String msg) {
		super(msg);	
	}
	public AnomalyException(int expected, int result) {
		super("you have an anomaly result value after[INSERT/UPDATE/DELETE] quert!!" 
				
				+"\n expected result " + expected + ", but result was " + result);	
	}

}
