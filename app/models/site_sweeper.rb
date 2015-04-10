class SiteSweeper < ActionController::Caching::Sweeper
  observe Site
  
  def after_save(site)
    expire_cache(site)
  end
  
  def after_destroy(site)
    expire_cache(site)
  end
  
  def expire_cache(site)
    name = "views/tracker/#{site.id}.js"
    puts "expiring site:#{site.id} cache #{name}"
    Rails.cache.delete name
  end
end