Ruby gem to access Authentise API v3
====================================

See http://docs.dev-auth.com/

Ye be warned: this has not been tested in production.

Example usage
-------------

```rb
require "authentise"

Authentise.configure do |c|
  c.secret_partner_key = "ZSBzaG9y-dCB2ZWhl-bWVuY2Ug-b2YgYW55-IGNhcm5h-bCB=="
end

upload = Authentise::Upload.new(
  stl_file: File.new("example.stl", "rb"),
  email: "example@example.com",
  cents: 2_00,
  currency: "EUR"
)

upload.token
# => "33b41d6e80d4918cfff768185d1d31a6"

upload.link_url
# => "https://widget.sendshapes.com/?token=33b41d6e80d4918cfff768185d1d31a6"

upload.status
# => {
#  printing_job_status: "warming_up",
#  printing_percentage: 0,
#  minutes_left: 21,
#  message: ""
# }
```


Development
-----------

For local development, please install the `bundler` gem then:

```sh
$ bundle
```

To launch specs:

```sh
$ rake
```


License
-------

Created by Sunny Ripert for [Cults.](https://cults3d.com),
licensed under the MIT License.
