module WalletsHelper
  def link_to_add_fields(name, f, association, id)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render("expenses/"+association.to_s.singularize + "s_fields", f: builder)
    end
    link_to_function(name, "add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")", id: id, class:"btn")
  end
end
