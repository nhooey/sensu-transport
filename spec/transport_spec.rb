require File.join(File.dirname(__FILE__), "helpers")
require "sensu/transport"
require "logger"

describe "Sensu::Transport" do
  include Helpers

  it "can load and connect to the rabbitmq transport" do
    async_wrapper do
      options = {}
      Sensu::Transport.connect("rabbitmq", options) do |transport|
        expect(transport.connected?).to be(true)
        async_done
      end
    end
  end

  it "can load and connect to the redis transport" do
    async_wrapper do
      options = {}
      Sensu::Transport.connect("redis", options) do |transport|
        expect(transport.connected?).to be(true)
        async_done
      end
    end
  end

  it "can set the rabbitmq transport logger" do
    async_wrapper do
      logger = Logger.new(STDOUT)
      Sensu::Transport.logger = logger
      Sensu::Transport.connect("rabbitmq") do |transport|
        expect(transport.logger).to eq(logger)
        expect(transport.logger).to respond_to(:error)
        async_done
      end
    end
  end

  it "can set the redis transport logger" do
    async_wrapper do
      logger = Logger.new(STDOUT)
      Sensu::Transport.logger = logger
      Sensu::Transport.connect("redis") do |transport|
        expect(transport.logger).to eq(logger)
        expect(transport.logger).to respond_to(:error)
        async_done
      end
    end
  end
end
