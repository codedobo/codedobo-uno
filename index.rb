# frozen_string_literal: true

require_relative './user-commands.rb'
require_relative './game.rb'
require_relative './setup.rb'
# Uno module for the codedobo
class UnoModule
  include CodeDoBo::BotModule

  def initialize(app_class, module_manager)
    @app_class = app_class
    @module_manager = module_manager
    send_message "\u001b[36mStarting uno module..."
    @client = module_manager.client
    @language = CodeDoBo::Language.new(module_manager.client, __dir__ + '/language')
    send_message "\u001b[32mSuccessfully started uno module!"
  end

  def console_command(command, _args)
    send_message "\u001b[96mRunning uno@#{module_version} module!" if command == 'uno'
    true if command == 'uno'
  end

  def match_making
    @match_making&.each do |_key, value|
      value.exit
    end
    @match_making = {}
    # @client.query('SELECT * FROM `uno`').each do |row|
    #   next if row['CATEGORY'].nil?
    #   next unless @module_manager.bot.discord.servers.key? row['SERVERID']

    #   channel = @module_manager.bot.discord.channel(row['CATEGORY'])
    #   bot = @module_manager.bot
    #   channel_match_making = UnoModule::MatchMaking.new(bot, channel, @language)
    #   @match_making[row['SERVERID'].to_i] = channel_match_making
    # end
  end

  def exit
    @match_making.each do |_key, value|
      value.exit
    end
  end
  attr_reader :data
end
