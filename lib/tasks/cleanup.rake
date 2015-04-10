task :cleanup => :environment do
  Visitor.where("created_at<?",3.days.ago).destroy_all
end
