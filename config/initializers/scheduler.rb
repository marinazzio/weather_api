require "rufus-scheduler"

scheduler = Rufus::Scheduler.new

scheduler.cron "55 23 * * *" do
  FetchDailyWeatherDataJob.perform_later
end
