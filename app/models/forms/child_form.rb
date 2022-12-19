module Forms
  class ChildForm
    include ActiveModel::Model
    include ActiveModel::Attributes

    attribute :name
    attribute :birthday

    validate :presence_name
    validate :presence_birthday
    validate :correct_birthday, if: :presence_birthday

    def age
      date_format = '%Y%m%d'
      (Time.current.strftime(date_format).to_i - Time.zone.parse(birthday).strftime(date_format).to_i) / 10000
    end

    def presence_name
      return true if name.present?
      errors.add(:presence_name, '名前の入力は必須です')
      false
    end

    def presence_birthday
      return true if birthday.present?
      errors.add(:presence_birthday, '生年月日は入力必須です')
      false
    end

    def correct_birthday
      return true if Time.zone.parse(birthday) <= Time.current
      errors.add(:correct_birthday, '未来の日付は入力できません')
      false
    end
  end
end