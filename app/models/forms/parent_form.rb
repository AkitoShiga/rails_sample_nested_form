module Forms
  class ParentForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :name
    attribute :child_forms
    validate :presence_name

    def initialize(*args)
      super(*args)
      self.child_forms = [ChildForm.new] if child_forms.blank?
    end

    def child_forms_attributes=(attributes)
      self.child_forms = attributes.map { |_k, v| ChildForm.new(v) }
    end

    def presence_name
      return true if name.present?
      errors.add(:presence_name, '名前の入力は必須です')
      false
    end

    def to_parent
      parent = Parent.new(name: self.name)
      child_forms.each do |child_form|
        parent.children.build(name: child_form.name, age: child_form.age)
      end
      parent
    end
  end
end