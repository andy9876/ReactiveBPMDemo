package com.decisioning;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import java.util.Random;
import java.util.Date;
import java.sql.Timestamp;

public class RunModelMS {
	
	private static final Logger LOG = LoggerFactory.getLogger(KafkaInstance.class);

	public RunModelMS() {
		// TODO Auto-generated constructor stub
	}

	//execute rules
	public String execute(String line, String previousState)
	{		                                   		

		 //
		String appid=null;
		Random rand = new Random();
		
        //LOG.info();

        //read the id out of the line
        appid = line.split(":")[1].trim().split(",")[0].split("\"")[1];
        
        
        //generate a random number between 1-100, if 50 or greater then mark as Fraudulent transaction
		if (rand.nextInt(100)>49)
			line = "{\"id\":\"" + appid + "\",\"action\": \"Fraudulent Transaction\",\"data\": {\"timestamp\": \"2016-06-10T14:33:29.102-00:00\"}}";
		else
			line = "{\"id\":\"" + appid + "\",\"action\": \"Transaction OK\",\"data\": {\"timestamp\": \"2016-06-10T14:33:29.102-00:00\"}}";						
			
		return line;
	}
}
