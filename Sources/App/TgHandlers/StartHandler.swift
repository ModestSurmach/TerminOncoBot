//
//  File.swift
//  
//
//  Created by Modest Surmach on 18.12.2023.
//

import Vapor
import TelegramVaporBot


final class StartHandler {
    
    static func addHandlers(app: Vapor.Application, connection: TGConnectionPrtcl) async {
        
        await startHandler(app: app, connection: connection)
        
    }
    
    
    
    private static func startHandler(app: Vapor.Application, connection: TGConnectionPrtcl) async {
        await connection.dispatcher.add(TGMessageHandler(filters: (.all)) { update, bot in
            let params: TGSendMessageParams = .init(chatId: .chat(update.message!.chat.id), text: "Ok")
            try await connection.bot.sendMessage(params: params)
        })
    }
    
    
}
