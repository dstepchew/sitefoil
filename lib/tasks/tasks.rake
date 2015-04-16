
task :on_cron => :environment do
  def log s
    Rails.logger.info s
    puts s
  end

  log "removing non active visitors. currently: visitors: #{Visitor.count}, hits: #{Hit.count}"
  Visitor.where("updated_at<?",1.month.ago).destroy_all
  log "after: visitors: #{Visitor.count}, hits: #{Hit.count}"

  log "removing old hits"
  Hit.where("updated_at<?",1.month.ago).destroy_all
  log "after: hits: #{Hit.count}"
  
  total = Site.count
  Site.all.each_with_index do |site, i|
    log "site recalc #{i+1}/#{total}"
    site.on_cron
  end

end