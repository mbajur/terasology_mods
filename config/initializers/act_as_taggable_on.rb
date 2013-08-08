ActsAsTaggableOn::Tag.class_eval do
  has_friendly_id :name,
                  :use_slug => true,
                  :approximate_ascii => true,
                  :reserved_words => ['show', 'edit', 'create', 'update', 'destroy']
end