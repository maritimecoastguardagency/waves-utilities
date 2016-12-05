module WavesUtilities
  class Owner
    attr_accessor(
      :name,
      :address_1,
      :address_2,
      :address_3,
      :town,
      :postcode,
      :country,
      :nationality,
      :email,
      :phone_number,
      :declared_at
    )

    def initialize(params = {})
      params.reject! { |param| !respond_to?(param) }
      assign_attributes(params)
    end

    def to_s
      name
    end

    def assign_attributes(params = {})
      params.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def inline_address
      [
        address_1,
        address_2,
        address_3,
        town,
        country,
        postcode,
      ].compact.reject(&:empty?).join(", ")
    end
  end
end
