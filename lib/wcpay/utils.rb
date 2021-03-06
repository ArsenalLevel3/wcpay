require 'nokogiri'
require 'uuid'

module WCPay
  module Utils
    def self.stringify_keys(hash)
      new_hash = {}
      hash.each do |key, value|
        new_hash[(key.to_s rescue key) || key] = value
      end
      new_hash
    end
    
    def self.nonce_str
      # 随机字符串，长度要求在32位以内
      UUID.generate.gsub('-', '')
    end
    
    def self.xml_body options = {}
      xml = '<xml>'
      options.each { |key, value| xml += "<#{key}>#{value}</#{key}>" }
      xml += '</xml>'
      xml
    end
    
    def self.xml_parse xml
      options = {}
      Nokogiri::XML(xml).children[0].children.each { |node| options[node.name] = node.text unless node.name == 'text' || node.text.blank? }
      options
    end
    
    def self.generate_batch_no
      t = Time.now
      batch_no = t.strftime('%Y%m%d%H%M%S') + t.nsec.to_s
      batch_no.ljust(24, rand(10).to_s)
    end
    
  end
end
