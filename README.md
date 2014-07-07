Bunsho
======

Bunsho is a document store where it is possible to store "documents" which
can be retrieved by users based on an uuid.

You store documents by calling a rest interface with either the actual
content or an url where the content can be downloaded.

Each document has a limit on how many times it can be downloaded.

A document can be any kind of data, e.g. pdf file, tiff picture, excel spread
sheet.

Interface
=========

Retrieval
---------

Documents can be retrieved by the following url:
  http://<server>/documents/<uuid>

uuid will be issued when storing the document.

The result will be a landing page, with a link to the actual file.

Storing
-------

Documents can be stored with 2 methods
  PUT http://<server>/rest/documents.json

    The contents to be stored must be sent in the body.
    Mime-type will be taken from Content-Type sent in the request.

  GET http://<server>/rest/documents/url.json?url=<url>

   The contents will be fetched from the given url and stored with
   the content-type supplied by the server handling the request.

In both cases a json structure will be return with information about
the document, including mime-type and uuid.

Configuration
=============

A configuration file with 2 parameters should be added to
config/application.local.rb

An example with the default values.

    module Bunsho
      class Application < Rails::Application
        config.store_dir = "/var/lib/bunsho"
        config.default_available_count = 3
      end
    end

store_dir is the directory where documents will be store. Make sure you
have plenty of room for the documents. A number of sub directories will be
created to limit the number files pr. directory.

default_available_count is the default number of times a document can be
downloaded.

Admin Interface
===============

The admin interface requires a CAS login server to be available.
The CAS server is configured with a file in config/initializers.

    Devise.setup do |config|
      config.secret_key = 'put-secret-here'
      config.cas_create_user = false
      config.cas_base_url = "https://auth.dtu.dk/dtu"
    end

*cas_create_user* tells if users must be created in advance in order to login.
Setting this value to true means anyone able to login into the CAS server
can login to the admin interface.

*cas_base_url* tells where to redirect the CAS login to.
