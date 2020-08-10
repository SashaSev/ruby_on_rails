module RegistrationsHelper

  def register_to_sold_out(event)

    if event.sold_out?
      content_tag(:span, "Sold Out", class: "sold_out")
    else
      link_to 'Register', new_event_registration_path(event), class: "register"
    end
  end
end
