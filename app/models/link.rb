require 'uri'

class Link < ActiveRecord::Base
  PROTOCOL = "http://"
  LINK_HAS_PROTOCOL = Regexp.new('\Ahttp:\/\/|\Ahttps:\/\/', Regexp::IGNORECASE)

  validates :url, :presence => true
  validates :short_url, :presence => true

  def self.normalize_url(url)
    p url
    url_to_be_cleaned = url['url']
    return nil if url_to_be_cleaned.blank?
    url_to_be_cleaned = PROTOCOL + url_to_be_cleaned.strip unless url_to_be_cleaned =~ LINK_HAS_PROTOCOL

    URI.parse(url_to_be_cleaned).normalize.to_s
  end

  def self.random_number(normalized_url)
    uri = URI(normalized_url)
    uri.scheme + '://smallurl.com/' + SecureRandom.urlsafe_base64(10, false)
  end
end

