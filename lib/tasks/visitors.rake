# added this before I realized I already had a tesk that deleted all visitors older than 30 days.  I'll leave this up for now just in case we need it - DWS

namespace :visitors do
  desc "TODO"
  task delete_30_days_old: :environment do
  	 Visitor.where(['created_at < ?', 30.days.ago]).destroy_all
  end

end
