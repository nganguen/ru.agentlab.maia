package ru.agentlab.maia.service.message.http;

import java.util.List;

import com.google.gson.Gson;

import io.netty.channel.ChannelHandlerContext;
import io.netty.handler.codec.MessageToMessageDecoder;
import ru.agentlab.maia.IMessage;
import ru.agentlab.maia.service.message.impl.AclMessage;

public class AclMessageDecoder extends MessageToMessageDecoder<String> {

	Gson gson;

	public AclMessageDecoder(Gson gson) {
		this.gson = gson;
	}

	@Override
	protected void decode(ChannelHandlerContext ctx, String request, List<Object> output) throws Exception {
		IMessage message = gson.fromJson(request, AclMessage.class);
		output.add(message);
	}

}
