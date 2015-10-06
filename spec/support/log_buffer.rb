require 'active_record/log_subscriber'

class LogBuffer < ActiveRecord::LogSubscriber

  def self.logs
    @logs ||= []
  end

  def sql(event)
    payload = event.payload

    sql   = payload[:sql]
    binds = nil

    unless (payload[:binds] || []).empty?
      binds =  payload[:binds].map { |col,v|
        render_bind(col, v)
      }.inspect
    end

    LogBuffer.logs << {sql: sql, binds: binds}
  end

  def logger
    @dev_null ||= Logger.new('/dev/null')
  end
end

LogBuffer.attach_to :active_record
