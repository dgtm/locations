require 'elasticsearch'

class Autocomplete
  class << self
    def index_name
      'locations'
    end

    def index_type
      'location'
    end

    def delete(index_name)
      client.indices.delete(index: index_name)
    end

    def create(params)
      client.index(
        index: index_name,
        type: index_type,
        id: 1,
        body: {
          title: 'KTM',
          coordinates: [0, 0]
        }
      )
    end

    def search(search_title)
      client.search(index: index_name, body: {
        query: {
          prefix: {
            title: search_title
          }
        }
      })
    end

    def suggestions
      client = Elasticsearch::Client.new log: true
      client.indices.create(index: 'locations')
      client.indices.put_mapping(
        index: index_name,
        type: index_type,
        body: {
          location: {
            properties: {
              title: {
                type: 'string',
                fields: { title_ngram: { analyzer: 'ngram' } }
              },
              coordinates: { type: 'geo_point' }
            }
          }
        }
      )
      ['A', 'B']
    end
  end
end
