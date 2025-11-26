# Fix Rails 8 + ActiveAdmin 3.4 FileUpdateChecker issue
module ActiveSupport
  class FileUpdateChecker
    private

    def escape(key)
      key = key.to_s if key.is_a?(Pathname)
      key.gsub(",", '\,')
    end
  end
end
