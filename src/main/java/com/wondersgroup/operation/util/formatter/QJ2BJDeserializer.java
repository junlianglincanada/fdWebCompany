package com.wondersgroup.operation.util.formatter;

import java.io.IOException;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;
import com.wondersgroup.util.QJConvert;

public class QJ2BJDeserializer extends JsonDeserializer<String> {

	@Override
	public String deserialize(JsonParser p, DeserializationContext ctxt) throws IOException, JsonProcessingException {
		String oldValue = p.getText();
		String newValue = QJConvert.qj2bj(oldValue);
		return newValue;
	}
}
