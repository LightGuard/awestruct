require 'net/http'

module Awestruct
  module Extensions
    module RemotePartial

      def remote_partial(url)
        url_tmp = url.sub('http://', '')
        r = 'remote_partial/' + url_tmp[/(.*)\/[^\/].+$/, 1]
        tmp = File.join(tmp(site.tmp_dir, r), File.basename(url_tmp))
        get_or_cache(tmp, url)
      end

      alias_method :remotePartial, :remote_partial

      def get_or_cache(tmp_file, url)
        response_body = ""
        if !File.exist?tmp_file
          $LOG.info url if $LOG.info? && !config.quiet
          response_body = Net::HTTP.get_response (url) do |response|
            case response
            when Net::HTTPSuccess then
              File.open(tmp_file, 'w') do |out|
                out.write response.body
              end
              response.body
            when Net::HTTPRedirect then
              $LOG.warn "Remote Partial #{url} redirected to #{response['location']}, please update" if $LOG.warn?
              ""
            else
              $LOG.error "Remote Partial #{url} error #{response.value}" if $LOG.error?
            end
          end
        else
          response_body = File.read(tmp_file)
        end
        response_body
      end


    end
  end
end
