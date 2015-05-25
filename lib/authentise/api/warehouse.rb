require "authentise/api"

module Authentise
  module API
    module Warehouse
      module_function

      # Params:
      # - cookie
      #
      # - name (string) – Required. The name of the model. This can be any
      #   string and should be meaningful to the user
      #
      # - allowed_transformations (hash) – Optional. The transformations that
      #   are allowed on this model.
      #   * resize (boolean) – Optional. true if this
      #     model is allowed to be resized automatically by other services. Default: false.
      #   * rotation (boolean) – Optional. true if
      #     this model is allowed to be rotated automatically by other services. Default: false.
      #
      # - callback (hash) – Optional. The URL to call when this model changes
      #   states.
      #   * url (string) – Optional. The URL to request for the
      #     callback
      #   * method (string) – Optional. The method to use for the
      #     request, one of GET, POST or PUT.
      def create_model(session_token: nil, name: nil)
        url = "https://models.authentise.com/model/"
        body = {
          name: name
        }.to_json
        options = {
          content_type: :json,
          accept: :json,
          cookies: { session: session_token }
        }
        RestClient.post(url, body, options) do |response,
                                                request,
                                                result|
          if response.code == 201
            {
              model_url: response.headers[:location],
              upload_url: response.headers[:x_upload_location]
            }
          else
            raise API::Error.new(JSON.parse(response)["message"])
          end
        end
      end

      def put_file(url: nil, file: nil)
        response = RestClient.put(url, file) do |response,
                                                 request,
                                                 result|
        if response.code == 201
          {
            model_url: response.headers[:location],
            upload_url: response.headers[:x_upload_location]
          }
        else
          raise API::Error.new(response)
        end
      end

      # Get information about a model.
      # def get_model(uuid)
      #   url = "#{host}/model/#{uuid}"
      #   response = RestClient.get(url)
      #   data = JSON.parse(response)
      #   {
      #     # The name of the model. (string)
      #     name: data["name"],
      #     # The current status of the model processing. Can be one of
      #     # "processing", "processed", or "error".
      #     status: data["status"],
      #     # The url of a link at which a snapshot of the model can be
      #     # downloaded. (string)
      #     snapshot: data["snapshot"],
      #     # The url of a link at which a the model can be downloaded.
      #     content: data["content"],
      #     # Boolean represeting if the model is manifold. If the model is
      #     # not manifold, there is a higher likelyhood that slicing will
      #     # fail.
      #     manifold: data["analyses.manifold"],
      #     # The date and time the model was created.
      #     created_at: data["created"],
      #     # The date and time the model was last updated.
      #     updated_at: data["updated"],
      #     # An array of model uris from which this model is derived.
      #     parents: data["parents"],
      #     #  An array of model uris from which are derived from this model.
      #     children: data["children"],
      #   }
      # end


      # Get a list of all models the requester has access to based on
      # query filters.
      #
      # Params:
      # - name: a partial name of models to search for. accepts the
      #   wildcard character: “*”.
      # - status: a status of models to search for.
      # - created: a creation date to search for models.
      # - updated: a updated date to search for models.
      # - sort – one of the other queryable parameters, such as name,
      #   status, created or updated. accepts + or - to indicate order of
      #   the sort. parameters may be strung together, separated by commas.
      #   example: "+status, +created, -name" or "name, created"
      # def get_models(params)
      #   url = "#{host}/model/#{uuid}"
      #   response = RestClient.get(url, params: params)
      #   data = parse(response)
      #   {
      #     # ?
      #     models: data["models"]
      #   }
      # end
    end
  end
end