require 'spree_core'
require 'synergy_bootstrap_theme_hooks'

module SynergyBootstrapTheme
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
      end
      
      Admin::PagesController.cache_sweeper :page_sweeper
      Admin::TrackersController.cache_sweeper :tracker_sweeper
      
      if defined?(Spree::RecentlyViewed) && Spree::RecentlyViewed::Config.instance
        Spree::RecentlyViewed::Config.set :recently_viewed_products_max_count => 3
      end
      
      if Spree::Config.instance
        Spree::Config.set :products_per_page => 12
      end

      Image.attachment_definitions[:attachment].merge!({
        :styles => {
            :mini => '50x50>',
            :small => '150x150>',
            :product => '240x240>',
            :large => '600x600>'
        }
      })
    end

    config.to_prepare &method(:activate).to_proc
  end
end
