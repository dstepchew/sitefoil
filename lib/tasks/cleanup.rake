task :cleanup => :environment do
  Visitor.where("created_at<?",3.days.ago).delete_all
  Hit.where("created_at<?",3.days.ago).delete_all
end
