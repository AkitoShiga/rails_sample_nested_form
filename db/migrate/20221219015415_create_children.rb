class CreateChildren < ActiveRecord::Migration[7.0]
  def change
    create_table :children do |t|
      t.references :parent, foreign_key: true, index: false, comment: '親のID'
      t.string  :name, comment: '名前'
      t.integer :age,  comment: '年齢'
      t.timestamps
    end
  end
end
