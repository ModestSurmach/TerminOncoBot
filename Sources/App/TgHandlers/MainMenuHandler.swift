//
//  File.swift
//  
//
//  Created by Modest Surmach on 18.12.2023.
//
import Vapor
import TelegramVaporBot

final class MainMenuHandler {
    
    static func addHandlers(app: Vapor.Application, connection: TGConnectionPrtcl)  async {
//        startHandler(app: app, bot: bot)
        await choosingAppointment(app: app, connection: connection)
    }
    
//    private static func startHandler(app: Vapor.Application, bot: TGBotPrtcl) {
//
//        stopWordsList()
//        let handler = TGMessageHandler(filters: .all && !.command.names(currentStopWordsList)) { update,bot in
//            let params = TGSendMessageParams(chatId: .chat(update.message!.chat.id), text: "Hi")
//            try bot.sendMessage(params: params)
//        }
//        bot.connection.dispatcher.add(handler)
//    }
    
    
    static func choosingAppointment(app: Vapor.Application, connection: TGConnectionPrtcl) async {
        
        let text = "hallo"
        
        let handler = TGMessageHandler(filters: .command.names(["/start", "Start"]) || .text.value("start") || .text.value("Start") || .text.value("старт") || .text.value("Старт")) { update, bot in
            
            let button1: [TGInlineKeyboardButton] = [.init(text: "Первичный прием", callbackData: "PrimaryAppointment")]
            let button2: [TGInlineKeyboardButton] = [.init(text: "Повторный прием", callbackData: "dateOfBirth")]

            let buttons: [[TGInlineKeyboardButton]] = [button1, button2]
            
            let keyboard: TGInlineKeyboardMarkup = .init(inlineKeyboard: buttons)
            
            let params = TGSendMessageParams(chatId: .chat(update.message!.chat.id), text: text, replyMarkup: .inlineKeyboardMarkup(keyboard))
            try await bot.sendMessage(params: params)
        }
        await connection.dispatcher.add(handler)
    }
    
}
