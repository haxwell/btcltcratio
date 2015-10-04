require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Btcratio
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    REFRESH_PERIOD_IN_SECONDS = 20
    UPDATE_CACHE_PERIOD_IN_SECONDS = REFRESH_PERIOD_IN_SECONDS + 15

    Thread.new {
        require 'rufus-scheduler'

        puts "attempting to start bfx polling thread..."
        
        sch = Rufus::Scheduler.new

        delay = REFRESH_PERIOD_IN_SECONDS 

        sch.every delay.to_s+'s' do 
            btc = Pubticker.new
            btc.tickerSymbol = 'btcusd'
            btc.populateUsingInternetAPI

            ltc = Pubticker.new
            ltc.tickerSymbol = 'ltcusd'
            ltc.populateUsingInternetAPI

            # TODO: add some exception handling here. 
            btc.save
            ltc.save
        end

        puts "bfx polling thread started."
    }

    Thread.new {
        require 'rufus-scheduler'

        puts "attempting to start update-cache thread..."

        sch = Rufus::Scheduler.new

        delay = UPDATE_CACHE_PERIOD_IN_SECONDS 

        sch.every delay.to_s+'s' do
            list = PubtickerCacherList.new.list
            list.each { |pc| pc.updateCache; }
        end

        puts "update-cache thread started."
    }

    Thread.new {
        require 'rufus-scheduler'

        sch = Rufus::Scheduler.new

        delay = 60 * 60 * 12; # 12 hours

        sch.every delay.to_s+'s' do
            times = PubtickerCacher.getPeriodBeginAndEndTime(TimePeriodConstants::YEAR)
            Pubticker.where("created_at <= ?", times[0].to_s.sub(" UTC", "")).delete

            puts "!!! Records older than " + times[0].to_s + " were deleted, so as to keep the DB from growing too large."
        end
    }

  end
end
