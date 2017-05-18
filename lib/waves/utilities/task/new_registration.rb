module WavesUtilities::Task::NewRegistration
  def processes
    [
      :declarations_required_on_create,
      :declarations_required_on_add_owner,
      :ownership_can_be_changed,
      :address_can_be_changed,
      :vessel_can_be_edited,
      :payment_required,
      :prints_certificate,
      :builds_registry,
      :builds_registration,
      :emails_application_approval,
      :emails_application_receipt,
      :referrable,
    ]
  end
end
