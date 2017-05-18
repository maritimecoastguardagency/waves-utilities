module WavesUtilities
  class Task
    def initialize(key)
      @key = key.to_sym
    end

    def ==(other)
      @key == other.to_sym
    end

    def description
      Task.all_task_types.find { |t| t[1] == @key }[0]
    end

    def method_missing(m, *args, &block)
      if m.match(/.*\?/)
        processes.include?(m.to_s.gsub("?", "").to_sym)
      else
        super
      end
    end

    def print_job_templates
      if prints_certificate?
        [:registration_certificate, :cover_letter]
      elsif prints_provisional_certificate?
        [:provisional_certificate, :cover_letter]
      elsif prints_current_transcript?
        [:current_transcript]
      elsif prints_historic_transcript?
        [:historic_transcript]
      elsif @key == :issue_csr
        [:csr_form]
      elsif @key == :termination_notice
        [:termination_notice]
      end
    end

    # def declarations_required_on_create?
    #   [
    #     :new_registration, :provisional, :re_registration, :renewal
    #   ].include?(@key)
    # end

    # def declarations_required_on_add_owner?
    #   return true if declarations_required_on_create?
    #   [:change_owner].include?(@key)
    # end

    # def electronic_delivery_available?
    #   [:current_transcript, :historic_transcript].include?(@key)
    # end

    # def ownership_can_be_changed?
    #   [
    #     :new_registration, :provisional, :change_owner, :renewal,
    #     :re_registration, :manual_override
    #   ].include?(@key)
    # end

    # def address_can_be_changed?
    #   ownership_can_be_changed? || @key == :change_address
    # end

    # def vessel_can_be_edited?
    #   [
    #     :new_registration, :provisional, :change_vessel, :renewal,
    #      :re_registration, :manual_override
    #   ].include?(@key)
    # end

    # def payment_required?
    #   ![
    #     :change_address, :closure, :enquiry, :termination_notice,
    #     :registrar_closure, :registrar_restores_closure, :issue_csr,
    #     :manual_override].include?(@key)
    # end


    # def prints_certificate?
    #   [
    #     :new_registration, :change_owner, :change_vessel, :renewal,
    #     :duplicate_certificate, :re_registration
    #   ].include?(@key)
    # end

    # def prints_provisional_certificate?
    #   [:provisional].include?(@key)
    # end

    # def prints_current_transcript?
    #   [:closure, :current_transcript].include?(@key)
    # end

    # def prints_historic_transcript?
    #   [:historic_transcript].include?(@key)
    # end

    # def duplicates_certificate?
    #   [:duplicate_certificate].include?(@key)
    # end

    # def renews_certificate?
    #   [:change_owner, :change_vessel, :renewal, :re_registration]
    #     .include?(@key)
    # end

    # def builds_registry?
    #   [
    #     :change_owner, :change_vessel, :change_address,
    #     :re_registration, :new_registration, :provisional, :renewal,
    #     :manual_override, :mortgage].include?(@key)
    # end

    # def builds_registration?
    #   [
    #     :change_owner, :change_vessel, :provisional,
    #     :re_registration, :new_registration, :renewal].include?(@key)
    # end

    # def emails_application_approval?
    #   [
    #     :new_registration, :renewal, :re_registration, :provisional,
    #     :change_owner, :change_vessel, :change_address,
    #     :closure, :current_transcript, :historic_transcript,
    #     :mortgage].include?(@key)
    # end

    # def emails_application_receipt?
    #   [
    #     :new_registration, :renewal, :re_registration, :provisional,
    #     :change_owner, :change_vessel, :change_address,
    #     :closure, :current_transcript, :historic_transcript,
    #     :duplicate_certificate, :enquiry, :mortgage].include?(@key)
    # end

    # def referrable?
    #   ![:manual_override].include?(@key)
    # end

    # def issues_csr?
    #   [:issue_csr].include?(@key)
    # end

    class << self
      def finance_task_types
        all_task_types.delete_if do |t|
          [:change_address, :closure, :enquiry].include?(t[1])
        end
      end

      def default_task_types
        all_task_types.delete_if { |t| t[1] == :unknown }
      end

      def govuk_task_types
        [
          :new_registration, :renewal, :change_owner,
          :change_vessel, :change_address, :duplicate_certificate,
          :current_transcript, :historic_transcript, :closure
        ]
      end

      def validation_helper_task_type_list
        default_task_types.map { |t| t[1].to_s }
      end

      # rubocop:disable Metrics/MethodLength
      def all_task_types
        [
          ["New Registration", :new_registration],
          ["Provisional Registration", :provisional],
          ["Transfer from Port in British Possession", :transfer_from_bdt],
          ["Renewal of Registration", :renewal],
          ["Re-Registration", :re_registration],
          ["Convert Pleasure to/from Commercial", :registration_conversion_pleasure_to_from_commercial],
          ["Convert Provisional to Full", :registration_conversion_provisional_to_full],
          ["Convert Provisional to Simple", :registration_conversion_provisional_to_simple],
          ["Convert Simple to Full", :registration_conversion_simple_to_full],
          ["Change of Ownership", :change_owner],
          ["Change of Ownership (Issue Certificate)", :change_owner_issue_certificate],
          ["Change of Address", :change_address],
          ["Change of Vessel details", :change_vessel],
          ["Change of Vessel details (Non-Chargeable)", :change_vessel_no_fee],
          ["Mortgage Registration", :mortgage],
          ["Mortgage Intent", :mortgage_intent],
          ["Mortgage Discharge", :mortgage_discharge],
          ["Current Transcript", :current_transcript],
          ["Historic Transcript", :historic_transcript],
          ["Issue CSR", :issue_csr],
          ["Certified Copy of CSR", :csr_certified_copy],
          ["Duplicate Certificate", :duplicate_certificate],
          ["Registration Closure", :closure],
          ["Registration Closure: Owner Request", :registrar_closure],
          ["Registration Closure: Notice of Termination", :termination_notice],
          ["Registrar Restores Closure", :registrar_restores_closure],
          ["Transfer to Port in British Possession", :transfer_to_bdt],
          ["General Enquiry", :enquiry],
          ["Manual Override", :manual_override],
          ["Unknown", :unknown]]
      end
    end
  end
end
