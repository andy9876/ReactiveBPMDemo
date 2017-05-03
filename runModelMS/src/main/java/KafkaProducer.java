package com.decisioning;

import kafka.producer.KeyedMessage;
import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class KafkaProducer {

    //Creating the Logger for logging
    private static final Logger LOG = LoggerFactory.getLogger(KafkaProducer.class);

    private String inputLine, key;
    private Configuration configuration;
    
    public KafkaProducer(String inputLine, Configuration configuration, String key) {
        this.inputLine = inputLine;
        this.configuration = configuration;
        this.key = key;
    }

    public KeyedMessage<String, String> execute() {

         KeyedMessage<String, String> data = null;

            LOG.info("writing to kafka="+inputLine);
            
            //populate the kafka data structure
             data = new KeyedMessage<String, String>(configuration.getString("kafka.topic"), key ,inputLine);
        return data;
    }

}

