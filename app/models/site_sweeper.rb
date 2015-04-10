class SiteSweeper < ActionController::Caching::Sweeper
  observe Site
  
  def after_save(site)
    expire_cache(site)
  end
  
  def after_destroy(site)
    expire_cache(site)
  end
  
  def expire_cache(site)
    name = "views/site/#{site.id}/recipes"
    puts "expiring site:#{site.id} cache #{name}"
    Rails.cache.delete name
  end

  def self.expire_cache
    Site.all.each do |r|
      r.save
    end
  end
end