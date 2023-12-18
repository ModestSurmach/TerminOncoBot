import Foundation
import Vapor
import TelegramVaporBot

public func configure(_ app: Application) async throws {
    
    app.http.server.configuration.hostname = "0.0.0.0"
    app.http.server.configuration.port = 9091
    
    

    
    
    
    
    
    let tgApi: String = "5829453178:AAEmZCBiQhviUJ8MWVfGRlyPbdOLqOjqDcA"
    /// set level of debug if you needed
    TGBot.log.logLevel = app.logger.logLevel
    let bot: TGBot = .init(app: app, botId: tgApi)
    await TGBOT.setConnection(try await TGLongPollingConnection(bot: bot))
    
    await DefaultBotHandlers.addHandlers(app: app, connection: TGBOT.connection)
    await StartHandler.addHandlers(app: app, connection: TGBOT.connection)
    await MainMenuHandler.addHandlers(app: app, bot: TGBOT.connection)
    
    try await TGBOT.connection.start()

    try routes(app)
}

