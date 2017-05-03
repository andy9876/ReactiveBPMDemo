package com.decisioning;

import kafka.javaapi.producer.Producer;
import kafka.producer.ProducerConfig;
import org.apache.commons.configuration.Configuration;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.Properties;


public class KafkaInstance {

    //Logger for logging
    private static final Logger LOG = LoggerFactory.getLogger(KafkaInstance.class);

    private Configuration configuration;
    private ProducerConfig config;
    private Producer<String, String> producer;

    public KafkaInstance(Configuration configuration) {
        this.configuration = configuration;
        initializeKafka();
    }

    public void initializeKafka() {

        LOG.info("Initializing Kafka Instance");
        //set the properties for kafka
        Properties props = new Properties();
        LOG.info("setting apache kafka properities");

        //****SET THE BELOW IP TO THE IP OF THE SERVER RUNNING KAFKA******
        props.put("metadata.broker.list", configuration.getString("metadata.broker.list"));
        props.put("serializer.class", configuration.getString("serializer.class"));

        //setup the kafka producer data structures
        config = new ProducerConfig(props);
        producer = new Producer<String, String>(config);


    }

    public Producer<String, String> getProducer() {
        return producer;
    }
}

