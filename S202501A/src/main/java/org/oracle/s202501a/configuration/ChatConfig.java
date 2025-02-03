package org.oracle.s202501a.configuration;

import org.oracle.s202501a.chat.ChatHandler;	
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.socket.config.annotation.EnableWebSocket;
import org.springframework.web.socket.config.annotation.WebSocketConfigurer;
import org.springframework.web.socket.config.annotation.WebSocketHandlerRegistry;


@Configuration
@EnableWebSocket
public class ChatConfig implements WebSocketConfigurer {
    // Socket사용시 Server PGM 등록
	// Socket 서버 --> controller 비숫
	@Autowired
	ChatHandler chatHandler;
	
	@Override
	public void registerWebSocketHandlers(WebSocketHandlerRegistry registry) {
		// 누군가  URL /chating --> socketHandler 발동
		registry.addHandler(chatHandler, "/chating");
	}

}
